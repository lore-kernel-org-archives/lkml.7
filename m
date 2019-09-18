Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDBCC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC31207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgOx0GIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfIRMx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:53:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729333AbfIRMx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:53:58 -0400
X-Greylist: delayed 109900 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 08:53:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568811236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycL5oW5FYNJjUQjrUvcbVifqvSx3XJongUQgpzwLpv8=;
        b=QgOx0GIek0qfp/lg9De+LLFlVkvXJuz4rUQ4hfoSxbdR5MNTPVwMlu0z2s+f9g1Z0ub5d3
        pYu/ZuMtH2TZCOKEZTUURmwLvsfgbJKI/9438/+BufySeFNeYeUpiN66RkaN/ToTrxHoyG
        aGj5QIgvXTYy7nczVJdy0gfVUC6StzI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-Rnw9RRrBNlWZbObQfttelg-1; Wed, 18 Sep 2019 08:53:55 -0400
Received: by mail-ed1-f72.google.com with SMTP id c90so4340125edf.17
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vszg+W+WXavX+2L9Kk3QRPhq1ht0GvDGZ0kiRY4GbPg=;
        b=FeAn3/ZcUI3/1XS/m0ED57FJfhHGZenIrfOeBtL7gBsGFWdjCVrfiLUW4h1cRR4T2w
         1224al5a5CpP8QC0jgNXelM651jUW9sZcWYRrLCV5VoGNOt8eN9pNyHQAg6LqG7A7h28
         gjGyoe1CLVDOG2aCitz/3UOXh+eJK4zNjBot3TuYDOJ3e1GMSd79lqLDBWuH1PRA8x23
         ViMTs3cbmvL07f5RRmNFCaxbJfNtWOrKCOEqBbOEvzSTI/5vgV/6p249i5M4QaKQn56x
         +jD1+N2WrHbD7b+VS3Ug1GQgi64X7TdNxPBkmT6yujiQHQ84Ox8yAfHvrztPmx+9rgPT
         vmnw==
X-Gm-Message-State: APjAAAUGpJce80qabKZiSJHsVxkYWDK7qI1IxfmttQKYkvskHySQ73jX
        mEt5dJH9vV50vyNxaTfIj39o/eVDLd7UMmKd+awGojlcURdzgNqOjGQy3VuXchTjsGyrYWHov4S
        Ul1VjwxNZw/NntLxpY5zgqQeW
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr1250413edv.225.1568811233192;
        Wed, 18 Sep 2019 05:53:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkPtdTN1u+9c+esJNyeY2qigBbptrNK5/lYQVegkGY+1YkDa/JNljIAQa6OK+N4D9KWvBPng==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr1250393edv.225.1568811233017;
        Wed, 18 Sep 2019 05:53:53 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s21sm1035118edi.85.2019.09.18.05.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 05:53:51 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] platform/x86/intel_cht_int33fe: Split code to USB
 TypeB and TypeC variants
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@infradead.org>
References: <20190917194507.14771-1-jekhor@gmail.com>
 <20190917194507.14771-2-jekhor@gmail.com>
 <20190918113835.GA16243@kuha.fi.intel.com>
 <20190918115251.GA28946@jeknote.loshitsa1.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <61df124e-18fc-c047-5490-a6b79cbed85c@redhat.com>
Date:   Wed, 18 Sep 2019 14:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190918115251.GA28946@jeknote.loshitsa1.net>
Content-Language: en-US
X-MC-Unique: Rnw9RRrBNlWZbObQfttelg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18-09-2019 13:52, Yauhen Kharuzhy wrote:
> On Wed, Sep 18, 2019 at 02:38:35PM +0300, Heikki Krogerus wrote:
>> On Tue, Sep 17, 2019 at 10:45:07PM +0300, Yauhen Kharuzhy wrote:
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
>>
>> Sorry, but "Type B" is even more confusing here. Type B refers to the
>> Standard-B USB connector, so _not_ the micro connector family. You can
>> check the connector definitions from the latest USB 3.2 specification.
>> The standard-b definition goes something like this:
>>
>>          "The standard _Type-B_ connector defined by the USB x specifica=
tion."
>>
>> Note that all the five supported connectors are listed in ch5
>> "Mechanical":
>>
>>          Standard-A
>>          Standard-B
>>          Micro-B
>>          Micro-AB
>>          Type-C
>>
>> So what was the problem with names that refer to the micro connector
>> family, for example "micro-ab" or "micro-b"?
>=20
> Only one problem: there is no difference between micro B, micro AB, mini
> B or Standard-B types of connectors from this driver point of view =E2=80=
=93 all
> of them can be used for device charging. Now we have only two kind of
> hardware with INT33FE pseudo-device: with Micro-B and Type-C connectors
> but other kind may exist. TypeB is not standartized but it seemed to me
> a good generalization of "USB connectors to charger connection but not
> Type-C". No problem to change it to other suitable name, 'simple', 'dumb'=
,
> 'non-TypeC' or 'micro-B'. All this names are not ideal.

Since the one non Type-C connector device we has has a micro-B I would just
call the file drivers/platform/x86/intel_cht_int33fe_microb.c and be done
with it.

Regards,

Hans

