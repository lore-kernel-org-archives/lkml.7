Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF6E23717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfICQDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:03:39 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:20703 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:03:39 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83G3JSd025010;
        Wed, 4 Sep 2019 01:03:19 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 04 Sep 2019 01:03:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83G3Ihr025006
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 4 Sep 2019 01:03:18 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH v2 1/3] ASoC: es8316: judge PCM rate at later timing
To:     Mark Brown <broonie@kernel.org>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
 <20190902120248.GA5819@sirena.co.uk>
 <1a3c5934-4731-d474-e9d5-795e8337b180@katsuster.net>
 <20190903111138.GA6247@sirena.co.uk>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <c142c351-5559-b162-e68f-98cf86b039aa@katsuster.net>
Date:   Wed, 4 Sep 2019 01:03:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903111138.GA6247@sirena.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 2019/09/03 20:11, Mark Brown wrote:
> On Tue, Sep 03, 2019 at 04:19:10AM +0900, Katsuhiro Suzuki wrote:
>> On 2019/09/02 21:02, Mark Brown wrote:
> 
>>> The best way to handle this is to try to support both fixed and variable
>>> clock rates, some other drivers do this by setting constraints based on
>>> MCLK only if the MCLK has been set to a non-zero value.  They have the
>>> machine drivers reset the clock rate to 0 when it goes idle so that no
>>> constraints are applied then.  This means that if the machine has a
> 
>> In my understanding, fixed and variable clock both use set_sysclk() for
>> telling their MCLK to codec driver. For fixed MCLK cases we need to
>> apply constraint but for variable MCLK cases we should not set
>> constraints at set_sysclk(). How can we identify these two cases...?
> 
> Like I say it's usually done by settingthe MCLK to 0 when not in use and
> then not applying any constraints if there's no MCLK set.
> 

Ah... I understand. Current implementation refuses MCLK == 0.
I'll change to accept MCLK == 0 for fixed clock users and send v3 patch.

Best Regards,
Katsuhiro Suzuki
