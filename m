Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0FC2D0D0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26C206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XN0q7zkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLWLKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 06:10:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfLWLKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 06:10:51 -0500
Received: from zn.tnic (p200300EC2F0ED600297A4D444152E07C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d600:297a:4d44:4152:e07c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C0011EC068C;
        Mon, 23 Dec 2019 12:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577099449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXE87PJHq7Mky6QJfUw3GMJLqILPgTPNw6sDYTcvNn8=;
        b=XN0q7zkOglF1G3gL/sKFNsowVCsrnJMNIF2I4zK9g45vObLKKOAt4btlQAlxycfhRxpBpk
        mEfITlcezPTtUYBD6SjYv6NJNd1eVQAC9ALqISKfZgJrr5W0GhYskhHejmJhwxDlMbmCPF
        pUvbXoPbZiVwJihKT3NfgBpkCJG2xZA=
Date:   Mon, 23 Dec 2019 12:10:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: mdio: Add missing inline to
 of_mdiobus_child_is_phy() dummy
Message-ID: <20191223111037.GA25148@zn.tnic>
References: <20191223100321.7364-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191223100321.7364-1-geert@linux-m68k.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 11:03:21AM +0100, Geert Uytterhoeven wrote:
> If CONFIG_OF_MDIO=n:
> 
>     drivers/net/phy/mdio_bus.c:23:
>     include/linux/of_mdio.h:58:13: warning: ‘of_mdiobus_child_is_phy’ defined but not used [-Wunused-function]
>      static bool of_mdiobus_child_is_phy(struct device_node *child)
> 		 ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix this by adding the missing "inline" keyword.
> 
> Fixes: 0aa4d016c043d16a ("of: mdio: export of_mdiobus_child_is_phy")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  include/linux/of_mdio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/of_mdio.h b/include/linux/of_mdio.h
> index 79bc82e30c02333d..491a2b7e77c1e906 100644
> --- a/include/linux/of_mdio.h
> +++ b/include/linux/of_mdio.h
> @@ -55,7 +55,7 @@ static inline int of_mdio_parse_addr(struct device *dev,
>  }
>  
>  #else /* CONFIG_OF_MDIO */
> -static bool of_mdiobus_child_is_phy(struct device_node *child)
> +static inline bool of_mdiobus_child_is_phy(struct device_node *child)
>  {
>  	return false;
>  }
> -- 

I'm seeing it too with rc3.

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
