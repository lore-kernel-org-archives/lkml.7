Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814AF208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOrPYTJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDIOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:43:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50824 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfDIOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:43:04 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so5311519itk.0;
        Tue, 09 Apr 2019 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKODETyjQrfp1Fgz6pcOSm3GJsqMKSgjGwqpvLl/PVI=;
        b=gOrPYTJt/Wx7+PJPLIkj2B++OMmp8f1J7APrP0lllhkye2xNUS0LetZdeUMD6izMtS
         UcrtJ+TwulM3WnxH9ztobofEAsc2jvv/X+dtADkcGfQ4p0iHEPkFcOCiaUAyqnVwc4jg
         NwZNJ4ot05QyZ0nubYL+Dp1CQle8bfFIM0gC1oXFczOtFcza+ZAzYGo0emf81VzeMdBO
         Ssu+5/TxvzRgz5U6bn1QI0ieBNwODQAnjr1UPdy4LzXKMHfoPZrFfiUKulx1iQqPzG8M
         kmoSycQJBil4zUTqJnWhl5GIOqESUjR4nmkmZ9YCkpvz8rJF2LaZ3j3GxTc9nQSnMaOs
         6wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKODETyjQrfp1Fgz6pcOSm3GJsqMKSgjGwqpvLl/PVI=;
        b=Nx/CnWWpL8MokvfDxbFYt7olk+SUppTOPqsVD7vQUMnhNr3r7dlx9WiEfDSnaa5QDg
         YUshT0IS1h5uqPMRMSt8Mm3gyFDErYYvvtZpFw7eZYpMD8MK1qaq5DK9OOc7pWVCQeFG
         qQ6HodZLxfJNp4AcbYFsj3TDXaqbTraoMUUnYNqPDeFOZQNjMkXOtudlLqcPaG8UUm2i
         nEYDWKS5pV1ah4ATMrw8FHseSjSP2RLh/FwC0bJbFIfs1/yTYov0EqOTLvAI4bfaVfzt
         gZph5qjv53tMzqJJcbPiPcePeoi70kc61HCk4s5fF+ApFBHdf+6PdEDx/MtdJELgnXmR
         go9w==
X-Gm-Message-State: APjAAAXfyk/UAosVNZTDImN3NtQwHxwxuoh1o27girYPsOAzqYmqR//H
        tY17Opz8BfWMsGTxE+xBDEk=
X-Google-Smtp-Source: APXvYqzW1cCUeskJwExpwYbchFo169PJq0fwChqknhLbOZskEAZYy+uOsv1aEcC/pQvhtn0s1481lg==
X-Received: by 2002:a24:953:: with SMTP id 80mr20848500itm.139.1554820983200;
        Tue, 09 Apr 2019 07:43:03 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id j10sm6562000itj.32.2019.04.09.07.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:43:02 -0700 (PDT)
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
Subject: [PATCH v10 5/7] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Tue,  9 Apr 2019 10:42:48 -0400
Message-Id: <20190409144250.7237-6-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409144250.7237-1-TheSven73@gmail.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
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

