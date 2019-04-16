Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33F8C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865BD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfDPImf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:42:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:42:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3AB10260FF2
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Sameer Nanda <snanda@chromium.org>, bleung@chromium.org,
        rjw@rjwysocki.net, gwendal@chromium.org,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com,
        kernel@collabora.com
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
 <20190416071941.GB14538@amd>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8d1f70a7-46d6-f278-f58c-6a7e7a644d46@collabora.com>
Date:   Tue, 16 Apr 2019 10:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416071941.GB14538@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 16/4/19 9:19, Pavel Machek wrote:
> Hi!
> 
>> This patch exposes a new property, similar to input current limit, to
>> re-configure the maximum voltage from the external supply at runtime
>> based on system-level knowledge or user input.
> 
> Well, and I suspect it should expose input power limit, not input
> voltage limit.
> 

Oh, ok, I thought we were agree that input voltage had sense after had some
discussion in v3. Seems that no, let me try to give you another example...

> DC-DC convertor efficiency normally does not much depend on input
> voltage....
> 
> 								Pavel
> 

As we said we have a heat "problem" due the internal voltage conversions.

Lets assume you have a linear regulator instead with a Vin range from 5V to 9V
and we want an output of 3.3V/1A

For 9V:
 Input power : P(in) = 9V x 1A = 9W
 Output power: P(out) = 3.3V x 1A = 3.3W
 Regulator power dissipated: P(reg) = P(in) - P(out) = 9W - 3.3W = 5.7W

For 5V:
 Input power : P(in) = 5V x 1A = 5W
 Output power: P(out) = 3.3V x 1A = 3.3W
 Regulator power dissipated: P(reg) = P(in) - P(out) = 5W - 3.3W = 1,7W

In the first case the regulator needs to dissipate more power, hence the
temperature is greater than the second case.

Thanks,
 Enric
