Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA2C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B221C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fLdOw/O2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJGUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:22:33 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:16267 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbfJGUWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570479751; x=1602015751;
  h=from:to:cc:subject:date:message-id;
  bh=hr0Akqt2j/UPUDcEP3WW0avFGJ8Jp7+/QzCVG442WG8=;
  b=fLdOw/O2EsoXwEPdl7aGc/6FnMha7vA0UyftSYhIImgpN3qBX8VUIXsJ
   6ENLCBa/AxLFo+fFIh28uXqS5B4cO9thO9pM1H7Dowq5XE4LPALhwZegr
   gcV8gjkolF7ypH0d+c5ZFNbhDPc20K6FzMhZork/4QBTiFIvV+3Mdd7jZ
   QKgOPXnavr/stfIdtUH4sQZtptjPHvAccaLP2joZCrszxuoteRpCDwxsI
   e5eqozkEb231MFHgF/2i9+39qKaf+d6Lntqcpct5VfdiHjNS/B8T8Y/6G
   SeMh2dm9zNKUtl+dLSWg3ir4pAwMflOHv0hLO1z65GW/gRkpcJGHyXZ2V
   A==;
IronPort-SDR: CK3hTX8pU1i1P+YYn0gFWAk20sN8Gj5uTUHEPdFb6Na3854Mw6o1LdeSB/KXJGVEk5h2NKgkvo
 yNwN8afmp/MMTh+vH/8wG87k2sITDgBYl26ZIdHwZb8WXpCKZdLb+yBOiGucD/uR+d4tFrRcId
 lvmUN5WctNhNCjYOjeLnr+ag0lfuNTOo/aF3UuxP4QJ2Kj41LzJKxeVzl2U0OtwhCVnLIr87A0
 i2/jmut7M3jIg/6a+yPAjeeaO3Mr5I0KSTbLzCgxgGdlkHFPdy4V7x78B5bJ94a8MFYtpJV5Fq
 9LU=
IronPort-PHdr: =?us-ascii?q?9a23=3AjyGWsRHL2C+RJ7vlKQuEop1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ7zpc6wAkXT6L1XgUPTWs2DsrQY0rGQ7v+rADddqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba58IRmsrQjctMYajZZsJ6sx1x?=
 =?us-ascii?q?DEvmZGd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U6VWACwpPG?=
 =?us-ascii?q?4p6sLrswLDTRaU6XsHTmoWiBtIDBPb4xz8Q5z8rzH1tut52CmdIM32UbU5Ui?=
 =?us-ascii?q?ms4qt3VBPljjoMOiUn+2/LlMN/kKNboAqgpxNhxY7UfJqVP+d6cq/EYN8WWX?=
 =?us-ascii?q?ZNUsNXWixEA4O8dJAPD+sHPeZXsoLzuUIApgawBQmtGuzvziJHjWLy0aA0z+?=
 =?us-ascii?q?gtFAfL0ws8Et8ArHjYscz5OLsPXeuoyKXE0DXOY/ZQ1Dzg6obHbwohrOmMU7?=
 =?us-ascii?q?xubMTfx0ohGQTeg1mMtYDoJS+Z2/4Rv2SH6edrSOKhi3QgqwF0ujWgxMYsi4?=
 =?us-ascii?q?jJhoIIzVDP6CJ0wYY0JN24UkF7YMKoHIdeuiyBKot5XtkiT3t2tykn170LoJ?=
 =?us-ascii?q?i2dzUJxpQ/3xPTdeCLfoyS7h/gVOudOyl0iG9qdb6lmhq/9UutxvXhWsS11F?=
 =?us-ascii?q?tGtDRJn9fMu3wXyRDe69KLR/ly80qnxD2BzRrc6vteLkAxjafbLpkhzaMumZ?=
 =?us-ascii?q?cLqkTDGzP2mF3xjK+LakUo4uio5PrjYrXhvpKcMpV7igD6Mqg3gsy/Bfk0Ph?=
 =?us-ascii?q?EAX2SG/emx16fv/UL+QLVNgf02lrfWvIrGKsQco661Gw5V0oA95BajFzqqzs?=
 =?us-ascii?q?gUkH0dIF9GeB+LlZblN0zBLfziEPuyh1ehnC9ux//cP73hBpvNLmLEkLfkZb?=
 =?us-ascii?q?t8609dyAopwtBe+55YFr8MLenuWkDtrtzUFAE2PBGpw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7StV6I5uQyI+iDfYMVuyjyK+Ij5/HwiX80gkEdfaa30psNcny4HeppI1?=
 =?us-ascii?q?+fYXXyhtcNC2AKvhAxTL+ipkeFVGtiZmSyQqV0siApCIunVd+Ybp2mmvqM0D?=
 =?us-ascii?q?rtTc4eXXxPFl3ZSSSgTI6DQfpZLX/PLw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EfBAA4nptdh8bWVdFmHgEGEoFcC4N?=
 =?us-ascii?q?eTBCNJYYyBosogQmFeoMNhSiBewEIAQEBDAEBLQIBAYRAgl8jNQgOAgMJAQE?=
 =?us-ascii?q?FAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhS?=
 =?us-ascii?q?ia4EDPIwlM4hgAQkNgUgJAQiBIoc1hFmBEIEHgRGDUIdlgkQEgTgBAQGVLJZ?=
 =?us-ascii?q?UAQYCghAUgXmTEyeEPIk/i0MBLacxAgoHBg8jgTEBgg9NJYFsCoFEUBAUgWm?=
 =?us-ascii?q?OTCEzgQiQZAE?=
X-IPAS-Result: =?us-ascii?q?A2EfBAA4nptdh8bWVdFmHgEGEoFcC4NeTBCNJYYyBosog?=
 =?us-ascii?q?QmFeoMNhSiBewEIAQEBDAEBLQIBAYRAgl8jNQgOAgMJAQEFAQEBAQEFBAEBA?=
 =?us-ascii?q?hABAQEIDQkIKYVAgjopgzULFhVSgRUBBQE1IjmCRwGBdhSia4EDPIwlM4hgA?=
 =?us-ascii?q?QkNgUgJAQiBIoc1hFmBEIEHgRGDUIdlgkQEgTgBAQGVLJZUAQYCghAUgXmTE?=
 =?us-ascii?q?yeEPIk/i0MBLacxAgoHBg8jgTEBgg9NJYFsCoFEUBAUgWmOTCEzgQiQZAE?=
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="85808312"
Received: from mail-pl1-f198.google.com ([209.85.214.198])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2019 13:22:03 -0700
Received: by mail-pl1-f198.google.com with SMTP id g11so9299021plm.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WiOjGK2UEBGulgrQmuu8TZAB1seQgp4rv89oyowfPPw=;
        b=Ed3gRCTJRqZfUXMQcmxZdWissJyMo+WN/zMCQUj74uyYf6jBtrmOlc0BMX0gbRAyVE
         ql2mG7Ar439J88veizDi1vq0fINUCaPBId3dEd9emXVXMzO1hPbLG1aprUQY5pZ8fdiO
         EAQobQOvB3GT0eamOsTn3VzXgLpU+hrXtdsBa4wbCFau6R8XykoLqqx69BWgQU1MC5pc
         B8UlESNhQmrPyOOnvAiKyynDPeNaoozk45g4QiDpL3H13fBtsvCmPorAIRYvbVCK51wf
         izjKl88OThdWhsvpREFsBnh1gyXYp0PdAx7OcrWAzXQufffFRd6c4dAodtp+ceKPWnBR
         u38g==
X-Gm-Message-State: APjAAAVOaseoqaJI9f5xo4ZMtgW+xEts7c2J5+IYY6EJ96+uR2dS9UcP
        O4bDYupeqZyQli0XeTft5P3lhTSKQk0N2DRVpvhU5Hrq6KxmnZ3+bn/iRwb+qAeoBcPapn/MkR4
        srNQt6I7Nrya2EHqa59ZIp4WlJw==
X-Received: by 2002:a17:902:14f:: with SMTP id 73mr32102206plb.57.1570479723395;
        Mon, 07 Oct 2019 13:22:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzujMvcuvfmr8yz99HLunQi0qdiMtJiJpDOd440zlu836xRN4VmA6fByQcRvdMogFrD2OzAQ==
X-Received: by 2002:a17:902:14f:: with SMTP id 73mr32102189plb.57.1570479723072;
        Mon, 07 Oct 2019 13:22:03 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id h4sm15150797pgg.81.2019.10.07.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 13:22:02 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     Yizhuo <yzhai003@ucr.edu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi_transport_sas: Potential NULL pointer deference in sas_rphy_match()
Date:   Mon,  7 Oct 2019 13:22:48 -0700
Message-Id: <20191007202249.29830-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function sas_rphy_match(), dev_to_shost() could return NULL,
however, the return value of dev_to_shost() is not checked and
get used. This could potentially be unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/scsi/scsi_transport_sas.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index ef138c57e2a6..04d83cbc35f2 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -1328,6 +1328,8 @@ static int sas_rphy_match(struct attribute_container *cont, struct device *dev)
 	if (!scsi_is_sas_rphy(dev))
 		return 0;
 	shost = dev_to_shost(dev->parent->parent);
+	if (!shost)
+		return 0;
 
 	if (!shost->transportt)
 		return 0;
-- 
2.17.1

