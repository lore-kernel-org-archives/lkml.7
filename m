Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5D7C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4270E206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgiMmBbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfLPLDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:03:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfLPLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:03:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so2501584wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=upjGYkZqZYKQQ1aSiBhxjtA8tPUTNd9STSo2heTQlKo=;
        b=DgiMmBbc3XYOjeI0isWd2VCBorba3D4aLArPEvxn+DHWraLRt73SMTNLGi1FXgnGC/
         elIJ+/hu1xmT23g5vMz6hg/Mnvi3Se3jQoCcVvs3Rf17/OKioIOZQ1r85uNMcdqrCSSg
         ES1FbPYr3EDaPkUj1lXEg4nFJZjotOe6oOtEgPNFXn9rqESkK1fjyFdSJ3aWbcnJdRfK
         jzNKdjqX8hNXdFxyQCWRtA/bmeH7/yMjLi5d8s18gYl8jgKw23c+e8RFGblEoEL1HvOH
         TFAlcUz5uYH73KTLFq3m/1iaw0eocEtSvMjHftJ4QXjN41GFSKhouNIYmHgVNw5gVJzp
         SGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=upjGYkZqZYKQQ1aSiBhxjtA8tPUTNd9STSo2heTQlKo=;
        b=SbjnQluOJP1PahCd6r2ATwMpniIL4R7n2/bWv4U53TFEfNfvrgbLyH4vHtIsbKRUGg
         z26A8rBGw3c08hEH3zRpINOmIq8lACAt8Se6hSkEBMTXpi9iH09qmrtFK3IQ4gbQ9Cmw
         3fgfhuj6Is21WSo2TEJ9SPDKFGRA06kM8emNmBnw58GC8lQDwMtOAAqMOhkhMGbRR3DL
         ydbf/1GLf9TP7KD5FKyM55IgAE6r2z/7nyEIq0UpB2IMgHPJwOS8wFxCHP1EVtBP83n7
         w3AYH1mHAjgETEOpf1sHNv/FBoDav6oeKgLs2altgjpWPZIkKfNo9gClUYZdFenotEDF
         MikQ==
X-Gm-Message-State: APjAAAVomvUUFtn6lB6OfXFjIcAT935JqXgNKkQD1DZkEABveKB/Y3XF
        hEhVHvCejTLQ8MVjQH/SRC3sK+lJb/s=
X-Google-Smtp-Source: APXvYqzDEtPf6hz1M4rCPCyKgQBoshf+86oUwaVQZlbVRiOSEN92y243LBjTNvXUVxZ+Fm0eIZdBQA==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr28599465wrs.330.1576494199982;
        Mon, 16 Dec 2019 03:03:19 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id t5sm20744255wrr.35.2019.12.16.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 03:03:19 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:03:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Jasper Lake PCI IDs
Message-ID: <20191216110318.GI3601@dell>
References: <20191209141507.60298-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191209141507.60298-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Dec 2019, Andy Shevchenko wrote:

> Intel Jasper Lake has the same LPSS than Intel Ice Lake.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
