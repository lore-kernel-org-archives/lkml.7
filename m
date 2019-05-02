Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21AAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861C5206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556757695;
	bh=vTfaDaANENUW+ILIYuTMhNnQ2ujEZviAu4AZiTJYDWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d8s+/sejMHxt4zRTK/Nmxan/l1Zz7qr2SNdY5l1M8omB4iaB+wJMO66jhdLlZ/JI5
	 SdZAyLzKcoYV1CbKHqfYZ7/284kKX4S+nw8hnxapKiHN+e+w8lk1ZWamIbcK5izxGo
	 fEt/cpzOg8RzWfEsEAlu3dkb4vEjPXtjpzE16U34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfEBAld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:41:33 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33152 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEBAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:41:33 -0400
Received: by mail-oi1-f193.google.com with SMTP id l1so421058oib.0;
        Wed, 01 May 2019 17:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=que7/XzZjSIdcZCiQ2C0xFwZqf7GgbSdIDqky43ue24=;
        b=VPXgXCZsNcjwwL4BsyM4tDW7TgDg6tvEcFZBImnmTRjnBVW+2Nd29/44dF8v5ezl1D
         pmEUIWl3sqJE5+pKuLV9eUuvSZXp7XYL3tmTq2IGXTHFQoGDqNYe1itauj7RXNCHYGQ7
         XI67BhcuTI7ghiy1YocPm/2VEy2hAM8d/NEAWh6tsO8cZaWFcY8ppiO1MhKGeRz6iDbz
         lRNxPACPhIuCjYYoVL41Q7sO9WApo2SzvT1I/RIKC3pD6FkzxEd9M9W9bQT2x1i/4gZu
         bgCjuySA0agBAwhHlpRbwr1XoSiXRyvVQ26up4KgSxVxCLKsWPsLky6IvlBA4xdcmEsx
         St3w==
X-Gm-Message-State: APjAAAUmHcuLfdxg8QpGCImgROWuc6zyErtQaAOUdJFFPeWt3w9pvm5r
        hlCVLRD5QXYKFdGh/hhogA==
X-Google-Smtp-Source: APXvYqz8ZZRbI0y5MUDWv1ckT2hvi/9XcubJQbSxUnrPuqm32Tec220tSjKVsA6maV8FYwrgYjAKDQ==
X-Received: by 2002:a54:4f02:: with SMTP id e2mr708714oiy.10.1556757691527;
        Wed, 01 May 2019 17:41:31 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 110sm1115344otu.9.2019.05.01.17.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:41:30 -0700 (PDT)
Date:   Wed, 1 May 2019 19:41:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, Sachin Ghadi <sachin.ghadi@sifive.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache
 Controller
Message-ID: <20190502004130.GA20802@bogus>
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com>
 <20190425101318.GA8469@e107155-lin>
 <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com>
 <20190426093358.GA28309@e107155-lin>
 <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 09:50:45AM +0530, Yash Shah wrote:
> On Fri, Apr 26, 2019 at 3:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Apr 26, 2019 at 11:20:17AM +0530, Yash Shah wrote:
> > > On Thu, Apr 25, 2019 at 3:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> > > > > Add device tree bindings for SiFive FU540 L2 cache controller driver
> > > > >
> > > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > > ---
> > > > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
> > > > >  1 file changed, 53 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > new file mode 100644
> > > > > index 0000000..15132e2
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > > @@ -0,0 +1,53 @@
> > > > > +SiFive L2 Cache Controller
> > > > > +--------------------------
> > > > > +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > > > > +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > > > > +acts as directory-based coherency manager.
> > > > > +
> > > > > +Required Properties:
> > > > > +--------------------
> > > > > +- compatible: Should be "sifive,fu540-c000-ccache"
> > > > > +
> > > > > +- cache-block-size: Specifies the block size in bytes of the cache
> > > > > +
> > > > > +- cache-level: Should be set to 2 for a level 2 cache
> > > > > +
> > > > > +- cache-sets: Specifies the number of associativity sets of the cache
> > > > > +
> > > > > +- cache-size: Specifies the size in bytes of the cache
> > > > > +
> > > > > +- cache-unified: Specifies the cache is a unified cache
> > > > > +
> > > > > +- interrupt-parent: Must be core interrupt controller
> > > > > +
> > > > > +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> > > > > +
> > > > > +- reg: Physical base address and size of L2 cache controller registers map
> > > > > +
> > > > > +- reg-names: Should be "control"
> > > > > +
> > > >
> > > > It would be good if you mark the properties that are present in DT
> > > > specification and those that are added for sifive,fu540-c000-ccache
> > >
> > > I believe there isn't any property which is added explicitly for
> > > sifive,fu540-c000-ccache.
> > >
> >
> > reg and interrupts are generally optional for normal cache and may be
> > required for cache controller like this. DT specification[1] covers
> > only caches and not cache controllers.
> 
> Are you suggesting something like this:
> 
> Required Properties:
> --------------------
> Standard Properties:

I don't think we need this separation.

> - compatible: Should be "sifive,<chip>-ccache"
>   Supported compatible strings are:
>   "sifive,fu540-c000-ccache" and "sifive,fu740-c000-ccache"
> 
> - cache-block-size: Specifies the block size in bytes of the cache
> 
> - cache-level: Should be set to 2 for a level 2 cache
> 
> - cache-sets: Specifies the number of associativity sets of the cache
> 
> - cache-size: Specifies the size in bytes of the cache

What are the possible valid values for these? That's what's important. 
What the properties mean are already defined in the spec.

> 
> - cache-unified: Specifies the cache is a unified cache
> 
> Non-Standard Properties:

I wouldn't call these non-standard.

> - interrupt-parent: Must be core interrupt controller

This is implied.

> 
> - interrupts: Must contain 3 entries for FU540 (DirError, DataError and
>   DataFail signals) or 4 entries for other chips (DirError, DirFail, DataError,
>   DataFail signals)
> 
> - reg: Physical base address and size of L2 cache controller registers map
> 
> - reg-names: Should be "control"

-names is not really needed when there is only 1 entry.

> 
> - Yash
> >
> > --
> > Regards,
> > Sudeep
> >
> > [1] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
