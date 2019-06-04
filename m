Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B320C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF41624146
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfFDIgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:36:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43780 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfFDIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:36:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so30789535edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0AsC3ilwHmdxFF7yJyfpqnmQ/JMg+U2f+pGfnwNxLI4=;
        b=keDcV7Se4pU/MJpNAKW9MEdrs5wVOy/lR368xgA5OAsD5NeKhg14uc7dD4hXBWsmR4
         3e5DWKUDpF7YFcuK47b6aHkr2PbdU4sOMUuZ6FOvSpEgBOmAtAdPoP+Q0faindHiCIDD
         mzgvzu8rFZHAycQf5NdencsMq88pT2PzUuUMDj0R0hLcaZytLanwJJ3+ArBGPD/PajjB
         2eTjfrshLezHk1ySrE8o1UWGr849eRLtFM3YXNnhwZL0G562XwDRkZpVM7aynese6r/l
         42Dut6UTO1anM8bQJDcA/8WUsZB3l94rUw7bSTQW1WtzK3XYPJRBwo2U8hUze6o5gcZK
         iEmg==
X-Gm-Message-State: APjAAAV/O4Z49KwlfftnXwYyqypwKEkrOXWNhSlOLyzAPjf66DUi+nQ7
        6/eF4xD+2R7QC871eQAc3VxDTAgwIpY=
X-Google-Smtp-Source: APXvYqyakQfdNKtHn1Kxax1xeVppcqd8SvB43SpKuhONd3xNwnNFFr8uJq0P1JIBMJrrbknl1KTn5Q==
X-Received: by 2002:a17:906:5159:: with SMTP id s25mr7939368ejl.16.1559637388807;
        Tue, 04 Jun 2019 01:36:28 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n8sm3030495ejk.45.2019.06.04.01.36.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:36:27 -0700 (PDT)
Subject: Re: hid-related 5.2-rc1 boot hang
From:   Hans de Goede <hdegoede@redhat.com>
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
 <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com>
Message-ID: <c05929f4-00b6-e098-cd69-cd6539ccd3f1@redhat.com>
Date:   Tue, 4 Jun 2019 10:36:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4548d196-b75f-c4d0-8f3c-3e734b9a758c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04-06-19 10:05, Hans de Goede wrote:

<snip>

>>>> We should likely just remove c52f from the list of supported devices.
>>>> C52f receivers seem to have a different firmware as they are meant to
>>>> work with different devices than C534. So I guess it is safer to not
>>>> handle those right now and get the code in when it is ready.
>>>
>>> Ack. Can you prepare a patch to drop the c52f id?
>>
>> Yes. I have an other revert never submitted that I need to push, so I
>> guess I can do a revert session today.
>>
>> I think I'll also buy one device with hopefully the C52F receiver as
>> the report descriptors attached in
>> https://bugzilla.kernel.org/show_bug.cgi?id=203619 seems different to
>> what I would have expected.
> 
> They are actually what I expected :)
> 
> The first USB interface is a mouse boot class device, since this is a mouse
> only receiver. This means that the mouse report is unnumbered and we need to
> extend the unnumbered mouse-report handling to handle this case. Also the
> device is using the same highres mouse-reports as the gaming receiver is.
> 
> I'm actually preparing a patch right now which should fix this. Still might
> be better to do the revert for 5.2 and get proper support for the c52f
> receiver into 5.3.

I've attached a patch to the bug:
https://bugzilla.kernel.org/show_bug.cgi?id=203619

Which should fix this. It is quite simple and safe, so if we get testing
feedback relatively soon, we could go with the fix instead of dropping the
product-id, your call.

Regards,

Hans
