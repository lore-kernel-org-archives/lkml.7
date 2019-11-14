Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C3C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C525B20723
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJCz2v2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKNU2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:28:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40394 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:28:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so7637944wmc.5;
        Thu, 14 Nov 2019 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K5embLHTDP7uNIGocODuFu6GQnCP8W2lQWuJv19zdl8=;
        b=oJCz2v2c5AYVz6Q6H4mdrlmjwMRXJl3QRv58ftEV+PhYZRrrjnkTSLO3STb7ZcfRgn
         N2OLdvEU1DxyXboZFDZpSOISB7tOshCnak0Kmvoql7WD0duVFKIn6dtpQ985JtQEI+4B
         2MoxmgIvBkQoTRhr8/ofs1F7C2qk8ec+NGHsxYFy3RUzbhF4sM4yQB53OiBj9t4uGml4
         7s6q357K5SH9nJ/WCTb+p6Z+XSYUhBFp6S811kDcmcPrOvw8oY3ElY7IUj8IEiGV4xco
         re2tlKjXgS0Z5vYsmtdntgVeM7iIqFDwlsO6N6StStT+9rOh8AbHHMeg/wPi7/SD2Lj4
         AZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K5embLHTDP7uNIGocODuFu6GQnCP8W2lQWuJv19zdl8=;
        b=HhX3H9q/f+XJ7kjHDOUN4bUonv7EjKBZYl5rpdQwtQjqZai0+4KPyxyjiFXBPwDLoq
         cjwK3Jg135TuLPDr4J6uS555YHOZaVi550ymeLPBh7B+VdoeXa0vO0TWFCdOADo3GEbj
         lo66UKXXDlkLhDIcK82O+7TK3jFQ9kEnFEtXV3aTJH0UrePN+nDBrirRj4jHwjn9NgLg
         +tztKp51XfG5HdaxyBG5S5iZdiCBeN5d0qWNhOB2suD6XS4GWmXx6e0Tk/ibtydtQCZo
         dOi5icoqDBaLz7s7E+hNnV7antxXSMyQJjM2NH1edAcvieU627GcSO7mVi27Ru/EsJlH
         Tz3Q==
X-Gm-Message-State: APjAAAWQ7qsyGMeMwfHBKSkLa+ow0MSe5GDA/7w6DRNxEaaD4Bg/xMmq
        xfIt53dGr+SdpVI9IoSFH3o=
X-Google-Smtp-Source: APXvYqyKPSnewY1soYVqWA6PQ+RofXvEux3LeOY/J6DXdBuJCVla8oCTl6/tXjcgmRorECdyF75imA==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr9819309wmk.25.1573763327200;
        Thu, 14 Nov 2019 12:28:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w19sm7276899wmk.36.2019.11.14.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:28:46 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] ARM: dts: bcm2711: force CMA into first GB of memory
Date:   Thu, 14 Nov 2019 12:28:42 -0800
Message-Id: <20191114202842.32505-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106095945.22933-2-nsaenzjulienne@suse.de>
References: <20191106095945.22933-1-nsaenzjulienne@suse.de> <20191106095945.22933-2-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Nov 2019 10:59:44 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> arm64 places the CMA in ZONE_DMA32, which is not good enough for the
> Raspberry Pi 4 since it contains peripherals that can only address the
> first GB of memory. Explicitly place the CMA into that area.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---

Applied to devicetree/next, thanks!
--
Florian
