Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68A3C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CA721873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997740;
	bh=S2yVBSm7lPNPpaNzZD2l8y2LHg6bt6MXEaEhLxtaK6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RLZO7OXh7J+QhxUI9qCwFOqZYLnliV1F3mkHdlRnHemSD/Eyv1h5MBwWgMVhgdI9h
	 D7dTmhkFUm0yH03gMP2pDQhSIDLvHVYNeVkvelO8qo64PyfF6iHY8GAJRfOCg5ZmDW
	 RzgeyxD3hEQBWxMmvxT8wnPP1MiFqnr623NL9S3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391467AbfGXTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391449AbfGXTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5463021873;
        Wed, 24 Jul 2019 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997736;
        bh=S2yVBSm7lPNPpaNzZD2l8y2LHg6bt6MXEaEhLxtaK6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1MIu9+zyB0MVTaunhXEAZklsuyNFwHuNjmYAVjgMTm7f8REfkhIBHMgvupddmqSz
         9B3bDuxS0Gra3UiI8eqrtSVfRsNKW96VST6Ou5CkAcVLHSP9BWQEqnKMXG06LTwWb8
         khbOaNKOvfsYQNDaOr7DVjcT3oSUlm+W5oOAKRUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 118/371] EDAC/sysfs: Drop device references properly
Date:   Wed, 24 Jul 2019 21:17:50 +0200
Message-Id: <20190724191733.704401710@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7adc05d2dc3af95e4e1534841d58f736262142cd ]

Do put_device() if device_add() fails.

 [ bp: do device_del() for the successfully created devices in
   edac_create_csrow_objects(), on the unwind path. ]

Signed-off-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20190427214925.GE16338@kroah.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/edac_mc_sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 464174685589..bf9273437e3f 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -443,7 +443,8 @@ static int edac_create_csrow_objects(struct mem_ctl_info *mci)
 		csrow = mci->csrows[i];
 		if (!nr_pages_per_csrow(csrow))
 			continue;
-		put_device(&mci->csrows[i]->dev);
+
+		device_del(&mci->csrows[i]->dev);
 	}
 
 	return err;
@@ -645,9 +646,11 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
 	dev_set_drvdata(&dimm->dev, dimm);
 	pm_runtime_forbid(&mci->dev);
 
-	err =  device_add(&dimm->dev);
+	err = device_add(&dimm->dev);
+	if (err)
+		put_device(&dimm->dev);
 
-	edac_dbg(0, "creating rank/dimm device %s\n", dev_name(&dimm->dev));
+	edac_dbg(0, "created rank/dimm device %s\n", dev_name(&dimm->dev));
 
 	return err;
 }
@@ -928,6 +931,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
 	err = device_add(&mci->dev);
 	if (err < 0) {
 		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
+		put_device(&mci->dev);
 		goto out;
 	}
 
-- 
2.20.1



