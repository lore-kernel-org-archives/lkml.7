Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF30C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E99215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887034;
	bh=YAoNevRZdrrDehJ/hPdRuUZnd/D//7WimKmw/6nGgNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X87hKSD7Nn6bOFfErMwky7fGcwlOupUmhYOxvQr3xkBrWt6lolyUMGTvS572if5GK
	 4FJJUY7ZH8LcU3XKBR2oyvxBSlG2oPtiTyFk0nC6fSDO01nep34IRdVDXltlzGA5yb
	 UEOq6DnW90ZJKrSbZwbLTdJRgPxlgJvcw1CUkXIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfK0UhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbfK0UhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:37:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB78920862;
        Wed, 27 Nov 2019 20:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887031;
        bh=YAoNevRZdrrDehJ/hPdRuUZnd/D//7WimKmw/6nGgNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgi/pKCnxfrAO1Eqwnom2NfP/jZzCDGLAScDuwKHO7ZcRbaF1mfYT4lOqVXdb5/bG
         2wBD5F+9uX+dgg3mz2lXLJse7cvzQRJMDt+OERD07dgZ7OWi4LN9cp+jIipdwUO3Mk
         mc2z4z0VD6UpIlHfKW4+oISs15oDrD48THons/TM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 087/132] scsi: mpt3sas: Fix driver modifying persistent data in Manufacturing page11
Date:   Wed, 27 Nov 2019 21:31:18 +0100
Message-Id: <20191127203016.159098651@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

[ Upstream commit 97f35194093362a63b33caba2485521ddabe2c95 ]

Currently driver is modifying both current & NVRAM/persistent data in
Manufacturing page11. Driver should change only current copy of
Manufacturing page11. It should not modify the persistent data.

So removed the section of code where driver is modifying the persistent
data of Manufacturing page11.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/mpt3sas/mpt3sas_config.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index a6914ec99cc04..56dc0e3be2ba2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -677,10 +677,6 @@ mpt3sas_config_set_manufacturing_pg11(struct MPT3SAS_ADAPTER *ioc,
 	r = _config_request(ioc, &mpi_request, mpi_reply,
 	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
 	    sizeof(*config_page));
-	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_WRITE_NVRAM;
-	r = _config_request(ioc, &mpi_request, mpi_reply,
-	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
-	    sizeof(*config_page));
  out:
 	return r;
 }
-- 
2.20.1



