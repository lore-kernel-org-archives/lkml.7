Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw/aS0HG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfJULLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:11:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41174 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbfJULLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:11:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so13460372wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsofjz6mshTaTSConAGSTps6s034Gbt4rNbvJmgPEqI=;
        b=Qw/aS0HGq3uA01t/yK2JtENn3tenwrVO/oinZ+LDdFPK4K7lSstYeFd09mmDdBc6jA
         3BktjSCm9JK61WZrxMyUBtJz729Va8PGXWcVkr9koxvT3rnLTo5fjjcPgUMRhtwZ+3bA
         sENUFHX9WqL6LaQkdYyAwMeUmEJtYE0uPFHMxp+ONNs5OD7z2cnfd0FAvZEtHHWaU3PO
         T/bLU0Q43Xa0jrWmnJKSEC0CnvkvdEfZhjLnoiW/kNYB+TzxTiyUc6sJUIcKkUGyRJ63
         8RbLCwZ4mqIdbyYVvo6/AX+k1Y4rpIlq82KgLKKsNJ/9L/UOMU3VYVlR5FwLDxHqxlmx
         Lk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsofjz6mshTaTSConAGSTps6s034Gbt4rNbvJmgPEqI=;
        b=NJjee8guTaQwkq6sWc+Wx+ajxBVkvzIx2ilISuYuk+SyTy5NlTAguc/L5uQI0SAkBK
         UwtjMtRghAbe7jyYTuVt0LGLeL01Hrre1AvkyLuEn9ei6pRhm4BPkn55KpiMugK441HD
         fN/IdRWxl4YFalZK2kkftmGkv8DoVQOT+78Tnox4abMrfSyG2G0iE1LfKJGol+s44Gtx
         hIJPiNUWjv1tutoKlvODk5R1gGxII4/FnBJPLQ/nkwLTNAWI+7AacidWP38MffXOs+fK
         o60VVK0tZ0EMtctReOKlKctahbFHraUMBKTzgBz6tM66U4GxAovUNYDK+Q1xEk+xiz+o
         /gmw==
X-Gm-Message-State: APjAAAXstg/BQgAhYQZ+YopOMsUBuSZKZPob90hj0LsSkq4/I/Bs8Ryz
        N522TaBQvdVr2rMPBPZH/su0fn3OXevLzw==
X-Google-Smtp-Source: APXvYqyEz+wOiJ9o9r1cn1J6DkUMs1jnwJCJCpIDNRnyLkmBeyFlC0rvOrNwlbB3d87ARm18YQ94qQ==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr14617479wrx.90.1571656300623;
        Mon, 21 Oct 2019 04:11:40 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r81sm7985522wme.16.2019.10.21.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:11:39 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:11:37 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 2/9] mfd: cs5535-mfd: Remove mfd_cell->id hack
Message-ID: <20191021111137.ey6cbrrb2af3wj5i@holly.lan>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-3-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021105822.20271-3-lee.jones@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:58:15AM +0100, Lee Jones wrote:
> The current implementation abuses the platform 'id' mfd_cell member
> to index into the correct resources entry.  If we place all cells
> into their numbered slots, we can cycle through all the cell entries
> and only process the populated ones which avoids this behaviour.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/cs5535-mfd.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> index 2c47afc22d24..9ce6bbcdbda1 100644
> --- a/drivers/mfd/cs5535-mfd.c
> +++ b/drivers/mfd/cs5535-mfd.c
> @@ -62,26 +62,22 @@ static int cs5535_mfd_res_disable(struct platform_device *pdev)
>  static struct resource cs5535_mfd_resources[NR_BARS];
>  
>  static struct mfd_cell cs5535_mfd_cells[] = {

This array is sized from the initializer...

> -	{
> -		.id = SMB_BAR,
> +	[SMB_BAR] = {
>  		.name = "cs5535-smb",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[SMB_BAR],
>  	},
> -	{
> -		.id = GPIO_BAR,
> +	[GPIO_BAR] = {
>  		.name = "cs5535-gpio",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[GPIO_BAR],
>  	},
> -	{
> -		.id = MFGPT_BAR,
> +	[MFGPT_BAR] = {
>  		.name = "cs5535-mfgpt",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[MFGPT_BAR],
>  	},
> -	{
> -		.id = PMS_BAR,
> +	[PMS_BAR] = {
>  		.name = "cs5535-pms",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[PMS_BAR],
> @@ -89,8 +85,7 @@ static struct mfd_cell cs5535_mfd_cells[] = {
>  		.enable = cs5535_mfd_res_enable,
>  		.disable = cs5535_mfd_res_disable,
>  	},
> -	{
> -		.id = ACPI_BAR,
> +	[ACPI_BAR] = {
>  		.name = "cs5535-acpi",
>  		.num_resources = 1,
>  		.resources = &cs5535_mfd_resources[ACPI_BAR],
> @@ -115,16 +110,16 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
>  		return err;
>  
>  	/* fill in IO range for each cell; subdrivers handle the region */
> -	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
> -		int bar = cs5535_mfd_cells[i].id;
> -		struct resource *r = &cs5535_mfd_resources[bar];
> +	for (i = 0; i < NR_BARS; i++) {

... which means this translation from ARRAY_SIZE() to NR_BARS
is rather odd.

I don't care whether the array is sized using NR_BARS or the loop
uses ARRAY_SIZE() but IMHO the loop boundary condition must match
the array declaration.

With that fixed free to throw the following onto the next rev:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
