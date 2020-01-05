Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A55CC33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D511321734
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 18:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578248912;
	bh=4x9vC91olmd60ycX0+AK25GUmB4k/f+cxqTH4tCuww8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q1k1ShHw/yWQLtxbSmMjZoNAgRDNRDd/wtOIk02Yi7vyHo3gTCuIGzn8v/fbPQchc
	 VCYN2Ure8v0HPNlmoCKYx8ZboKMJHGW/9URaJLgc+6xAUyzmAWYj8xjv7KNja4Q9Jf
	 2kTJFosLQH/K4QIW0rkXQcxCiiwOnQTkCYgel7q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAES2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 13:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgAES2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 13:28:30 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF62720866;
        Sun,  5 Jan 2020 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578248909;
        bh=4x9vC91olmd60ycX0+AK25GUmB4k/f+cxqTH4tCuww8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ExslCVI9aoGZEoasCewn+2z26EUJkgrLLXM4mFo8p8VKKO7R4I9kE/qBe2X93uG7+
         0bJdwQHlBwBT4aWDlPxzeDFTmH9rYUI0dEUnKrqJpPnb7WMtNDTnVhzLw4bSjv80gp
         bAcvqQfIGqLI7Rr/sj2DMWDyXkPLl41LK1Aghwio=
Date:   Sun, 5 Jan 2020 19:28:26 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200105182826.rnscz5d5pbtb72g2@gilmour.lan>
References: <20200102012657.9278-1-andre.przywara@arm.com>
 <20200102012657.9278-4-andre.przywara@arm.com>
 <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
 <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
 <20200104100422.z7iz4jiyj7kdvbtw@gilmour.lan>
 <42aabc62-4885-38fc-a6e5-0f057843d364@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <42aabc62-4885-38fc-a6e5-0f057843d364@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2020 at 04:40:58PM +0000, Andr=E9 Przywara wrote:
> On 04/01/2020 10:04, Maxime Ripard wrote:
> >> But more importantly: what are the guidelines for using this tag? I
> >> understand the desire to provide every possible pin description on
> >> one hand, but wanting to avoid having *all of them* in *each* .dtb
> >> on the other.
> >
> > Pin groups will take a lot of space in the dtb, and the DT parsing
> > will take some measurable time,
>
> Really? Where is that? In Linux, or in U-Boot, possibly with the caches
> off? I am just curious. AFAIK there are some inefficient algorithms in
> libfdt (which trade performance for a smaller memory footprint), but I
> thought those would be called only very rarely.

The last time I measured it was in U-Boot (and for the FIT image, not
an actual DT), but the parsing time for a FIT image with a kernel and
DTB was around 100ms.

(and adding the PSCI and simplefb nodes was in the same order of
magnitude).

Boot time was very sensitive, and I had to remove both.

> >> And should there be a dtc command line option to ignore those tags,
> >> or even to apply this tag (virtually) to every node?
> >
> > Most of the nodes are (reference) leaves in a DT though. Pretty much
> > all the device nodes have no references pointing to them, just like
> > most of the buses, the CPU nodes, etc. And I'm pretty sure you want to
> > keep them :)
>
> Yeah, that was a New-Year's brain-fart of mine ;-)
>
> While I was changing the patch I figured that it gets quite lengthy.
> Also looking at the a20.dtsi, I see that *all* pin groups have this tag
> now. Wouldn't it be easier to introduce *one* tag that applies that to
> all children of a node?

I don't really know, I'm not sure the proliferation of tags would be a
good thing either, and I'm not the dtc maintainer, so I don't really
have a say in this :)

> Another thing I was wondering about: Would we gain something by not
> compiling nodes which have status =3D "disabled"? This is mentioned as a
> generic property in the DT spec, although it says there that the exact
> meaning is device dependent. But it sound still worthwhile, especially
> since we would avoid more pin groups to be compiled in.

I guess that would be good too, but the semantics are a bit different
so we'd need a different tag.

Maxime
