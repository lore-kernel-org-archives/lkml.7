Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9F32173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PeVELfYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfHHIzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:55:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41380 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:55:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so90854545wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGMV7QhC8DNNZSd4DygDFTwAShSfi/80pVWOD2ZlzJ4=;
        b=PeVELfYvvyjsx6clfPeEV6Kyb4FSgsdGONpfUp+mhUWbRbE6lOwzvPOuOzghkx6UY7
         sV7OyXvLbqZR62Qbpmmw4l35xC2kfWcUBQ9+I1cBzj0J6TbruWWxPqzkzawHAzd3dNDq
         LSGhY2wEMrRjIPBV4X3wMMXLBpcdLvif5+dTdz4KVRvyQ7ytn1UF/bgn3kkRGHH7e4T5
         YsHJvm4sGZLQmwtl3c6ZDriwhEv982T5LMZGUnye2w1eT2zjbfINQ/MNb8q8VQ9+jPuP
         epUB01MA29ckMpujdwib4vSG15vWT/tXHrpAh9yXYq7MethOMhpCYaazti6CrRejYT1v
         F2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGMV7QhC8DNNZSd4DygDFTwAShSfi/80pVWOD2ZlzJ4=;
        b=SOJ8XTL1AXCB73YOBL9h5HfPOPy/EtmOfnG1YniM2i+VBYFd+CUuIdv65eTeaGa/f1
         QkJ7R5yHpdqkHeWZxkxQ2LNiuAY3/cVwhO+9agZRBVHWVvftWzdY9cbpHc2RA5iDf8i5
         aoPbf1xtuUPi9ZuhkVUUFuoszAdMKlWHXil0YKOaRW8JlAwvdDkWrlUtBiLczeVjX8wb
         daUOX3+SyOFX0KWc32G1iUopbYr3TlhaEv1ANVCgCSpLyARyn2+PFu2koLGKT/SQAont
         FKmjgWTHdjZYlB8welXoavVhf3ELaaJf9nzQbzanD5xy7vL1LcXCjuSm0GM8IUWV0/ZE
         zLRg==
X-Gm-Message-State: APjAAAXgHY7UcttCRatNwZQd/J8R+bcEJB0p9DD3JRa3YAmI7L1SR4Jr
        9/VCdtAizuiFOuavvS6FzXFRXA==
X-Google-Smtp-Source: APXvYqx4HZQxEVZ8L3lNTFhLUVF9yFAHzskRwJoSI/HZlrCcCvMyPu5yrg2yl0ii5Hl6FetDC3yEvQ==
X-Received: by 2002:adf:a348:: with SMTP id d8mr3321352wrb.235.1565254526837;
        Thu, 08 Aug 2019 01:55:26 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i66sm3380649wmi.11.2019.08.08.01.55.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:55:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] MAINTAINERS: Update with Amlogic DRM bindings converted as YAML
Date:   Thu,  8 Aug 2019 10:55:22 +0200
Message-Id: <20190808085522.21950-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808085522.21950-1-narmstrong@baylibre.com>
References: <20190808085522.21950-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amlogic,meson-dw-hdmi.txt and amlogic,meson-vpu.txt has been
converted to YAML schemas, update MAINTAINERS to match them again.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f0..c55c18531cd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5318,8 +5318,8 @@ L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/gpu/drm/meson/
-F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
-F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
+F:	Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+F:	Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 F:	Documentation/gpu/meson.rst
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
-- 
2.22.0

