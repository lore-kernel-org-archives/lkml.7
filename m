Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C965C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A29F22CE9
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHaLTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 07:19:05 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:59429 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHaLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 07:19:05 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7VBIhZf087789;
        Sat, 31 Aug 2019 20:18:43 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 31 Aug 2019 20:18:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7VBIgAG087782
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 31 Aug 2019 20:18:43 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
 <20190830111817.GA5182@sirena.co.uk>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <ee38ca00-4146-49fe-21c0-af0578b1d65c@katsuster.net>
Date:   Sat, 31 Aug 2019 20:18:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830111817.GA5182@sirena.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 2019/08/30 20:18, Mark Brown wrote:
> On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:
> 
>> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
>> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
> 
> If we don't get a clock it'd be nice to at least log that in case
> there's something wrong with the clock driver so that people have more
> of a hint as to why things might be breaking.
> 

OK, to change more user friendly.


>> +
>> +	if (es8316->mclk) {
>> +		ret = clk_prepare_enable(es8316->mclk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
> 
> There's nothing that disables the clock on remove.
> 
> Otherwise this looks good.
> 
Thank you for reviewing. I'll fix it and send V2 patch set.


> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

Best Regards,
Katsuhiro Suzuki
