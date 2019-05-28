Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EC9C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612D42075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfE1InV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:43:21 -0400
Received: from ns.iliad.fr ([212.27.33.1]:59964 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE1InV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:43:21 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 3BE4020D88;
        Tue, 28 May 2019 10:43:20 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 23ADB20C11;
        Tue, 28 May 2019 10:43:20 +0200 (CEST)
Subject: Re: [PATCH 1/1] drm/panel: truly: Add additional delay after pulling
 down reset gpio
To:     Vivek Gautam <vivek.gautam@codeaurora.org>, airlied@linux.ie,
        thierry.reding@gmail.com, daniel@ffwll.ch
Cc:     Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190527102616.28315-1-vivek.gautam@codeaurora.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7dfcf294-6ab1-c1ce-352d-dfdeec4347af@free.fr>
Date:   Tue, 28 May 2019 10:43:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527102616.28315-1-vivek.gautam@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue May 28 10:43:20 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 12:26, Vivek Gautam wrote:

> MTP SDM845 panel seems to need additional delay to bring panel
> to a workable state. Running modetest without this change displays
> blurry artifacts.
> 
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  drivers/gpu/drm/panel/panel-truly-nt35597.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> index fc2a66c53db4..aa7153fd3be4 100644
> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> @@ -280,6 +280,7 @@ static int truly_35597_power_on(struct truly_nt35597 *ctx)
>  	gpiod_set_value(ctx->reset_gpio, 1);
>  	usleep_range(10000, 20000);
>  	gpiod_set_value(ctx->reset_gpio, 0);
> +	usleep_range(10000, 20000);

I'm not sure usleep_range() makes sense with these values.

AFAIU, usleep_range() is typically used for sub-jiffy sleeps, and is based
on HRT to generate an interrupt.

Once we get into jiffy granularity, it seems to me msleep() is good enough.
IIUC, it would piggy-back on the jiffy timer interrupt.

In short, why not just use msleep(10); ?

Regards.
