Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A36DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF642146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xd7qynPF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UuwugYyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfCTMyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:54:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbfCTMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:54:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B0F09617AA; Wed, 20 Mar 2019 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553086453;
        bh=S+//d+8XRGfDWTwGoXAsPfcR4sX01lQTYFWyJMr879o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Xd7qynPFxcJhn9KbvabWEVeLyYbl3slK5n4m4P7Upl2KgJVZXXvIclx4Zwg/08kId
         VPM6eMEtrgeWxpsdhvWQVj7ACDx5+y/dd8VTPGkNk3gxZx7nomHWY4QS58qlT+8rrD
         kYazLI+rr/PMitQoC3FtDC50aT91I7NPSEXiu+rU=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EB7E615BE;
        Wed, 20 Mar 2019 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553086448;
        bh=S+//d+8XRGfDWTwGoXAsPfcR4sX01lQTYFWyJMr879o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UuwugYyKgv3HMOENBe4MwyhNGgVnlyHAPqaOtUbgiDd/gZa7HupzynhfiLRT8mbwl
         iSIDld5ldyPNzWT/tJ3GyngD0WhHe2Ck/6dbkTqrUjTkwgWT81hreZryGEaDQUKvDE
         c0R7bknjh7f/3eC1rUZUXuoSg+iTE2btkpH9XDHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EB7E615BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] thunderbolt: Fix to check return value of ida_simple_get
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190319172259.8874-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6e3d1501-be71-ac95-2f47-ab928b3bc026@codeaurora.org>
Date:   Wed, 20 Mar 2019 18:24:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190319172259.8874-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/19/2019 10:52 PM, Aditya Pakki wrote:
> ida_simple_get on failure can return an error. The patch ensures that
> the dev_set_name is set on non failure cases.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---


We should add check against `ida_simple_get` instead of svc->id >= 0 and 
clean up  svc.

Also, It seems clean up is missing when device_register fails and it is 
leaking svc.

Cheers,
Mukesh


>   drivers/thunderbolt/xdomain.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> index e27dd8beb94b..b1768f595259 100644
> --- a/drivers/thunderbolt/xdomain.c
> +++ b/drivers/thunderbolt/xdomain.c
> @@ -772,7 +772,9 @@ static void enumerate_services(struct tb_xdomain *xd)
>   		svc->dev.bus = &tb_bus_type;
>   		svc->dev.type = &tb_service_type;
>   		svc->dev.parent = &xd->dev;
> -		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
> +		if (svc->id >= 0)
> +			dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev),
> +					svc->id);
>   
>   		if (device_register(&svc->dev)) {
>   			put_device(&svc->dev);
