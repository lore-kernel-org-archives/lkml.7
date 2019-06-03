Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB68C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F27F2804B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfFCJvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:51:33 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41839 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfFCJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:51:32 -0400
Received: by mail-ed1-f46.google.com with SMTP id x25so13866659eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFgMYWZVFF/pv2yQUfl1pVX/S/7PJrbgn5hFnfiX3Ao=;
        b=KAgOvQfAR/ByX7GszlHnQ8v53Px+wrvGOqOZaILFGY374A4FNQDFJX0MvpVjmY7my6
         dkq84ZymnUadJyYHXbW0sKEBxQchrHhVizlCc8+WS4rquvKx39q9ddCFJgr3aVbpksyA
         4+945sRePcTDpTYR06rXV7IdzR7bSPN/lQtIhYIHFKzbpE+TGTn7IbVraaBtGLiWLEgR
         xHuVadhLm06HORBhMq0jiR4m0yRLursekP9zSUyGJWbd4NLplzX9q2jnqoFLXIBHxR2J
         lSSJ9kHS/NQl7EfmIfwCeRn3TuyRtbv95nYvtpH0dKmz9HY2MuMqGazWTZWAD9VdnkO6
         eG5Q==
X-Gm-Message-State: APjAAAVn+ekNyM1QZWVgf95wytFAhqmv65kAL/plYV4MiGU8CJYm9BOx
        iNsd/gB0HBnItWnITAwuvrcRIid7C04=
X-Google-Smtp-Source: APXvYqyWeH+AOs5iqMi+X6vzrvGzGfd5Wup2yVJUR4wVxwhOVY++WwxZic/YzC1hS8zijT302FZJpQ==
X-Received: by 2002:aa7:db56:: with SMTP id n22mr11375926edt.192.1559555490316;
        Mon, 03 Jun 2019 02:51:30 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id dc1sm2470642ejb.39.2019.06.03.02.51.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 02:51:29 -0700 (PDT)
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
Message-ID: <5471f010-cb42-c548-37e2-2b9c9eba1184@redhat.com>
Date:   Mon, 3 Jun 2019 11:51:28 +0200
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

Hi Again,

On 03-06-19 11:11, Hans de Goede wrote:
<snip>

>> not sure about the rest of logitech issues yet) next week.
> 
> The main problem seems to be the request_module patches. Although I also
> have 2 reports of problems with hid-logitech-dj driving the 0xc52f product-id,
> so we may need to drop that product-id from hid-logitech-dj, I'm working on
> that one...

Besides the modprobe hanging issue, the only other issues all
(2 reporters) seem to be with 0xc52f receivers. We have a bug
open for this:

https://bugzilla.kernel.org/show_bug.cgi?id=203619

And I've asked the reporter of the second bug to add his logs
to that bug.

Regards,

Hans

