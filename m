Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30303C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E6522CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfIDPzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:55:38 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:55900 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbfIDPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:55:38 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84FtLBW074387;
        Thu, 5 Sep 2019 00:55:22 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Thu, 05 Sep 2019 00:55:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84FtLpL074384
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Sep 2019 00:55:21 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 1/4] ASoC: es8316: judge PCM rate at later timing
To:     Mark Brown <broonie@kernel.org>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903174801.GD7916@sirena.co.uk>
 <85c717bf-d875-016c-a303-867bdca9a645@katsuster.net>
 <20190904153016.GD4348@sirena.co.uk>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <d6f821d9-e7ed-95fd-fc47-82208f77c5df@katsuster.net>
Date:   Thu, 5 Sep 2019 00:55:21 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904153016.GD4348@sirena.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/05 0:30, Mark Brown wrote:
> On Thu, Sep 05, 2019 at 12:06:23AM +0900, Katsuhiro Suzuki wrote:
> 
>> Would you tell me one more thing. I don't understand who sets MCLK to 0.
>> Is it needed original machine driver instead of audio-graph-card?
> 
>> On my test environment (audio-graph-card + Rockchip I2S + ES8316), it
>> seems audio-graph-card has never called set_sysclk() with freq = 0 after
>> stop play/capture sound. So my env will go to bad scenario as I described in
>> this patch.
> 
> You shouldn't need a custom machine driver - you'll just be the first
> person who ran into this with audio-graph-card.  I'd just add this
> support to the audio-graph-card, either with custom startup and shutdown
> callbacks or using a set_bias_level() callback (both get used, I'd guess
> the set_bias_level() is easier since you don't need to reference count
> anything).
> 

Oh, I understand current situation. I'll try it.
Thanks for your support!

Best Regards,
Katsuhiro Suzuki
