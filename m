Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B75C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D620748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBLukaEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOMKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:10:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26286 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727399AbfKOMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573819808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SLCfbXrVulZogYj/s2/SbxodvpIYXr2n3EpWJPZhgM=;
        b=PBLukaEqHyjPwXP2q6j15H7BHeAVqbBlnf8pqR/SfO3oi7mnbIN5PHvQZ7wyqc2EfUl+FH
        N7N/LVB3nINFDe2OgJtQ2m2wjpldS/RNosMi7c7iPvlhrdgPaXRxjYkLtW8Hrv7bYtKulj
        9zAmhzV6vybTkEYZkLMBdNfXWKjpnOs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-ZMKWNOMgPqCeaPhXKKHHmg-1; Fri, 15 Nov 2019 07:10:02 -0500
Received: by mail-wm1-f71.google.com with SMTP id f14so5914200wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 04:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4+dQMXVTzdXBza6cpCVy4c3dq1dN1YlKsihA8W4Y8Y=;
        b=HXNRW+yAoX+sXb3Qtx5VyQ+EF2NpnqNL4928M+DW2Z2FM2VMYI5n222Cyw4e32A5k9
         92N0g9hixubMrRaXLFB5mwamwN5juu4Dn9wjqsKzXIwJT0NJTbG0mO2Zh9Beo3GPosFj
         kPlV0WO4fVSJiDUlnPHg1LhsbrFEfvrOmJSmQF5hCM2ONafAJxyJ7KRWpe06/ys/j0NT
         VEZEBtVV5dX4AFnQC9BpYO8liSR4uCMsa8qgzpRICxGzAHUMj1Xe1DMtQlXAradb/IJe
         6nE3upVlU1+3DGy6BGk2rCt6vGj8kcN+IyAYpuxOzwOMVrSCftQoUawVg0K+laYcHsBp
         qUtw==
X-Gm-Message-State: APjAAAXKfzXrTggrPaAUpcC1R5uKgMQBI1jfTfmRWUSLkZUf7GMHgJMR
        Ta8SM/97gsyURjptAqqHm4XfJJexu0fipTzFCzrN3fp9kZiEaXPV5VTjMmXwVFRodGn+45NqBmr
        l5ZzJS31qnxmExnBNN7HbSUnr
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13131552wmd.171.1573819801059;
        Fri, 15 Nov 2019 04:10:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVn+PxOzHLWEYlmy0V5fELKmqUNxPX2dvbZL7DihUzDLfdB4tPBTsaLy1Ld99Eg+Qze1qseg==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13131526wmd.171.1573819800855;
        Fri, 15 Nov 2019 04:10:00 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y8sm9103529wmi.9.2019.11.15.04.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:10:00 -0800 (PST)
Subject: Re: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
 <20191011144834.GL16384@42.do-not-panic.com>
 <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
 <20191114194233.GE11244@42.do-not-panic.com>
 <f00804ae-e556-35e4-d0a3-cd9201fdd2d0@redhat.com>
 <9b0a0121-3e63-0602-6c0d-00547e389f76@redhat.com>
 <20191114215009.GF11244@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d7546f63-5472-b867-4e79-912edf9cfa6c@redhat.com>
Date:   Fri, 15 Nov 2019 13:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114215009.GF11244@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: ZMKWNOMgPqCeaPhXKKHHmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-11-2019 22:50, Luis Chamberlain wrote:
> On Thu, Nov 14, 2019 at 09:48:38PM +0100, Hans de Goede wrote:

<snip>

>> But I guess what you really want is some error to be thrown if someone
>> calls firmware_request_platform() before we are ready.
>=20
> Yes.
>=20
>> I guess I could make efi_check_for_embedded_firmwares() which scans
>> for known firmwares and saved a copy set a flag that it has run.
>>
>> And then combine that with making efi_get_embedded_fw() (which underpins
>> firmware_request_platform()) print a warning when called if that flag
>> is not set yet.

<snip>

> That'd be great.

So I've been working on this, my first though was to use WARN_ON as
calling this too early would be a bug, but there is a bunch of
normal circumstances where efi_check_for_embedded_firmwares() never
runs. One of the being classic BIOS boot, but e.g. also when running
paravirtualized in a paravirt env. using UEFI.

Normally we should not end up calling efi_get_embedded_fw() in those
cases, for one it is unlikely for any drivers using firmware_request_platfo=
rm()
to be used in such an environment, and if we somehow do end up with
a case where firmware_request_platform() is called, since the EFI
emebedded fw fallback then will not work I would expect a copy of
the necessary fw to be under /lib/firmware so we never hit the fallback.

This all makes efi_get_embedded_fw() getting called in cases where
efi_check_for_embedded_firmwares() will never run unlikely, but not
impossible. Making a WARN_ON the wrong thing to do so for v8 of this
patch-set I will add a pr_warn for this.

Note I've looked into detecting all the circumstances where it is normal
for efi_check_for_embedded_firmwares() to never run, but after tracing
the call path leading up to it getting called I've found that a check
for that is complicated and more importantly error-prone and likely
to get out of sync with reality if any of the functions higher up
the call path ever change the conditions.

So a pr_warn it is, and since as explained one would normally not
expect to ever hit the fallback on systems where
efi_check_for_embedded_firmwares() does not get called, I see no
harm in simply always printing the warning if
efi_check_for_embedded_firmwares() was not called.

Regards,

Hans

