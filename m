Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F032C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E555F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="XuTR6bBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfFYK3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:29:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35709 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfFYK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:29:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so15728327ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BJvNPnbZj9zGBKXuVgxHHmB6XgCNQ719LVT/L+1Rnxk=;
        b=XuTR6bBeaKUEPh5UseQhYYmWqWAjNUjpRgAX7AjxbeZvduUacWiwx++x4y492nNlyJ
         EIQHpYkQUIM7XnxbkRk6C+yta1outhXZQMjawylDaxz7QXJfTykh9CiuLL5vgC/4Va2G
         a7cUrKWfE8IG5ZULQFCEoWbVnO/1l8O45A6uLrA5eZ6v4IQZyuGS7FckdCqLtDPlipsu
         ATOBHN8iT4W6Obl4voBrkbuXM+O2TR+2Fbf8P4qF69veEXHMpcTVbWNKQ0IZY3L4Cd2U
         OjUZ7CkDc/ZF8AIeBz4xW1OSQrX6fy/1KD+YiSSiq1Ji+UsKERGqccwZVKT+lLqVgPzf
         9m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BJvNPnbZj9zGBKXuVgxHHmB6XgCNQ719LVT/L+1Rnxk=;
        b=hfWKnwXSuCHY2FfH/8sW0x8xRbseihpavF8gQ/FRvd4wjXhq00AiAbI4GdlXKZZ9iZ
         B8AQaZtuYpU5Zmp5MeHO2CwQfBwGca+Q5D7D8rotl9fXIIIXTS8COsLyXxYnKsNJ6wgT
         v7YX2yhFzAGj+Y0oY4GSCBB3/5YfP21nwGRfJYRxAuEa2Rlm70uHwaLXB7uDX8mzMFKS
         GlboWSQR7P+zW5A3baNj1kjJbcY02eynPRjrF/caX4WDGJSZXlT7fMJ+WNdGJDZAVdAr
         NCBwimvULuRuilLVQGdR/TunxkYDg2dtPIRjytGyFJ1xP5DLq0oB0mANLMgswthJCH+E
         kzBQ==
X-Gm-Message-State: APjAAAX5eOsbqCExjeCvkSIgJmG/Tc4aYQEN4E+eqrgLo82wDXZ5m/IZ
        3PTEAUb/Fh10lfRgEHZNV96Gmw==
X-Google-Smtp-Source: APXvYqzZrJaehMzYIKdHcvNvYc3CnjfleAEBrYTTtIQcy5nKdqK/0MyQ6sURR/CIPhIrmkkSaB30rA==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr55277216ljp.202.1561458568940;
        Tue, 25 Jun 2019 03:29:28 -0700 (PDT)
Received: from [192.168.1.100] ([213.87.147.32])
        by smtp.gmail.com with ESMTPSA id j7sm2539448lji.27.2019.06.25.03.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:29:28 -0700 (PDT)
Subject: Re: [PATCH net-next] net: stmmac: Fix the case when PHY handle is not
 present
To:     Jose Abreu <Jose.Abreu@synopsys.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <351cce38d1c572d8b171044f2856c7fae9f89cbc.1561450696.git.joabreu@synopsys.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <895a67c1-3b83-d7be-b64e-61cff86d057d@cogentembedded.com>
Date:   Tue, 25 Jun 2019 13:29:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <351cce38d1c572d8b171044f2856c7fae9f89cbc.1561450696.git.joabreu@synopsys.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 25.06.2019 11:19, Jose Abreu wrote:

> Some DT bindings do not have the PHY handle. Let's fallback to manually
> discovery in case phylink_of_phy_connect() fails.
> 
> Reported-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> Fixes: 74371272f97f ("net: stmmac: Convert to phylink and remove phylib logic")
> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> ---
> Hello Katsuhiro,
> 
> Can you please test this patch ?
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index a48751989fa6..f4593d2d9d20 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -950,9 +950,12 @@ static int stmmac_init_phy(struct net_device *dev)
>   
>   	node = priv->plat->phylink_node;
>   
> -	if (node) {
> +	if (node)
>   		ret = phylink_of_phy_connect(priv->phylink, node, 0);
> -	} else {
> +
> +	/* Some DT bindings do not set-up the PHY handle. Let's try to
> +	 * manually parse it */

    The multi-line comments inb the networking code should be formatted like 
below:

	/*
	 * bla
	 * bla
	 */

> +	if (!node || ret) {
>   		int addr = priv->plat->phy_addr;
>   		struct phy_device *phydev;
>   

MBR, Sergei
