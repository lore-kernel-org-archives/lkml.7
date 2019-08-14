Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D41CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E052083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="oXMn6VeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfHNQJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:09:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34680 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfHNQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:09:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so12982202oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwEcHH9UXdU1fXXFDvnaYZ/QstlJxWFiAYonmCkc7s4=;
        b=oXMn6VeZmUplJ9AJjI73fg5Ol5bdgZLWYd5b7qf5eXqDzrUVh+dDTPLAp9zVNJCUWr
         H4TZnBs9Pd32gBeKSi+C3dmCoyDO8qDvpzsRncd87MbkxWoDBRHnATZgFEDT4uz8Klcf
         OAq4UtQgUfaWq/q86N50NdAY3kn/33QR+ZvAtM4xfNKCqIe0X5YynaPigWo5lvurwhF6
         9k1zFVPKVJOamgslpHSpldlFvzMWFJySz5eHxjqtJb/rz2kSfhBQr0770m0lOkYiWXqF
         9lGt2kBcjVKHZKwvotF6RHswDCo3XelrgWXuqBXCBz0di+Ud3c3ruD9RvS7LvQMUljyF
         Cn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwEcHH9UXdU1fXXFDvnaYZ/QstlJxWFiAYonmCkc7s4=;
        b=RSdp8nIczjwx84ojmlTHSQlyev5C8BGGs11WW3WA4tCr6YWhm+i3N490WJ2c98T7dl
         tHo8JLRQ8xV6sc2uDHhv10ozpryDma+pMygzjBS+vHfr+ahIHLMexVLUubaQSrN6fG6U
         rBbqtVIIcEAuemFF5pglZPIDWhPlKo8S5c36hXGLmJ/17reoFyy4PmO5pgSaUsDP6S25
         rK3vZRdCoNf7IQCY/j9D4KX7BLWYaRBiLpLg/GtNvH+tOQo8AlSgCYbQU4a5/Vvd6dfD
         xZfk3Hg12DOIKP3dBEno4eEdrMiKKgdfaqEs6PXGlOGs0RHQroTwi9/Y6dUzUSv/9cET
         TFTA==
X-Gm-Message-State: APjAAAXfH9VgDL2kQ3UUfS2EfbqGdlG6nC24VliKGspKxk/8jFckiYlD
        64kvN4rLpuZqg3Fv6o2JNohpQuAzWpkdqEpriOcr0g==
X-Google-Smtp-Source: APXvYqw2Wr+rTImwzofqR6bX79DGk8Ar7TAUAA36PWc+8TrwWyv7gXBdmJ0xerCaL/yyLJDlp/YTYeIuIp0x6Ne1c4g=
X-Received: by 2002:aca:d558:: with SMTP id m85mr524632oig.0.1565798952523;
 Wed, 14 Aug 2019 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190808202415.25166-1-stephend@silicom-usa.com>
 <20190810074317.GA18582@infradead.org> <abfa4b20-2916-d89a-f4d3-b27fca5906b2@silicom-usa.com>
 <CAPcyv4g+PdbisZd8=FpB5QiR_FCA2OQ9EqEF9yMAN=XWTYXY1Q@mail.gmail.com>
 <051cb164-19d5-9241-2941-0d866e565339@silicom-usa.com> <20190812180613.GA18377@infradead.org>
 <CAA9_cme3saBAJEyob3B1tX=t8keTodWJZMUd1j_v7vPMRU+aXA@mail.gmail.com>
 <20190813072954.GA23417@infradead.org> <CAPcyv4h5kCKVyCjomBUY27MJwheDZ8v87+a9K-2YCgyqRWR7eQ@mail.gmail.com>
 <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com>
In-Reply-To: <c023a18c-8b70-dc59-3db8-51d3a6b23d3c@silicom-usa.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 14 Aug 2019 09:09:01 -0700
Message-ID: <CAPcyv4jcaY04nu31oStLc-eCO-+T1iOpxARmAHvPS1jxKF9cQA@mail.gmail.com>
Subject: Re: [PATCH] ata: ahci: Lookup PCS register offset based on PCI device ID
To:     Stephen Douthit <stephend@silicom-usa.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 7:34 AM Stephen Douthit
<stephend@silicom-usa.com> wrote:
>
> On 8/13/19 6:07 PM, Dan Williams wrote:
> > On Tue, Aug 13, 2019 at 12:31 AM Christoph Hellwig <hch@infradead.org> wrote:
> >>
> >> On Mon, Aug 12, 2019 at 12:31:35PM -0700, Dan Williams wrote:
> >>> It seems platforms / controllers that fail to run the option-rom
> >>> should be quirked by device-id, but the PCS register twiddling be
> >>> removed for everyone else. "Card BIOS" to me implies devices with an
> >>> Option-ROM BAR which I don't think modern devices have, so that might
> >>> be a simple way to try to phase out this quirk going forward without
> >>> regressing working setups that might be relying on this.
> >>>
> >>> Then again the driver is already depending on the number of enabled
> >>> ports to be reliable before PCS is written, and the current driver
> >>> does not attempt to enable ports that were not enabled previously.
> >>> That tells me that if the PCS quirk ever mattered it would have
> >>> already regressed when the driver switched from blindly writing 0xf to
> >>> only setting the bits that were already set in ->port_map.
> >>
> >> But how do we find that out?
> >
> > We can layer another assumption on top of Tejun's assumptions from
> > commit 49f290903935 "ahci: update PCS programming". The kernel
> > community has not received any regression reports from that change
> > which says:
> >
> > "
> >      port_map is determined from PORTS_IMPL PCI register which is
> >      implemented as write or write-once register.  If the register isn't
> >      programmed, ahci automatically generates it from number of ports,
> >      which is good enough for PCS programming.  ICH6/7M are probably the
> >      only ones where non-contiguous enable bits are necessary && PORTS_IMPL
> >      isn't programmed properly but they're proven to work reliably with 0xf
> >      anyway.
> > "
> >
> > So the potential options I see are:
> >
> > 1/ Keep the current scheme, but limit it to cases where PORTS_IMPL is
> > less than 8 and assume this need to set the bits is unnecessary legacy
> > to carry forward
> >
> > 2/ Option1 + additionally use PORTS_IMPL as a gate to guess when the
> > PCS format might be different for values >= 8.
> >
> > I think the driver does not need to consider Option2 unless / until it
> > encounters a platform where firmware does not "do the right thing",
> > and given Denverton has been in the wild with the wrong PCS twiddling
> > it seems to suggest nothing needs to be done there.
> >
> >> A compromise to me seems that we just do the PCS quirk for all Intel
> >> devices explicitly listed in the PCI Ids based on new board_* values
> >> as long as they have the old PCS location, and assume anything new
> >> enough to have the new location won't need to quirk, given that it
> >> never properly worked.  This might miss some intel devices that were
> >> supported with the class based catchall, though.
> >
> > I'd be more comfortable with PORT_IMPL as the deciding factor.
>
> Unfortunately we can't use CAP.NP or PORTS_IMPL for this heuristic.
>
> The problem is that BIOS should be setting the PORTS_IMPL bitmask to
> match which lanes have actually been connected on the board.  So
> PORTS_IMPL can be < 8 even if the controller is new enough to
> potentially support > 8 and has the new config space layout.
>
> As proof here's the relevant ahci_print_info() output booting on a
> Denverton based box with 5 ports implemented:
>
> ahci 0000:00:14.0: AHCI 0001.0301 32 slots 5 ports 6 Gbps 0x7a impl SATA mode
>                                             |               \-PORTS_IMPL
>                                             \-CAP.NP

Ugh, ok, thanks for clarifying and my mistake for not realizing
Denverton already violates that heuristic.

So now I'm trying to grok Christoph's suggestion. Are you saying that
all existing board-ids would assume old PCS format? That would mean
that Denverton gets the wrong format via board_ahci via the class code
matching? Maybe I'm not understanding the suggestion...

Another option might be that controllers >= 1.3.1 will stop using the
PCS twiddling, and then we go add a new board id where / if it happens
to matter in practice.
