Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0758C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F022793F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 14:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaIRevF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFBONm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 10:13:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39321 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfFBONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 10:13:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so6739696pgc.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9PH2k6rPB87/EEGusf4NGVLGYsoLDBvNH1XesU5MSE=;
        b=PaIRevF6X9EwLo4tynO/oQYZRBcG85PvvyQLyKkXdp6vLjcnIUH5UpsmZLz4KjTSBK
         hms704ygyRWoFPRI63ehIjsVCPvsOsoLL/AGv2aj3Mda4muSyDjZjdLokpCixSZp4ahG
         qlAtxyFvBrQMPKJWe18dzIzQFmAOLj+AU3DvdTYo7PkHk0cbmUPxrnna1QjVzTad/gOQ
         nrWhRxa14WLuw3btqxPJvpBCUuBlBc4O4MmyrqQ1XI4zXU21DvHZq1m0yqutKddyMBjH
         gtoHj2K6RggWYFSgNfu5ixkSbo2dtTPZLaqkqci6yyFWWYqFXhrf2EcOBYyeQxJTEwcW
         f+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9PH2k6rPB87/EEGusf4NGVLGYsoLDBvNH1XesU5MSE=;
        b=EbyB1/Ms6gmIJ0l+JYLu7SHrX+C2sZojvXcEKE1kHrbwf7p/qKhDm/ixKQFjmB4DYB
         ezyN61efxmgxfPLEAUQClVUler5wZ4pnmuOaczfRjBKnZ7IACmCVePtpFq4Fh8ko+5hd
         CcvzEAV7K8ykSAGQgOCGyCsTCKLSuGZFvDwxtkWSTCkHrDdxE2CewYMDYxrY0JmHTBer
         cnqdKiZ+jolBPFDKeJEvJC8xUHzEaQb9FN3I+e28XOveFp+cklNo36UHipDYD674Hiek
         fKqDEdz4mE7/ah7N39MjxxaFbWxtIzkuC19ZZnf2BjkiBpLzSBxuD3KxbXxDKYSd9aOp
         +mUg==
X-Gm-Message-State: APjAAAWk0jHyPNrswEL/BGGAHYZpiTmmECzscOdxZcVW29cv6cMiYYWu
        HVGwnMs40sm4NZQ0Z9oko7k=
X-Google-Smtp-Source: APXvYqzpaRyuh5gQli++xqEgVoQRrE1rPqttbhI9uhh1SUA8jrKDVOtdKqsjDKH3Ewbwo8eiC0WG0Q==
X-Received: by 2002:a65:530d:: with SMTP id m13mr22569795pgq.68.1559484821083;
        Sun, 02 Jun 2019 07:13:41 -0700 (PDT)
Received: from localhost.localdomain (119-18-21-111.771215.syd.nbn.aussiebb.net. [119.18.21.111])
        by smtp.gmail.com with ESMTPSA id x66sm12533278pfx.139.2019.06.02.07.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 07:13:40 -0700 (PDT)
From:   Rhys Kidd <rhyskidd@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Rhys Kidd <rhyskidd@gmail.com>
Subject: [PATCH 2/2] drm/nouveau/bios/init: handle INIT_RESET_END devinit opcode
Date:   Mon,  3 Jun 2019 00:13:15 +1000
Message-Id: <20190602141315.6197-3-rhyskidd@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602141315.6197-1-rhyskidd@gmail.com>
References: <20190602141315.6197-1-rhyskidd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal that the reset sequence has completed.

This opcode signals that the software reset sequence has completed.
Ordinarily, no actual operations are performed by the opcode.
However it allows for possible software work arounds by devinit
engines in software agents other than the VBIOS, such as the resman,
FCODE, and EFI driver.

Signed-off-by: Rhys Kidd <rhyskidd@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index a54b5e410dcd..49d09503cd31 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -1945,6 +1945,17 @@ init_reset_begun(struct nvbios_init *init)
 	init->offset += 1;
 }
 
+/**
+ * INIT_RESET_END - opcode 0x8d
+ *
+ */
+static void
+init_reset_end(struct nvbios_init *init)
+{
+	trace("RESET_END\n");
+	init->offset += 1;
+}
+
 /**
  * INIT_GPIO - opcode 0x8e
  *
@@ -2272,7 +2283,7 @@ static struct nvbios_init_opcode {
 	[0x7a] = { init_zm_reg },
 	[0x87] = { init_ram_restrict_pll },
 	[0x8c] = { init_reset_begun },
-	[0x8d] = { init_reserved },
+	[0x8d] = { init_reset_end },
 	[0x8e] = { init_gpio },
 	[0x8f] = { init_ram_restrict_zm_reg_group },
 	[0x90] = { init_copy_zm_reg },
-- 
2.20.1

