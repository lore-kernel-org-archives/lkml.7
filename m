Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A72C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4B212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfFHR4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 13:56:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35813 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfFHR4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 13:56:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so2831679pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 10:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iyAgZ7LPNrjAJ5HMh1hGYwXJ8qs3w42dLho45Ew1g/g=;
        b=dvtwP36LwCjfbjGQecm0GXUYg3spkyKgemfDvpOA8+r2Hxmx789h/WGIKLebc2ezOX
         cAj8rtljW9HPTtYATbx8y6DaeK8mrsAOIeEl4/oBORq/kgdW1l5g6sRgqYAylEnFIFb5
         ngsFq/L4GY+ekPAbkhb/TKVykv3iErn67DNgoG5wom5Rp9Mj5PmFBh8cfp/wV2GtNWA9
         eM/GMPaSOWHUKUKVi0fOeKDTgTKfruvYIj62rQXLiv+LhsUb7NX8CB2XN3A4DL65f85i
         UOYF3Q+0cKBzQlihaSmgFtTsf9/EO9lww+rJNyTpWMBb/V/fWoQL73R+OAgwxDYIZsDI
         xFQg==
X-Gm-Message-State: APjAAAUB29UgDB/plcamjidz8X8s+PLpWyrssfFlY07plxM4jkD9TcsN
        MotNrMCxhCSo1/InqcanHfjVOQ==
X-Google-Smtp-Source: APXvYqxUP4Kmv8FJwbiZts6nQLQw4BBk0vluayMvRAl8Cod+/UWEDIOm2zQpFKVrMo0x1jmMHUb1PQ==
X-Received: by 2002:a63:e10d:: with SMTP id z13mr8254805pgh.116.1560016606841;
        Sat, 08 Jun 2019 10:56:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s12sm5453255pjp.10.2019.06.08.10.56.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 10:56:46 -0700 (PDT)
Date:   Sat, 08 Jun 2019 10:56:46 -0700 (PDT)
X-Google-Original-Date: Sat, 08 Jun 2019 10:42:17 PDT (-0700)
Subject:     Re: [PATCH v3 1/5] arch: riscv: add support for building DTB files from DT source data
In-Reply-To: <alpine.DEB.2.21.9999.1906062208280.28147@viisi.sifive.com>
CC:     lollivier@baylibre.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul@pwsan.com,
        aou@eecs.berkeley.edu
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-802d67ce-9f78-4ebc-9981-a27e5e4e40df@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019 22:12:05 PDT (-0700), Paul Walmsley wrote:
> On Tue, 4 Jun 2019, Loys Ollivier wrote:
>
>> Always build it ?
>> Any particular reason to drop ARCH_SIFIVE ?
>
> Palmer had some reservations about it, so I dropped it for now.  But then
> as I was thinking about it, I remembered that I also had some reservations
> about it, years ago: that everyone should use CONFIG_SOC_* for this,
> rather than CONFIG_ARCH.  CONFIG_ARCH_* seems better reserved for
> CPU architectures.

Specifically my worry is that "ARCH_SIFIVE" makes it sound like we're adding
SiFive-specific architecture features, and we've been trying really hard to
make sure that the various bits of core software avoid boing vendor specific.
We've had suggestions of adding vendor-specific instructions to the Linux port
with those instructions being conditionally compiled under ARCH_$VENDOR, but
I'd rejected that under the "no vendor-specific stuff" argument.  As such it
doesn't seem fair to go add in an ARCH_SIFIVE for our vendor-specific stuff.

The SOC stuff will, of course, be vendor specific.  In this idealized world
SiFive's SOC support has nothing to do with RISC-V, but of course all of
SiFive's SOCs are RISC-V based so the separation is a bit of pedantry.  That
said, in this case I think getting the name right does make it slightly easier
to espouse this "one kernel can run on all RISC-V systems" philosophy.
Balancing the SiFive and RISC-V stuff can be a bit tricky, which is why I am
sometimes a bit pedantic about these sorts of things.

> If you agree, would you like to send a followup series, based on the DT
> patches, to make the SiFive DT file builds depend on CONFIG_SOC_* instead?

I'd be happy with something like that.  We'd also talked about this selecting
all the SiFive platform drivers.  It should, of course, be possible to select
multiple SOC vendors in a single kernel -- we don't have any other real
hardware right now, but maybe some sort of "CONFIG_SOC_RISCV_VIRT" would be a
good proof of concept?

> Thanks for the comment,
>
> - Paul
