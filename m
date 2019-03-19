Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F33C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53B20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfCSDfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:35:20 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:48808 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCSDfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:35:20 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1h65Wz-0006SK-He from Jiada_Wang@mentor.com ; Mon, 18 Mar 2019 20:35:13 -0700
Received: from [134.86.193.85] (147.34.91.1) by svr-orw-mbx-03.mgc.mentorg.com
 (147.34.90.203) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 18 Mar
 2019 20:35:10 -0700
Subject: Re: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential
 deadlock
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
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
 <8cd7f718-bfb2-15c8-823d-88458b385377@mentor.com>
 <TY1PR01MB177056C725F16385A627111EC04A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <3f76f14b-b520-a0fa-b354-765a9e60551d@mentor.com>
Date:   Tue, 19 Mar 2019 12:34:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <TY1PR01MB177056C725F16385A627111EC04A0@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-06.mgc.mentorg.com (147.34.90.206) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio

On 2019/03/14 3:19, Fabrizio Castro wrote:
> Hello Jiada,
> 
>> From: Jiada Wang <jiada_wang@mentor.com>
>> Sent: 13 March 2019 11:56
>> Subject: Re: [PATCH linux-next v2 1/2] ASoC: rsnd: src: Avoid a potential deadlock
>>
>> Hi Geert
>>
>> On 2019/03/12 18:15, Geert Uytterhoeven wrote:
>>> Hi Jiada, Fabrizio,
>>>
>>> On Thu, Mar 7, 2019 at 7:17 AM Jiada Wang <jiada_wang@mentor.com> wrote:
>>>> lockdep warns us that priv->lock and k->k_lock can cause a
>>>> deadlock when after acquire of k->k_lock, process is interrupted
>>>> by src, while in another routine of src .init, k->k_lock is
>>>> acquired with priv->lock held.
>>>>
>>>> This patch avoids a potential deadlock by not calling soc_device_match()
>>>> in SRC .init callback, instead it adds new soc fields in priv->flags to
>>>> differentiate SoCs.
>>>>
>>>> Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
>>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>>> ---
>>>>    sound/soc/sh/rcar/core.c | 2 ++
>>>>    sound/soc/sh/rcar/rsnd.h | 5 +++++
>>>>    sound/soc/sh/rcar/src.c  | 9 +--------
>>>>    3 files changed, 8 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
>>>> index 022996d2db13..4fe83e611c01 100644
>>>> --- a/sound/soc/sh/rcar/core.c
>>>> +++ b/sound/soc/sh/rcar/core.c
>>>> @@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
>>>>           { .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
>>>>           { .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
>>>>           { .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
>>>> +       /* Special Handling */
>>>> +       { .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },
>>>
>>> I guess we need an entry for RZ/G2E, too?
> 
> Geert has a point, I am looking at the User manual for the RZ/G2E and it looks like the
> implementation for the RZ/G2E is the same as the one for the r8a77990
> 
>>>
>> Sorry, I don't have user manual for RZ/G2E,
>> if you can let me know where to find RZ/G2E's user manual,
>> I can add entry for these SoCs
> 
> If you prefer I could add that after running some tests? I do have a board with a RZ/G2E.
> 
Yes, please
since I have neither RZ/G2E board to test nor its user manual

Thanks,
Jiada
> Thanks,
> Fab
> 
>>
>> Thanks,
>> Jiada
>>> Gr{oetje,eeting}s,
>>>
>>>                           Geert
>>>
