Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC386C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1112084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfDYLTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:19:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:19:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 327E82813B8
Subject: Re: [PATCH 00/30] Update cros_ec_commands.h
To:     Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org
References: <20190424232918.243308-1-gwendal@chromium.org>
 <20190425081232.GA14758@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <aa1c0ab7-6491-69a8-936c-26460b78d6c2@collabora.com>
Date:   Thu, 25 Apr 2019 13:19:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425081232.GA14758@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal, Lee

On 25/4/19 10:12, Lee Jones wrote:
> On Wed, 24 Apr 2019, Gwendal Grignou wrote:
> 
>> The interface between CrosEC embedded controller and the host,
>> described by cros_ec_commands.h, as diverged from what the embedded
>> controller really support.
>>
>> The source of thruth is at
>> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>>
>> That include file is converted to remove ACPI and Embedded only code.
>>
>> From now on, cros_ec_commands.h will be automatically generated from
>> the file above, do not modify directly.
>>
>> Fell free to squash the commits below.
> 
> This is going to need a bunch of Chromium reviews (and testing
> ideally) before I can take this set.
> 

I tested this patchset in different ways. With the full series applied I checked
that didn't break any cros-ec driver on Kevin, Samus and Veyron devices. I also
checked via userspace tool that I don't see any problem sending commands and
finally I checked that applying one-by-one the patches didn't break the build on
x86 and arm64, there is though, a problem,

[PATCH 24/30] mfd: cros_ec: Update I2S API

introduces a build problem because removes a struct that is currently used by
the cros_ec_codec driver. I think that at the same time we should update that
driver with the new struct name.

Once this is fixed,

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

for the full series.

Thanks,
 Enric

