Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0422087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+A81wcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfHSRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:16:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbfHSRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:16:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so1543191pfq.0;
        Mon, 19 Aug 2019 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B594JSWSVAK5cSvz2jxLmvYlIr8hDspAxcGfnCZxVuQ=;
        b=e+A81wcFIo0p5+zsGvEa6VEEhK2nSH+8tLEdkygViusIVNadsxe6YNoM0ps0btYU5h
         NoQCp/8YO47fWk1/7A//pzzKvylIegvJMZ27hg9R1Noh997YuJZJ6t6/HBUWtyF69h1N
         4I+pfc75HVXQFfIt2vgfOUf2gVMHqOqAhZXhXEhn94PPRokNnQjTreKNfaJc058WXodY
         19RLQEajSlgzGDFaOkMedzuvZ9znYak9Rskyg1TbP5kPq1J0IBpMHh673hs3mw4JHQVS
         ccXC6rCxm5DacelS/Je7qEdZ192mbeuLRGGWqeYVjZDp7m5M/4uXHDNH1Ca2b9HDCbZt
         Xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B594JSWSVAK5cSvz2jxLmvYlIr8hDspAxcGfnCZxVuQ=;
        b=KRzimvzXUVjwJVAXPIWy8EqeIpZ8GVmyi0zWO+mVFjT/V5jJ9Hj7Z3JaQD788IAvTE
         l6nfs0pRUq61f9TzBHOfW8DTOT4GSfDh7lRGsQDATTkeg9p8AeEZR+T0/2KCNn5wjFof
         4Z4JZkV19effG0wHFEUvXe5r4tDfSpZlIFNMUM0tu8w0o0F4me0juwLyaJvsV86iYf0l
         QB168ri3Xq0/wTyDKboL3TCdRR9ujFKjPFMNHXqUphv5ECcE475QTw5d+ZgKAa/J3Jb1
         wo2m5n3vukpSQ2hK++Q6d4NhN5rcLMkMrXyLKMZtZhI86upMz0vYi+RemKhRnd2DNgtf
         K7hQ==
X-Gm-Message-State: APjAAAXOJ1CtmG27yGki+gBaJmXoS3sPzAvxkQM39K/DFj6ckhtyVqpn
        IGiwWU5yUzbc9ZEipbuAtf0=
X-Google-Smtp-Source: APXvYqw3afHwjaZV1PHagRMNtuQluFZ49zBxUg2asWpktEmkXIpf4KQ5IQ3nZ3xyu3/x7X9GVz6NEA==
X-Received: by 2002:a17:90a:234f:: with SMTP id f73mr22254911pje.130.1566234987802;
        Mon, 19 Aug 2019 10:16:27 -0700 (PDT)
Received: from [192.168.1.70] (c-73-231-235-122.hsd1.ca.comcast.net. [73.231.235.122])
        by smtp.gmail.com with ESMTPSA id l4sm12867067pjq.9.2019.08.19.10.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 10:16:27 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] of/platform: Add functional dependency link from
 DT bindings
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <20190724001100.133423-1-saravanak@google.com>
 <20190724001100.133423-4-saravanak@google.com>
 <141d2e16-26cc-1f05-1ac0-6784bab5ae88@gmail.com>
 <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <19c99a6e-51c3-68d7-d1d6-640aae754c14@gmail.com>
Date:   Mon, 19 Aug 2019 10:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGETcx-dVnLCRA+1CX47gtZgtwTcrN5KefpjMzh9OJB-BEnqyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 6:50 PM, Saravana Kannan wrote:
> On Wed, Aug 7, 2019 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 7/23/19 5:10 PM, Saravana Kannan wrote:
>>> Add device-links after the devices are created (but before they are
>>> probed) by looking at common DT bindings like clocks and
>>> interconnects.


< very big snip (lots of comments that deserve answers) >


>>
>> /**
>>  * of_link_property - TODO:
>>  * dev:
>>  * con_np:
>>  * prop:
>>  *
>>  * TODO...
>>  *
>>  * Any failed attempt to create a link will NOT result in an immediate return.
>>  * of_link_property() must create all possible links even when one of more
>>  * attempts to create a link fail.
>>
>> Why?  isn't one failure enough to prevent probing this device?
>> Continuing to scan just results in extra work... which will be
>> repeated every time device_link_check_waiting_consumers() is called
> 
> Context:
> As I said in the cover letter, avoiding unnecessary probes is just one
> of the reasons for this patch. The other (arguably more important)

Agree that it is more important.


> reason for this patch is to make sure suppliers know that they have
> consumers that are yet to be probed. That way, suppliers can leave
> their resource on AND in the right state if they were left on by the
> bootloader. For example, if a clock was left on and at 200 MHz, the
> clock provider needs to keep that clock ON and at 200 MHz till all the
> consumers are probed.
> 
> Answer: Let's say a consumer device Z has suppliers A, B and C. If the
> linking fails at A and you return immediately, then B and C could
> probe and then figure that they have no more consumers (they don't see
> a link to Z) and turn off their resources. And Z could fail
> catastrophically.

Then I think that this approach is fatally flawed in the current implementation.

A device can be added by a module that is loaded.  In that case the device
was not present at late boot when the suppliers may turn off their resources.
(I am assuming the details since I have not reviewed the patches later in
the series that implement this part.)

Am I missing something?

If I am wrong, then I'll have more comments for your review replies for
patches 2 and 3.

> 

< another snip >

> Thanks,
> Saravana
> 

-Frank
