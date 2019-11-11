Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B7F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8OzICbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKIlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:41:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36755 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:41:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so13632823wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KCmc19tl0wgB8bUYraCEnB0e8NL+pKss8TeCjXS/jF0=;
        b=Y8OzICbse73309NMJ0VjUGZCXN/87gY7N1Zjw2jaQerfgMOfFaswH3mL1xiDp0WTLp
         sasui6q5LZqGo8WTiMj6LyfPRc3+L9vnG5nv8+9rqkCRH4p8yFfP5rtEWaxQDpWmUxX8
         ZaJsidNBEvNG7iO9kBIKut8qTWbO4rxJIH9AmgWBE70l/GX3fWi6P1c3kL+AxYfBX5yh
         y7Mhd2s2TxaTdn9NTsN2ZA+u1J6zkt/NRRkhHg6N158vRohMwuGLm+PeWshYi6ZSFfe7
         Fu6/wgsMic4pNetCtv3s6g1qLg5q2tugKW0P7u1SNTxwdY6SvY8LC2G1T97WleOmeC34
         zFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KCmc19tl0wgB8bUYraCEnB0e8NL+pKss8TeCjXS/jF0=;
        b=uXLYLdGzZfFbmaXKXunI3foDdUsMUeeIOQOLKN4BQ1OCXEHBbN/m64MC59Fd6vGm58
         rH7Q5wDX4UZXoZ67PoaO3X7MGHq3i90XCyuJhG+3oHdAFHhVDIwzjozkn4+VEEOCd+wh
         PgtGX7LMVtplcr8Hug+llogwtF5Xt8TYVs4+o+2+pNWSADzXcy7bGhPHo3iKhJuFPgSV
         bO4W4/du+oACsWq1BZ/cN2cwz1iB90B+Ra6mbo3Rt0cQ2SF8zJs1S4ZU/iSHG1UVKIRU
         02/DB5kacugtLXolbWKjq7AZlLINfIFhHsgcqBbBD3p8EtMgJMdCxzqltkEssJKIVocV
         Keew==
X-Gm-Message-State: APjAAAXWBcg5L7BxJkbcvN24kjNDW+W9tnVs0c8O3mMItyuEBvkV2W8c
        SE1YqnqQzg6kJVYkbWvhXU3+Rw==
X-Google-Smtp-Source: APXvYqwovfXUYQZzwcYemWjNFlXPIj6YWwZTBOIPv8OqmNdKOB1tnj0rQhHNx/arAXytBG2Eynagzw==
X-Received: by 2002:adf:a553:: with SMTP id j19mr15552326wrb.184.1573461672797;
        Mon, 11 Nov 2019 00:41:12 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id x7sm39693490wrg.63.2019.11.11.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:41:12 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:41:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 2/4] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191111084105.GI18902@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191016210629.1005086-3-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016210629.1005086-3-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Tuowen Zhao wrote:

> Implement a resource managed strongly uncachable ioremap function.
> 
> Cc: <stable@vger.kernel.org>
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/io.h |  2 ++
>  lib/devres.c       | 19 +++++++++++++++++++
>  2 files changed, 21 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
