Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E8C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0324215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561370374;
	bh=AZ4hQFbDbc3e4yABmB6vYKoy2RI/A6f6SK1Pel/zyrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h+vncMxblk9LHOGhFsVTBbS1JfQ9M8C2OFe4iKrd18qjpSPnUmvASoBPCetn/p3Fb
	 EJ4ch6uon6vlolU9n81u0JrbWnzyc3QXMTymhQI81YmFTezKo27KWREt7NwDSM5/DI
	 0+bBstsmPGvOCMvx/y9SBgGpHg13zny01Cw15msA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfFXJ7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbfFXJ73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:59:29 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F1A205ED;
        Mon, 24 Jun 2019 09:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561370368;
        bh=AZ4hQFbDbc3e4yABmB6vYKoy2RI/A6f6SK1Pel/zyrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RX/WwSwwS/IoKtcaz4gKAFkWjTBlOEMsdnNJxezoo9F2AKUEOqV1JoWa5Aiuvodo5
         fPy2oCqFFyZvRYSxdphatdlJEY/ycXw6X298YJECnefFonPqA8NGh8KxiECc45M+0W
         16N4wowCzsgwvJAfzYyN7FGDlcJOCxL19EvfIJ7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 48/51] cfg80211: fix memory leak of wiphy device name
Date:   Mon, 24 Jun 2019 17:57:06 +0800
Message-Id: <20190624092311.362114698@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092305.919204959@linuxfoundation.org>
References: <20190624092305.919204959@linuxfoundation.org>
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
 


