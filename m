Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFB7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3882084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbfJWIip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:38:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389913AbfJWIio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:38:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB97AD32800C05640DB2;
        Wed, 23 Oct 2019 16:38:41 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 16:38:33 +0800
Subject: Re: [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency
To:     Tzung-Bi Shih <tzungbi@google.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        =?UTF-8?B?U2h1bmxpIFdhbmcgKOeOi+mhuuWIqSk=?= 
        <shunli.wang@mediatek.com>, <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <tglx@linutronix.de>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        "ALSA development" <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
References: <20191023063103.44941-1-maowenan@huawei.com>
 <CA+Px+wX7-tn-rXeKqnPtp74tU5cLxhJwF6XZ_jeQX-tnAfvO5g@mail.gmail.com>
From:   maowenan <maowenan@huawei.com>
Message-ID: <1d948ec1-69e4-735f-c369-80d2b28e0eaa@huawei.com>
Date:   Wed, 23 Oct 2019 16:38:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CA+Px+wX7-tn-rXeKqnPtp74tU5cLxhJwF6XZ_jeQX-tnAfvO5g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/23 16:32, Tzung-Bi Shih wrote:
> On Wed, Oct 23, 2019 at 2:31 PM Mao Wenan <maowenan@huawei.com> wrote:
>>
>> If SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=y,
>> below errors can be seen:
>> sound/soc/codecs/cros_ec_codec.o: In function `send_ec_host_command':
>> cros_ec_codec.c:(.text+0x534): undefined reference to `cros_ec_cmd_xfer_status'
>> cros_ec_codec.c:(.text+0x101c): undefined reference to `cros_ec_get_host_event'
>>
>> This is because it will select SND_SOC_CROS_EC_CODEC
>> after commit 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV"),
>> but SND_SOC_CROS_EC_CODEC depends on CROS_EC.
>>
>> Fixes: 2cc3cd5fdc8b ("ASoC: mediatek: mt8183: support WoV")
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  sound/soc/mediatek/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
>> index 8b29f39..a656d20 100644
>> --- a/sound/soc/mediatek/Kconfig
>> +++ b/sound/soc/mediatek/Kconfig
>> @@ -125,7 +125,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
>>         select SND_SOC_MAX98357A
>>         select SND_SOC_BT_SCO
>>         select SND_SOC_TS3A227E
>> -       select SND_SOC_CROS_EC_CODEC
>> +       select SND_SOC_CROS_EC_CODEC if CROS_EC
>>         help
>>           This adds ASoC driver for Mediatek MT8183 boards
>>           with the MT6358 TS3A227E MAX98357A audio codec.
>> --
>> 2.7.4
>>
> 
> Just realized your patch seems not showing in the list
> (https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/thread.html).
> I have no idea why.
> 
I receive below message after I post, do you know why?
'''
Your mail to 'Alsa-devel' with the subject

    [PATCH] ASoC: mediatek: Check SND_SOC_CROS_EC_CODEC dependency

Is being held until the list moderator can review it for approval.

The reason it is being held:

    Post by non-member to a members-only list

Either the message will get posted to the list, or you will receive
notification of the moderator's decision.  If you would like to cancel
this posting, please visit the following URL:

    https://mailman.alsa-project.org/mailman/confirm/alsa-devel/574c24ad00f4d1aefc802a8a4b2c5fbda710e4e9
'''

> .
> 

