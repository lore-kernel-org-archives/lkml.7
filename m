Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871EAC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12C204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 23:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QHNqWfAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHZXzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 19:55:06 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:40291 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfHZXzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 19:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1566863706; x=1598399706;
  h=from:to:cc:subject:date:message-id;
  bh=iCjgpBsVvJ3spaD/Rrndfb8rLJ6fzZve2WlhemnbJX0=;
  b=QHNqWfAfj2ka3jRnRQQixzKKDmri1pF9MMDQCxSpmyyx8C1O2Du6eNFt
   PHkOaV2clJkMI7XUj9sw3yKvPElBOiWSMX6Oa/uIbhsltYfnORzSnVjcY
   6FtvP2wKXu7kztMlFZDaASiC8RcmDkKI0K2PUQFIIPmbjXsziKig2Okwj
   luY3bwozoGT233z5wrRhueCny5UJuoMYgq9EU8PK1Sm7jbHw1RbHkDoTT
   Ehz9Ip/fpATFua0qy7zppYA5RuYwO81LSljR8tJhgrGj1iD4RHv9jZLV5
   175YwUeC5wuezpeAx7Jxn485yZMiJq0jcCqNuSQ+hPNQtbZB9ckbg8egD
   A==;
IronPort-SDR: 6OEh149dR4LsnU11jRGCoPa7ews15zRkUGv+youfSN5WKqSy3t2/DzOae+BnWKsvxRyaQOoK5u
 i/XXOZj2eWQc9d1OWx8yIXPHZarDr2eu/21rSpG4tUdX2ip22q6qHxOmaDGXLm5L2x5wKh1Hgz
 kp2jQlUTDemY/dbw/fqzqBorH4yCDuns2cEddPeT4ODg0juMqGZMmsI68nBOHaxmwagDyY0Vvq
 BoJSbyCObRZD0zWKjVdjvovfCoeimhNnhXY5xheIusXEEn7fvmCHpETZjSIkOBLGA6b7n7EGfA
 Gno=
IronPort-PHdr: =?us-ascii?q?9a23=3AYi3DURGcOzTSSUSY97Iwj51GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ78rsiwAkXT6L1XgUPTWs2DsrQY0rCQ6v29EjZfqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba5sIBmssAnctskbjYR8Jqsz1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWixEA4O8dJAPD+sHPeZXsoLzuUIApgawBQmtGuzvziJHjWLy0aA0z+?=
 =?us-ascii?q?gtFAfL1xEiEd0TqnTZtNX7OrkPX+67z6fGyi7OY+9K1Trn9ITFaAwtre2KUL?=
 =?us-ascii?q?ltccTR004vFwbdg1qSqIzkPjOV1vkKs2OG6OdhVeOui249pAFwvjSj2skhh5?=
 =?us-ascii?q?LUho0J0FDI7zt2z5soJdChTkNwfN2qEINIui2EK4d7RtkuTmJotSog1LEKpJ?=
 =?us-ascii?q?62cDIXxJkjxBPTc+GLfomM7x75SuqcLzd1iGh7dL++nRq/80etx+vhXceuyl?=
 =?us-ascii?q?lKtDBKktzUu3AI0Bzc99aIR+Nm/kekxTaPzwfT6vxYIUwslarUNZohwrkom5?=
 =?us-ascii?q?oWq0vDHyv2lFzujK+Za0ko4+ao5/njb7jlvJOcOIh0igbxMqQqhMOzG/g3Mg?=
 =?us-ascii?q?8LX2SD+OS80qPs/VHhTblUkvE7lrPVvZPaKMgBuKK1Hg9Y3pw+5xu7DDqqyN?=
 =?us-ascii?q?EYkmMGLFJBdhKHlY/pO1TWLfH4DPa/g06jkDZ3y/zaMLDsGYjNIWTZkLv7Y7?=
 =?us-ascii?q?ly9lNcxBIpzd9D/5JUFq0BIPXrV0/1tdzYCAI5MgOtz+bkFtp9zIUeVnyLAq?=
 =?us-ascii?q?KCLqPSvkGH5vg1L+mPeoAVojD9JOYh5/L0in85g1AdLuGHx5wSPUG5DPR7JA?=
 =?us-ascii?q?3NcGjsi9ZZSTwiowEkCuHmlQvRAnZoe3+uUvdktXkAA4W8ANKGGdig?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GmIAAEcWRdh8bXVdFlHgEGBwaBZ4M?=
 =?us-ascii?q?FU0wQh2uFMoZeAQaDQCiHNxhxhXiDCIFkhTsBCAEBAQwBARsSAgEBgQSDO4J?=
 =?us-ascii?q?qIzgTAgoBAQUBAQEBAQYEAQECEAEBAQgNCQgphTQMgjopgUxfNQsWFVJWPwE?=
 =?us-ascii?q?FATUiOYJHAYF2FAWeHIEDPIwjM4N3hGQBCAyBSQkBCIEihxmEWYEQgQeDbnO?=
 =?us-ascii?q?CSIFFg1aCRASBLgEBAZQ/lXkBBgIBggwUgXCEeo1NJ4MfgQ6JF4sKAS2EBZ1?=
 =?us-ascii?q?qg3ICCgcGDyGBRoF6TSWBbAqBRAmCUx6GBIgpHzOBCIt6glIB?=
X-IPAS-Result: =?us-ascii?q?A2GmIAAEcWRdh8bXVdFlHgEGBwaBZ4MFU0wQh2uFMoZeA?=
 =?us-ascii?q?QaDQCiHNxhxhXiDCIFkhTsBCAEBAQwBARsSAgEBgQSDO4JqIzgTAgoBAQUBA?=
 =?us-ascii?q?QEBAQYEAQECEAEBAQgNCQgphTQMgjopgUxfNQsWFVJWPwEFATUiOYJHAYF2F?=
 =?us-ascii?q?AWeHIEDPIwjM4N3hGQBCAyBSQkBCIEihxmEWYEQgQeDbnOCSIFFg1aCRASBL?=
 =?us-ascii?q?gEBAZQ/lXkBBgIBggwUgXCEeo1NJ4MfgQ6JF4sKAS2EBZ1qg3ICCgcGDyGBR?=
 =?us-ascii?q?oF6TSWBbAqBRAmCUx6GBIgpHzOBCIt6glIB?=
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; 
   d="scan'208";a="72783151"
Received: from mail-pg1-f198.google.com ([209.85.215.198])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 16:54:58 -0700
Received: by mail-pg1-f198.google.com with SMTP id n9so10655620pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 16:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0xmb65xr0CBfxuC3uWVpQkR2Ek+p0pitIFWU9dtWX9A=;
        b=NO7txdkEj+6IuJp8XaQyzp890dtxwZTckQEOSOwxuW1wTSF1B8mQvPucnZA2nqHTef
         CiS0e7D8usiepjc/BQ/O6OCPys7DZXBmXj1stvbOWdJDJ2ZMCzzZu01TzD0w1dUSVHwC
         7a4nvoFCspM7bXh6+l9v2hdFG+Tmdn5prdySPFOfNij5hDI1RbFiQNpPLuSvuxf0t2Jv
         LIzRD32WJvKXDmvTR1jep+UZfW890qujYR+VEBTOh78F+mOPuQPHAUW48wSYepLqe+2Z
         5OTbMHbi627I5fQJ+9/IyB6fL+XO5uH64oVgGixIwNB8bI+UotYst+e0Aa+ltvNa3wWh
         wHNA==
X-Gm-Message-State: APjAAAUcEHZNIZnlaK1dUgpZrXXcUTk0Gto4JUnOWIgChZzITbCmK4/Q
        wtWdCQFG5P6Ux8eF8bAwtd9lIf9QoLs2EFzFBNTy7CSiVi6KWD2herM5aTufMPvx5FWY/MikvJ7
        Pj7qKINTYOpwdk6KqqcZFad+B9A==
X-Received: by 2002:a63:3805:: with SMTP id f5mr18549994pga.272.1566863696850;
        Mon, 26 Aug 2019 16:54:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqws6Si3A54Js/iWt7UYfiNmKzerD0mxC1IVR7kF2Zm1xDIh3F0K5ILCCloPy2Y9vz/RjxxDnA==
X-Received: by 2002:a63:3805:: with SMTP id f5mr18549967pga.272.1566863696509;
        Mon, 26 Aug 2019 16:54:56 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id z25sm5562854pfa.91.2019.08.26.16.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 16:54:55 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Mike Isely <isely@pobox.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] pvrusb2: qctrl.flag will be uninitlaized if  cx2341x_ctrl_query() returns error code
Date:   Mon, 26 Aug 2019 16:55:28 -0700
Message-Id: <20190826235528.9923-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function ctrl_cx2341x_getv4lflags(), qctrl.flag
will be uninitlaized if cx2341x_ctrl_query() returns -EINVAL.
However, it will be used in the later if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index ad5b25b89699..66a34fb9e6b2 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -790,7 +790,7 @@ static int ctrl_cx2341x_set(struct pvr2_ctrl *cptr,int m,int v)
 
 static unsigned int ctrl_cx2341x_getv4lflags(struct pvr2_ctrl *cptr)
 {
-	struct v4l2_queryctrl qctrl;
+	struct v4l2_queryctrl qctrl = {};
 	struct pvr2_ctl_info *info;
 	qctrl.id = cptr->info->v4l_id;
 	cx2341x_ctrl_query(&cptr->hdw->enc_ctl_state,&qctrl);
-- 
2.17.1

