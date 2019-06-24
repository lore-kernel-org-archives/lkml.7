Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED39C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CE920652
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371745;
	bh=r9qR6vdNFVnaspyC0BjX8Zv4RgKiC6mrDPulvEKLJ4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1fgNdd8H6QA/fYQFd2w3QaS+G5OHOm2DxT8vFBd84k4OOGymL25zQdnqB1p4RFSx1
	 4dv9ptL9872XgZPhVrTOqJliWfcGJVk0fdt1utOMRetfu0O4dK37QAXZBLu7cBgkQ2
	 R9tI3/kkGk8rN/vClvtllc0CtWihCo3BnNi1j+l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfFXKWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:22:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbfFXKWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:22:17 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C06821473;
        Mon, 24 Jun 2019 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371736;
        bh=r9qR6vdNFVnaspyC0BjX8Zv4RgKiC6mrDPulvEKLJ4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rs9g9i/BlI+hY1KoPuzbzNhVfz4JaeGFwoUVdQkFScFage88VGlkkTnWkgemLe4pW
         4pHjofE1Iog9nNsy4Md9HlFF3UHC70Kp28u6Ihkx0r7JoVM2aGD3PQtuax4VvPpn7L
         9vpPhsmskZgwl5i0Yi5FZYBGuRZ2k+6XVjQ9OoHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7fddca22578bc67c3fe4@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.1 115/121] cfg80211: fix memory leak of wiphy device name
Date:   Mon, 24 Jun 2019 17:57:27 +0800
Message-Id: <20190624092326.525035719@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
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
@@ -513,7 +513,7 @@ use_default_name:
 				   &rdev->rfkill_ops, rdev);
 
 	if (!rdev->rfkill) {
-		kfree(rdev);
+		wiphy_free(&rdev->wiphy);
 		return NULL;
 	}
 


