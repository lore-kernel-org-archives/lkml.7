Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4B12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfCYJQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:16:23 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50689 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfCYJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:16:22 -0400
Received: from [192.168.178.52] ([109.104.40.77]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIxBa-1hOMOB0cyg-00KLf7; Mon, 25 Mar 2019 10:15:53 +0100
Subject: Re: [PATCH] vc04_services: vchiq_arm: fix a NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Tobias_B=c3=bcttner?= <tobias.buettner@fau.de>,
        Eric Anholt <eric@anholt.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-rpi-kernel@lists.infradead.org, pakki001@umn.edu,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org
References: <20190324224331.1163-1-kjlu@umn.edu>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <61d81106-ec5a-c5a1-4757-85cdc7944f41@i2se.com>
Date:   Mon, 25 Mar 2019 10:15:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324224331.1163-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:9uuwymMZl51TYvO3F/CzGTAwI2xnDWTNJqMa/098EHmEjagAuY2
 DOkR7ftkM3w5K5UAZCWkafD0lMX/aq6vvfZrLQm6OVmWLREKl2pdXBIZMS1YcNKwjt6TWUA
 hP3y7wox8lKDDYzdOI6sxF1niQwQwk3+HR3mp98pR4GhVsOdfEXYAU+v2p9x6jrIkkWBfTS
 Crs1/7U3Oo2I4rPx4ilQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fNl+24C9bGM=:wvZgp9etrvla3y5funjoBy
 ziTKAy+5ERZWlBxdjR9+MZkjBpfEeWIFm2Nj7BTSgpPqREBOS/sZmfFthF7/NkkLmBrlBMlUk
 4chooValJDKgZNnbf5qUTUCM1vpMD+g/cg6EhRcmwaCx9N32r1RuI85K4BEFPFzA7RqpVZdF4
 9MPUso27U2E2ER1TIvTzFALwLelVhGTSaecJfqvLevgb0VnTuz0zajsMVn/+ZBHmollzaiQt2
 II73yfip9fylWfFsxkHWbu6q+gBN/eDlWfXYvzcr895AQUeNlJTTwzd+Kme/puZI+IBHq/5zM
 7y92/DJfJkzP4d+lj6tzOrveh06naGrKhQtIdbO1BJCo7lK5MRvDXsQ0d86ypVTFssgS8W8Ip
 GReprMspPg9nhesv2H3FExr8x86puq6iy4AyKpAMDx/Klk70PK+x3g1gqrhK50RfN5knyrzDN
 P7wxMsv2s7yDAjIrT+pLYn2Igf99rTxyePX0phvuYl+sXKYGQauXYv863F96H9vJ8lQi2e3+R
 ZTTaN6QUY0r/37wtsT05yJkbhHI5Z7ssstd5qVVh632pXHGtXk6T5slfz9exp1X9qLRrbpY10
 4vmm3egmfO0ZfaPhlPNL/GcnvJQjl7FSq4h1ZTrV6YoIP50SnjE8eH1kAJnmaV1K7uxLeJEW3
 jUhU96S2sVgb+LS0W7ZTgoQJm/eegFf40Xa4GrurbJoa68pH1nPabObjbi2mD96kV7xQ/9HpL
 2vIpVeMXUnmgsn+V43NO/+hG00MBR2Vdy+OLXe4tSRVI2+dUUsCbJtH5jHQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Am 24.03.19 um 23:43 schrieb Kangjie Lu:
> When kzalloc fails, "platform_state->inited = 1" is a NULL pointer
> dereference. The fix returns VCHIQ_ERROR in case it failed to
> avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
please add a proper fixes tag.
> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c  | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> index dd4898861b83..0f12fe617575 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
> @@ -209,6 +209,8 @@ vchiq_platform_init_state(struct vchiq_state *state)
>  	struct vchiq_2835_state *platform_state;
>  
>  	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
> +	if (!state->platform_state)
> +		return VCHIQ_ERROR;

this change is good, but vchiq_init_state doesn't bail out immediately
in case vchiq_platform_init_state fails.

Could you please fix that, too?

Thanks Stefan

>  	platform_state = (struct vchiq_2835_state *)state->platform_state;
>  
>  	platform_state->inited = 1;

