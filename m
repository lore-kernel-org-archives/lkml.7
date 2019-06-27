Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1659C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51842086D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdJ9L/4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfF0Rng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:43:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46788 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfF0Rne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:43:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1658529pls.13;
        Thu, 27 Jun 2019 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fAB+02+QvXObdBU3H9Vv8v02eYyU6/qD4FmI+pFgbpQ=;
        b=NdJ9L/4MA8r0TUvSTrbAA/E6cr3Lz5zz4ZYuv3WZI69WHcxRMUqowmrsmipFUwMipj
         ZlGcxUeaDsJFfZCq8zp668yOF1nOzIjDFxAD7AnEvUPS+bcE7abtdOr610pkdWslj55P
         r8vmlCOlt3Hy2SklLat7JxFOYXbNkxO829b1H8dJ34qMRusZcXQ2oa+i9H0SDNoAz777
         K819OgkMyTMlixqsC4bL9n+ETMSOASRDi54b9UMJ4PkwMSi4tIrMnmOo4XsWQlB1gG/7
         +COP57H3QixVc9jctvFM97Kh45IewOuSKgkhiornN3ADcbnIXC411S2Jk6SBOiAWw1K+
         tgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fAB+02+QvXObdBU3H9Vv8v02eYyU6/qD4FmI+pFgbpQ=;
        b=aF+f8hmE1+0zKEZrF3DxSFSBsNdG18SgBf1O0wFRUm4mUyehd4DQF62PRTnGd/Bixb
         vKsdr8S+2iViwqE7wTJzR4QMJz/97gsoab4hMkUy+NND5mj1gL8ESWEGpn8dN3xTDUIc
         IAhiA0vISgNzwyeYtWDyoqH82egGSyGIuN4cysblgbaAP+HbNb5CvYrcnmdwpNqsSXyB
         PlxFn/wJBSg2wQ5ffxU2GMjrAcJrYDzRgOO6L2pvDfThIIsfKTTkScEgeqnLTf5m03NN
         DKU5nwqAdSVqlTjXDpjk2ANwT94/gmHDMdgjg2TvkDBeUChL1UqMqQTsJwTw1+svHGJ9
         HZhg==
X-Gm-Message-State: APjAAAUPEOxYoVYOXWvKDLH9/b35xKKeyTbArvGsB8TMIALtcPCqpCpc
        pu6X6rvEqwRV0jh8cxeFmxU=
X-Google-Smtp-Source: APXvYqwwzRSUIJQt4d88OFuNzY9HqOtIGplMC0nIbgKlnpgPmZP0Duj85iYCOzPXEF2GyHOuEkmoGg==
X-Received: by 2002:a17:902:e40f:: with SMTP id ci15mr6014598plb.103.1561657413046;
        Thu, 27 Jun 2019 10:43:33 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id p67sm7855370pfg.124.2019.06.27.10.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:43:32 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 56/87] scsi: pmcraid: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:43:27 +0800
Message-Id: <20190627174327.5147-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/pmcraid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index ca22526aff7f..9e11e20d9e0d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4720,7 +4720,6 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
 			return -ENOMEM;
 		}
 
-		memset(pinstance->hrrq_start[i], 0, buffer_size);
 		pinstance->hrrq_curr[i] = pinstance->hrrq_start[i];
 		pinstance->hrrq_end[i] =
 			pinstance->hrrq_start[i] + PMCRAID_MAX_CMD - 1;
-- 
2.11.0

