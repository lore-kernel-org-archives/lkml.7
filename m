Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5ECC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428F8214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCML4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:56:09 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57188 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfCML4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:56:09 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h42UM-0002rZ-Kd from Jiada_Wang@mentor.com ; Wed, 13 Mar 2019 04:56:02 -0700
Received: from [172.30.112.185] (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 13 Mar 2019 04:55:58 -0700
Subject: Re: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential
 deadlock
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190307061554.26486-1-jiada_wang@mentor.com>
 <20190307061554.26486-2-jiada_wang@mentor.com>
 <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <8cd7f718-bfb2-15c8-823d-88458b385377@mentor.com>
Date:   Wed, 13 Mar 2019 20:55:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU+1Ntz6uvk-VYsSdWJgBfzHu99SztqyfLX7z2FRxPdNg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert

On 2019/03/12 18:15, Geert Uytterhoeven wrote:
> Hi Jiada, Fabrizio,
> 
> On Thu, Mar 7, 2019 at 7:17 AM Jiada Wang <jiada_wang@mentor.com> wrote:
>> lockdep warns us that priv->lock and k->k_lock can cause a
>> deadlock when after acquire of k->k_lock, process is interrupted
>> by src, while in another routine of src .init, k->k_lock is
>> acquired with priv->lock held.
>>
>> This patch avoids a potential deadlock by not calling soc_device_match()
>> in SRC .init callback, instead it adds new soc fields in priv->flags to
>> differentiate SoCs.
>>
>> Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   sound/soc/sh/rcar/core.c | 2 ++
>>   sound/soc/sh/rcar/rsnd.h | 5 +++++
>>   sound/soc/sh/rcar/src.c  | 9 +--------
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
>> index 022996d2db13..4fe83e611c01 100644
>> --- a/sound/soc/sh/rcar/core.c
>> +++ b/sound/soc/sh/rcar/core.c
>> @@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
>>          { .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
>>          { .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
>>          { .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
>> +       /* Special Handling */
>> +       { .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },
> 
> I guess we need an entry for RZ/G2E, too?
> 
Sorry, I don't have user manual for RZ/G2E,
if you can let me know where to find RZ/G2E's user manual,
I can add entry for these SoCs

Thanks,
Jiada
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
