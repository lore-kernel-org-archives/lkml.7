Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55423ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D20A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrBo0HrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfJPH1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:27:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726856AbfJPH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571210842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGBDAdb3YnijWBVYdlInolCMs5oOL00xTnXj5F/DK3A=;
        b=ZrBo0HrTSGGsmF+hWsu/IZcaqdaLHNOevyMyTaxbNgmS7Rnj66NFlmC1quTb3tGIWwMys2
        5pIXh15Sa+k5BiJiwrwWMhsCE2QqEY61T79r2PPhx3Yaj5CkoJ+MGz7LqozWv7lh/fx5UR
        MKcUL3I+chO/cgQCIN0YAU/bO7K0fLQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-ulPgfiwANrqjZXqf_p6GEQ-1; Wed, 16 Oct 2019 03:27:20 -0400
Received: by mail-wm1-f70.google.com with SMTP id r21so584374wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhD8VGexW/5QagnP/Ued5Qhc8c7mr6fpk5pCNSfJYfc=;
        b=mn8Ny15AKBSOLeau0wgZFYu3qXD4vdnenA6DCqT6xAV1fUcHvfD7oq5FbER3aFwCBG
         siF9XVPMPAisnSRPmn9mo9W9Dn8voFjouFr9laQRzR7i8Kv9fqO1CdsVYpxY8f35huDU
         FxClsZbvTi0f//X1rmRB2JLiSx5YSKrD1DXDmMDtdhvWmTn1E+jvQBh1C491eMgIYtso
         LI1YPgrv/B1m1EJT1JX9Ycwlq6U2aNqosbCY8+pMKM0L55/jez0lWwTRu7qF/fbM9nQH
         qlkIlhoNfUfRpNN3OvdltX7vVLUWiv1+sMiRMh8IVrioykQMBhB0IOyl4smiajxizee5
         Kqeg==
X-Gm-Message-State: APjAAAUQ1gV4ckY3aGxIUbG+6pBdik7WNc1G5raO8gV5MRALWYlEYb/x
        2zNcNGL18DUGO6uI0Dpoz14XyRo7+q7fElkX62vp4qpQdz0tUX5/VBj7XLOsGAFriBpfVpZTz3Z
        GuhG32ulgXF541cl+d7YImuP6
X-Received: by 2002:a1c:9894:: with SMTP id a142mr2036226wme.70.1571210839646;
        Wed, 16 Oct 2019 00:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyPkQFx5uOArg7hO/ofUb50CjW/EkVfR8jfBWPKRTJEKoyhGtFJhJoj6xq6jfvZZfKpiJrn1A==
X-Received: by 2002:a1c:9894:: with SMTP id a142mr2036195wme.70.1571210839356;
        Wed, 16 Oct 2019 00:27:19 -0700 (PDT)
Received: from localhost.localdomain ([109.38.134.168])
        by smtp.gmail.com with ESMTPSA id q192sm1902217wme.23.2019.10.16.00.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 00:27:18 -0700 (PDT)
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
 <2e369349-41f6-bd15-2829-fa886f209b39@redhat.com>
 <CALAqxLVcQ7yZuJCUEqGmvqcz5u0Gd=xJzqLbmiXKR+LJrOhvMQ@mail.gmail.com>
 <b8695418-9d3a-96a6-9587-c9a790f49740@redhat.com>
 <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <648e2943-42f5-e07d-5bb4-f6fd8b38b726@redhat.com>
Date:   Wed, 16 Oct 2019 09:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLVh6GbiKmuK60e6f+_dWh-TS2ZLrwx0WsSo5bKp-F3iLA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: ulPgfiwANrqjZXqf_p6GEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/15/19 7:39 AM, John Stultz wrote:
> On Thu, Oct 3, 2019 at 1:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 03-10-2019 22:37, John Stultz wrote:
>>> Fair point. I'm sort of taking a larger patchset and trying to break
>>> it up into more easily reviewable chunks, but I guess here I mis-cut.
>>>
>>> The user is the hikey960 gpio hub driver here:
>>>     https://git.linaro.org/people/john.stultz/android-dev.git/commit/?i=
d=3Db06158a2d3eb00c914f12c76c93695e92d9af00f
>>
>> Hmm, that seems to tie the TypeC data-role to the power-role, which
>> is not going to work with role swapping.
>=20
> Thanks again for the feedback here. Sorry for the slow response. Been
> reworking some of the easier changes but am starting to look at how to
> address your feedback here.
>=20
>> What is controlling the usb-role-switch, and thus ultimately
>> causing the notifier you are suggesting to get called ?
>=20
> The tcpm_mux_set() call via tcpm_state_machine_work()
>=20
>> Things like TYPEC_VBUS_POWER_OFF and TYPEC_VBUS_POWER_ON
>> really beg to be modeled as a regulator and then the
>> Type-C controller (using e.g. the drivers/usb/typec/tcpm/tcpm.c
>> framework) can use that regulator to control things.
>> in case of the tcpm.c framework it can then use that
>> regulator to implement the set_vbus callback.
>=20
> So I'm looking at the bindings and I'm not sure exactly how to tie a
> regulator style driver into the tcpm for this?
> Looking at the driver I just see this commented out bit:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/usb/typec/tcpm/tcpm.c#n3075
>=20
> Do you happen to have a pointer to something closer to what you are descr=
ibing?

Look at the tcpm_set_vbus implementation in drivers/usb/typec/tcpm/fusb302.=
c
you need to do something similar in your Type-C controller driver and
export the GPIO as as a gpio-controlled regulator and tie the regulator to
the connector.

Regards,

Hans

