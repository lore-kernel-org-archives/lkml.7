Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF8BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7C72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbKid/KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfDPP4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:56:36 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51374 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbfDPP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:56:32 -0400
Received: by mail-it1-f193.google.com with SMTP id s3so19091040itk.1;
        Tue, 16 Apr 2019 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKODETyjQrfp1Fgz6pcOSm3GJsqMKSgjGwqpvLl/PVI=;
        b=dbKid/KIyJ627ouEo230CGlFfCalHht4nTaDNtt7eVnrmKWsh7J3XtxYp122sZtHWQ
         bwf7Cy0HR/e6/G4D22vhdml+TIYCdJa40PQPf3Ydiu+VkovD4NQEYoF0vesFwYp6wOk0
         yaOQp0osfdWuQuCe4wVCKCjsEKCq6BlhvnH+t0yZNUBzgcWB+msy5w2xibF9FwI7WX/R
         9IjWxCeEOOsQnllnyzfN7s4RllFOkTNof3whXaUjKMyXMEn+jA0OIM6hWWGfSJ6wiun0
         tYbgMk72grXvZEUt5+3NZTSmUPYs13SSBXXuiKU7LdybIRgkun9pKXI+eg2E0c6pMgO+
         0dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKODETyjQrfp1Fgz6pcOSm3GJsqMKSgjGwqpvLl/PVI=;
        b=YJagnQAi9ctkPObGfo87q8/j1VuPaoNHiU6r7xQzGHGsTMf7o3PABnWWuUkbP52NfR
         nYuSXDOkAPxxtizieuQXciZBULoXJ/KPNTuLHf8+s4ZkBr/d31tz99BEy4IZ8vPJ3Oan
         NvM+fOjj95D53yFYOen+L+YEE9cx2Pof7MsTgreR88sdVRutNPVVFfUljnrgaTb95BiX
         20bb05YYR5VbjMMBJFa5EDnrSpjfqzaGh17Dj65ny7jwR+3r/9dtDwKpxA83xUDZ5fOZ
         3IS1ZwqbkDVR7j+jg3xP1RiBcxoTG2ZeDe449aPWWSOUXZTD728IRejsWS02YuJ0WOQp
         sksQ==
X-Gm-Message-State: APjAAAV9auYTJMupyNGwwFr7QqDf9wtqJizh8bwTj1TtaveqH3I3G8L6
        k7YXTYd2laoVHwnQ5E77uW0=
X-Google-Smtp-Source: APXvYqyv6FDtHaamnzAcQsJOgrENGM6YvhUbMY1LpeZv0yVyqXg4L5iXZ2Wh5cniCfDcC8Wq5kqqEw==
X-Received: by 2002:a24:760a:: with SMTP id z10mr29667259itb.115.1555430191549;
        Tue, 16 Apr 2019 08:56:31 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 64sm9766630ite.42.2019.04.16.08.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 08:56:30 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v11 5/7] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Tue, 16 Apr 2019 11:56:16 -0400
Message-Id: <20190416155618.1369-6-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416155618.1369-1-TheSven73@gmail.com>
References: <20190416155618.1369-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..f3c81407675e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -36,6 +36,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	arcx Inc. / Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

