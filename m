Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D5C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB13B2075A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgAHBQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:16:16 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:36826 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgAHBQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:16:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1iozxD-0001AQ-83; Wed, 08 Jan 2020 01:16:11 +0000
Message-ID: <6c2151b5d9b07c7cc29cd484a80d0db213e5fa19.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v2 13/24] drm/etnaviv: reject timeouts with
 tv_nsec >= NSEC_PER_SEC
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>
Date:   Wed, 08 Jan 2020 01:16:09 +0000
In-Reply-To: <20191213205417.3871055-4-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
         <20191213205417.3871055-4-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-13 at 21:53 +0100, Arnd Bergmann wrote:
> Most kernel interfaces that take a timespec require normalized
> representation with tv_nsec between 0 and NSEC_PER_SEC.
> 
> Passing values larger than 0x100000000ull further behaves differently
> on 32-bit and 64-bit kernels, and can cause the latter to spend a long
> time counting seconds in timespec64_sub()/set_normalized_timespec64().
> 
> Reject those large values at the user interface to enforce sane and
> portable behavior.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 1f9c01be40d7..95d72dc00280 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -297,6 +297,9 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
>  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
>  		return -EINVAL;
>  
> +	if (args->timeout.tv_nsec > NSEC_PER_SEC)
[...]

There's an off-by-one error between the subject line and the actual
changes.  The subject line seems to have the correct comparison.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

