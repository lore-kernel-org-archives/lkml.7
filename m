Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E86FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1DD22CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbfIDPHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:07:12 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:27777 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbfIDPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:07:12 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x84F6OmK057013;
        Thu, 5 Sep 2019 00:06:24 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Thu, 05 Sep 2019 00:06:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x84F6N7i057007
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 5 Sep 2019 00:06:24 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v3 1/4] ASoC: es8316: judge PCM rate at later timing
To:     Mark Brown <broonie@kernel.org>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903174801.GD7916@sirena.co.uk>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <85c717bf-d875-016c-a303-867bdca9a645@katsuster.net>
Date:   Thu, 5 Sep 2019 00:06:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903174801.GD7916@sirena.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 2019/09/04 2:48, Mark Brown wrote:
> On Wed, Sep 04, 2019 at 01:53:19AM +0900, Katsuhiro Suzuki wrote:
> 
>> Root cause of this strange behavior is changing constraints list at
>> set_sysclk timing. It seems that is too early to determine. So this
>> patch does not use constraints list and check PCM rate limit more
>> later timing at hw_params.
> 
> hw_params is a bit late to impose constraints, you want them to be
> available to be available to the application before it gets as far as
> picking the parameters it wants so that you don't get hw_params failing
> due to an invalid configuration.  That makes everything run more
> smoothly, applications should be able to trust the constraints they got
> and some will not handle failures well.
> 
> The way this works with the variable MCLKs is that you end up in one of
> two cases (wm8731 and wm8741 do this):
> 
>     1. The system is idle, MCLK is set to 0.  In this case no constraints
>        are set and we just set MCLK to whatever is required in hw_params()
>        in the machine driver.
>     2. One direction is active, MCLK is set to whatever that needed.  In
>        this case startup() sets constraints derived from the MCLK.
> 
> There are races in this if streams are being started and torn down
> simultaneously, there's not much we can do about them with the API the
> way it is so we do have to validate in hw_params() anyway but it should
> be validation not constraint imposition.
> 
> If the system has a fixed MCLK it just sets that on probe then we always
> get the constraints applied on startup through the same code that
> handles case 2.
> 

Thank you for explanation. I agree with apply no constraints if MCLK is
set to 0, and suitable constraints if MCLK is set to other values like
as wm8731 and wm8741 drivers.

I'll change my patch set and send.


Would you tell me one more thing. I don't understand who sets MCLK to 0.
Is it needed original machine driver instead of audio-graph-card?

On my test environment (audio-graph-card + Rockchip I2S + ES8316), it
seems audio-graph-card has never called set_sysclk() with freq = 0 after
stop play/capture sound. So my env will go to bad scenario as I 
described in this patch.

Best Regards,
Katsuhiro Suzuki
