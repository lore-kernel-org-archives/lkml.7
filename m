Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D39CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03019208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhjSWFba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfJ1UqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:46:05 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:44851 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJ1UqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:46:04 -0400
Received: by mail-pl1-f177.google.com with SMTP id q16so6013889pll.11;
        Mon, 28 Oct 2019 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=lV3TnrefZSIp2fBnZfeV64I5DeWk0aVLIz9eM31Y7DE=;
        b=nhjSWFba7+p4xp4vcCxRo7Ivtn17fiGuTkgM4306IMhMQkfnKDp2wHMkIfWT8e7az4
         7YOQ0o/XSuK8rpTb5aWxd9EaVPFrDk1cTdEseDbI2K8odAw3FY8ZxQ+e3JPkECRIjlZa
         3t5TRjhUZ1z1V8V/A8TkHa/gSKKfss5P7FJfR3Z902htuwYH6uxIMNbJzTJ3FUPVcGKL
         UCb20Eb/7IvOrcXjcQyeccE9x9Tlc3U9Wfy9HVppNdJ7GY5CR7iDiDKhDfmo931Pb0gs
         QKqruvPMhnHfzRFJKuptnwKChS+/31YQoYltlyGhnxDj4tTPd7T1Vk52uY24KmtCC4zP
         P6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lV3TnrefZSIp2fBnZfeV64I5DeWk0aVLIz9eM31Y7DE=;
        b=sMMj09YiiljYkIaMTeSKqf1ZhJhrgIah27GRgHCRaShp2qwh68TF7TXVxezwhHeRoz
         imZy4tksFUaiGjodefdk8GI/nWwmEVzsVm8pT5eE2qwy2krGbwL6XKLmLgSnFQB805hT
         Zi1m81NFi2+59tdru+++04rzEuQofH2qD1jEHrL4saI7T4qIUFK6+645UEwnVTruKMso
         5/CpmGJVA1ErEQlTgPzQaJoAN8p+pAOg0oc5fjEh+4wC0rs88R8D/ILGhxydNbwUO/OD
         TjOX0gwadX56uo3/NG3Hkb5zWp2QctN2lUyQnRegGpVqdt6T1ATa6bf/bv2q0o3Wkql3
         SAcQ==
X-Gm-Message-State: APjAAAW6aS9oxjtFdQmNoNSmNqmVJxHdVMvQ6woqZWyUTdiyneH0NWTq
        ntOWsQP0yfx+wRm5pTpFw19uc/NyT510dA==
X-Google-Smtp-Source: APXvYqyqiBPqzBlqrSy0IddkiaS8mVe5wE1mBhL3+Wr7Mc7NuyY5wAZi98T20HhHXDPdRGQKPx7oUQ==
X-Received: by 2002:a17:902:59d9:: with SMTP id d25mr21878plj.250.1572295563266;
        Mon, 28 Oct 2019 13:46:03 -0700 (PDT)
Received: from iclxps (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.gmail.com with ESMTPSA id z10sm6560789pfr.139.2019.10.28.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 13:46:02 -0700 (PDT)
Message-ID: <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
Subject: Fwd: [PATCH v5 1/4] sparc64: implement ioremap_uc
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     sparclinux@vger.kernel.org,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org
Date:   Mon, 28 Oct 2019 14:46:00 -0600
References: <20191016210629.1005086-2-ztuowen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding sparc list. Sorry, first time missed the list.

Looking for some reviews.

Patch set: Fix MTRR bug for intel-lpss-pci
https://lkml.org/lkml/2019/10/16/1230

Tuowen

-------- Forwarded Message --------
From: Tuowen Zhao <ztuowen@gmail.com>
To: lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net, 
Tuowen Zhao <ztuowen@gmail.com>, kbuild test robot <lkp@intel.com>
Subject: [PATCH v5 1/4] sparc64: implement ioremap_uc
Date: Wed, 16 Oct 2019 15:06:27 -0600

On sparc64, the whole physical IO address space is accessible using
physically addressed loads and stores. *_uc does nothing like the
others.

Cc: <stable@vger.kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
 arch/sparc/include/asm/io_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/io_64.h
b/arch/sparc/include/asm/io_64.h
index 688911051b44..f4afa301954a 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -407,6 +407,7 @@ static inline void __iomem *ioremap(unsigned long
offset, unsigned long size)
 }
 
 #define ioremap_nocache(X,Y)		ioremap((X),(Y))
+#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 
-- 
2.23.0


