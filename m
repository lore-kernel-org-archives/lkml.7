Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A71C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D3C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGJImp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:42:45 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:44021 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfGJImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:42:45 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 54BB33C0585;
        Wed, 10 Jul 2019 10:42:42 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XxKdoW40fsLm; Wed, 10 Jul 2019 10:42:36 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A27C53C001F;
        Wed, 10 Jul 2019 10:42:36 +0200 (CEST)
Received: from [10.72.93.172] (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 10 Jul
 2019 10:42:36 +0200
Subject: Re: [ALSA patch] [PATCH] ALSA: pcm: Enable MMAP status and control
 for ARMv7 and ARMv8
To:     Takashi Iwai <tiwai@suse.de>, <kuninori.morimoto.gx@renesas.com>,
        <hiroyuki.yokoyama.vx@renesas.com>, <colin.king@canonical.com>,
        <gregkh@linuxfoundation.org>, <chanho.min@lge.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1555490771-13242-1-git-send-email-twischer@de.adit-jv.com>
 <s5hlg093s2b.wl-tiwai@suse.de>
 <5946b2b4-ecf7-8266-2998-a19b7d9a2d2c@de.adit-jv.com>
 <s5hftqh3r6t.wl-tiwai@suse.de>
From:   Timo Wischer <twischer@de.adit-jv.com>
Message-ID: <750ee44c-e28e-7711-2f07-a40fd3a87b38@de.adit-jv.com>
Date:   Wed, 10 Jul 2019 10:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <s5hftqh3r6t.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

it would be great if someone from Renesas or someone else could 
acknowledge the patch.
I think it is a good improvement especially when using ALSA plugins like 
dmix.

Feel free to forward if you know someone who is aware of the cache 
coherency of ARM architectures.

Best regards
*Timo Wischer*
Engineering Software Multimedia (ADITG/ESM)

Tel. +49 5121 49 6938
On 4/17/19 11:40 AM, Takashi Iwai wrote:
> On Wed, 17 Apr 2019 11:30:10 +0200,
> Timo Wischer wrote:
>> On 4/17/19 11:21, Takashi Iwai wrote:
>>> On Wed, 17 Apr 2019 10:46:11 +0200,
>>> <twischer@de.adit-jv.com> wrote:
>>>> From: Timo Wischer <twischer@de.adit-jv.com>
>>>>
>>>> Since ARMv7 hardware cache coherence is supported.
>>>> "The SCU maintains coherency between the individual data caches in the
>>>> Cortex-A5 MPCore processor using a variation of the MOESI protocol" [1].
>>>>
>>>> Therefore this patch enables the MMAP access to the status and control
>>>> structures. This avoids HWSYYNC ioctl calls and therefore lowers the CPU
>>>> usage.
>>>>
>>>> [1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0434c/
>>>> BABJECBF.html
>>> Interesting...  I thought it would never work properly on ARM.
>>> If it really works like that, I'd happily apply the change.
>>> But I'd like to hear a confirmation from ARM people before merging
>>> such an intensive change.
>> Hi Takashi,
>>
>> do I need to send this patch to any other mailing list or do you think
>> some corresponding guy is already on the lists I have used?
> Well, maybe we need to ping ARM people if no one on the lists you
> Cc'ed give comments.  Let's see.
>
>
> Takashi
>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>>> Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>>>> ---
>>>>    sound/core/pcm_native.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>>>> index 1d84529..b8019ef 100644
>>>> --- a/sound/core/pcm_native.c
>>>> +++ b/sound/core/pcm_native.c
>>>> @@ -3225,7 +3225,8 @@ static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
>>>>     * Only on coherent architectures, we can mmap the status and the control records
>>>>     * for effcient data transfer.  On others, we have to use HWSYNC ioctl...
>>>>     */
>>>> -#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA)
>>>> +#if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_ALPHA) || \
>>>> +	(defined(CONFIG_ARM) && defined(CONFIG_CPU_V7)) || defined(CONFIG_ARM64)
>>>>    /*
>>>>     * mmap status record
>>>>     */
>>>> -- 
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> Patch mailing list
>>>> Patch@alsa-project.org
>>>> https://mailman.alsa-project.org/mailman/listinfo/patch
>>>>
