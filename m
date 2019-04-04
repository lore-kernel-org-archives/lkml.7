Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C471C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A28A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JyzFFT8x";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EcFOgzZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfDDJy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:54:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfDDIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4926D616BA; Thu,  4 Apr 2019 08:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367952;
        bh=yoLu/o28ZD1QndvsKomVuSCI7v9By4sVSI2CeABFZe4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JyzFFT8xxCcTiAlR8iZQYcQbUz7mrrGbxvSW3RhV9z6WMCyZYrn011lkBTZ9hmr8h
         vnXd6gF/Fmq9MzDnpYek/vwgXBp4VCltxPOTwRuBLl972YobifggkyP8DIld/gTMo0
         grURxSdRrB3pZN8xHMiMXC/95hnX2TG7bcnGynaI=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23C736079C;
        Thu,  4 Apr 2019 08:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554367949;
        bh=yoLu/o28ZD1QndvsKomVuSCI7v9By4sVSI2CeABFZe4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EcFOgzZzVmKMOFP5+yhnqQXZRn4r0S4V/lnH2ZXo0pIoCKaIFcDH8nodouwNtEwMk
         XAsKu+HSpIUp6Pukh9m2LC6E6qqsiRGRY0KgRRgOoDq4IGiRVbsmZtcdKWECveMueH
         E2BU/FBb9wh8HD0qhGwc6QC+7c4VcnP5YqtjiIE4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23C736079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] soundwire: cdns: Fix compilation error on arm64
To:     Jan Kotas <jank@cadence.com>, vkoul@kernel.org,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190404081221.341-1-jank@cadence.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ed49c2d9-dba1-1de6-0178-651f6567e3c3@codeaurora.org>
Date:   Thu, 4 Apr 2019 14:22:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404081221.341-1-jank@cadence.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:42 PM, Jan Kotas wrote:
> On arm64 the cadence_master.c file doesn't compile.
>
> readl and writel are undefined.
> This patch fixes that by including io.h.
>
> Signed-off-by: Jan Kotas <jank@cadence.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/soundwire/cadence_master.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index cb6a331f4..0b5bcc209 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -9,6 +9,7 @@
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
> +#include <linux/io.h>
>   #include <linux/module.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/soundwire/sdw_registers.h>
