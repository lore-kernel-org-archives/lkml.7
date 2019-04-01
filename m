Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C594C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102882070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e4y5sEcp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zqd+e1Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfDAMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:50:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:50:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 49A1D604BE; Mon,  1 Apr 2019 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554123031;
        bh=LnvAho8D76g0pkPeMNQFqSCLmkeRDkLzdfTzt87vcvo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e4y5sEcpf6Wb79zsRAfYmg4zo649JsTXRL+6YegfhZadjf0VeFLatt3IpY7XWt6n/
         VAlUexwfbbcZybMiHEE6LL4EwwnhsxrAu6agZBGRs4XKIbd7ym4VKJznRh/q880+fk
         S8k3Fn7tGGHmlzw9kx6ZDdS5I2+GlcyAA+xCsaQU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63FD4604BE;
        Mon,  1 Apr 2019 12:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554123028;
        bh=LnvAho8D76g0pkPeMNQFqSCLmkeRDkLzdfTzt87vcvo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Zqd+e1YgJENw1WayBd2fLD5zvlfVLRTiCbKsTsc472z6J0B1DGxcnPn9hc0DXSoTf
         tQ4cAyxmpwo3WcV5w3z8L1GDR5r+1ySVErd7JTWmQ/V9vEYWwWhKN9M966pKJ7DNYj
         zUXyedoXOHV6Lcu4bD3+IiqoCDluYv+1BfqPkZ40=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63FD4604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 04/12] phy: tegra: add missing of_node_put after
 of_device_is_available
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kernel-janitors@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
 <1550928043-14889-5-git-send-email-Julia.Lawall@lip6.fr>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <bb2f2129-8d68-9a55-1bc4-f6ffc26677c5@codeaurora.org>
Date:   Mon, 1 Apr 2019 18:20:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1550928043-14889-5-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/23/2019 6:50 PM, Julia Lawall wrote:
> Add an of_node_put when a tested device node is not available.
>
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>
> // <smpl>
> @@
> identifier f;
> local idexpression e;
> expression x;
> @@
>
> e = f(...);
> ... when != of_node_put(e)
>      when != x = e
>      when != e = x
>      when any
> if (<+...of_device_is_available(e)...+>) {
>    ... when != of_node_put(e)
> (
>    return e;
> |
> + of_node_put(e);
>    return ...;
> )
> }
> // </smpl>
>
> Fixes: 53d2a715c2403 ("phy: Add Tegra XUSB pad controller support")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
>
> ---
>   drivers/phy/tegra/xusb.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff -u -p a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -260,8 +260,10 @@ tegra_xusb_pad_create(struct tegra_xusb_
>   	int err;
>   
>   	np = tegra_xusb_find_pad_node(padctl, soc->name);
> -	if (!np || !of_device_is_available(np))
> +	if (!np || !of_device_is_available(np)) {
> +		of_node_put(np);
>   		return NULL;
> +	}
>   
>   	pad = soc->ops->probe(padctl, soc, np);
>   	if (IS_ERR(pad)) {
>
