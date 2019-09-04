Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E28AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8E922CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfIDPqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:46:05 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:18121 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbfIDPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:46:05 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84Fk2VD072180;
        Thu, 5 Sep 2019 00:46:02 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 05 Sep 2019 00:46:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84Fk2oG072177
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Sep 2019 00:46:02 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 2/4] ASoC: es8316: add clock control of MCLK
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903165322.20791-2-katsuhiro@katsuster.net>
 <CAHp75Vcm0yus5GpZEttdr_C07gmQXeNJ16gb_TFLUTvGkc164w@mail.gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <23e51463-1d95-59dd-c449-d4245aadcab5@katsuster.net>
Date:   Thu, 5 Sep 2019 00:46:02 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcm0yus5GpZEttdr_C07gmQXeNJ16gb_TFLUTvGkc164w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Thank you for reviewing.

On 2019/09/04 23:37, Andy Shevchenko wrote:
> On Tue, Sep 3, 2019 at 7:54 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>>
>> This patch introduce clock property for MCLK master freq control.
>> Driver will set rate of MCLK master if set_sysclk is called and
>> changing sysclk by board driver.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> 
>> +       if (es8316->mclk) {
> 
> You don't need this if clock has been requested as optional
> (clk_get_optional() or so).
> 
>> +               ret = clk_set_rate(es8316->mclk, freq);
>> +               if (ret)
>> +                       return ret;
>> +       }
> 
>> +       es8316->mclk = devm_clk_get(component->dev, "mclk");
>> +       if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
>> +               return -EPROBE_DEFER;
>> +       if (IS_ERR(es8316->mclk)) {
>> +               dev_err(component->dev, "clock is invalid, ignored\n");
>> +               es8316->mclk = NULL;
>> +       }
> 
> devm_clk_get_optional()
> 
>> +       if (es8316->mclk) {
> 
> Ditto as above.
> 
>> +               ret = clk_prepare_enable(es8316->mclk);
>> +               if (ret) {
>> +                       dev_err(component->dev, "unable to enable clock\n");
>> +                       return ret;
>> +               }
>> +       }
> 
>> +       if (es8316->mclk)
> 
> Ditto.
> 
>> +               clk_disable_unprepare(es8316->mclk);
>> +}
> 
> 

Indeed, NULL check of MCLK is not needed.
I'll make and send fixup patch.

Best Regards,
Katsuhiro Suzuki
