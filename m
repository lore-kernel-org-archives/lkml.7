Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD5C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D9F24679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 07:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjadsDBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfLFHzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 02:55:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33091 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFHzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 02:55:24 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so2413416pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 23:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaqU4ZZ/Urt5R21/nikc8rCEF6ts1fVjkR26xtBAyOA=;
        b=jjadsDBNPS8OtHRSPNn6QtxEfvQBzpDZDLfkKU2DTOIaMvf03RP/kOkQ/D/LbYSgyH
         x5nkPApqMZdMlAjPyQR/bXrWy1RRhxm3NGXvYJ5bjtMpV5bWtBOQA11CO1JLwESZN33v
         ukIFxIOwWS7ZNyuIoSm7ELAPv4vFhGTDCHYeNNqHhRRmE5gEQyC7TU6BuGoRsI7Yj0HM
         fncxDwvOewPurjd9a9E/A5kvOqzcme2NE/UPAwWFXbTvLz76qcbT0smbhefAHssfpSuf
         LdI4h6HDmcvhWxYvGT0R+O9hvLozpSpvi7LZMc0dRePOQRR6QOqjuGBcGmIRrDv5p1Il
         odSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaqU4ZZ/Urt5R21/nikc8rCEF6ts1fVjkR26xtBAyOA=;
        b=H+h/k7sCUKvXIx8Ym2U8vF+JNYqCIry+aiqoC672pUC+uSPZWuxHXAjqo03Qxe3oUl
         rjlIcOZ/wN7NH6sYHCU4/2elc/OnHM3ywe6D6qcH+0MmCS7pDrvSNtsqAT+hw2XU9NCk
         ABXvfRmOI0TnCZQjr12d3j3Xs5NWUj7ajln0gNpvpUUKoCg4Fw5VQO1EsR+U8o3OVOsJ
         Q+dae6ucS3xujTZsFnFAblWZfmEOMLNtywzYteA2XG+9D5ZeUZviOjNKlrFE7c/mvV2Q
         w2dG4LQGL8o6lq+7kpXQNSamtHwRIf5jpSF812TZ6CzH+vpgA0IcIHTDNM7ftftH5t9D
         HbDQ==
X-Gm-Message-State: APjAAAXQ6gGVCCCAi2mHh+3pTfeNypfHINK0jcv56k5YQcJNG/kbjZAt
        9kBJtsoMAzRxCyaf7X/LhxA=
X-Google-Smtp-Source: APXvYqzgg7fH/uj3wNC9qxJt7g/rdmxrFIo8YiaT1FrtCXHCjuwNzj4iChssf7KJ7/vc+FGiKEjkpA==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr9867579pls.335.1575618924028;
        Thu, 05 Dec 2019 23:55:24 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u2sm13894922pgc.19.2019.12.05.23.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 23:55:23 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] staging: rts5208: add missed pci_release_regions
Date:   Fri,  6 Dec 2019 15:55:15 +0800
Message-Id: <20191206075515.18581-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index cb95ad6fa4f9..15fc96b42032 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -831,7 +831,8 @@ static int rtsx_probe(struct pci_dev *pci,
 	host = scsi_host_alloc(&rtsx_host_template, sizeof(*dev));
 	if (!host) {
 		dev_err(&pci->dev, "Unable to allocate the scsi host\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto scsi_host_alloc_fail;
 	}
 
 	dev = host_to_rtsx(host);
@@ -971,7 +972,8 @@ static int rtsx_probe(struct pci_dev *pci,
 	kfree(dev->chip);
 chip_alloc_fail:
 	dev_err(&pci->dev, "%s failed\n", __func__);
-
+scsi_host_alloc_fail:
+	pci_release_regions(pci);
 	return err;
 }
 
@@ -983,6 +985,7 @@ static void rtsx_remove(struct pci_dev *pci)
 
 	quiesce_and_remove_host(dev);
 	release_everything(dev);
+	pci_release_regions(pci);
 }
 
 /* PCI IDs */
-- 
2.24.0

