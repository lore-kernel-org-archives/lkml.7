Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D30C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4862086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYHTVFkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbfIIPCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:02:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33912 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733073AbfIIPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:02:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so4455635wrx.1;
        Mon, 09 Sep 2019 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2M403PGzeHsgRfWBo9vriBLfSezzprBCgW0woIy9ug=;
        b=GYHTVFkcpkNuI6btoryG5kJHIVq3FGm7RQG6Kt3SOKd9P38AyaGq+dTvlsDKvUyWek
         A3Pv3+LOSbh9y4yZM5QuT9aH19qUYHWsZjRExqhN1KmM8oZIbbd98hOPI0Zw9+jE/i8U
         aVYzbE7iNoQy472GtVvkj9uyfg3YhPqYvbJ7XVJcArQtncN5RHk6kOrIL3olOO/cfV81
         V0rRXjOajeXMr7H+3GsHen/EgR+7zEJDcOfnYoUYXnXPagQlbpzNbITYYg+b4dG61QIP
         N+xj4woJHg/ZIcxiYpWA0kE09rcyB03Jm4sW9/bRkmNQHdiCIAGqFl7OsyceuU7bFrIa
         nC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2M403PGzeHsgRfWBo9vriBLfSezzprBCgW0woIy9ug=;
        b=FhzfDRsnkWW0gQkRb/UiLzC7zaIL76UHDWrvemy8hLBM/h/s3+hIULErU7CIpVCZZU
         FlRRU9gCvwHGtZ3TbL5/FVCiRPRjtRvr7YMaciMymQtbQ2NgEHlSDgWISHNr8bsxrUsE
         evdcA3hEe1jbjlMdJZdHn7z6RrY8fI5fgQ2tfcBYl6IUdm0p63AF/R+jHEZwv2YKiJIC
         2XBDIFo7yUyCjjBJAaqFeEjAqbA/ct5hYaoahCVeUWZnLQA+iOViGpLjplixnw+TUeJa
         CnPvQtYQ47H5tLQh1vQP25/GDPBHYnAnuzkuuAO/jic2+kSrmqprOTaMkoP8eIrebrBK
         jQOA==
X-Gm-Message-State: APjAAAUrhSfBQGG/gcqRxm7m4TyJKOIz9EWcWSuhNEy9tkERnNiG+NkT
        jpKBHfAhFUdqVHgoCgM7gsU=
X-Google-Smtp-Source: APXvYqzDmQ/HWnchUAb8AIL0X1Ko3tv+V7JpQ2AA+3yPhXgaA0+6kuTVTl66RxXE9TlWF+A3mcdY/w==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr19862411wrv.119.1568041349772;
        Mon, 09 Sep 2019 08:02:29 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id s26sm27755397wrs.63.2019.09.09.08.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 08:02:29 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 5/6] dt-bindings: arm: amlogic: update libretech-cc compatible
Date:   Mon,  9 Sep 2019 19:01:26 +0400
Message-Id: <1568041287-7805-6-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
References: <1568041287-7805-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the compatible for the Libre Computer aml-s905x-cc to be more
descriptive using the format introduced with the aml-s805x-ac board.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 325c6fd..b3c9dbb 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -95,7 +95,7 @@ properties:
               - amlogic,p212
               - hwacom,amazetv
               - khadas,vim
-              - libretech,cc
+              - libretech,aml-s905x-cc
               - nexbox,a95x
               - seirobotics,sei510
           - const: amlogic,s905x
-- 
2.7.4

