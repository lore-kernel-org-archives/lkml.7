Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0DBC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA8D27F5E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfFCJRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:17:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41482 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfFCJLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id x25so13710888eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OG+wv3KqwkIxkFn1hvlOhyQJMdD3qAH7uLRblyeIxmw=;
        b=hGZAYoZqefZdKEh2IvuFHZoH2jMmweH23m7kzh8kBSP0WX+mCvB/axNY+1bYGZ61we
         h1Su4MTGuQj1N3DgLRHw5lgv9vDnvDl9X4qf3BKOSVYS/qE0ab5z0T6DoDaI47mynVDk
         gRGir8zIJ9LaGwwMaXoBXWnMB2F1bfsk6pEPOoZyDUyWB01+6arH2iDwn6qy3Xi2xDiM
         GcTm23daMZrx3nOjb2w7cOm8DUHlDzrS0jaWXB9QHetMvwWGfjmwDKQMVNRh+sPdOlgI
         mdPZZrlEQBROuma2ORi9Ns6AJaT124nEebmYfszHCu15GuUC0t8bWheXJAuV0kG/CdbU
         /vYw==
X-Gm-Message-State: APjAAAX+WGsEaISJ5Tr07h9JAB0LxSuEfe4Tn1Ot5HDJjk07Mm27PjKP
        PVorkAGWKlhdN/tUEERsQfdoPY1gX9w=
X-Google-Smtp-Source: APXvYqz1vb/GtNDI0d8P3KGIusxxHGOCkfnzNhDpbmeVWD1r4YyvZTFrjQYsLumEjHBqId5ctx21ww==
X-Received: by 2002:a50:fc82:: with SMTP id f2mr26823610edq.72.1559553111720;
        Mon, 03 Jun 2019 02:11:51 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y8sm2530322ejq.24.2019.06.03.02.11.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 02:11:51 -0700 (PDT)
Subject: Re: hid-related 5.2-rc1 boot hang
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e158d983-1e7e-4c49-aaab-ff2092d36438@redhat.com>
Date:   Mon, 3 Jun 2019 11:11:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1906010014150.1962@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01-06-19 00:15, Jiri Kosina wrote:
> On Thu, 30 May 2019, Dave Hansen wrote:
> 
>> On 5/29/19 2:17 AM, Hans de Goede wrote:
>> ...
>>> Dave, can you try building your initrd without the hid-logitech-dj module
>>> included in the initrd?
>>
>> I did this on a vanilla 5.2-rc2 kernel (without the reverts) and still
>> experienced the boot hang while the device was inserted.
>>
>>> Also can you check if your modprobe is provided by module-init-tools
>>> or by kmod ?
>>
>> $ dpkg -S `which modprobe`
>> kmod: /sbin/modprobe
> 
> Benjamin, Hans, are you looking into this?

Not really, I cannot reproduce the request_module problem. I was hoping some
of the info from Dave would help to pinpoint it, but it does not :|

> If not, I think we should start reverting (at least the request_module()
> changes

I agree we need to do something about the request_module changes.

I myself was thinking about somehow making them conditional, e.g. we
could add a (temporary) module option defaulting to false for this
while we investigate further.

I'm afraid that if we just revert we will never find the root cause and then
we will be stuck with the suboptimal behavior of first the generic hid driver
binding followed by a unbind + bind of the new driver shortly afterwards,
which also leads to a ton of udev events being fired to userspace (well I
guess this does make for a good stress test of the userspace hotplug code).

> not sure about the rest of logitech issues yet) next week.

The main problem seems to be the request_module patches. Although I also
have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
so we may need to drop that product-id from hid-logitech-dj, I'm working on
that one...

Regards,

Hans

