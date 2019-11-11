Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D56C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C97C20856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 08:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DAu2HnwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfKKIlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:41:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53982 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 03:41:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id u18so4683667wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 00:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=D9ANwiExHt1yTMKRwFIcJkkf6Wu2KVUdWv6iFNiEGAA=;
        b=DAu2HnwLPOnhy8v0K0GB+6pFXgIA76ujbDLaAKDLnUy+UOcn0kdZAfgLyeJV7aBYOO
         ZtP7Lub1GggntYGQZhKlXdsBVMVyKIw/q6ucqxcxHpvovYVVWWXmXSkCFkl3FVORINxZ
         6JwPTGmn4tDFavjLKE8+U2SkwufzzlQUpoDb5aEL3QgxwvSazJ+bOrVeMezRQKaxX0be
         zsLkAzBnIJHNUVl9a+x+Wc967jUi//D0gxSKGynPgkkRdDXMjV4VzNvDfr1suGIYSsPU
         qQyEWSXCYFiaravcRo/tvNMGgmp/oHldr0WbE8vsSW3bTWgPB6d2JhJ13Wzcml4gvpEC
         G4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=D9ANwiExHt1yTMKRwFIcJkkf6Wu2KVUdWv6iFNiEGAA=;
        b=uJ2vFqHZU9DXRlw0Gj9TKbN3w/5Mw4BLAjNDX3JTmX2ZME4seqK34Wh5bBuPkv7g0a
         vtGvOjsvb5eZwbB328CBnzYwxdZ3Mvg5qp7vaCvrORITM2Fbxsl9D21x3Xwk8VpYeym9
         hT2NVGcyTJUnXYrKf8qhhqhpgg3icinRJDyjg5wxKXMMZNjouUAZgXlc+Z5wHlGwL1H7
         DEQe8FAnykPwfuF8910r+80/MBrF0kUd7O4FTJ/0qw/3ZC6QU4qNoLj15vrxkOwgR8qB
         LCPWPvBm9pnYmhr7UwaN7EcY9ByRYsI/v6puy21UkQiGjlWQWyyfH60Xxde14TfyaD8M
         MFsg==
X-Gm-Message-State: APjAAAWnDlg+y8tadAGilqsIhcTL9mEYAmPvmDVteHcbQKDA/u0WZo4i
        ZocHFXV0Ujh1uBig5afbAbIVEw==
X-Google-Smtp-Source: APXvYqxkSb+iisYPp5FReOjbmZuJmU+bKJxivtEunqIqofhaA6gynDXj0PAas1OyQbuYC5ErQnOgzQ==
X-Received: by 2002:a05:600c:3cc:: with SMTP id z12mr20946217wmd.151.1573461682052;
        Mon, 11 Nov 2019 00:41:22 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id b8sm14298485wrt.39.2019.11.11.00.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 00:41:21 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:41:14 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
        mcgrof@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v5 3/4] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191111084114.GJ18902@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191016210629.1005086-4-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016210629.1005086-4-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Tuowen Zhao wrote:

> Some BIOS erroneously specifies write-combining BAR for intel-lpss-pci
> in MTRR. This will cause the system to hang during boot. If possible,
> this bug could be corrected with a firmware update.
> 
> This patch use devm_ioremap_uc to overwrite/ignore the MTRR settings
> by forcing the use of strongly uncachable pages for intel-lpss.
> 
> The BIOS bug is present on Dell XPS 13 7390 2-in-1:
> 
> [    0.001734]   5 base 4000000000 mask 6000000000 write-combining
> 
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0 (i915)
>   4010000000-4010000fff : 0000:00:15.0 (intel-lpss-pci)
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203485
> Cc: <stable@vger.kernel.org>
> Tested-by: AceLan Kao <acelan.kao@canonical.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/intel-lpss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
