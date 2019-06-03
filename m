Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A71C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9972800C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfFCJcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:32:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33692 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfFCJcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:32:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id y17so7938644edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MuUwNLcPfT/+zATBH4u9dUs0Z1WXWpu06xsQGxzqoY=;
        b=Vu+thWWdEOCzCJnSb0hoJS+pF8xH1Ch0W9NCni0z+mYk7rUthOVwKFJv5omY91KLVo
         EwbKejkaT5yWeAaZndgPDE/h87BE3Ghr54E2cs5Wo4vCQw0qQtzQjErIUVpOIXXZvuR7
         BoojHM41NmOvnE0gUmLE/NbQWJpIGD+aLHI7PUAVJeixwYhxGR0PLAsGf9e9M95mrLwE
         kX31xwYrgYArwsbmi0UJyNJpdZUhynmwrsFPiuIqIvj5xNAGdCGMernW9eGeNtlTx8Wc
         kZ+MZZQvwceT0MQtkj+ansxULDKM3zTB6t1RqTXnPzlYmh21btuMd9NRFdYa4KkTzfpx
         cBoA==
X-Gm-Message-State: APjAAAXdcypsGkNKLwGQ3QerZNK1ivkRLz6osqvPjo0ITbFvt85gWZMS
        7EGZ3xiL9nTyyDwASTuQmg3X8DO3tk0=
X-Google-Smtp-Source: APXvYqzPLI+BhjrCwqu59zzJGO7teaba6zJ0gAKWLOiqpf18XHKqh7nGwqSw2w3RyWK/gNr6AyETRQ==
X-Received: by 2002:aa7:d342:: with SMTP id m2mr27474197edr.111.1559554333155;
        Mon, 03 Jun 2019 02:32:13 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id h23sm2513270ejc.34.2019.06.03.02.32.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 02:32:12 -0700 (PDT)
Subject: Re: hid-related 5.2-rc1 boot hang
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, Dave Hansen <dave.hansen@intel.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
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
Message-ID: <e602db44-c792-1abe-e389-a71fca6d2ddd@redhat.com>
Date:   Mon, 3 Jun 2019 11:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-06-19 11:11, Hans de Goede wrote:
> Hi,
> 
> On 01-06-19 00:15, Jiri Kosina wrote:
>> On Thu, 30 May 2019, Dave Hansen wrote:
>>
>>> On 5/29/19 2:17 AM, Hans de Goede wrote:
>>> ...
>>>> Dave, can you try building your initrd without the hid-logitech-dj module
>>>> included in the initrd?
>>>
>>> I did this on a vanilla 5.2-rc2 kernel (without the reverts) and still
>>> experienced the boot hang while the device was inserted.
>>>
>>>> Also can you check if your modprobe is provided by module-init-tools
>>>> or by kmod ?
>>>
>>> $ dpkg -S `which modprobe`
>>> kmod: /sbin/modprobe
>>
>> Benjamin, Hans, are you looking into this?
> 
> Not really, I cannot reproduce the request_module problem. I was hoping some
> of the info from Dave would help to pinpoint it, but it does not :|
> 
>> If not, I think we should start reverting (at least the request_module()
>> changes
> 
> I agree we need to do something about the request_module changes.
> 
> I myself was thinking about somehow making them conditional, e.g. we
> could add a (temporary) module option defaulting to false for this
> while we investigate further.
> 
> I'm afraid that if we just revert we will never find the root cause and then
> we will be stuck with the suboptimal behavior of first the generic hid driver
> binding followed by a unbind + bind of the new driver shortly afterwards,
> which also leads to a ton of udev events being fired to userspace (well I
> guess this does make for a good stress test of the userspace hotplug code).

Quick update, we have another report of module-loading related problems
which are likely related:

https://bugzilla.kernel.org/show_bug.cgi?id=203741

In this case there is no hang, instead there is a 1 to 3 minute delay.

Regards,

Hans

