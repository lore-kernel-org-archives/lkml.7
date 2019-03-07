Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F017C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D7520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbU/e/5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCGSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:13:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43687 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCGSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:13:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so12040623pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQjfEuWWPGlxVOFdaO+RnpbsWJ3NkSCVY4/xY49b5ak=;
        b=vbU/e/5/QeXMXOrI1YPxmI+V3wYWcqXTo6pO4TAcik2KDwjFJdHAOd/sofaqpBmIG5
         KYe7EgszOiawv4ZIlhHH8W19VuJg6E5VLU1xgIHq5whfPEOUF7HTUaw59bjWGdrD698G
         PGqz/Zm4g3JvtoXDQh5usNJ4uKCucoeHFRTW7Ii5EbRks++7HkNnpP7EtRkPhlhYZSaa
         b2UcqBLourfr480pqmYxlt/EIao2nzZ2nrH4ObL/YK08kg4A0MAUfJWNccpkUootMhH5
         Sdbc0mIXvgXbhRbD8gnrI4IAImGj7qFvmcVRixGOdwbfqGheKLDoDMyBKk11ihvYBtEM
         n/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQjfEuWWPGlxVOFdaO+RnpbsWJ3NkSCVY4/xY49b5ak=;
        b=e6rDcLphUuxhO9qaKdxZ3Kzoevr+a/SxiDC0o+fIGIqKdfQSe858gDeyLGo5b0IiFR
         T6gZ5CdMah7L3fKmhZuB31SSS4jYTAcaigJ06aIZiWni3bO7zbx3HCpwdjSbxKD3ljCu
         +tYf4mHpEa+av6ieUkhfrH4IphUHjbdO+B4HlZq/CFO1iNc2BtdCVCZmbdRns8rFPv+u
         E+j6xnvHISz1AUWx0o78eyjOUAnIl7zHmgZWTpD3WDu+NfG+jZnujDz0xeuz+NaA341P
         r6AZtM+h9dOtX5LaG19hEmThCAYMhAYQPT6wpMBcqZeCwc47BIfNvsxt6LpefXCbZ03v
         GU3w==
X-Gm-Message-State: APjAAAWUaWs3Dz6DHCSSUIxemVOAW3lPmKq7Wy3fKdGOjr49nC7Clcq1
        jGB/LlV4rYSK482IPF/tZFjsQgpTNX8HNp41rD9NMw==
X-Google-Smtp-Source: APXvYqzQ9NSuypziQqqFe860leXDVL3Xmy19jNxDyNv0Vkvoluj93Ot6fP+Nvqm5P5bbtps/wne847HtxGa5aIn/hn8=
X-Received: by 2002:a63:40c1:: with SMTP id n184mr12006577pga.225.1551982389545;
 Thu, 07 Mar 2019 10:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20190307162101.29204-1-natechancellor@gmail.com> <20190307180027.6226-1-natechancellor@gmail.com>
In-Reply-To: <20190307180027.6226-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:12:58 -0800
Message-ID: <CAKwvOdkfjR98zrjA0i--EmTg75FZv83efZPmSQTe191AhTAhEg@mail.gmail.com>
Subject: Re: [PATCH v2] net: stmmac: Avoid sometimes uninitialized Clang warnings
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 10:00 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:495:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:532:3: warning: variable 'ns' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:741:3: warning: variable 'sec_inc' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
>
> Clang is concerned with the use of stmmac_do_void_callback (which
> stmmac_get_timestamp and stmmac_config_sub_second_increment wrap),
> as it may fail to initialize these values if the if condition was ever
> false (meaning the callbacks don't exist). It's not wrong because the
> callbacks (get_timestamp and config_sub_second_increment respectively)
> are the ones that initialize the variables. While it's unlikely that the
> callbacks are ever going to disappear and make that condition false, we
> can easily avoid this warning by zero initialize the variables.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/384
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

V2 LGTM, thanks for resending.

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Respect reverse Christmas tree variable ordering in
>   stmmac_hwtstamp_set.
>
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e2a13ec2e30b..97c5e1aad88f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -480,7 +480,7 @@ static void stmmac_get_tx_hwtstamp(struct stmmac_priv *priv,
>                                    struct dma_desc *p, struct sk_buff *skb)
>  {
>         struct skb_shared_hwtstamps shhwtstamp;
> -       u64 ns;
> +       u64 ns = 0;
>
>         if (!priv->hwts_tx_en)
>                 return;
> @@ -519,7 +519,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
>  {
>         struct skb_shared_hwtstamps *shhwtstamp = NULL;
>         struct dma_desc *desc = p;
> -       u64 ns;
> +       u64 ns = 0;
>
>         if (!priv->hwts_rx_en)
>                 return;
> @@ -564,8 +564,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
>         u32 snap_type_sel = 0;
>         u32 ts_master_en = 0;
>         u32 ts_event_en = 0;
> +       u32 sec_inc = 0;
>         u32 value = 0;
> -       u32 sec_inc;
>         bool xmac;
>
>         xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190307180027.6226-1-natechancellor%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Thanks,
~Nick Desaulniers
