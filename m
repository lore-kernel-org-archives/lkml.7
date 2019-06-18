Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACC2C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D8C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560866994;
	bh=6K/wRG1IurOYIBuuzccqJIUPKFi908D9irK0M3WxPJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wPlPL2j9t61A7NkSYmXRsAKv6Vmv9yeMmFRdmya/X0M/al+p5XY5SIJ2NnOf6tn0P
	 fopq82JjHOfuLlKY6JVHBDSdZluErmZ90+9/GTvwnImZFeIR/HCnsOvKcEG4ZAF3aG
	 vu977pSC4asuL/Q9vAdV4sYu0ddubMF30TIiBtnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfFROJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:09:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42262 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfFROJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:09:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so15418887qtk.9;
        Tue, 18 Jun 2019 07:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GyQ7NHmIrnNmBSgVyVESd2wNXZg9DCHFi2yId0sHyBk=;
        b=PdPzkB6/dua425wtW3F0dvMUs/GCYBeQX5UxO6oDjU+MUc5yjhLO7zMX9SnVYRbO45
         T/D5kA30TBE9IQc3hdZw8lBsNKbVnSGzP0xrA2jMIS3a5AdFb/12kBs4BcQL4YuYCV+B
         ztvqAfdeCI7lK6hVkpaOq+EkAw1w2kIEODIyWj8d9Yoxu8VzhQj7pZuzsK8f5sQVAkuF
         FwBBLkTMLCn5ViyShaKslUMSZ75UmpPJics44VHeEdrh+Fya6F67S2Worla+a9KkTUD7
         uJwHVQFiMBo2vsUHGImwRjnf7PwOMQb9ge+M8c3CVYaNsmaaxDuMdaKVric7cR3ya95j
         eTCA==
X-Gm-Message-State: APjAAAXS+Sn+qJ8QcNxudDxI+YMD0uTiVndhf34CHVNmW0d2VkXb8Ny2
        8Znie1Cq8fDFaybT6It5iQ==
X-Google-Smtp-Source: APXvYqy9m96oP9T8hp2Tshk/w80pIqjMUf7CXez4snhNRdVA9CnKuTOFT+BYdJIoAUJv31L+/KSzPw==
X-Received: by 2002:ac8:3908:: with SMTP id s8mr99042910qtb.224.1560866990989;
        Tue, 18 Jun 2019 07:09:50 -0700 (PDT)
Received: from localhost ([64.188.179.192])
        by smtp.gmail.com with ESMTPSA id x10sm10883256qtc.34.2019.06.18.07.09.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 07:09:50 -0700 (PDT)
Date:   Tue, 18 Jun 2019 08:09:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH next v2] of/fdt: Fix defined but not used compiler warning
Message-ID: <20190618140948.GA18305@bogus>
References: <20190612010011.90185-1-wangkefeng.wang@huawei.com>
 <20190615030343.96524-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190615030343.96524-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2019 11:03:43 +0800, Kefeng Wang wrote:
> When CONFIG_OF_EARLY_FLATTREE is disabled, there is a compiler
> warning,
> 
> drivers/of/fdt.c:129:19: warning: ‘of_fdt_match’ defined but not used [-Wunused-function]
>  static int __init of_fdt_match(const void *blob, unsigned long node,
> 
> Since the only caller of of_fdt_match() is of_flat_dt_match(),
> let's move the body of of_fdt_match() into of_flat_dt_match()
> and eliminate of_fdt_match().
> 
> Meanwhile, move of_fdt_is_compatible() under CONFIG_OF_EARLY_FLATTREE,
> as all callers are over there.
> 
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> -Move the body of of_fdt_match() into of_flat_dt_match(), suggested by Frank.
> 
>  drivers/of/fdt.c | 99 ++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 54 deletions(-)
> 

Applied, thanks.

Rob
