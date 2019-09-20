Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A92AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506CC20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7TMvnhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395093AbfITHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:35:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394988AbfITHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568964922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XyZZ63KwFlGC73LPX/aig03cpoLvqfBXJmLqDYqz7Y=;
        b=B7TMvnhkZT57e/jf1pnVng7zXy5A6ivCJjmEAN66FWMZZQNlqawZygGPa71UDr/oMiE1/k
        Kbj7wBbJV8D9MazRWPCH1CFArDVV7qgI5l1mg9gZlhJx/I3XUcxzFYjojXEtPnlDecnHFd
        AvjeMELvXw0iN8qwLItuykNLhq+zzgA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-jWqow0IgP5WRJ9hYtNkGlw-1; Fri, 20 Sep 2019 03:35:21 -0400
Received: by mail-ed1-f72.google.com with SMTP id s3so3634986edr.15
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SJGmDqFeDkJEkAT4Eqq0SqoK3gH7r/gSL7IoX/3siGE=;
        b=si3GeGaUg2s0n4t/OuLVqWhhzuUiC8H2V5UQuevtGrNoIq5wLmU7nNWTGecUFkxBxH
         qjIMW+dcAvFTckDHsu5tnMGWAnvhECHDOtyAeL0n+XFJqHbpwK+YnoNC8YQPdzOhmGNd
         yvKnL27aDqXZKxjZuh0F3hqunkXtZhNsk8DhQ7mh78EsBoe86BemfEC0KFFyEgRDK/nI
         hxyIUWtwr1mZFKd5AbMujtUP72sENYZ9WLemEV7r0m2LFSkvhGEHTUl4gUDdy6MjpHer
         Yw+tLQIWGgLxBB1YIO2my70cctIJeqwoQSAx+DFGK2koVd36Rk4InkbhzwWtTP34GoQr
         YBSQ==
X-Gm-Message-State: APjAAAX2BvyXq01wAtlvRahT2lba9HYQMI5RWzh2DFN6tU9M8ZRmpjig
        V1PIyoceJHLrkbHR5O9+ockSK4fHEeNatXok4hcUscfbDV7iMrUrPlSmvZt7IA01+1clpxrT/0F
        HoC3qqh1I7Vu62hOED0wrdL9r
X-Received: by 2002:a50:9e0a:: with SMTP id z10mr5667760ede.202.1568964919421;
        Fri, 20 Sep 2019 00:35:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwc3TC04YKGH/Ex7AW+SYUUeAYz7oWSx3ivXirItbcMpPEuGmxvD/07Jh9AKo+3fLueGPRn6g==
X-Received: by 2002:a50:9e0a:: with SMTP id z10mr5667737ede.202.1568964919294;
        Fri, 20 Sep 2019 00:35:19 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id a36sm181336edc.58.2019.09.20.00.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 00:35:17 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] platform/x86: huawei-wmi: Add quirks and module
 parameters
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
 <20190920003938.21617-3-ayman.bagabas@gmail.com>
 <20190920060812.GB473898@kroah.com>
 <30a363e5-5691-e008-e1e5-55936fa3cd92@redhat.com>
 <s5hlfujo27x.wl-tiwai@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <58e11827-cb9c-3ca9-c2a6-636453958382@redhat.com>
Date:   Fri, 20 Sep 2019 09:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <s5hlfujo27x.wl-tiwai@suse.de>
Content-Language: en-US
X-MC-Unique: jWqow0IgP5WRJ9hYtNkGlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-09-2019 09:29, Takashi Iwai wrote:
> On Fri, 20 Sep 2019 09:24:08 +0200,
> Hans de Goede wrote:
>>
>> Hi,
>>
>> On 20-09-2019 08:08, Greg Kroah-Hartman wrote:
>>> On Thu, Sep 19, 2019 at 08:39:07PM -0400, Ayman Bagabas wrote:
>>>> Introduce quirks and module parameters. 3 quirks are added:
>>>> 1. Fixes reporting brightness keys twice since it's already handled by
>>>>      acpi-video.
>>>> 2. Some models need a short delay when setting battery thresholds to
>>>>      prevent a race condition when two processes read/write. (will be =
used later)
>>>> 3. Matebook X (2017) handles micmute led through the "legacy" interfac=
e
>>>>      which is not currently implemented. Use ACPI EC method to control
>>>>      this led. (will be used later)
>>>>
>>>> 2 module parameters are added to enable this short delay and/or report
>>>>     brightness keys through this driver.
>>>
>>> module parameters are a pain to manage and handle over time.  Is there
>>> any way you can "automatically" figure this out, or use a sysfs file
>>> instead?
>>
>> The patch also adds dmi matches to set the quirks, so the module params
>> are there to override those and/or to easily test which are the right op=
tions
>> with new modules. The normal / expected use-case for everything to be se=
t
>> automatically based on the DMI table.

Ugh lots of typos / missing words I need to learn to re-read before hitting=
 send ...

"modules" -> "models"
"use-case" -> "use-case is"

>>
>> With that said, the module-params should really always override the dmi =
values,
>> so I would like to suggest to make the module-params int-s instead of bo=
ol-s
>> and to do something like this:
>>
>> static int battery_reset =3D -1;
>> static int report_brightness =3D -1;
>>
>> =09quirks =3D &quirk_unknown;
>> =09dmi_check_system(huawei_quirks);
>> =09/* If set the module options override the vale from the DMI table */

"vale" here should be "values" of course.

>> =09if (battery_reset !=3D -1)
>> =09=09quirks->battery_reset =3D battery_reset;
>> =09if (report_brightness !=3D -1)
>> =09=09quirks->report_brightness =3D report_brightness;
>=20
> ... and use "bint" for module_param() type.

Ack.

Regards,

Hans

