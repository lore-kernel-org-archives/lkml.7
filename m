Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EE5208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370792;
	bh=AZ4hQFbDbc3e4yABmB6vYKoy2RI/A6f6SK1Pel/zyrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAHFC4a8+s/h2gHrLfU3etmSsfBK0z1GWkKD34zgMO4rwJmAQSXM7nhuVim6u/oo8
	 Ss6I34KzFaey1IdONg5gCQTvYk+/984tU6Ag0CqqsD+7sVVuvJfJ+O9QmAGgOekV4s
	 RdX4coBEMyMr62BDS7PGXB5w79HBVbP2U4eX8J9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfFXKGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730104AbfFXKG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:06:28 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1898208E3;
        Mon, 24 Jun 2019 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370787;
        bh=AZ4hQFbDbc3e4yABmB6vYKoy2RI/A6f6SK1Pel/zyrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BySj56OqvfJ9jLCLOgsXWAD9L+zQfhNk0fKFlEo+t6S/hApgZPu+FVJwhDTm25YHi
         kpBl8bxaXbxAdgr6PmIZ1VKxiKLkMejbMuh69JYDJdTr+u3Pkrsq6sLc6CLoHfsYHX
         pIg74Bd/w/RnCdFo28Z3HqMg9wN2KtaTr/g5BuZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 84/90] cfg80211: fix memory leak of wiphy device name
Date:   Mon, 24 Jun 2019 17:57:14 +0800
Message-Id: <20190624092319.410368076@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092313.788773607@linuxfoundation.org>
References: <20190624092313.788773607@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 4f488fbca2a86cc7714a128952eead92cac279ab upstream.

In wiphy_new_nm(), if an error occurs after dev_set_name() and
device_initialize() have already been called, it's necessary to call
put_device() (via wiphy_free()) to avoid a memory leak.

Reported-by: syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com
Fixes: 1f87f7d3a3b4 ("cfg80211: add rfkill support")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -498,7 +498,7 @@ use_default_name:
 				   &rdev->rfkill_ops, rdev);
 
 	if (!rdev->rfkill) {
-		kfree(rdev);
+		wiphy_free(&rdev->wiphy);
 		return NULL;
 	}
 


