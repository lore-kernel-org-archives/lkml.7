Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A48EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FDB217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq5Zm314"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDITdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:33:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33345 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDITdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:33:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so10022883plo.0;
        Tue, 09 Apr 2019 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QgJkMtNpl2HO1zTvmqyKDIdj/cyy7r4s0wVY5vIR5jc=;
        b=Oq5Zm314Yj2mQnf+yKzsgp8hITuit67Rw6922wjYx0mwYLtBmH3HoW33lULHA/da1A
         RGC6OEm0RMPaBaY9jRNLWXR8ABfuTook0PNh6nmr59vL3hIpWPm2PSpXlpMjhh2/xQ5q
         js0WEe58YXBzDzjJTlZY5vkvfFpY7qFkniJOyQve6DNvM8ZWNxtOrTGda+gX2pR8qjCw
         X91n9qKDlfFtNqO5P61GJRaNTAUSOCW/5OVCKLYZ4pkr+dfzn4JecctUo/50Pc7CfwGb
         ZxQ3JEPSfqpSnFTYntGMFTJaOUNfD2oGfzJoCw3gq1EiFKatKXWG05fLstaCmjdIgy0S
         zpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QgJkMtNpl2HO1zTvmqyKDIdj/cyy7r4s0wVY5vIR5jc=;
        b=lx1NL4CIa7KYzS66+lA/A+9GYrO4bunvW2oJw1jWrxbr12y8Z9OyKSbyOv7LR03oLA
         z51c4AYBJ8HlhpnpHVlglKps5LznYOlI6XOzY0UeZdpb2HaAAUYE+tyoTSOjBQSVEnp3
         qDQahSS6Sormo7yqVj5SaR1M/EJn3hunpBirCee7WqRrBwN54ezm9Q4WRU133R6hoz9x
         NkGCrlMgsyFjql+3EgFG2I3E6T4Um1Mrn8REyyLgTEzujK9uSFrzSW5B3E3yvjTDNyo8
         9drCTfNEzF+gCk61zHOryl1StXJvi4LqucqWDv+Q/Q6E0nYl388bX+jg3qnXA15BFQmw
         cm8A==
X-Gm-Message-State: APjAAAVbF9JoNAxKNd1+TTJ+4sHwV4tEonh3pHfzKiI8JaN+IZcCqZjC
        udvwQi0hELNe24/DwjX/PnM=
X-Google-Smtp-Source: APXvYqxmLLFlxYxOgIre8kVesQc/I01jCDULjuA69HEP3+h5s7MSFlORuz5XjXNxSODwPkplj68H3w==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr39719227pld.58.1554838410247;
        Tue, 09 Apr 2019 12:33:30 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l69sm46643489pga.73.2019.04.09.12.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 12:33:29 -0700 (PDT)
Subject: Re: Using device tree overlays in Linux
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
 <61185ee9-4bee-eec3-f0d0-6d6760595845@gmail.com>
 <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <78fc3196-c45b-230d-6bf8-0d8572bd3044@gmail.com>
Date:   Tue, 9 Apr 2019 12:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <224942bd629e41eaa23ab327b015134e@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/19 6:27 PM, Chris Packham wrote:
> Hi Frank,
> 
> On 8/04/19 1:05 PM, Frank Rowand wrote:
>> Hi Chris,
>>
>> On 4/3/19 6:50 PM, Chris Packham wrote:
>>> Hi,
>>>
>>> I'm implementing support for some modular Linux based systems using
>>> device tree overlays. The code is working but it seems a little more
>>> fiddly that than it should be so I'm wondering if I'm doing it right.
>>
>> Let me start by saying that I strongly discourage using device tree
>> overlays in the Linux kernel until the support is more baked.  For
>> some info on how unbaked overlays are, see:
>>
>>     https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts
>>
>> You should consider applying overlays in the Linux kernel to be
>> fragile at best.
>>
>> If you can not figure out how to solve your needs without using
>> overlays, then having the boot loader apply the overlay instead
>> of the kernel applying the overlay avoids most of the issues.
>>
> 
> Consider us beta-testers :).
> 
> We've got a few modular systems that have miscellaneous devices that we 
> want to be hot-swapping at run time. For the most part the devices in 
> question are i2c based. We want to use overlays as it saves manually 
> instantiating devices and avoids needing specific knowledge of the base 
> platform.

I want to make sure we are using a common vocabulary.

By hot-swap, do you mean physically plugging in or removing the device
_while the kernel is booted_?

If this is the case, then my suggestion of using the boot loader to
apply the devicetree overlay is not sufficient.


>>> An example of what I'm doing is
>>>
>>>
>>> arch/arm/boot/dts/Makefile:
>>> DTC_FLAGS_myboard += -@
>>>
>>> drivers/foo/Makefile:
>>> obj-y += myplugin.dtb.o
>>> obj-y += mydriver.o
>>>
>>> drivers/foo/myplugin.dts:
>>> /dts-v1/;
>>> /plugin/;
>>> /{
>>> 	fragment@0 {
>>> 		target = <&i2c0>;
>>> 		__overlay__ {
>>> 			gpio@74 {
>>> 				compatible = "nxp,pca9539";
>>> 				reg = <0x74>
>>> 			};
>>> 		};
>>> 	};
>>> };
>>
>> The fragment and __overlay__ nodes are implementation, subject to
>> change, and should not be hand coded.  The dtc compiler has added
>> features to allow a more generic source code.  The above should be:
>>
>> // SPDX-License-Identifier: GPL-2.0
>> /dts-v1/;
>> /plugin/;
>>
>> &i2c0 {
>> 	gpio@74 {
>> 		compatible = "nxp,pca9539";
>> 		reg = <0x74>;
>> 	};
>> };
>>
>> (Not compiled, not tested.)
>>
>> The rcar overlay sources were merged before dtc was updated to
>> handle this new syntax, so they are not a good example for
>> how to write an overlay.
> 
> OK thanks. I suspected as much. I'll update my code based on your example.
> 
>>> drivers/foo/mydriver.c:
>>> extern uint8_t __dtb_myplugin_begin[];
>>> extern uint8_t __dtb_myplugin_end[];
>>>
>>> int mydriver_probe(struct platform_device *pdev)
>>> {
>>> 	u32 size = __dtb_myplugin_end - __dtb_myplugin_begin;
>>> 	int overlay_id;
>>> 	int ret;
>>> 	
>>> 	ret = of_overlay_fdt_apply(__dtb_myplugin_begin,
>>> 				   size, &overlay_id);
>>> 	return ret;
>>> }
>>
>> I'm guessing that you have simplified your use case to make it easier to
>> describe (thank you for that).  But that also makes it harder to understand
>> the use case, and whether this is a good solution.  Can you describe your
>> use case in some more detail?
> 
> As I said above we have a few different modular systems we're trying to 
> support. But they all do basically the same thing.
> 
> The insertion of a module is detected based on a gpio line being asserted.
> 
> Then we identify what was just inserted, the details vary a little per 
> platform but in one instance we load an overlay that has instantiates an 
> i2c eeprom identifying the module.
> 
> Once we know which specific module has been inserted based on the data 
> in the eeprom we load another overlay that instantiates the rest of the 
> devices on that module.

As an alternate solution, could nodes for all of the possible modules be
included in the devicetree, but disabled?  Then as modules are detected, the
appropriate nodes could be enabled.  (This is a conceptual proposal - the
implementation details might encounter issues, some of which are similar
to the issues overlays face.)


>>> The first issue is that I need to add -@ to the DTC_FLAGS for my board
>>> dtb. I kind of understand that I only need -@ if my overlay targets
>>> something symbolic so I might not need it but I was surprised that there
>>> wasn't a Kconfig option that makes this happen automatically.
>>>
>>> externing things in C files makes checkpatch.pl complain. I see the
>>> of/unittests.c and rcar_du_of.c hide this with a macro. I was again
>>> surprised that there wasn't a common macro to declare these.
>>
>> unittests.c should not be used as a model of how to code for devicetree.
>> There are some hacks that are needed to be able to test, but should not
>> be used by normal drivers.
>>
>> The rcar use of overlays is a temporary hack to provide backward
>> compatibility.  The intent is to drop this code once the backward
>> compatibility window ends.
> 
> Yes I suspected as much.
> 
>> The long-term intent (once enough of the overlay code is in place) is
>> to provide an overlay loader than can apply an overlay .dtb from a file.
> 
> Would that be a kernel helper or driven via udev?

The implementation is TBD.  I would prefer to defer the implementation
discussion until we are closer to being willing to accept a loader.

-Frank

