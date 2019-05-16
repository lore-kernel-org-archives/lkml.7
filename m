Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D203C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AB820818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2v0e0U1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfEPNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:08:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44290 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfEPNIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:08:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id g9so1821635pfo.11;
        Thu, 16 May 2019 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TpUJh8xmWCZIn3ut3vYXKe3CVBgzC6r7GRy49zcEzg4=;
        b=g2v0e0U1HpV1wTsbSjaH9o502+3Bqtnzyy5tHc3jPNtzKGVEIEdwq/GWyak3paNVV9
         2Ntx767VlInd3vqKrKOUvM7V1HGhZAUcAPspHSsCYamEPWtu2fuW8T7nJndnybYaoCBJ
         QGQorTOVf6PNgZ2CA43U+7RO6hd7gbgwdDvFuTbTj0w2ZN9Ho5zMK+1hdyVAhZY6YFSq
         gS3odjLplXN5NCTxuJQhSd+scbwY4sF4s3xP22HL8WE9c+SBYirpBBWrXCSRfcbFDgjL
         7JMla4f+WLoLP+RFUp4UovyiqXBbiDKlXugyyL3ICgxoMvh7Xn6XUhO6tlWOgOOzFvj6
         A3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TpUJh8xmWCZIn3ut3vYXKe3CVBgzC6r7GRy49zcEzg4=;
        b=I+HNFmDujtFLaKeYxLkskOIniVG4hUnFvax9mfdBv9ZO5nCYb9A7C1IcpD8E+UuG0f
         f779Ad3qV4ZxFWCE0+KiYMDVv3WVDEcJszx9EnN/jnoPi/THOMbMOJ5/TWDsKoqEahfv
         AdwBHC5xUYOb2RIQxqq1HQ+4T1byPG0P7E8Dk82hq37t+6ndRzd/mtFQXXxRWnwr+IRJ
         kqoDL5Q32Zw8WKsdUDjRyqd6aA9sfLkQKBny86XgaDqEN5VJ3tUTibla+Cpw/QE8JOkH
         xSDWd/70VTJT4uWObz1dnGKpnCgs334E2oadqp/+2w4VspqIdM067bdgSfVqznAvFYg1
         ZvJw==
X-Gm-Message-State: APjAAAVw6cM9CUEmJIshRlIlGI/iLHgPywrt7qol3Ru2CNoWeHC+gHjy
        PtbtgmMaTf5xtbTeTFeF0HY=
X-Google-Smtp-Source: APXvYqyyLxju7G7/XX696dUrXPvqym+Z43/tS74KS05kbMPbTAzOS0igaTQ1mEPLz8KIpI5ElyKY7g==
X-Received: by 2002:a63:17:: with SMTP id 23mr49640161pga.206.1558012121388;
        Thu, 16 May 2019 06:08:41 -0700 (PDT)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id b4sm6453216pfd.120.2019.05.16.06.08.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 06:08:40 -0700 (PDT)
From:   parna.naveenkumar@gmail.com
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH] USB: serial: mos7840: Prefer 'unsigned int' to bare use of 'unsigned'
Date:   Thu, 16 May 2019 18:37:59 +0530
Message-Id: <20190516130759.12996-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

This fixes checkpatch.pl warning "WARNING: Prefer 'unsigned int' to
bare use of 'unsigned'".

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/usb/serial/mos7840.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index a698d46ba773..a610af4dea3f 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1682,7 +1682,7 @@ static void mos7840_change_port_settings(struct tty_struct *tty,
 	struct moschip_port *mos7840_port, struct ktermios *old_termios)
 {
 	int baud;
-	unsigned cflag;
+	unsigned int cflag;
 	__u8 lData;
 	__u8 lParity;
 	__u8 lStop;
-- 
2.17.1

