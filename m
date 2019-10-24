Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A02CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB52205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIXq/4wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503643AbfJXQjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35684 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503629AbfJXQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:39:12 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so38886491qtq.2;
        Thu, 24 Oct 2019 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBStHmHEV5B5bW8UOdDVAaSdAsUZ6zk/15tXrG1wW9k=;
        b=RIXq/4wfdukLU5uuWuQF2OK8a4dUMHXkUmt1Ftle/qClyK9CzBLcYC0Rm6YzufgGOQ
         jSuqdlsNKDchwzegUeM3Bb7VhPXkL2Pff271WlEIX8eoQMSmGyjxcVfRg6U2wnBVlY5t
         S4Z0L90uHwuHpRbim+lNpzPn7ZT9+O4F0m0ylnzgriPk4XNrie0AdQdjVSpcJwJR4zve
         ia16euZ4t0T8cOyak/+6e+g0TDFP7VBYlvEU1Zm2TMifaulcsYHTRX42omvOdLtnSD0q
         xMRDpyaGJZ7NAV3JU6yUvJqVhC2bCFQmoNDLEmBR5aAos8qWmT19EVhadgmioTtC29JD
         hAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBStHmHEV5B5bW8UOdDVAaSdAsUZ6zk/15tXrG1wW9k=;
        b=guj84vdgeRNh/48PXmhe6NN/ERdrWbGVox2WaUa06jCJSuM6OZwnwyr21+JvZkk3Kd
         pOQpfbfmxT+TcDW7dDIx601IdjJUcZbCsraqtxifYp9sDZinTXs3inwYIQ4xDHfOJ+xX
         E3KAT7BFOjgYph3D3kZv7a7IQDk0KATpYjw8UG+O+gcOhJLiIF1kLR/eORiJWA6NQxs7
         /Y09S95hgDs8t5Md83pnnyvlIxTI/KX3TnSyXdmHDyJXynJKvUGQ9Zq740kVEpdTgx+O
         fi6uGZBpbkHr4mfSmPfOHnpOzi+4j8h/y1h1zTsGjdU7Fhj+xw0zBeWPEY3Ic6AE558o
         GSvg==
X-Gm-Message-State: APjAAAViGloi8rxx9PNA4pQEaba3SX788maE3rJujoqz/Frwl3Oz2pmy
        KzqZrKuUk9tnBftuulPyHy8=
X-Google-Smtp-Source: APXvYqyG2CvSxVSEZAf+22TWA18DwezJJpUt3QES1hnt1261ClLqV7jx8YbDvZ0i+vCFlf+VD/Vezw==
X-Received: by 2002:a0c:e801:: with SMTP id y1mr633274qvn.76.1571935151427;
        Thu, 24 Oct 2019 09:39:11 -0700 (PDT)
Received: from localhost.localdomain ([201.53.210.37])
        by smtp.gmail.com with ESMTPSA id l15sm14660121qkj.16.2019.10.24.09.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:39:10 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 2/3] staging: sm750fb: align arguments with open parenthesis in file sm750_accel.h
Date:   Thu, 24 Oct 2019 13:38:21 -0300
Message-Id: <20191024163822.7157-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
References: <20191024163822.7157-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Alignment should match open parenthesis"
in file sm750_accel.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index c16350b5a310..2c79cb730a0a 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -190,9 +190,9 @@ void sm750_hw_set2dformat(struct lynx_accel *accel, int fmt);
 void sm750_hw_de_init(struct lynx_accel *accel);
 
 int sm750_hw_fillrect(struct lynx_accel *accel,
-				u32 base, u32 pitch, u32 Bpp,
-				u32 x, u32 y, u32 width, u32 height,
-				u32 color, u32 rop);
+		      u32 base, u32 pitch, u32 Bpp,
+		      u32 x, u32 y, u32 width, u32 height,
+		      u32 color, u32 rop);
 
 /**
  * sm750_hm_copyarea
-- 
2.20.1

