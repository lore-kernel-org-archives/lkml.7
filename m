Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214A0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D3821900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO6/AIyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCVBMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:12:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVBMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:12:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so300759pfm.12;
        Thu, 21 Mar 2019 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hn1l35il4CXqkv0le4BYOEd6w+xQ7Q2k3NTZIb1qvmc=;
        b=SO6/AIyzLLQ1+4ycHWIqw+ndleOcRuEK4NaqUtbyMSBYxHneTTY7AQ4L9mJmQVtZvP
         FP8031StJ8pmbY4CPnJhYYMn34pnU1qDrQMe4gCm/qwmrvHfqZM/AWA5z3yY0TFR07ob
         xfsmuaX3YEUOPmz1WRybVLECsIUgqDftF6gGDsu5eqAbsEgcyQ3pm1tg7aVHLtgG9Ufr
         GRrTsD2JfZh12UaSOI6Lkp6udGEhscWbqhCbRaOj7sst0Cx6bvpnzp1D9jQVUhS9o7/A
         fDjo7n4GtEtvU1iSaqIq1b0lr8uQB/hlucHqSqf5gyjPvCoIs7QIYR/67LaDcxVLr8iv
         85+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hn1l35il4CXqkv0le4BYOEd6w+xQ7Q2k3NTZIb1qvmc=;
        b=Io6WXn5yREAEpuLJOXSLhF85C9N2m6UwvkpA+ShfSf/HeLXCU9HZs98IQQOGtLpLoX
         LSTjFlOTDZPxDWGvO8kNU+zO2yLKXt7guBY8ngyB9pk/qrRs9WkRofMta3EXb0QaEb9+
         qS9LXtAnAvnCYldhL5UZdA4PDGAt671cbhhLz/S6/I/l+cvONIftirPE92OTG19GxyaQ
         XLocPbCn3spKugwzy/fz2ntgeCjV+av00g1Y3aSUHZldBHLwt2n+dLOQTGH39D67n5XZ
         xqFuCPRcVkF2qPtZlVBlXwvxsJwA2fvcVbmODmh9NzYn7nv7dFddgUlFT5fTLzE9WJbG
         KHOg==
X-Gm-Message-State: APjAAAXm2g5A/SJuyeKaAlbFqgBMGvjSQ40mURzwwWKd6enIH0cDUQJG
        ljO3WI2BA+/6D5zN45aMXUs=
X-Google-Smtp-Source: APXvYqwpaOHCDcGBjjSaqBR9rISOcKVcHSx4EdlbjHUpjGeT+AmYJ5U9A//pUuq+2FLU++/H2NyQSQ==
X-Received: by 2002:a62:ea0f:: with SMTP id t15mr6529957pfh.124.1553217172277;
        Thu, 21 Mar 2019 18:12:52 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f7sm7044173pgf.48.2019.03.21.18.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:12:51 -0700 (PDT)
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com,
        Frank Rowand-real <frowand@gmail.com>
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
 <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
 <3bdbe44c-5bd8-db37-89f9-a518cd5a21a8@deltatee.com>
 <CAFd5g45u6oX=nK9anAEdfsV+8SET8Zo_Dpy0WfzCna19r_jSyw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <aea24c8e-5ce8-5f33-c81b-d2eeef588ec8@gmail.com>
Date:   Thu, 21 Mar 2019 18:12:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g45u6oX=nK9anAEdfsV+8SET8Zo_Dpy0WfzCna19r_jSyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 4:33 PM, Brendan Higgins wrote:
> On Thu, Mar 21, 2019 at 3:27 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2019-03-21 4:07 p.m., Brendan Higgins wrote:
>>> A couple of points, as for needing CONFIG_PCI; my plan to deal with
>>> that type of thing has been that we would add support for a KUnit/UML
>>> version that is just for KUnit. It would mock out the necessary bits
>>> to provide a fake hardware implementation for anything that might
>>> depend on it. I wrote a prototype for mocking/faking MMIO that I
>>> presented to the list here[1]; it is not part of the current patchset
>>> because we decided it would be best to focus on getting an MVP in, but
>>> I plan on bringing it back up at some point. Anyway, what do you
>>> generally think of this approach?
>>
>> Yes, I was wondering if that might be possible. I think that's a great
>> approach but it will unfortunately take a lot of work before larger
>> swaths of the kernel are testable in Kunit with UML. Having more common
>> mocked infrastructure will be great by-product of it though.
> 
> Yeah, it's unfortunate that the best way to do something often takes
> so much longer.
> 
>>
>>> Awesome, I looked at the code you posted and it doesn't look like you
>>> have had too many troubles. One thing that stood out to me, why did
>>> you need to put it in the kunit/ dir?
>>
>> Yeah, writing the code was super easy. Only after, did I realized I
>> couldn't get it to easily build.
> 
> Yeah, we really need to fix that; unfortunately, broadly addressing
> that problem is really hard and will most likely take a long time.
> 
>>
>> Putting it in the kunit directory was necessary because nothing in the
>> NTB tree builds unless CONFIG_NTB is set (see drivers/Makefile) and
>> CONFIG_NTB depends on CONFIG_PCI. I didn't experiment to see how hard it
>> would be to set CONFIG_NTB without CONFIG_PCI; I assumed it would be tricky.
>>
>>> I am looking forward to see what you think!
>>
>> Generally, I'm impressed and want to see this work in upstream as soon
>> as possible so I can start to make use of it!
> 
> Great to hear! I was trying to get the next revision out this week,
> but addressing some of the comments is taking a little longer than
> expected. I should have something together fairly soon though
> (hopefully next week). Good news is that next revision will be
> non-RFC; most of the feedback has settled down and I think we are
> ready to start figuring out how to merge it. Fingers crossed :-)
> 
> Cheers

I'll be out of the office next week and will not be able to review.
Please hold off on any devicetree related files until after I review.

Thanks,

Frank

