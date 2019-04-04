Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3473C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9917C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554340675;
	bh=yymA39LA7eJhd4jifzcnBTuqwG6z3k/nJ6Y3aNW27CM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zPN1fqrIoPaCnSNe7u2UV6CzgQrr72o7g6p5DPc4dZbg9Sxl91lPMC38JppKN2kIK
	 ApCT+Ijx6DlotvVRBDXiiuT4hjkeu4YSg1i43d3t2P0ceLcJBymyx1NO/A2WHrs4N9
	 7xVdv24gnVzJ/+i4iHRMt4u8gQJPjipUnEVsv2fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDDBRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfDDBRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:17:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12E14214AF;
        Thu,  4 Apr 2019 01:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554340672;
        bh=yymA39LA7eJhd4jifzcnBTuqwG6z3k/nJ6Y3aNW27CM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KMMvpBcd+8+8mUzQDL3mu0fy9Ee8SOWNXRlPtHcV6miPg/IvZfqIilysmFFcuR6Du
         sS+KJesDNdCTAYJzf5v7T5uoscT2ZiEkME95L5BGrtVtCWGJJ7Gch53w/VQ6ZMmSZg
         2wuA+4Svz5cUxrkl+6aVTmvsFpsnH0HqyPmYrHOI=
Received: by mail-qk1-f170.google.com with SMTP id w20so647855qka.7;
        Wed, 03 Apr 2019 18:17:52 -0700 (PDT)
X-Gm-Message-State: APjAAAXyPCT5GOaL6Zh0Khg5Pb8xTwWCAyIt82qev+oYQVK1skhSWtEE
        Joa516YqGDKAY6ipBBcV7TdnsIeOdMDmD4uXAw==
X-Google-Smtp-Source: APXvYqwKIU4/yzVU4Q4LwBsOvfW/bsQjbS96OYjtGaJX057xOqCvfP0RUE3l13IxpMkg1qhSYBZ6Y/oNt1wLpqGqwrw=
X-Received: by 2002:ae9:e313:: with SMTP id v19mr2647385qkf.153.1554340671248;
 Wed, 03 Apr 2019 18:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com> <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com> <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
 <8e574cfa-29d9-0f0a-d670-c4869bd262c4@arm.com>
In-Reply-To: <8e574cfa-29d9-0f0a-d670-c4869bd262c4@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 3 Apr 2019 20:17:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4drKZy1OOv_5T6KQBkoo=J+rJ2DDAVtqLY73ZVGG-jA@mail.gmail.com>
Message-ID: <CAL_JsqK4drKZy1OOv_5T6KQBkoo=J+rJ2DDAVtqLY73ZVGG-jA@mail.gmail.com>
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
To:     James Morse <james.morse@arm.com>
Cc:     Yash Shah <yash.shah@sifive.com>, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 11:36 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Rob,
>
> On 29/03/2019 14:11, Rob Herring wrote:
> > On Thu, Mar 28, 2019 at 1:47 PM James Morse <james.morse@arm.com> wrote:
> >> On 28/03/2019 13:16, Rob Herring wrote:
> >>> On Tue, Mar 12, 2019 at 02:51:00PM +0530, Yash Shah wrote:
> >>>> DT documentation for L2 cache controller added.
>
> >>>> diff --git a/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> >>>> new file mode 100644
> >>>> index 0000000..abce09f
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/edac/sifive-edac-l2.txt
> >>>> @@ -0,0 +1,31 @@
> >>>> +SiFive L2 Cache EDAC driver device tree bindings
> >>>> +-------------------------------------------------
> >>>> +This driver uses the EDAC framework to report L2 cache controller ECC errors.
> >>>
> >>> Bindings are for h/w blocks, not drivers. (And Boris may want a single
> >>> driver, but bindings should reflect the h/w, not what Linux (currently)
> >>> wants.
> >>
> >> For h/w block compatibles and edac, I think all we need now is to ensure the DT contains
> >> the three compatible strings: platform (if there is one), soc and ip-name (if its a
> >> re-usable thing).
> >> This is so that linux can pick the biggest of the three (usually platform) to probe the
> >> driver from, as this lets us capture platform properties we only find out about later.
> >
> > DT is not the only what to instantiate drivers. If the OS really wants
> > to have a single driver for multiple h/w blocks, then it needs to
> > instantiate a driver itself (based on the top-level compatible
> > probably) and then that driver can find the DT nodes it needs itself.
>
> I think this is where we are heading. (but I need to get my head round this top-level thing).
>
> Can the OS do both, depending on the platform?
> e.g. on a system with one component the driver runs 'standalone', whereas on a bigger
> system with multiple components the same driver is used as a library by something else.
>
> I don't see how this would work if the common component's DT entry looks the same on both
> platforms. Wouldn't this depend on the order stuff is done in, or 'but not this one'
> checks in the driver?

Yeah, it could get a bit messy. I think we'd have to always do things
as described above for anything using that set of components. If you
truly have some set of multiple blocks and any combination of them can
appear, then we shouldn't be trying to have a single driver and EDAC
needs to change to support that IMO. However, I'd guess things are not
that stable to have many different combinations of components. SoCs
have new DDR controllers practically every generation for example.

> > In any case, it's all irrelevant to the DT binding. We don't design
> > bindings around what some particular OS wants.
>
> I agree.
>
> What we want to do is spot the problems on the horizon so we either have the right
> information in the DT today, or at least know what it looks like so we don't cause a
> regression when a new platform makes previous behaviour generic/a-library.

If we follow what the current OS wants, then what is right will change.

Rob
