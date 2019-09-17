Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CEC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948362171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568738127;
	bh=FUP4jikvmgxt3jNITmvO9vbkaVXhXmpV7aPrr6kR2X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XCUK9VJBEupkMR5BecoHgixMg8Y07nWmu8QR1YcP075ZKllvIcu3jaQgrMJULg3tZ
	 IUtZzHyqMWiGFHPaBblLoHKDcYiMpEQropAYv8y7ouxDH6TlQ+lVuPiJ/TlKWvOCD9
	 DogvkSDyRHWVZlUDRk7FFcqqg5A0LBmd46bJcfD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfIQQf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:35:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43003 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730516AbfIQQfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:24 -0400
Received: by mail-io1-f67.google.com with SMTP id n197so9084314iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=294+1pNE1QvrA8K+k/rIQCwQYW84ev1PmbYotCH5RCQ=;
        b=Tfh+5yMrHUYKeKA9+q9X6Xhm8+u0RWVyyxHdAX3aZLxwUsRnoeNaDspvl/Un73Bwcq
         pnSPCVbxML9W+UK0zA6h+xDzQ1aNt9SoJrM1RHuV/WAJ4yhq/ZC1U64Bi2Fj2iYsBIs8
         KCi2E5pJsZ7F3KklKGa85rzhKvCnRActTpNuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=294+1pNE1QvrA8K+k/rIQCwQYW84ev1PmbYotCH5RCQ=;
        b=Jm9r2H9s30MWVXjPGXwkebeaNYyQpZFmRwoHgSTqLLqgtVfm2ef8N6xyd3wcs0AkZY
         t0PrlzN4VpeynI2eOiE8k1zwoJ9WSvgoyAO9O20OtsA3HsSmTwuoynnbKgIP58l5JiI2
         YhP0hYidGZBDHQSRXpMBvdBUGbDb31SrVVx8yJD6p4+f46Ta756zqtouFTjAUouAoJhq
         Ff1OIgqPGHl151x/VAf+MqsM+krub6TeJ5orWFUOxTOsMp081Zx0sR3p8omM6SH2QPUO
         wCA8jQawz7fsjuma4vA9fi2Oz/9nx7N0zOiKVTT3SoThI7bddCDSxCiyWXmHj+p4zaca
         i6pQ==
X-Gm-Message-State: APjAAAWZ/CSBCD3csSTFmYmWT9smPNKREmnD8cvlMMR6Mo8791qEyhyE
        QNXKZi84bQg78g3jYMYefkzabA==
X-Google-Smtp-Source: APXvYqylcBKYmKIgGAXRltGvqqvimwBhgilW0kwtUz36uYE1R/OGf1EPI+4k/kLL9WPdRjdp2/iXxA==
X-Received: by 2002:a02:ce2b:: with SMTP id v11mr2431784jar.134.1568738123063;
        Tue, 17 Sep 2019 09:35:23 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v3sm2593781ioh.51.2019.09.17.09.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 09:35:22 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, helen.koike@collabora.com,
        skhan@linuxfoundation.org, andrealmeid@collabora.com,
        dafna.hirschfeld@collabora.com, hverkuil-cisco@xs4all.nl,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        nicolas.ferre@microchip.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] MAINTAINERS: Add reviewer to vimc driver
Date:   Tue, 17 Sep 2019 10:35:12 -0600
Message-Id: <e0665a825bbef9027bcbc5a9d14c3ac8b902d3c3.1568689325.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1568689325.git.skhan@linuxfoundation.org>
References: <cover.1568689325.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After practically re-writing the driver to collpase it into a monolith,
I am adding myself as a reviewer for vimc driver.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c62b45201d7..4529d257f8db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17041,6 +17041,7 @@ F:	include/media/videobuf2-*
 
 VIMC VIRTUAL MEDIA CONTROLLER DRIVER
 M:	Helen Koike <helen.koike@collabora.com>
+R:	Shuah Khan <skhan@linuxfoundation.org>
 L:	linux-media@vger.kernel.org
 T:	git git://linuxtv.org/media_tree.git
 W:	https://linuxtv.org
-- 
2.20.1

