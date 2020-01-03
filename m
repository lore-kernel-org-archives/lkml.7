Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA71C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715072053B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 10:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="QWESwEUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgACKYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 05:24:03 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:35107 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACKYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 05:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578047041;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ptzf07pECs+0aSDlIJmrKwxK6Srl79d80vBcpL7VdiE=;
        b=QWESwEUyLbO9j0iNwmtArHv45UjmdG21ReRn9cNB4zylMrPATTgQuD7ZgIO/67jc2E
        bt/hR75aHtZ8qszUzeWYuvllOm8djdDV0uh84ZEsWc5bmI+4XkNrQGfhfyhRP+TOjdGR
        MaMPdwqHpaGtIXQWXtLg1D+Azm5En/DuJJLJkezHDJnBUSfPsVuY3O01/MHQPTK60K9z
        Ele5n5ZL+HnFUIMqVc8XuuAbz7THIej4qAS1nuWkCJ+g3mjaFqSgBxyMVg4JTgsZ1LLR
        nzRZ+BFef+EPwrLltS0R6REiGU+r9iGU0IkxyZIr7Gu7QEZneFor31qrE/6yDpeCrTeH
        NC+A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJDdPLYs76f"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.1.3 AUTH)
        with ESMTPSA id z012abw03ANqcuB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 3 Jan 2020 11:23:52 +0100 (CET)
Date:   Fri, 3 Jan 2020 11:23:47 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Barry Song <Baohua.Song@csr.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 055/191] mfd: mfd-core: Honour Device Trees request
 to disable a child-device
Message-ID: <20200103102347.GA879@gerhold.net>
References: <20200102215829.911231638@linuxfoundation.org>
 <20200102215835.819082035@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102215835.819082035@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 11:05:37PM +0100, Greg Kroah-Hartman wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> [ Upstream commit 6b5c350648b857047b47acf74a57087ad27d6183 ]
> 
> Until now, MFD has assumed all child devices passed to it (via
> mfd_cells) are to be registered. It does not take into account
> requests from Device Tree and the like to disable child devices
> on a per-platform basis.
> 
> Well now it does.
> 
> Link: https://www.spinics.net/lists/arm-kernel/msg366309.html
> Link: https://lkml.org/lkml/2019/8/22/1350

As far as I understand it, this commit is not suitable for backporting.
The link above explains the problem for a similar patch:

	But I believe this would introduce a rather ugly bug in
	mfd_remove_devices() if the first sub-device is set to disabled:
	It iterates over the children devices to find the base address
	of the allocated "usage count" array, which is then used to free it.
	If the first sub-device is missing, it would free the wrong address.

This problem does not exist in mainline because the MFD usage counting
was removed entirely as part of the larger "Simplify MFD Core" series [1].

None of the device trees in the stable kernels should depend on
disabling MFD devices from the device tree. (They were written at a time
when the MFD core ignored that request entirely...)
Therefore, I would suggest to drop this patch entirely.

[1]: https://lore.kernel.org/lkml/20191101074518.26228-1-lee.jones@linaro.org/

> 
> Reported-by: Barry Song <Baohua.Song@csr.com>
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Tested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/mfd/mfd-core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 23276a80e3b4..b0afefdc9eac 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -174,6 +174,11 @@ static int mfd_add_device(struct device *parent, int id,
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
> 2.20.1
> 
> 
> 
