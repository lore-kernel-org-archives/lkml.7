Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAECCC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AB8218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDFxYat3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391149AbfIRUMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:12:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23855 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391137AbfIRUMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568837569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v9sv0DKh9f3NsnbGXTaL3YG4I+eX8M5sU84IvrSpMY0=;
        b=LDFxYat3YEvnErE7MdVDnIVgH9oepFygUSM78lBKYqRAfx0uC+Qu6YH6jEiIZVggoZhx1v
        0q5akxPDfDFoBA9wdQmziEhhX8CkP0aSNDBVT40qF3vAfdsMaZWXX8SFG/hSVKg2zE0jn4
        ckmmOehv3UlP4K/XIMGvQYaaMPkTBRw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-EVNdbup2MAuOH0Y8CPb3VQ-1; Wed, 18 Sep 2019 16:12:47 -0400
Received: by mail-ed1-f69.google.com with SMTP id f9so509198edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 13:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=De9bpu85iWCrg9FOtrMaR9Am6eWZHF17S1auesNwPzs=;
        b=Dl6kBJRx2uvKa57ATVGubU39m6lGlwJJ8dTw/scI6Lp3+ENQJWvpiNlvKMmRVMOs73
         x3bIyd+YZ7JTkE6nfHi0cPiy/HojmCfWdhwRGqPEkw5/8nob75YOPI6i6rTPpBOanUdu
         eRPr2v5yi2nPI8P1zpQ2L6Q/VkCihuUnMVSMX61I9WFacPfvPfew1Sl6I9FUC8ZQDTJc
         EEfL0tCoVPD1eZWWIyJjefnd45dmC3CIEFi+J0ERjE5SwGTpRSlUgu+KidZ8WsbWbXma
         tjuX217iak3f+NE3SV22wJM6WF3ETcDrnamU5pvWRHLqSl8qUCOtZ2Ww7yOkGjDL2SW8
         vOpw==
X-Gm-Message-State: APjAAAUjFNq2KfUqnRi/wAKaDR+enlLGpGWj2jm7APJcz4oqRRSMblEq
        tQ6+fSs53k//veMD3EXu5R2RlAaI5GjPyvj13M6qk4eya97hbRdzQw1bGhylkycJJllSKU8ptNs
        Yv7oCt/lht9MZubnca+PctbD4
X-Received: by 2002:a50:9eee:: with SMTP id a101mr12230249edf.128.1568837566162;
        Wed, 18 Sep 2019 13:12:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyslwNM3rIG3aZMTd6CcIy0InQkvmt8LC0hs3cL6s31VQkeyNAAShugVbzD6QWLrZr87sFuxQ==
X-Received: by 2002:a50:9eee:: with SMTP id a101mr12230211edf.128.1568837565727;
        Wed, 18 Sep 2019 13:12:45 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i63sm1221905edi.65.2019.09.18.13.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:12:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <f578a65b-af02-5fe8-dd59-9918c000da64@redhat.com>
 <20190918114224.GA23318@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <029c7865-b9b3-1e58-7092-6d8495de0116@redhat.com>
Date:   Wed, 18 Sep 2019 22:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918114224.GA23318@jeknote.loshitsa1.net>
Content-Language: en-US
X-MC-Unique: EVNdbup2MAuOH0Y8CPb3VQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-09-2019 13:42, Yauhen Kharuzhy wrote:
> On Wed, Sep 18, 2019 at 11:20:21AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 17-09-2019 21:45, Yauhen Kharuzhy wrote:
>>> Existing intel_cht_int33fe ACPI pseudo-device driver assumes that
>>> hardware has TypeC connector and register related devices described as
>>> I2C connections in the _CRS resource.
>>>
>>> There is at least one hardware (Lenovo Yoga Book YB1-91L/F) with micro
>>> USB B connector exists. It has INT33FE device in the DSDT table but
>>> there are only two I2C connection described: PMIC and BQ27452 battery
>>> fuel gauge.
>>>
>>> Splitting existing INT33FE driver allow to maintain code for USB type B
>>> (AB) connector variant separately and make it simpler.
>>>
>>> Split driver to intel_cht_int33fe_common.c and
>>> intel_cht_int33fe_{typeb,typec}.c. Compile all this source to one .ko
>>> module to make user experience easier.
>>>
>>> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
>>
>> Thank you for doing this, this version looks much better IMHO.
>>
>> Note that this does not apply to Linus' current master, please
>> rebase. Specifically this conflicts with this patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D78cd4bf53635d3aeb73435bc89eb6eb39450f315
>>
>> Which just got merged. Instead of rebasing on Linus' master
>> (which is always a bit adventurous to use during the merge window)
>> you can also cherry-pick that single commit on top of v5.3
>> and use that as a base.
>>
>> Note that that patch makes changes to struct cht_int33fe_data
>> specifically it drops the:
>>
>> =09struct fwnode_handle *mux;
>>
>> Member, so when rebasing you should drop that in the new
>> version of the struct on common.h .
>>
>> Besides that this need a rebase, overall this looks good, I have some
>> small remarks inline:
>=20
> Arghh.. OK, I have rebased the patch but at current torvalds kernel
> i2c_acpi_new_device() fails with -EPROBE_DEFER at my hw, so I cannot chec=
k if it
> is fully working. But I will resend patch anyway soon, this error should
> not be related to the patch content.

Are you sure it is not working? -EPROBE_DEFER is normal(ish) it just means
that the i2c-controller driver for the bus has not initialized yet.

If you are building the i2c_designware or acpi_lpss drivers as module, or i=
f
you are building the intel_cht_int33fe code into the kernel, then this
is more or less expected to happen.

You can do "ls /sys/bus/i2c/devices" to check if it did succeed on
later re-probe attempts (the fuel-gauge device should be there if
things succeeded).

And you should probably do one more version, suppressing the dev_err
on -EPROBE_DEFER like e.g. this snippet from the typec code:

         if (fusb302_irq < 0) {
                 if (fusb302_irq !=3D -EPROBE_DEFER)
                         dev_err(dev, "Error getting FUSB302 irq\n");
                 return fusb302_irq;
         }

Regards,

Hans




>=20
>>> +=09data->hw_type =3D ret;
>>> +=09data->dev =3D dev;
>>> +
>>> +=09switch (data->hw_type) {
>>
>> I suggested adding hw_type to data so that it could be used to
>> select the right remove function in cht_int33fe_remove(),
>> since you are using a remove function pointer in data for this
>> (which is fine), there is no reason to store hw_type in
>> cht_int33fe_data anymore, please drop this and change the
>>
>> =09switch (data->hw_type) {
>>
>> to:
>>
>> =09switch (ret) {
>=20
> OK, sure
>=20
>>
>> p.s.
>>
>> I've done the rebase myself and I'm building a kernel with my re-based v=
ersion of this
>> patch to test it on a typec device. I will get back to you with the resu=
lts
>> (I expect things will just work, just making sure).
>>
>=20

