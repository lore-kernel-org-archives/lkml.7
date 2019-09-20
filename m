Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C580CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7EC2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JojRgbKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfITN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:56:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727737AbfITN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568987777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+jOBIp7ba0yHIK4tEPcw4cnj60zFLAq56/BryStmgs=;
        b=JojRgbKGvwGBnrWNur7H/yFUcmYmq1nyYrlNNuiMLdHCTPT3vAo+zGBxzESkrLqAFoOysf
        Wz7htre43rgV+l2YEXImokfEngWS/tl1B+prN1vD6O9Sm2YmGEbwW2hEBpD1FPsTFbYZ2q
        ETdsB0FakSZmXaAOaU8WiH9qhO22bd8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-U5_CgNTLOEWp1f6LELh2DQ-1; Fri, 20 Sep 2019 09:56:15 -0400
Received: by mail-ed1-f72.google.com with SMTP id s29so4244953eds.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 06:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQZ80X2IpSpPo25VXl4Y9/0GgF00Rtrbgz84uINzy+Q=;
        b=pgETzK0syx6/+O8afElOvRQ/oFmN59prXNphKZ1lPFY5VGYdjGOME+tA4wOsHRVLHl
         sFzOPS0mHtALtJnMufQWElo+Fv9nmGvRYxPyp4lLMFKG9yd8G59+QGZJXXA9YhNvAcnZ
         KquA8y4tXNlqj4vByeXUERo4p3W2Unuuw+xZN6NTxDf0FPV3Ib0ica7G5rS4HLjxmHIn
         ZDxZrlwu3VC8wSCKY6LGavvVVGSjXfTTe/SfTKv1g2bSgKL3pgCQKOHx8fWIGiQSMZ7K
         kkTGzLTWHMbuOpHscvkpFWSZcmi8VtzZu4hn8zAXAdqfC/eTWiD713IXoztB7WXCZbNo
         l0ew==
X-Gm-Message-State: APjAAAUvJ2brLeygGhiVfgBbEIiu+2C+Hu0mWYv+dB/YrOx/BpbnBV41
        qR2l3sfQ8W497ueIwO+3Z8hLDtu+TmqV07MR0iOdT5c5Bcf2wauTX7n2q8ggC3wVFaYYQN71P2h
        DrLC84Wnlj87La/USzi50y1Fr
X-Received: by 2002:a05:6402:1ade:: with SMTP id ba30mr16084564edb.304.1568987768712;
        Fri, 20 Sep 2019 06:56:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy1AEcgEJKD2ZHrH2/XvpO9JWOZsPUPg1K0MTs8/0vvQKBKiDlsga+bM5q1s6vwiCeaKOAlEg==
X-Received: by 2002:a05:6402:1ade:: with SMTP id ba30mr16084543edb.304.1568987768534;
        Fri, 20 Sep 2019 06:56:08 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id i30sm342639ede.32.2019.09.20.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 06:56:07 -0700 (PDT)
Subject: Re: [PATCH 4.19 16/50] gpiolib: acpi: Add
 gpiolib_acpi_run_edge_events_on_boot option and blacklist
To:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20190918061223.116178343@linuxfoundation.org>
 <20190918061224.680169319@linuxfoundation.org> <20190919074601.GA6968@amd>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <511ae431-2a0e-6362-094a-988c0f3e0db6@redhat.com>
Date:   Fri, 20 Sep 2019 15:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919074601.GA6968@amd>
Content-Language: en-US
X-MC-Unique: U5_CgNTLOEWp1f6LELh2DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/19/19 9:46 AM, Pavel Machek wrote:
> On Wed 2019-09-18 08:18:59, Greg Kroah-Hartman wrote:
>> From: Hans de Goede <hdegoede@redhat.com>
>>
>> commit 61f7f7c8f978b1c0d80e43c83b7d110ca0496eb4 upstream.
>>
>> Another day; another DSDT bug we need to workaround...
>>
>> Since commit ca876c7483b6 ("gpiolib-acpi: make sure we trigger edge even=
ts
>> at least once on boot") we call _AEI edge handlers at boot.
>>
>> In some rare cases this causes problems. One example of this is the Mini=
x
>> Neo Z83-4 mini PC, this device has a clear DSDT bug where it has some co=
py
>> and pasted code for dealing with Micro USB-B connector host/device role
>> switching, while the mini PC does not even have a micro-USB connector.
>> This code, which should not be there, messes with the DDC data pin from
>> the HDMI connector (switching it to GPIO mode) breaking HDMI support.
>>
>> To avoid problems like this, this commit adds a new
>> gpiolib_acpi.run_edge_events_on_boot kernel commandline option, which
>> allows disabling the running of _AEI edge event handlers at boot.
>=20
> So... apparently Windows does _not_ run _AEI edge event handlers at
> boot, otherwise Minix would realize that fault.

Right, also came the conclusion that Windows likely does not run
_AEI edge event handlers at boot.

> Would it make sense not to do it by default, either?

Well as the commit-msg for the commit which originally added this
explains, there are at least 2 reasons to run them at boot:

1) This is necessary on at least some ms surface devices to get
the initial LID state correct, otherwise the LID will be report
being closed until the first time it is actually closed +
opened again. Now this case we can probably quirk ourselves
out of in some way.

2) The other case is Cherry Trail based tablets. The hw on these
can typically do both USB device and host mode on the tablets
micro-b or type-c connector. This involves a mux which switches
the data lines between the host and device controllers inside the
Cherry Trail SoC. This mux is controlled by an edge-triggered ACPI
eventhandler connected to the ID pin of the micro-b connector.

OOTB Windows only supports host mode, I guess there might be some
way to get device mode to work under Windows but tablet manufacturers
do not seem to care about this.

By default many UEFI firmwares put the mux in host mode during boot,
independent of the actual ID pin value since they only care about host
mode and want to support e.g. booting from USB or an external kbd.

By default the ID pin on the micro-b connector is high (pulled up)
an actual micro-b to host(A-female) cable pulls the ID-pin to gnd,
a USB-A to micro-B cable such as used to connect the tablet to a PC
leaves the ID pin floating (pulled high).

So without a host adapter inserted, we boot with the mux in host
mode, and the ID pin high. Now if the user connects the tablet to
a PC (or it was connected at boot) the ID pin does not change,
the mux is not change and device mode does not work since the
mux is set wrong. The only way to fix this is to force the ID
pin to change, so that would mean inserting a host-adapter, removing
it again and then connecting the tablet to a PC.

Running the _AEI handler at boot correctly puts the mux in
device position fixing this. Almost all Cherry Trall devices
suffer from this, makig it impossible to quirk our way out of this.

Now arguably we could limit the running of _AEI handlers at boot
to Cherry Trail, I would not object to that, but the
Minix Neo Z83-4 mini PC is a Cherry Trail device itself, as
mentioned in the commit msg, the  troublesome _AEI handler on this
device is the same ID pin handler which we want to run boot on all
Cherry Trail tablets. In this mini-pc case it is wrong though since
the mini-pc does not even have a micro-b connector.

I hope this explains.

Regards,

Hans

