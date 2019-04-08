Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1150FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C928F20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI6xxjSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDHBFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 21:05:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38544 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDHBFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 21:05:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so1823738plb.5;
        Sun, 07 Apr 2019 18:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRZuwdqNrDmLOSIG1Aix46gTawZmZ1+exJPbBgpW89g=;
        b=GI6xxjSDP/CHore2xT0PGImeHE5sBpc0peysmIsRdbm374fACFuXN/ER+jLMbyVAmF
         SbLYLV/rSQ1yUpaONR/DOT2DufiHXg9d4mFplnOgui9EUmi3bo4vOlre4az03610DQcc
         OTL70QbDqvI4EHMn6hSpYO21aJ/1kR2IW+WVDtDTO6+/rJ4kegdSQ0H2GMFcmCE4y2tf
         8U5szm7i6wpR0Pimp7qTaVgQCNgNE9ismCOgtGI24yVTPb+n2aC7oiuXKWZoZfT752I/
         KoQPzD6OWzTYX/LIdPY/W1lHURIhbHhY00zmqxUwsPB36M2MS0Fg06hdWnmJM4C6Pk6g
         CD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRZuwdqNrDmLOSIG1Aix46gTawZmZ1+exJPbBgpW89g=;
        b=tvMDMmS0AV7TV4LL++Njf85dMMkeBQCaUrqJyDOskCqm0ZKBFyHEGAAGHZi4ELRUs7
         HX8TCTmf2cb/utQ8x88HtvPcJ/fvkWxlAF7LYKUfFBYwsGHqgkseX5O+lucVt5EaUvuC
         yYzioZThuJhRSKML4rkGA66m1M1gdO/QjUUaoLhn53f+KXBIi8RkQIQkzrzKAKp10oTV
         TORzWHMlXKXEC9VP36JBd9WSh7PVgAXte+tKRmMytThRy1VoxNKf8V8QahQl/zQrZ7lL
         9EAtbFUL+SDhmaDRl2+azZ152NWJAxNkB1rWCH+evnObjTPfMVMLMAt5pPXholGAhJG6
         PseA==
X-Gm-Message-State: APjAAAUFNPVbUulw1qZRYCgzpZRoneU9pSUQxpAG4Q44cQKTeThFO2RO
        lqWZtgB13Vy8eTOp+6VnA4Y=
X-Google-Smtp-Source: APXvYqzx5vlL3Y+lsvwNVNEOkuyVAuJDNWn8sUIHx/yFPtAm/roBCv2B2xuZeWtTQPy4Rw3uQm26tQ==
X-Received: by 2002:a17:902:d70f:: with SMTP id w15mr27404577ply.134.1554685517683;
        Sun, 07 Apr 2019 18:05:17 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id z14sm42105223pfn.161.2019.04.07.18.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 18:05:16 -0700 (PDT)
Subject: Re: Using device tree overlays in Linux
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "pantelis.antoniou@konsulko.com" <pantelis.antoniou@konsulko.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
References: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <61185ee9-4bee-eec3-f0d0-6d6760595845@gmail.com>
Date:   Sun, 7 Apr 2019 18:05:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <71fb0ff289e84c55bd92ecd96bc9aa76@svr-chch-ex1.atlnz.lc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 4/3/19 6:50 PM, Chris Packham wrote:
> Hi,
> 
> I'm implementing support for some modular Linux based systems using 
> device tree overlays. The code is working but it seems a little more 
> fiddly that than it should be so I'm wondering if I'm doing it right.

Let me start by saying that I strongly discourage using device tree
overlays in the Linux kernel until the support is more baked.  For
some info on how unbaked overlays are, see:

   https://elinux.org/Frank%27s_Evolving_Overlay_Thoughts

You should consider applying overlays in the Linux kernel to be
fragile at best.

If you can not figure out how to solve your needs without using
overlays, then having the boot loader apply the overlay instead
of the kernel applying the overlay avoids most of the issues.


> An example of what I'm doing is
> 
> 
> arch/arm/boot/dts/Makefile:
> DTC_FLAGS_myboard += -@
> 
> drivers/foo/Makefile:
> obj-y += myplugin.dtb.o
> obj-y += mydriver.o
> 
> drivers/foo/myplugin.dts:
> /dts-v1/;
> /plugin/;
> /{
> 	fragment@0 {
> 		target = <&i2c0>;
> 		__overlay__ {
> 			gpio@74 {
> 				compatible = "nxp,pca9539";
> 				reg = <0x74>
> 			};
> 		};
> 	};
> };

The fragment and __overlay__ nodes are implementation, subject to
change, and should not be hand coded.  The dtc compiler has added
features to allow a more generic source code.  The above should be:

// SPDX-License-Identifier: GPL-2.0
/dts-v1/;
/plugin/;

&i2c0 {
	gpio@74 {
		compatible = "nxp,pca9539";
		reg = <0x74>;
	};
};

(Not compiled, not tested.)

The rcar overlay sources were merged before dtc was updated to
handle this new syntax, so they are not a good example for
how to write an overlay.


> drivers/foo/mydriver.c:
> extern uint8_t __dtb_myplugin_begin[];
> extern uint8_t __dtb_myplugin_end[];
> 
> int mydriver_probe(struct platform_device *pdev)
> {
> 	u32 size = __dtb_myplugin_end - __dtb_myplugin_begin;
> 	int overlay_id;
> 	int ret;
> 	
> 	ret = of_overlay_fdt_apply(__dtb_myplugin_begin,
> 				   size, &overlay_id);
> 	return ret;
> }

I'm guessing that you have simplified your use case to make it easier to
describe (thank you for that).  But that also makes it harder to understand
the use case, and whether this is a good solution.  Can you describe your
use case in some more detail?


> The first issue is that I need to add -@ to the DTC_FLAGS for my board 
> dtb. I kind of understand that I only need -@ if my overlay targets 
> something symbolic so I might not need it but I was surprised that there 
> wasn't a Kconfig option that makes this happen automatically.
> 
> externing things in C files makes checkpatch.pl complain. I see the 
> of/unittests.c and rcar_du_of.c hide this with a macro. I was again 
> surprised that there wasn't a common macro to declare these.

unittests.c should not be used as a model of how to code for devicetree.
There are some hacks that are needed to be able to test, but should not
be used by normal drivers.

The rcar use of overlays is a temporary hack to provide backward
compatibility.  The intent is to drop this code once the backward
compatibility window ends.

The long-term intent (once enough of the overlay code is in place) is
to provide an overlay loader than can apply an overlay .dtb from a file.

-Frank
