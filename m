Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A048C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E44721850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpdFsSOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfB1Arv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:47:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbfB1Arv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:47:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so8803182pgl.5;
        Wed, 27 Feb 2019 16:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H3hXfDj0PXBoFA9cGgNBp7TmibItk5rJ8IiapF7qRlI=;
        b=FpdFsSORXTE5ALYt/FEXzffH7PDPJuT7po/2MhlkDBB//oLyzu6aeKWhqQ+awdLqqX
         t1arCbISgUK0YFJNR0PODGctCHdIuymlgyOCnBhLZzGYBN59S9wB+B8VvY2xYBlIkUQe
         /RqKqh6T3GMhyrum2Ugp5n+ZYzx3/0Dd1CgZP50Dfea7Xd/gBisQO5IfEtMz9hX+hiyk
         HaGA93icCJAbnMJZtFI1yIgX2y0CmFIF2SBmhyM+xJdU/4IV7FJoaq+irIe4vREsiits
         5cXr/aP6Rk6Ju20tyG2SWhaUD6ExAjM4lgFl9HueMix4rPE3hIZIfTOZbl3N/glgaXW4
         V8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H3hXfDj0PXBoFA9cGgNBp7TmibItk5rJ8IiapF7qRlI=;
        b=ofTHc1nkIUgKl+TZscI19CDTQlaozIZRuTyMhXwnJTqxhdr9aiyWN5FGKYt7Po6sS5
         glKagXUzBW/wGWIj5cw12WM3UOzdZRjPqN8r3BwKcLlFivSbTHWFU0z0Xpc5f6v3dACA
         pSHOQzhsLWoB+IAjZ3sMolOIQIR88YTG/oi/XQUIAApFPgwVCMD3UvNAuSTKUHt7U4Oi
         f5et8nhIfoQXiYQNz7plBR9PIdNz7TN6Hb2UXjKo7WevQLwvfzVzfqAYPaLw9VfJeWR4
         RfXKsmIU8G0VYWpgUoQ927bUMBH/4KuIdRZmwaIBxCpUCFKf714r4UG4C7Os2wbldanr
         YHtg==
X-Gm-Message-State: AHQUAuZ08UP16/vfcbNmVswR/4NqJmFMqd6G1NUmFP9wObgAJVoWrToR
        kZO9YByjOMN9mLTGnK/4pw8=
X-Google-Smtp-Source: AHgI3IZhh1JFXZBlrrbqGTkMOIDkp0jCdJZyTpl42phRKA6pJQ3SiAvO0ijYaGWfFyh8Rvp5uGiN2g==
X-Received: by 2002:a65:51c3:: with SMTP id i3mr5670927pgq.45.1551314870020;
        Wed, 27 Feb 2019 16:47:50 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::87c4])
        by smtp.gmail.com with ESMTPSA id a24sm21150495pfo.160.2019.02.27.16.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 16:47:49 -0800 (PST)
Date:   Wed, 27 Feb 2019 16:48:00 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] net: seeq: replace kmalloc / memset(,0) with kzalloc
Message-ID: <20190228004800.GA26378@bobby.localdomain>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
 <5ff7bcf7b8db8daa129703e5f7b632825f25c766.1551246708.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff7bcf7b8db8daa129703e5f7b632825f25c766.1551246708.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:09:54PM -0800, Robert Eshleman wrote:
> This patch reduces a call to memset(,0) by replacing
> a kmalloc call with a kzalloc call.
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  drivers/net/ethernet/seeq/ether3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/seeq/ether3.c b/drivers/net/ethernet/seeq/ether3.c
> index d1bb73bf9914..7456cf08a48f 100644
> --- a/drivers/net/ethernet/seeq/ether3.c
> +++ b/drivers/net/ethernet/seeq/ether3.c
> @@ -223,7 +223,7 @@ ether3_addr(char *addr, struct expansion_card *ec)
>  static int
>  ether3_ramtest(struct net_device *dev, unsigned char byte)
>  {
> -	unsigned char *buffer = kmalloc(RX_END, GFP_KERNEL);
> +	unsigned char *buffer = kzalloc(RX_END, GFP_KERNEL);
>  	int i,ret = 0;
>  	int max_errors = 4;
>  	int bad = -1;
> @@ -231,7 +231,6 @@ ether3_ramtest(struct net_device *dev, unsigned char byte)
>  	if (!buffer)
>  		return 1;
>  
> -	memset(buffer, byte, RX_END);

Byte is not zero, so the intent of this patch does not apply here.
Dropping this from the patch set in v2.


>  	ether3_setbuffer(dev, buffer_write, 0);
>  	ether3_writebuffer(dev, buffer, TX_END);
>  	ether3_setbuffer(dev, buffer_write, RX_START);
> -- 
> 2.20.1
> 
