Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF54C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719E20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWFdr07r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCGPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:31:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46415 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:31:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so13795411edy.13;
        Thu, 07 Mar 2019 07:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRxbOE53Ja7Pi5yq9dWyQSKq1h628jf5nvvkcUfp3NY=;
        b=dWFdr07rpcwCQHP36QnW0uX3VCLJrFsczSQHDNGoUmSGTeTBqZ4HJe+hR5kElNgV0/
         ZytjRdCcreF3O8ce9/MVGlyR5JK0JroMYyYDoMi7kQH9lUZ3Dk1bvfgWBMG21a5nlyLY
         4UATE6IYmsDlpdqrkul08cLkdMA4Qe3MxjehZ27FgHp/mW00OLtMo4CPGNGy0rx3b25R
         MjEqA6QZujICJnml4/QYruV0PmHGfoSKQALNmk8mrkMnDQHi2EFGM+wtLJTiMRsd3+tu
         JxhBRpuT+SEiB7kBO8qaiSvTs2O87WOpVTXjaDnLmEXQK1S+nSMLb/v5Dx95IxtRi440
         wtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRxbOE53Ja7Pi5yq9dWyQSKq1h628jf5nvvkcUfp3NY=;
        b=ZA2JEPc5mPKQsDr/o87qsjqXvyneJutvcFJJ1GIRVszkPmoVy1zBzf9PXqz4F+nRmU
         70P8CRh0eQqxaaqKRRglHS6Lcaa3t4NbYlEU7XQ+TE/7MRc86QBdwyrpuUMMskf3AQ52
         sSyNE/sAXKp1jmPd2ssMpuRVjy4gxt7vkNUis8i8LMHEXW4cB8PkJ80dLHDBJ3Uk3oFZ
         0PIaRi9pqt20NeLyB2zMAEa4xFkrjWx0fQIDRTbLIVJM3/mxSTbf2h5qy7Wty3r6m+5Z
         pp83qeJjvyRzLoms+WrpD6O4Qp/cxyMVj50yuIxFcLRAjfgPkGgxzK5REjsDJVewafSt
         cvjg==
X-Gm-Message-State: APjAAAXXg2Fld85d5DMKOaAWbomBtcDA7K3gsoMuVeVQSm7RRZ3J4Pnm
        W07SeRyjUmSxAXzwLmxoRvw=
X-Google-Smtp-Source: APXvYqxLXjgKxhPUdOwtFhBcSv5tYJ+pB/7QI/BpnvzuJVuhxCVIKfYxN5SJ7Hb5HuEoth0xNlEmSA==
X-Received: by 2002:a17:906:95c3:: with SMTP id n3mr8424519ejy.59.1551972706635;
        Thu, 07 Mar 2019 07:31:46 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id a51sm1434907edd.57.2019.03.07.07.31.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:31:45 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:31:43 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peak_usb: fix clang build warning
Message-ID: <20190307153143.GI20201@archlinux-ryzen>
References: <20190307103219.1539316-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103219.1539316-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:31:55AM +0100, Arnd Bergmann wrote:
> Clang points out undefined behavior when building the pcan_usb_pro driver:
> 
> drivers/net/can/usb/peak_usb/pcan_usb_pro.c:136:15: error: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Werror,-Wvarargs]
> 
> Changing the function prototype to avoid argument promotion in the
> varargs call avoids the warning, and should make this well-defined.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Link: https://github.com/ClangBuiltLinux/linux/issues/109
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

I wonder if the format specifier in the pr_err statement at the end of
this function should be updated.

> ---
>  drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> index d516def846ab..b388406ac0f5 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
> @@ -127,7 +127,7 @@ static u8 *pcan_msg_init_empty(struct pcan_usb_pro_msg *pm,
>  /*
>   * add one record to a message being built
>   */
> -static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, u8 id, ...)
> +static int pcan_msg_add_rec(struct pcan_usb_pro_msg *pm, int id, ...)
>  {
>  	int len, i;
>  	u8 *pc;
> -- 
> 2.20.0
> 
