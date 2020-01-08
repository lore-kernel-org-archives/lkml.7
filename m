Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA86EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BF52070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgAHOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:20:25 -0500
Received: from foss.arm.com ([217.140.110.172]:45232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbgAHOUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:20:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F23B31B;
        Wed,  8 Jan 2020 06:20:24 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E4533F703;
        Wed,  8 Jan 2020 06:20:22 -0800 (PST)
Subject: Re: [PATCH RFT v1 1/3] drm/panfrost: enable devfreq based the
 "operating-points-v2" property
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, alyssa@rosenzweig.io,
        steven.price@arm.com, tomeu.vizoso@collabora.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20200107230626.885451-1-martin.blumenstingl@googlemail.com>
 <20200107230626.885451-2-martin.blumenstingl@googlemail.com>
 <a85f2063-f412-9762-58d1-47fdffb24af9@arm.com>
 <CAFBinCBYrNC+ULV6Y=77qogowkDZwM+H0bxOqPN4sT6q3krGfw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <be59a20b-af08-5b55-fa69-f87d5aa9f277@arm.com>
Date:   Wed, 8 Jan 2020 14:20:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCBYrNC+ULV6Y=77qogowkDZwM+H0bxOqPN4sT6q3krGfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Sudeep ]

On 08/01/2020 12:38 pm, Martin Blumenstingl wrote:
> Hi Robin,
> 
> On Wed, Jan 8, 2020 at 12:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 07/01/2020 11:06 pm, Martin Blumenstingl wrote:
>>> Decouple the check to see whether we want to enable devfreq for the GPU
>>> from dev_pm_opp_set_regulators(). This is preparation work for adding
>>> back support for regulator control (which means we need to call
>>> dev_pm_opp_set_regulators() before dev_pm_opp_of_add_table(), which
>>> means having a check for "is devfreq enabled" that is not tied to
>>> dev_pm_opp_of_add_table() makes things easier).
>>
>> Hmm, what about cases like the SCMI DVFS protocol where the OPPs are
>> dynamically discovered rather than statically defined in DT?
> where can I find such an example (Amlogic SoCs use SCPI instead of
> SCMI, so I don't think that I have any board with SCMI support) or
> some documentation?
> (I could only find SCPI clock and CPU DVFS implementations, but no
> generic "OPPs for any device" implementation)

On closer inspection I think this applies to the SCPI DVFS protocol 
too[1]. AIUI the fact that neither is wired up to a devfreq driver yet 
is merely due to lack of demand and suitable systems to develop/test on 
so far - the panfrost devfreq code is only now looking like the first 
viable upstream use-case ;)

Robin.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.dui0922g/BABFEBCD.html
