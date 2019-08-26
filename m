Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95881C3A5A4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744F32173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfHZPZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:25:30 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:35048 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfHZPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:25:27 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7QFP7hr031359;
        Tue, 27 Aug 2019 00:25:08 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Tue, 27 Aug 2019 00:25:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7QFP7Ox031353
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 27 Aug 2019 00:25:07 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] ASoC: es8316: limit headphone mixer volume
To:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Drake <drake@endlessm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20190824210426.16218-1-katsuhiro@katsuster.net>
 <943932bf-2042-2a69-c705-b8e090e96377@redhat.com>
 <CAD8Lp44_uAC4phZ9NbvM_LKNUoiNUqAnFsq4h-bJiQn6byjzGw@mail.gmail.com>
 <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <9574e5f4-e9db-1876-73f7-19a79fb1209e@katsuster.net>
Date:   Tue, 27 Aug 2019 00:25:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eeee149c-4d9b-8b2e-780b-a41e2c87ec02@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans, Daniel,

Thank you for reviewing and comment.

On 2019/08/26 18:09, Hans de Goede wrote:
> Hi,
> 
> On 26-08-19 04:53, Daniel Drake wrote:
>> On Mon, Aug 26, 2019 at 1:38 AM Hans de Goede <hdegoede@redhat.com> 
>> wrote:
>>> On 24-08-19 23:04, Katsuhiro Suzuki wrote:
>>>> This patch limits Headphone mixer volume to 4 from 7.
>>>> Because output sound suddenly becomes very loudly with many noise if
>>>> set volume over 4.
>>
>> That sounds like something that should be limited in UCM.
>>
>>> Higher then 4 not working matches my experience, see this comment from
>>> the UCM file: alsa-lib/src/conf/ucm/codecs/es8316/EnableSeq.conf :
>>>
>>> # Set HP mixer vol to -6 dB (4/7) louder does not work
>>> cset "name='Headphone Mixer Volume' 4"
>>
>> What does "does not work" mean more precisely?
> 
> IIRC garbled sound.
> 
>> I checked the spec, there is indeed something wrong in the kernel 
>> driver here.
>> The db scale is not a simple scale as the kernel source suggests.
>>
>> Instead it is:
>> 0000 – -12dB
>> 0001 – -10.5dB
>> 0010 – -9dB
>> 0011 – -7.5dB
>> 0100 – -6dB
>> 1000 – -4.5dB
>> 1001 – -3dB
>> 1010 – -1.5dB
>> 1011 – 0dB
>>
>> So perhaps we can fix the kernel to follow this table and then use UCM
>> to limit the volume if its too high on a given platform?
> 
> Yes that sounds like the right thing to do. Katsuhiro can you confirm that
> using this table allows using the full scale ? note that the full scale now
> has 9 steps rather then 8.
> 

I've finished testing this table on my board (RockPro64).
Every values work well without garbled sound.

I checked address 0x16 register via /sys/kernel/debug/regmap too.
The register values and dB (get from alsamixer) are the following if
I increase headphone volume to max from min.

   reg   dB
   0x16  scale
   ------------
   0x00  -12.00
   0x11  -10.50
   0x22  -9.00
   0x33  -7.50
   0x44  -6.00
   0x88  -4.50
   0x99  -3.00
   0xaa  -1.50
   0xbb  0.00


And I found other problem, current code is inverted L/R volume.
It's only in Headphone "mixer" volume. It seems Headphone "master"
volume works correctly.

I'll fix these problems and send V2 patch set.


> Regards,
> 
> Hans
> 
> 

Best Regards,
Katsuhiro Suzuki
