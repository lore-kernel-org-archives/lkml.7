Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96921C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69237206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387530AbfIEJh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:37:57 -0400
Received: from foss.arm.com ([217.140.110.172]:40444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730872AbfIEJh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:37:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883721576;
        Thu,  5 Sep 2019 02:37:56 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9AB33F67D;
        Thu,  5 Sep 2019 02:37:55 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
Date:   Thu, 5 Sep 2019 10:37:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 09:21, Rob Herring wrote:
> +Steven
> 
> On Wed, Sep 4, 2019 at 1:30 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> The panfrost driver requests a supply using regulator_get_optional()
>> but both the name of the supply and the usage pattern suggest that it is
>> being used for the main power for the device and is not at all optional
>> for the device for function, there is no meaningful handling for absent
>> supplies.  Such regulators should use the vanilla regulator_get()
>> interface, it will ensure that even if a supply is not described in the
>> system integration one will be provided in software.
> 
> I guess commits e21dd290881b ("drm/panfrost: Enable devfreq to work
> without regulator") and c90f30812a79 ("drm/panfrost: Add missing check
> for pfdev->regulator")
> in -next should be reverted or partially reverted?

Ah, I didn't realise that regulator_get() will return a dummy regulator
if none is provided in the DT. In theory that seems like a nicer
solution to my two commits. However there's still a problem - the dummy
regulator returned from regulator_get() reports errors when
regulator_set_voltage() is called. So I get errors like this:

[  299.861165] panfrost e82c0000.mali: Cannot set voltage 1100000 uV
[  299.867294] devfreq devfreq0: dvfs failed with (-22) error

(And therefore the frequency isn't being changed)

Ideally we want a dummy regulator that will silently ignore any
regulator_set_voltage() calls.

Steve
