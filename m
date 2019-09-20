Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745ABC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403152086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B64UNnCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394999AbfITHYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:24:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394988AbfITHYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568964254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVGyEzIpXZFt2w1fAetDgSLPM6b5VQq1fUVZtxklqxg=;
        b=B64UNnCzGTTPHpxLbwjOahNsOwbcos45jX2YI7sfXBpJxtZXFwez+4aHslURDzapxj44gC
        ETyVuZ0mGoKudsdsh+uR32EHCwh3x6/90wwBi+XzA32S8EJq38uQPTBzFWq0AsZs3rh7Gm
        iZEDny/UzA0qPXdyDHYoQxdIXHxx4KA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-lhlbgUHYPvircOrWYN5xoQ-1; Fri, 20 Sep 2019 03:24:12 -0400
Received: by mail-ed1-f71.google.com with SMTP id s15so2451444edj.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6OkBuWjoxWL/pIuhPJa4NpzgSq8YM2TDi8732wO4HI=;
        b=gkOmo7c5psTUlVVCTzV8VB9a7xR6m0mDSlZDJnQLmVt5t4gD9i/pair9mQ2vWlE4YK
         1QaLPH1HQjfIMf7L2/W0S6PYrk7btyVFWbToOX/D+YDhHrImdFbAAFutMfup6lvSZ5sX
         /hbS0mMrzIjawDOngRBB2NmtLvF6P3HcwOikU1YRvJ7PGdi0Ui5GyQdkm5EokdW3Tgkb
         x9f4eVF50WKKKwkGTUNcO8GscRtwvGaP6rxoU3Kxh5Dhk0rxF0y6QHEQdtuiAVyeETTb
         Vc8jq/pTY6D47+k6GLamaaGv/sZyDKlzJ1so63r9vCul7q/pYGXZaWrzUk9guDaORH3U
         cTRA==
X-Gm-Message-State: APjAAAW71iwUO4XScfZ98ul1oRkkowDu4aBpbT8Oe1IwvyoGC+8JkuGr
        PYk8bdP7mmY/QxJL+VQzi+wbB7XLPzOYqhFMua7i0GcCxPti/S7SnS+A9+R6rjasliO6AcL7ijv
        +F8G8E0YpDhqxqh468m2mxXd2
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr18324922ejj.18.1568964250696;
        Fri, 20 Sep 2019 00:24:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBUYNM3WgAtUt0AspuhWHpC/wlZM4YwF+Ndz/2pXA/cE34PTfQGrvd+x1+P7EUBu4MGo19Ag==
X-Received: by 2002:a17:906:405b:: with SMTP id y27mr18324896ejj.18.1568964250445;
        Fri, 20 Sep 2019 00:24:10 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id ha2sm131428ejb.63.2019.09.20.00.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 00:24:09 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] platform/x86: huawei-wmi: Add quirks and module
 parameters
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <30a363e5-5691-e008-e1e5-55936fa3cd92@redhat.com>
Date:   Fri, 20 Sep 2019 09:24:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920060812.GB473898@kroah.com>
Content-Language: en-US
X-MC-Unique: lhlbgUHYPvircOrWYN5xoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-09-2019 08:08, Greg Kroah-Hartman wrote:
> On Thu, Sep 19, 2019 at 08:39:07PM -0400, Ayman Bagabas wrote:
>> Introduce quirks and module parameters. 3 quirks are added:
>> 1. Fixes reporting brightness keys twice since it's already handled by
>>     acpi-video.
>> 2. Some models need a short delay when setting battery thresholds to
>>     prevent a race condition when two processes read/write. (will be use=
d later)
>> 3. Matebook X (2017) handles micmute led through the "legacy" interface
>>     which is not currently implemented. Use ACPI EC method to control
>>     this led. (will be used later)
>>
>> 2 module parameters are added to enable this short delay and/or report
>>    brightness keys through this driver.
>=20
> module parameters are a pain to manage and handle over time.  Is there
> any way you can "automatically" figure this out, or use a sysfs file
> instead?

The patch also adds dmi matches to set the quirks, so the module params
are there to override those and/or to easily test which are the right optio=
ns
with new modules. The normal / expected use-case for everything to be set
automatically based on the DMI table.

With that said, the module-params should really always override the dmi val=
ues,
so I would like to suggest to make the module-params int-s instead of bool-=
s
and to do something like this:

static int battery_reset =3D -1;
static int report_brightness =3D -1;

=09quirks =3D &quirk_unknown;
=09dmi_check_system(huawei_quirks);
=09/* If set the module options override the vale from the DMI table */
=09if (battery_reset !=3D -1)
=09=09quirks->battery_reset =3D battery_reset;
=09if (report_brightness !=3D -1)
=09=09quirks->report_brightness =3D report_brightness;

Regards,

Hans


