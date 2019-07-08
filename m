Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA7C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53503216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599251;
	bh=8hI5/kyrzUY8MgsAAViMvfz2eLYL4XMiQw7G0mhYKWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0s7oNCPAXnH9tob+2OhKQZpAryZgk5DE9u/y0Rszu5PUfRSdLErbEBDsgYlzGL0P
	 P0Vglym6n694YRu9uLpJTdzx3yfMBDjgmHeJvlBFtcqmsHqDv0IT/0xPtD7SkAeYPg
	 kSxME5DM4Cy3y9bE+wX31lLdskPerBne4lO1Ioi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbfGHPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733290AbfGHPTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:19:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF402171F;
        Mon,  8 Jul 2019 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599186;
        bh=8hI5/kyrzUY8MgsAAViMvfz2eLYL4XMiQw7G0mhYKWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ClIQLPa8m028pdKw1YcuFe4lSFTt7fmY9ZXIM28MyVeCxBYPBTIsmHoRzo/t+KwIE
         ggshvbKdoB8B0N5ZjXTw3Yox2cg17N5qYwjkw4V9tCmx4uiHT7J0EhuMafUhL1epvU
         vq1WN0SuzoFA+Cw7xCnEMQOfJhQdkIoVYM5Di+i4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 033/102] cfg80211: fix memory leak of wiphy device name
Date:   Mon,  8 Jul 2019 17:12:26 +0200
Message-Id: <20190708150528.091164020@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150525.973820964@linuxfoundation.org>
References: <20190708150525.973820964@linuxfoundation.org>
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
@@ -478,7 +478,7 @@ use_default_name:
 				   &rdev->rfkill_ops, rdev);
 
 	if (!rdev->rfkill) {
-		kfree(rdev);
+		wiphy_free(&rdev->wiphy);
 		return NULL;
 	}
 


