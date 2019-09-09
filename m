Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2DC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541C2218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbfIISWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:22:34 -0400
Received: from mout02.posteo.de ([185.67.36.142]:37539 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfIISWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:22:34 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A3A552400FD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 20:14:53 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46RxCH3tqVz9rxH;
        Mon,  9 Sep 2019 20:14:51 +0200 (CEST)
Date:   Mon, 9 Sep 2019 20:14:50 +0200 (CEST)
From:   Marc Dietrich <marvin24@gmx.de>
X-X-Sender: lucile@macbook-pro.fritz.box
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: make use of
 devm_platform_ioremap_resource
In-Reply-To: <1567935662-8006-1-git-send-email-hariprasad.kelam@gmail.com>
Message-ID: <alpine.OSX.2.21.1909092010430.4245@macbook-pro.fritz.box>
References: <1567935662-8006-1-git-send-email-hariprasad.kelam@gmail.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hariprased,

On Sun, 8 Sep 2019, hariprasad@MISSING_DOMAIN wrote:
                              ^^^^^^^^^^^^^^^^^^
something is wrong with your git mail config...

> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>
> fix below issue reported by coccicheck
> drivers/staging//nvec/nvec.c:794:1-5: WARNING: Use
> devm_platform_ioremap_resource for base
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Acked-by: Marc Dietrich <marvin24@gmx.de>

Thanks!

Marc

> ---
> drivers/staging/nvec/nvec.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 1cbd7b7..360ec04 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -767,7 +767,6 @@ static int tegra_nvec_probe(struct platform_device *pdev)
> 	struct device *dev = &pdev->dev;
> 	struct nvec_chip *nvec;
> 	struct nvec_msg *msg;
> -	struct resource *res;
> 	void __iomem *base;
> 	char	get_firmware_version[] = { NVEC_CNTL, GET_FIRMWARE_VERSION },
> 		unmute_speakers[] = { NVEC_OEM0, 0x10, 0x59, 0x95 },
> @@ -790,8 +789,7 @@ static int tegra_nvec_probe(struct platform_device *pdev)
> 		return -ENODEV;
> 	}
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(dev, res);
> +	base = devm_platform_ioremap_resource(pdev, 0);
> 	if (IS_ERR(base))
> 		return PTR_ERR(base);
>
> -- 
> 2.7.4
>
>
