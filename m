Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B00C4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD982086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfIICtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:49:40 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:49243 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733062AbfIICtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 22:49:40 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x892nRXu066490;
        Mon, 9 Sep 2019 11:49:27 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Mon, 09 Sep 2019 11:49:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.2] (238.8.232.153.ap.dti.ne.jp [153.232.8.238])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x892nRLX066484
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 9 Sep 2019 11:49:27 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] SoC: simple-card-utils: set 0Hz to sysclk when shutdown
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190907174501.19833-1-katsuhiro@katsuster.net>
 <87woei5mzj.wl-kuninori.morimoto.gx@renesas.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <af9678aa-bd38-7cb5-5d25-b133a269f19f@katsuster.net>
Date:   Mon, 9 Sep 2019 11:49:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87woei5mzj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/09 9:31, Kuninori Morimoto wrote:
> 
> Hi Katsuhiro
> 
>> This patch set 0Hz to sysclk when shutdown the card.
>>
>> Some codecs set rate constraints that derives from sysclk. This
>> mechanism works correctly if machine drivers give fixed frequency.
>>
>> But simple-audio and audio-graph card set variable clock rate if
>> 'mclk-fs' property exists. In this case, rate constraints will go
>> bad scenario. For example a codec accepts three limited rates
>> (mclk / 256, mclk / 384, mclk / 512).
>>
>> Bad scenario as follows (mclk-fs = 256):
>>     - Initialize sysclk by correct value (Ex. 12.288MHz)
>>       - Codec set constraints of PCM rate by sysclk
>>         48kHz (1/256), 32kHz (1/384), 24kHz (1/512)
>>     - Play 48kHz sound, it's acceptable
>>     - Sysclk is not changed
>>
>>     - Play 32kHz sound, it's acceptable
>>     - Set sysclk to 8.192MHz (= fs * mclk-fs = 32k * 256)
>>       - Codec set constraints of PCM rate by sysclk
>>         32kHz (1/256), 21.33kHz (1/384), 16kHz (1/512)
>>
>>     - Play 48kHz again, but it's NOT acceptable because constraints
>>       do not allow 48kHz
>>
>> So codecs treat 0Hz sysclk as signal of applying no constraints to
>> avoid this problem.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
> 
> I'm not 100% understand your issue.
> .hw_params (= set mclk/sysclk) is not called in bad case ??
> Or it is called but Codec driver ignores it somehow ??
> 

Ah, sorry for confusing. It's not either. hw_params() of machine
driver has been called even if constraints don't have a requested
PCM rate. But it's not expected.

For example, if constraints are 32k, 21.33k, 16k, hw_params() will
be called with 32k when an user requests to play 48k sounds.


> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
> 

Best Regards,
Katsuhiro Suzuki
