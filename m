Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159DF20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q3LLb7Zj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfFQLAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:00:42 -0400
Received: from mout.web.de ([212.227.15.14]:51857 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfFQLAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560769233;
        bh=cl5hc3psPBqPufyRnHGOWRBIVEWwsgEkuVX5yPLzDMo=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=Q3LLb7Zj0QIdzsTXuLoGDhKtMRSW5CNCPh/vRO/BsbWXCJ3idYaDWUHS3HMrevnCt
         mx0MXrTYLN2FZIwRYAnoJ6q8v4tFw4Licgnif8ioMWd0Ny36RJWkVuQC/aVGNjzkM3
         pCrO+AkeX0KMmBdrAH9WDFh8X3dnpVgRm3rqcTeE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.164.208]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTPjb-1i1CWl3I99-00SLE6; Mon, 17
 Jun 2019 13:00:32 +0200
To:     linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] megaraid_sas: Delete a redundant memory setting in
 megasas_alloc_cmds()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <3921d044-72d6-d092-e792-01c896ae222b@web.de>
Date:   Mon, 17 Jun 2019 13:00:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+WQVPl0MeIdN58HXt3L50FnFytrpzbX4mxGHi9jzFA7Wa6D3ELC
 ZY8UEdlvE+ehhxnqQ+sTJICvBZBPAgVPVLzgA8v47kzoQFiIgYTnDb4DnnPPfoep9XbPaem
 bPwoP9Ze7Bm7e/NxoG2VxatVnyJw3rNV03UnjjvPmDgEPf1dEwpeJTot6K94luFrljDuZGP
 sIcTYRJC5L6U0c0JJef8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CGh1YRyV2/0=:suECTuDYyCVBdte/xXqpdw
 aMC5teckP2HLrF0H5oGeJsMT07evrjY5Lx9pYBoWwJvuBS+w6u9jaVaLNyhRoK5j3PDr0iPf9
 wIve80QnnkHqLmn92Wr7Q6fKYAPru+NzL+ScP/aB9UTpH0A4dhL8BobjBmpK4UGtR/ERb5xB0
 ICTeu2YK+f8iEJohMJ+EIOFNSp9SD6FW3dojJVb0wlSd+aHPU97iOZqAGeuUnMyWp8/9yIff1
 FBapksg/Vtct8MBFr2wl0GSW+5j0uRjfQTokNUDpdCMD+a4h6jUMqqEpyTO9kJqcAaLijRIvt
 QiQ1SWyQy+0F5G7sA2ZVNy8mvNMNk/ISn58sC2eEwHEGSEzkMcBXqq5gM2M6NU+cc4SO3+Rz+
 1jMDSHCgXSyzaY5+FPQjZ8VXLhqTm5S5aYK5UgYvhCVTJa7HgBz6eHideQqUOhXykNAldsCSZ
 jlmy0iZFTo0xFL7hw8oaXYzBKacIK4+1SYBbk+w1hzUBnSazlS4+qaRd4/b6euhwwjC0VIvcO
 7sZjYLWeVgJ4WsJaF9gYmF4cFUYZ5Z+8U2X40qq2XmIWqe3Hkzg3DQwdmwrbXvS+KXTxE+oef
 n+1TOKBSr3aoRddTg0+IEPI0S/OJDWrq2HASYvAWDp+Gop/+aqwecoJB+dPZ5Grz07/ScJ0bA
 WyRKvtueyCtFMfXFxGwAj9XCKWckwpyQf3DLoaEp0hruweAtp5d4Q1yK7zfFCyUUbGS7UifHf
 bRN6/niBVPcYBNxWo0KqlQpW5ptDca0FJzIxQBIcwlQI6g4BAAOexJJ1qpXmR8sOxOuigMNbV
 PVsyVhxL5ofwMVFAeLT47um+RllGlwtpbp04gYemtL5eDiAnFxmlFQMs+fopk+gW6jjGy2HTK
 E/01tX4iTtwt61JFOqsfXxNOspBWbmIBARbQDHlhm730Varod5m8aM2T0bSyyDa0CuZiKGpRV
 WQm/MDyQiLrXFQ54cJji+UC62gdNKchN4dxkofcEr2yU/DsF4zRur
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Jun 2019 12:42:15 +0200

The memory was set to zero already by a call of the function =E2=80=9Ckcal=
loc=E2=80=9D.
Thus remove an extra call of the function =E2=80=9Cmemset=E2=80=9D for thi=
s purpose.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/mega=
raid/megaraid_sas_base.c
index 176b59a34a79..047990d3cffd 100644
=2D-- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4239,8 +4239,6 @@ int megasas_alloc_cmds(struct megasas_instance *inst=
ance)
 		return -ENOMEM;
 	}

-	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd *) *max_cmd);
-
 	for (i =3D 0; i < max_cmd; i++) {
 		instance->cmd_list[i] =3D kmalloc(sizeof(struct megasas_cmd),
 						GFP_KERNEL);
=2D-
2.22.0

