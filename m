Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6DAC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5375720869
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="f070bUpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfKFRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:47:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37425 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:47:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id p24so12970591pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jLVK2WlcaVQyNRbsc1cvkwH00Gi3//Qd+y3i+vGWGII=;
        b=f070bUplznEd4tDzRb/eMeXZaMF0IM6IL/8LpOtcRFLF6/+1cpjbGhaVbSILHJ1kbf
         l5LAWUGbg51jWEW/5felrEG2HybJOXvVSeSirZvJO5lwPlZp4jWfr4Q5Z+Qne0sJV3wa
         inukx8+Xq/L5BelohbepgUDT52nKqRZagq+QZ9KeSPpHhYk8olSqzVJZjFn3s/TCKx52
         2nXGBMGoJ7t7IZFyZ3lkHWwrZTNMKdvZUcn1tilPBOfLxMh8meGDG4QJW6E/AXixGtPc
         DM9ZfCiRaYyJR/Fzg8ZTroGl4lEVe4/8unKV0lrtedFAikOZHrwiHUoaPa80sQeHXgvp
         DlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jLVK2WlcaVQyNRbsc1cvkwH00Gi3//Qd+y3i+vGWGII=;
        b=e8PM+IDMCk/5jKpfOdTytqMYRsm98vD7KpjopGFgwhxVQE2G/hSWkWuwGtX+96Gs5l
         PqktkOnUQVattbDloqe87hbYeND6XAQYeyVv3Lv5oyaU62uWuowbNsSBvv5maGZuDa4j
         oPTi/9ryR0KJQLH0pOD219COlonsb6oMnTWBXi+LUHgV9xWPz6nvuG0WTyTEM71N8pFB
         pLT5sc6Ggrq4yHH28uyLCfMoqWRutu/2j9tXrdqF8W+V/BBHVxiL3P86Lk7XfjpWagYx
         iZA4mVWKI9k77i0i5KsNbvsvz3vimu29d2y7vKBhjwVeNrUxKMruIMTmVOp9J3f3tCMp
         9vQw==
X-Gm-Message-State: APjAAAWj95NO6RyuNzxM6BdxD64i0n7o4mVADqNTl5WvGspA/1IANMGx
        ybA8ceIAcM7YGbgFJajbtBFiek3TNFk=
X-Google-Smtp-Source: APXvYqyYNIYRggSXRQElqoLJQTOLynSrYJ7nZKm/MRTJ/TgRSe6f4yMAKEV6ZoQYqFXQladGruX/YA==
X-Received: by 2002:a63:81:: with SMTP id 123mr4418668pga.47.1573062474187;
        Wed, 06 Nov 2019 09:47:54 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s8sm9979435pgi.54.2019.11.06.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:47:53 -0800 (PST)
Date:   Wed, 06 Nov 2019 09:47:53 -0800 (PST)
X-Google-Original-Date: Wed, 06 Nov 2019 08:49:32 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Add multiple compression image format.
In-Reply-To: <20191106000652.8370-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-cf6b2a66-7749-4816-85a5-41a067eb5c32@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2019 16:06:52 PST (-0800), Atish Patra wrote:
> Currently, there is only support for .gz compression type
> for generating kernel Image.
>
> Add support for other compression methods(lzma, lz4, lzo, bzip2)
> that helps in generating a even smaller kernel image. Image.gz
> will still be the default compressed image.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/Makefile | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 0990a9fdbe5d..88356650c992 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -24,6 +24,18 @@ $(obj)/Image: vmlinux FORCE
>  $(obj)/Image.gz: $(obj)/Image FORCE
>  	$(call if_changed,gzip)
>
> +$(obj)/Image.bz2: $(obj)/Image FORCE
> +	$(call if_changed,bzip2)
> +
> +$(obj)/Image.lz4: $(obj)/Image FORCE
> +	$(call if_changed,lz4)
> +
> +$(obj)/Image.lzma: $(obj)/Image FORCE
> +	$(call if_changed,lzma)
> +
> +$(obj)/Image.lzo: $(obj)/Image FORCE
> +	$(call if_changed,lzo)
> +
>  install:
>  	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
>  	$(obj)/Image System.map "$(INSTALL_PATH)"

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
