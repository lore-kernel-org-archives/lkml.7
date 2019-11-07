Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66B3206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Qpcx2anj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfKGS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:27:02 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:21572 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573151218;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Oqhe1WXoIbq8yVt8OzlAqvdDOM9RGB7JcT21P0FRSQk=;
        b=Qpcx2anj4TqpylsWHdwrCObqloiKcit4jenBhF9RfrxvPKRiLwEXPW9Gat1mtANi7X
        61aOYge/Y3MZl4bqw3u+gTunbPbeE3JQEkiuUoQow282JoCkKePfEp1VHjhXFtM3KHbM
        yoZWddnnfKH3DhwZsVSs68hFordkBJBNZsBwS/74CUNKZXfzEQjpv33rof57TxaXa5wS
        eH7fgpQRYEQGM3SNDsEM0GUFJKzj3wY+mBr8s9R7v/111flyfJMFrfF2uK4/WuNXSSes
        8pRGdyrdoIjg98x9Su/a85PGdGsVDnMCS+VS8IIoTTCF1xoUIZ5ld+8rhNyjiiWuSgmG
        EUVQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDd+zEsL6f"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vA7IQpoNh
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 7 Nov 2019 19:26:51 +0100 (CET)
Date:   Thu, 7 Nov 2019 19:26:45 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, broonie@kernel.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org,
        Barry Song <Baohua.Song@csr.com>
Subject: Re: [PATCH 1/1] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
Message-ID: <20191107182645.GA13813@gerhold.net>
References: <20191107111950.1189-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107111950.1189-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 11:19:50AM +0000, Lee Jones wrote:
> Until now, MFD has assumed all child devices passed to it (via
> mfd_cells) are to be registered. It does not take into account
> requests from Device Tree and the like to disable child devices
> on a per-platform basis.
> 
> Well now it does.
> 
> Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
> Link: https://lkml.org/lkml/2019/8/22/1350
> 
> Reported-by: Barry Song <Baohua.Song@csr.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Thanks for all your work on this issue!

FWIW:
Tested-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/mfd/mfd-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index cb3e0a14bbdd..f5a73af60dd4 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -152,6 +152,11 @@ static int mfd_add_device(struct device *parent, int id,
>  	if (parent->of_node && cell->of_compatible) {
>  		for_each_child_of_node(parent->of_node, np) {
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
> +				if (!of_device_is_available(np)) {
> +					/* Ignore disabled devices error free */
> +					ret = 0;
> +					goto fail_alias;
> +				}
>  				pdev->dev.of_node = np;
>  				pdev->dev.fwnode = &np->fwnode;
>  				break;
> -- 
> 2.24.0
> 
