Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43656C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64420854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nRJZhfnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfCSQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:17:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33100 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:17:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so480967pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=r6fCR0Ba++QOuxz6R+4A4oS+Zt54avu6KSLhTyIAJSc=;
        b=nRJZhfnmhnyP7yqNTqtX3dofQ4Nk5Qo+78ekVgNnrD9jiAwtEz7IMyldhperXeOLpz
         4undoaMb7UkqX6bIns/qvuN+JwTIB5ez0XYuOFXInz1an8AaZtdztOsaMqJeuD9aGCE1
         NVFN89pcvnjGLDhHNWsgVIOr1h6X30Hs0l0Sn1Qsg1oFmgX4R+/RR1q2dGJezoJOn79j
         ekxaNlly32/WoWzq5hoykBT9l9IAKOMzUCmEcL6+LyBhc10yRgEwqxlTVrArQZiAjXjt
         KeGsASAEgoXp0a1cfeNnMLCmzjd/jq2IcqfuvWObJZAplvoBmK9KZzG87kghFNXJmLo/
         Ovyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=r6fCR0Ba++QOuxz6R+4A4oS+Zt54avu6KSLhTyIAJSc=;
        b=QM7UlwlQYb8RSl7skKMgG1VfnADiIAB/GGcG568o2obS3rzXxHMRju9l+7o3U93O1A
         C2XsVawiEN7eme04KwCWtAVrrTpcEZJARm2W0B7ew6HstI9AZWDsQAwEveY8aWa9Wo+S
         iVv1dEriWs/gxGrQdN62G2SXFVhF05tr+P86rAtQKp/xkkZjiPdCAkX5MEzkaQ4LLEof
         JJLFEZ3WOqxod6eCRr/Hfc1e4FUPCNvcXz5jxtXv7YrLWY0uX/zpMHMCM9xbHEovwb3g
         QHxxHEYfoDUf0TwahUrFcR8kpojMn9PN7MkW6P7lOxDRHOArz62svqW+sw19G7ye6zeR
         semQ==
X-Gm-Message-State: APjAAAUdmQ2AS99kB6v2HBKOyWU1dWkGmlhfOjBBYLGBlgXkPumOwh+S
        rQk6G8HY6ZNinusEBivhuRpvSA==
X-Google-Smtp-Source: APXvYqyTh4Rz3ZIjKty65iBaLCRjboFLLl+hqSEPoWui2KPGhH4GS2c3aIqkV3tGPbTvLDzMR2P+wQ==
X-Received: by 2002:a65:6154:: with SMTP id o20mr2557086pgv.205.1553012227183;
        Tue, 19 Mar 2019 09:17:07 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id i72sm29114760pfj.147.2019.03.19.09.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:17:06 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, richard@nod.at, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 2/2] mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf
In-Reply-To: <20190318204722.9901-3-martin.blumenstingl@googlemail.com>
References: <20190318204722.9901-1-martin.blumenstingl@googlemail.com> <20190318204722.9901-3-martin.blumenstingl@googlemail.com>
Date:   Tue, 19 Mar 2019 09:17:05 -0700
Message-ID: <7hva0eg7pa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> meson_nfc_dma_buffer_setup() is called with the "info" buffer which is
> allocated a few lines before using kzalloc(). If
> meson_nfc_dma_buffer_setup() fails we need to free the allocated "info"
> buffer instead of only freeing it upon success.
>
> Fixes: 8fae856c53500a ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Liang Yang <liang.yang@amlogic.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
