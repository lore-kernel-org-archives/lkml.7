Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F02CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303924DA9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfFDIFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:05:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44600 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfFDIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:05:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so30683279edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xUZni4OpdFc/4ft0GFU+wjL+RRsQvYq3HFinNPCtXFo=;
        b=Kjj833Jxi1AKsDxjzfhtQSFq8L0UJSFG+DpwdtR4htwMAdORf2TvHZbnCsAP1IX5S1
         RiC2vTXcsapaKGY8boyK2Alq+tdaG1lZ6RpSRIlunrdO153KlXComHQH0hv2vJd+lfnu
         ZjgbUegxLt0w3jY+czgDCOMTgj5b3GQSSYN36k6PPJ/dWZkBcnOjeJpnzdTv5V3TtuqN
         UiCqAEhl0wE3hjqAiJrRPKMqj7LWd2ykwHnngtcZi5SNWxKnV1vwsiFCDbIEDI1PKA/e
         Z+phthuJbAZytI7p71fXrZTuykBOvkTCjK5x25tjp0QC4Zpl8fgH62y0U62arMjUkYk5
         3Dew==
X-Gm-Message-State: APjAAAWPcueF2mNo1NZZN+sV0bBx4A+/C8s0nc51VzuRvs/3C0UFByUE
        Im0GT0jgXc0ZHM8mJAYCyHMJ47w/3p0=
X-Google-Smtp-Source: APXvYqxuoF85UwAHq6t+G0SV+bMOXI7UMJbsQCPCCeH34yDY0yGe1/5LIxDWcHLt6IjVIgTNanZOPQ==
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr34078396edr.67.1559635504158;
        Tue, 04 Jun 2019 01:05:04 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id f3sm3038326ejo.90.2019.06.04.01.05.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:05:03 -0700 (PDT)
Subject: Re: hid-related 5.2-rc1 boot hang
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <2c1684f6-9def-93dc-54ab-888142fd5e71@intel.com>
 <nycvar.YFH.7.76.1905281913140.1962@cbobk.fhfr.pm>
 <CAO-hwJJzNAuFbdMVFZ4+h7J=bh6QHr_MioyK2yTV=M5R6CTm=A@mail.gmail.com>
 <8a17e6e2-b468-28fd-5b40-0c258ca7efa9@intel.com>
 <4689a737-6c40-b4ae-cc38-5df60318adce@redhat.com>
 <a349dfac-be58-93bd-e44c-080ed935ab06@intel.com>
 <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
 <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com>
 <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
 <CAO-hwJKRRpsShw6B-YLmsEnjQ+iYtz+VmZK+VSRcDmiBwnS+oA@mail.gmail.com>
 <e431dafc-0fb4-4be3-ac29-dcf125929090@redhat.com>
 <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com>
Date:   Tue, 4 Jun 2019 10:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJ+5UYJMnuCS0UL4g45Xc181LraAzc-CMuYB2rcqKGe_Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-06-19 09:51, Benjamin Tissoires wrote:
> On Mon, Jun 3, 2019 at 4:17 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 03-06-19 15:55, Benjamin Tissoires wrote:
>>> On Mon, Jun 3, 2019 at 11:51 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Again,
>>>>
>>>> On 03-06-19 11:11, Hans de Goede wrote:
>>>> <snip>
>>>>
>>>>>> not sure about the rest of logitech issues yet) next week.
>>>>>
>>>>> The main problem seems to be the request_module patches. Although I also
>>>
>>> Can't we use request_module_nowait() instead, and set a reasonable
>>> timeout that we detect only once to check if userspace is compatible:
>>>
>>> In pseudo-code:
>>> if (!request_module_checked) {
>>>     request_module_nowait(name);
>>>     use_request_module = wait_event_timeout(wq,
>>>           first_module_loaded, 10 seconds in jiffies);
>>>     request_module_checked = true;
>>> } else if (use_request_module) {
>>>     request_module(name);
>>> }
>>
>> Well looking at the just attached dmesg , the modprobe
>> when triggered by udev from userspace succeeds in about
>> 0.5 seconds, so it seems that the modprobe hangs happens
>> when called from within the kernel rather then from within
>> userspace.
>>
>> What I do not know if is the hang is inside userspace, or
>> maybe it happens when modprobe calls back into the kernel,
>> if the hang happens when modprobe calls back into the kernel,
>> then other modprobes (done from udev) likely will hang too
>> since I think only 1 modprobe can happen at a time.
>>
>> I really wish we knew what distinguished working systems
>> from non working systems :|
>>
>> I cannot find a common denominator; other then the systems
>> are not running Fedora. So far we've reports from both Ubuntu 16.04
>> and Tumbleweed, so software version wise these 2 are wide apart.
> 
> I am trying to reproduce the lock locally, and installed an opensuse
> Tumbleweed in a VM. When forwarding a Unifying receiver to the VM, I
> do not see the lock with either my vanilla compiled kernel and the rpm
> found in http://download.opensuse.org/repositories/Kernel:/HEAD/standard/x86_64/
> 
> Next step is install Tumbleweed on bare metal, but I do not see how
> this could introduce a difference (maybe USB2 vs 3).

Ok, thank you for looking into this.

>>>>> have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
>>>>> so we may need to drop that product-id from hid-logitech-dj, I'm working on
>>>>> that one...
>>>>
>>>> Besides the modprobe hanging issue, the only other issues all
>>>> (2 reporters) seem to be with 0xc52f receivers. We have a bug
>>>> open for this:
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=203619
>>>>
>>>> And I've asked the reporter of the second bug to add his logs
>>>> to that bug.
>>>
>>> We should likely just remove c52f from the list of supported devices.
>>> C52f receivers seem to have a different firmware as they are meant to
>>> work with different devices than C534. So I guess it is safer to not
>>> handle those right now and get the code in when it is ready.
>>
>> Ack. Can you prepare a patch to drop the c52f id?
> 
> Yes. I have an other revert never submitted that I need to push, so I
> guess I can do a revert session today.
> 
> I think I'll also buy one device with hopefully the C52F receiver as
> the report descriptors attached in
> https://bugzilla.kernel.org/show_bug.cgi?id=203619 seems different to
> what I would have expected.

They are actually what I expected :)

The first USB interface is a mouse boot class device, since this is a mouse
only receiver. This means that the mouse report is unnumbered and we need to
extend the unnumbered mouse-report handling to handle this case. Also the
device is using the same highres mouse-reports as the gaming receiver is.

I'm actually preparing a patch right now which should fix this. Still might
be better to do the revert for 5.2 and get proper support for the c52f
receiver into 5.3.

Regards,

Hans
