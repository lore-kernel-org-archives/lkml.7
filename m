Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B23C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F432206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGgrYEnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfD0TkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:40:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40131 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfD0TkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:40:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so9353140wre.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=fKR+2+8WBNjRQO8k76MeFd4PJddg9TDvAb+H1+9qQ90=;
        b=RGgrYEnfRUcmn/XyJlvcEsio5C4VLyuqVbMNUvSiUxTYPSJFOAdtzxrpBTxO/hUq07
         XM2c7+28aXqoiPhIR7atNCoYPILw0Nx8R087q8RzFORhzRu/0d9s7HVwKq2g7Ck4O7k9
         S5Rq0ekPhNy6JK52Qb/wHutFaGdg0VBBxGwJagTjxR6KrLxvgKiuqJDsLNFZhNKWxXVs
         PDpjuKKn6gZeWQOrFjWf58kMKVheHKDsmD885FEfWYdZnUE+0jJgotg29SjF4x0OFr9M
         9B89bjoNPOS9TgFj1kxOd0oTBF5QomXN3hAosNZvY7ikgKIUWAdUuSXtqjH0i3RWfjY0
         UHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fKR+2+8WBNjRQO8k76MeFd4PJddg9TDvAb+H1+9qQ90=;
        b=NKEAFu21U1fsCsGTvR9WVC2RdkbDRrdL7BpBKvBKMsrvBM+m7pTU0BPvEnOPmNFXEF
         Cp86ccVZ1cF6wrCi9Bih/Q9yNMJpSLR43X2bPFmEsvEOSRpQBia5U1aRLs/OrmDt44mh
         SkfGTop++dTYHUBKnj1YhHnaYnVxRwFf4LwZJiku+jDjygtlqUIRHMad+Nnq9+BMYgXf
         4Tva9D+z51/uPXnwwHCb3n8scTuIF1vLbA5anXdY6aqgTrlqKIwASKeboHXkZ5y738+E
         DrFbJ8wWbN2Jf4qdXMFJmmG3MDSzwsJg51w/YDnCKkO6dqa4EX8GthMs9/+0nr2K2w7J
         /FSw==
X-Gm-Message-State: APjAAAXXH+NWs6k36HnqcrlujNh0C3GbK0/gC9wvpTKTqVLNbXI/y9PM
        YPB0W/pqAynxx7neauo5XOw=
X-Google-Smtp-Source: APXvYqzu6mAkqViDeimdaKTDzKDyQgLujzASfjuiVNytxBmOrCsKng/3awOUpIBTkk2McR8PqMVgQQ==
X-Received: by 2002:a5d:4a83:: with SMTP id o3mr17138355wrq.90.1556394019754;
        Sat, 27 Apr 2019 12:40:19 -0700 (PDT)
Received: from localhost.localdomain (p5DCFF0C6.dip0.t-ipconnect.de. [93.207.240.198])
        by smtp.gmail.com with ESMTPSA id d18sm11099284wrx.56.2019.04.27.12.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 12:40:18 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tlv320aic3x: Add support for high power analog output
Date:   Sat, 27 Apr 2019 21:40:05 +0200
Message-Id: <20190427194005.7308-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to power and output level control for the analog high power
output drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..d4bafac802eb 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -419,6 +419,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Pop reduction */
 	SOC_ENUM("Output Driver Power-On time", aic3x_poweron_time_enum),
 	SOC_ENUM("Output Driver Ramp-up step", aic3x_rampup_step_enum),
+
+	/* Analog HPOUT, HPCOM power and output level controls */
+	SOC_DOUBLE_R("Analog output power control", HPROUT_CTRL,
+			HPRCOM_CTRL, 0, 1, 0),
+	SOC_DOUBLE_R("Analog output level control", HPROUT_CTRL,
+			HPRCOM_CTRL, 4, 9, 0),
 };
 
 /* For other than tlv320aic3104 */
-- 
2.17.1

