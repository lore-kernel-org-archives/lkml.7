Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A65ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28EF2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="i8IC+ybA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502385AbfJQMe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:34:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38521 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfJQMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:34:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so1748764lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uMFWZhVs3nOLCl7bSNvnSRRP4v3iwqBQaN+r4cGzM5w=;
        b=i8IC+ybAH7Xu7kPM1yyi1ejpd2G+foax89r02+eIpDfbysN1/dJVRVOC1WXOjAP7R0
         n7QEgIsfDwQaR6XPB6O7Opdti6NPjAKKHaInhfmR/TBpfvfblOvLNtWbf+AODqeB4c1/
         M934EFwgtgZdAu3sspAjeymnEZ83UQyhEIU70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMFWZhVs3nOLCl7bSNvnSRRP4v3iwqBQaN+r4cGzM5w=;
        b=ZmLUTgF7FSHvfsvDBbMcYLIzARKMI7OLKg71Bra6KQqUFP/U+ZGMVG15aHMhVIQ2bT
         piqtdn5BWI0UnzQC2/BFqiDv7AJ3a0PW/rfGnYmXYpW20CY0GaE2CEkkUwRNSkIvD/ls
         9M0Bu9ZELgQ1yoVJn4HEzmhn9wCGnARXjK/qPxG9dC5pjD5T2MKfgdM8+/DMphQcH8DN
         Vc94VR2ZfLzFNf05rojnTeJX5TO1SxtfR344YAzRWsh+VXiNXys/KBf/lB9ViJwfo+mC
         jAie4OgSnLvlzZwTLLmPO9bgGxSbQSnZ+2qC9xP/JyONn2ubELqIsXTTORTTpcsJtp0X
         UKkg==
X-Gm-Message-State: APjAAAVTebAGyxG2CwpK2PHxceyLrvLTEPJYCFU2Nsf3+C+yFRjX213u
        9zZYpFVEPTJr4HWBzdAHpNDxgA==
X-Google-Smtp-Source: APXvYqwmJXI9/ifsToGepUzplMqcGqjd91BZPdQ3/V3K6BdotfwTLPKZg1XHe8tNSIfFdS4KkkB5AQ==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr1544119lfm.15.1571315694244;
        Thu, 17 Oct 2019 05:34:54 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y4sm1124965ljd.82.2019.10.17.05.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 05:34:53 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] watchdog servicing during decompression
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>, kernel@pengutronix.de,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
 <20191017120310.GD25745@shell.armlinux.org.uk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c4b6805b-67fe-6bce-1777-2d81e96b4ac9@rasmusvillemoes.dk>
Date:   Thu, 17 Oct 2019 14:34:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017120310.GD25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2019 14.03, Russell King - ARM Linux admin wrote:
> We used to have this on ARM - it was called from the decompressor
> code via an arch_decomp_wdog() hook.
> 
> That code got removed because it is entirely unsuitable for a multi-
> platform kernel.  This looks like it takes an address for the watchdog
> from the Kconfig, and builds that into the decompressor, making the
> decompressor specific to that board or platform.
> 
> I'm not sure distros are going to like that given where we are with
> multiplatform kernels.

This is definitely not for multiplatform kernels or general distros,
it's for kernels that are built as part of a BSP for a specific board -
hence the "Say N unless you know you need this.".

I didn't know it used to exist. But I do know that something like this
is carried out-of-tree for lots of boards, so I thought I'd try to get
upstream support.

The first two patches, or something like them, would be nice on their
own, as that would minimize the conflicts when forward-porting the
board-specific patch. But such a half-implemented feature that requires
out-of-tree patches to actually do anything useful of course won't fly.

I'm not really a big fan of the third patch, even though it does work
for all the cases I've encountered so far - I'm sure there would be
boards where a much more complicated solution would be needed. Another
method I thought of was to just supply a __weak no-op
decompress_keepalive(), and then have a config option to point at an
extra object file to link into the compressed/vmlinux (similar to the
initramfs_source option that also points to some external resource).

But if the mainline kernel doesn't want anything like this
re-introduced, that's also fine, that just means a bit of job security.

Rasmus
