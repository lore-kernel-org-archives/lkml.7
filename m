Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE07BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C92F20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDKIXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:23:19 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:53459 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:23:19 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hEUzK-000823-61; Thu, 11 Apr 2019 09:23:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 11 Apr 2019 09:23:13 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     thierry.reding@gmail.com, digetx@gmail.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: fix compile error when IOMMU API is not
 available
In-Reply-To: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
References: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
Message-ID: <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-04-10 23:47, Stefan Agner wrote:
> In case the IOMMU API is not available compiling host1x fails with
> the following error:
>   In file included from drivers/gpu/host1x/hw/host1x06.c:27:
>   drivers/gpu/host1x/hw/channel_hw.c: In function 
> ‘host1x_channel_set_streamid’:
>   drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit
> declaration of function
>     ‘dev_iommu_fwspec_get’; did you mean ‘iommu_fwspec_free’?
> [-Werror=implicit-function-declaration]
>   struct iommu_fwspec *spec = 
> dev_iommu_fwspec_get(channel->dev->parent);
>                               ^~~~~~~~~~~~~~~~~~~~
>                               iommu_fwspec_free
> 
> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

would it be better to provide something like this i nthe header that
defines dev_iommu_fwspec_get() to be:

static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device 
*dev) { return NULL; }

although returning an PTR_ERR would have been better.

> ---
>  drivers/gpu/host1x/hw/channel_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/host1x/hw/channel_hw.c
> b/drivers/gpu/host1x/hw/channel_hw.c
> index 27101c04a827..4030d64916f0 100644
> --- a/drivers/gpu/host1x/hw/channel_hw.c
> +++ b/drivers/gpu/host1x/hw/channel_hw.c
> @@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct
> host1x_job *job)
> 
>  static void host1x_channel_set_streamid(struct host1x_channel 
> *channel)
>  {
> -#if HOST1X_HW >= 6
> +#if IS_ENABLED(CONFIG_IOMMU_API) &&  HOST1X_HW >= 6
>  	struct iommu_fwspec *spec = 
> dev_iommu_fwspec_get(channel->dev->parent);
>  	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
