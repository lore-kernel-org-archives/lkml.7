Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B45C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8367520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj+mrDId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfDHE4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:56:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33724 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:56:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so13992757qtb.0;
        Sun, 07 Apr 2019 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eeg/iQque3UHAGJsuOtYqDAVu2/w5DEjM9/Mu6Sz2Fg=;
        b=jj+mrDIdADkTz9e+GtFEh7twr0vMYJJdtfyF9Fqj5GCLD63IEPDGQJawJf2CUKvHM3
         WyBCDBHbWCJ500jzMtbC7jE3k4tw12qOLpAzZmAKzVUZ31edgabSlELBybw6vxU8jT4I
         aASs14RMrpDwa4ff36P6OsMswwq8wtnf3251hp2SMfDPohPZuSBCmtzlh8KJmDhlZppp
         SZZhPFG1siOgDKH96ClEpGmk5rnai3xyD2+4TeETD+0AyumVDL5mfbqh32mzDEEUPxNX
         PhI/DV6OPu/ybd2H/qIV2hSjCN15uNuHJ+zFbK/pMwGsepe8MUrncKe+EMvQR/bvObtb
         mRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eeg/iQque3UHAGJsuOtYqDAVu2/w5DEjM9/Mu6Sz2Fg=;
        b=JvOJGvH9nB1AbjkeOD37qXqLbsDBlvlC53RLZdWEe5WPnCvc4lCLzNaniFtIzTuQao
         bTUnjGb8xbweV/62giTOorZAf0OFS889vYzxL2qTOSVh23HXql+oIbEGofZKdMJ2M43r
         ohsRz87oMc2AQFCFtjahGmOkW0Cu4CVgLmukETamhSH7/91zW7QUu8JRYs1+2iQLz+gD
         9WC4wE+dubWmnkk6yilHfeeFfU66Egs0xWIxzS90XLld2J+VmdJB45q9vWDJf0QoobdN
         BcSuffCl0kC2Agf+HJSmLAoeDNtLKBP2TOWtMxv/deWEYfRCxJszB2OX692a4lg3xI2a
         WNkA==
X-Gm-Message-State: APjAAAWiU9DnXDt9LcS7r3RWcjvUWxyLShQx6sQPFmga0ryXyA7TUTZS
        IdvCh95QnhQWt2RnPF4mCSa/HkV8xHI=
X-Google-Smtp-Source: APXvYqzTSV0+VX0lnrWKVJprcM1BwTHop0SI1h+GPbf+kON0XPWbeadKSbFyBbdWT4uebExO6Xt6lw==
X-Received: by 2002:a0c:88e3:: with SMTP id 32mr21561335qvo.31.1554699364458;
        Sun, 07 Apr 2019 21:56:04 -0700 (PDT)
Received: from localhost.localdomain ([187.56.54.93])
        by smtp.gmail.com with ESMTPSA id t35sm19129808qtc.10.2019.04.07.21.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 21:56:03 -0700 (PDT)
From:   Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: media: zoran: fix trailing whitespaces
Date:   Mon,  8 Apr 2019 01:55:54 -0300
Message-Id: <20190408045554.18905-1-arthurmoraeslago@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were several form feeds(^L) in the file, this patch removes them
to conform with the coding style.

Signed-off-by: Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
---
Made a mistake while typing recipients on the last e-mail and it was not
sent to the kernel list. Re-sending now with correct address, sorry for
the hassle.

 drivers/staging/media/zoran/videocodec.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
index 4946791fce0d..c37c0e4fb624 100644
--- a/drivers/staging/media/zoran/videocodec.h
+++ b/drivers/staging/media/zoran/videocodec.h
@@ -49,7 +49,7 @@
    device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
    ----------------------------------------------------------------------------
 */
-
+
 
 /* ========================================== */
 /* description of the videocodec_io structure */
@@ -96,7 +96,7 @@
 		the calls include frame numbers and flags (even/odd/...)
 		if needed and a flag which allows blocking until its ready
 */
-
+
 /* ============== */
 /* user interface */
 /* ============== */
@@ -116,7 +116,7 @@ M                       zr36055[0] 0001 0000c001 00000000 (zr36050[0])
 M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
 
 */
-
+
 
 /* =============================================== */
 /* special defines for the videocodec_io structure */
@@ -195,7 +195,7 @@ M                       zr36055[1] 0001 0000c001 00000000 (zr36050[1])
 /*  -> used in get_image, put_image                                        */
 #define CODEC_TRANSFER_KERNEL 0	/* use "memcopy" */
 #define CODEC_TRANSFER_USER   1	/* use "to/from_user" */
-
+
 
 /* ========================= */
 /* the structures itself ... */
@@ -309,7 +309,7 @@ struct videocodec_master {
 			  __u16 reg,
 			  __u32 value);
 };
-
+
 
 /* ================================================= */
 /* function prototypes of the master/slave interface */
-- 
2.21.0

