Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C3C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76ACC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbfFKQ1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:27:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51915 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbfFKQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:27:44 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so5980144itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m54vtFTLLc6L49HOxvhgOC5cZDmqGyAKOX7qrD66JJc=;
        b=o04jqAIVP7Sj+Ua8oVbJ5E1wQ0+rtsbpp7zbaGoqnE0QNTpKsO8fosjXLOmEjtKTrY
         gxayQVxlAp78T/xY8ZJ1Ce5vvJw8gXIw6VKYd8f/LcPBH2TpmrwsKabh+7+R1JsZ5mcI
         XtorD64C3UPZWpXdipXzstZuqPpFkv8LCJLyPzR4G0Xgw0S6GWrjsDanufwxsOjzvTx8
         QWTeR/ciLhtyk9w4ErsuEJfglfEAK5a4d+hLW5xjK3rvFHvDYvV+1yw9WLjhFx2RGY8O
         xpf/+/an8KNz0526OwByFhphoabjCkToaVj3S/IKnuFs0FD+Bqz5GvrGQTfg67NKM3Mc
         vv6w==
X-Gm-Message-State: APjAAAV61/awlnWhikqfDPo+d0jcvvfSnAPavI4RI7kNYgnDy2JM/HUm
        WNfbuGZ6U4LqzH1QlSt+SKpWSejOOcg=
X-Google-Smtp-Source: APXvYqwhAqk3DHHOLEXBAt7xsQdBVFfnS5WyELVTG4mZC3jJqxDQC1PTMLKNBMCiSsOfVulfxT6V4w==
X-Received: by 2002:a05:6638:38a:: with SMTP id y10mr52662186jap.104.1560270462995;
        Tue, 11 Jun 2019 09:27:42 -0700 (PDT)
Received: from masetto.ahs3 (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id r143sm2140499ita.0.2019.06.11.09.27.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:27:42 -0700 (PDT)
Reply-To: ahs3@redhat.com
Subject: Re: [RFC PATCH] ACPI / processors: allow a processor device _UID to
 be a string
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190610200734.1182-1-ahs3@redhat.com>
 <20190611125258.GA16445@e107155-lin>
 <5ea4f403-853f-5067-4e9b-a8aabec5b1cd@redhat.com>
 <20190611160906.GA27548@e107155-lin>
From:   Al Stone <ahs3@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0dfa99bf-7527-9dc3-201e-a482057fd51c@redhat.com>
Date:   Tue, 11 Jun 2019 10:27:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611160906.GA27548@e107155-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 10:11 AM, Sudeep Holla wrote:
> On Tue, Jun 11, 2019 at 10:03:15AM -0600, Al Stone wrote:
>> On 6/11/19 6:53 AM, Sudeep Holla wrote:
>>> On Mon, Jun 10, 2019 at 02:07:34PM -0600, Al Stone wrote:
>>>> In the ACPI specification, section 6.1.12, a _UID may be either an
>>>> integer or a string object.  Up until now, when defining processor
>>>> Device()s in ACPI (_HID ACPI0007), only integers were allowed even
>>>> though this ignored the specification.  As a practical matter, it
>>>> was not an issue.
>>>>
>>>> Recently, some DSDTs have shown up that look like this:
>>>>
>>>>   Device (XX00)
>>>>   {
>>>> 	Name (_HID, "ACPI0007" /* Processor Device */)
>>>>         Name (_UID, "XYZZY-XX00")
>>>>         .....
>>>>   }
>>>>
>>>> which is perfectly legal.  However, the kernel will report instead:
>>>>
>>>
>>> I am not sure how this can be perfectly legal from specification
>>> perspective. It's legal with respect to AML namespace but then the
>>> other condition of this matching with entries in static tables like
>>> MADT is not possible where there are declared to be simple 4 byte
>>> integer/word. Same is true for even ACPI0010, the processor container
>>> objects which need to match entries in PPTT,
>>>
>>> ACPI Processor UID(in MADT): The OS associates this GICC(applies even
>>> for APIC and family) Structure with a processor device object in
>>> the namespace when the _UID child object of the processor device
>>> evaluates to a numeric value that matches the numeric value in this
>>> field.
>>>
>>> So for me that indicates it can't be string unless you have some ways to
>>> match those _UID entries to ACPI Processor ID in MADT and PPTT.
>>>
>>> Let me know if I am missing to consider something here.
>>>
>>> --
>>> Regards,
>>> Sudeep
>>>
>>
>> Harumph.  I think what we have here is a big mess in the spec, but
>> that is exactly why this is an RFC.
>>
>> The MADT can have any of ~16 different subtables, as you note.  Of
>> those, only these require a numeric _UID:
>>
>>    -- Type 0x0: Processor Local APIC
>>    -- Type 0x4: Local APIC NMI [0]
>>    -- Type 0x7: Processor Local SAPIC [1]
>>    -- Type 0x9: Processor Local x2APIC
>>    -- Type 0xa: Local x2APIC NMI [0]
>>    -- Type 0xb: GICC
>>
>> Note [0]: a value of !0x0 is also allowed, indicating all processors
>>      [1]: this has two fields that could be interpreted as an ID when
>>           used together
>>
>> It does not appear that you could build a usable system without any
>> of these subtables -- but perhaps someone knows of incantations that
>> could -- which is why I thought a string _UID might be viable.
>>
> 
> I hope no one is shipping such device yet or am I wrong ?
> We can ask them to fix as Linux simply can't boot on such system or
> even if it boots, it may have issues with acpi_processor drivers.

I don't think it's shipping, but even if it is, I'm going to have to
insist they fix their tables, just as a practical matter.  I need to
ask if it boots that other OS, too.

>> If we consider the PPTT too, then yeah, _UID must be an integer for
>> some devices.
>>
>> Thanks for the feedback; it forced me to double-check my thinking about
>> the MADT.  The root cause of the issue is not the kernel in this case,
>> but a lack of clarity in the spec -- or at least implied requirements
>> that probably need to be explicit.  I'll send in a spec change.
>>
> 
> Completely agreed. Even little more clarification on this is helpful.
> Thanks for volunteering :) to take up spec change, much appreciated.

No problem, and glad to do it.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
