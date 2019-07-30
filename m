Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE180C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE5420693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564485206;
	bh=9tf7pyyGFyjMsbo4saqBU7or8vExlKNzfa5rBM69Tw0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=MQnbG8cBj7PzpzjVEzZNhO7Ys2AWS8pgnEkWqjLeKOtw9g84+nBKG656OYqiSsMQ+
	 6I7ndxIQMOPs2kBi0Tdm6ZmYETCuNSuRlUeWxbqVgXcIpo/hcHzrKgkjZMkvo/TSUr
	 0c2vD6cDjOZUS7Dr2+534qmoQVk6zNkOL56D0LBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfG3LNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 07:13:25 -0400
Received: from foss.arm.com ([217.140.110.172]:59424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfG3LNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 07:13:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30C42344;
        Tue, 30 Jul 2019 04:13:24 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4D813F575;
        Tue, 30 Jul 2019 04:13:23 -0700 (PDT)
Subject: Re: [PATCH 05/12] genirq/debugfs: Replace strncmp with str_has_prefix
To:     Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190729151435.9498-1-hslester96@gmail.com>
 <alpine.DEB.2.21.1907301113580.1738@nanos.tec.linutronix.de>
 <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <708d8d79-6464-fbd3-6a62-853c29b32cc3@kernel.org>
Date:   Tue, 30 Jul 2019 12:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANhBUQ2L71Q2j_iOUaHW7qk0BS6wwMBwmtd8N4S5mNLYHr4Dhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2019 11:58, Chuhong Yuan wrote:
> Thomas Gleixner <tglx@linutronix.de> 于2019年7月30日周二 下午5:17写道：
>>
>> On Mon, 29 Jul 2019, Chuhong Yuan wrote:
>>
>>> strncmp(str, const, len) is error-prone.
>>> We had better use newly introduced
>>> str_has_prefix() instead of it.
>>
>> Can you please provide a proper explanation why the below strncmp() is
>> error prone?
>>
> 
> If the size is less than 7, for example, 2, then even if buf is "tr", the
> result will still be true. This is an error.
> strncmp(str, const, len) is error-prone mainly because the len is easy
> to be wrong.
> 
>> Just running a script and copying some boiler plate changelog saying
>> 'strncmp() is error prone' does not cut it.
>>
>>> -     if (!strncmp(buf, "trigger", size)) {
>>> +     if (str_has_prefix(buf, "trigger")) {
>>
>> Especially when the resulting code is not equivalent.
>>
> 
> I think here the semantic is the comparison should only return true
> when buf is "trigger".

Not quite. It will satisfy the condition for 't', 'tr', 'trig',
'trigger', and of course 'triggerthissillyinterruptwhichImdebugging'.

I agree that the semantic is a bit bizarre and maybe not quite expected,
but still... You seem to be changing the semantic without any
justification other than "this is safer".

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
