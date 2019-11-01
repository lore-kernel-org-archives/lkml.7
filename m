Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B53ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F8E2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0Vz8wh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfKAV0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:26:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42969 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKAV0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:26:43 -0400
Received: by mail-oi1-f193.google.com with SMTP id i185so9343700oif.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akkZD3w083zl13woGTjsh480XINKZCL3wR8VL14OTmQ=;
        b=s0Vz8wh0GQ9oVFLmjY4JYB4Ahm42iKCgainya75ejaw+VdRDfft88VS6BcoRAIOLF6
         hRc37n2vtK2pgiVbgYHLJHJoJKNqX3i+FgLVWUseXizVnLdELNDtCT2R9oKWfqhFEru1
         Yw7TuoxlW1zCwHrf1/9rBmkVLwejj8GIMWpu3Cl06CuxcimZuGtOgNnvM37W2MzSNcUZ
         Fb0Ue/qO564LvEi6EdftMqD3bVfz1zmlbLi6jMaUn2HplbDzmArPbjdtMKmScfEaexJV
         1M/ImLD4nnaxXfT6meC5xHAnY6ViRXAanGiHl3yo7uwsvD/Q7hw3yGdBU5aRGAn1EM5b
         1DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akkZD3w083zl13woGTjsh480XINKZCL3wR8VL14OTmQ=;
        b=AaxoxlS7SqV5g1tQrbYa880SW96R5hib0oq3h8eZgF0rgA7dQnRx6hlO0Khk/ruQGg
         Y4wYhjZSH9Ktg5Wv7tHoI+XoW3CgAoLcGu4fLo04tMVdhG5SqJupdeapyUy3x4croRRS
         4UiLYw24IOrJGZe873wHNbCrotH6cU4T0MZVy4veYi0mrqR61f/MTq9rS2Vi6ZeJ6qiv
         CgOBdgUyWmGm3ncnB1h70Er0ayaARL/Ip5DN1uJxTaZ/KzvqgTJpchiGZCjqEgR7+aHZ
         Nw6FhhGqfRXAbqUyqblFDlF9Y8uTzy1JLqaIsJf1onoBdACUaxgiJJfYNhJLATCs2EGp
         5oaA==
X-Gm-Message-State: APjAAAXb0Hhv8X1pof4EfkHvHFOa8b5uCJmmZ5K8h4ifdS2r1B3HLP+x
        3IF78yenO3FOoAyOyn5Jw45KF4YQJ7LTw/A0mlNSTESm
X-Google-Smtp-Source: APXvYqw7SAiHX+nkrUKhSIYt2GxZg2umVPUbXjZgJSciGR9hzGh6xvHktK2T6WuzUWM47Qoeq91MlB0qRkEzP7LLxC4=
X-Received: by 2002:aca:f408:: with SMTP id s8mr1061686oih.69.1572643602372;
 Fri, 01 Nov 2019 14:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191030145112.19738-1-will@kernel.org> <6e457227-ca06-2998-4ffa-a58ab171ce32@arm.com>
 <20191030155444.GC19096@willie-the-truck> <CAGETcx9ogWQC1ZtnS_4xC3ShqBpuRSKudWEEWC22UZUEhdEU4A@mail.gmail.com>
 <20191031193758.GA2607492@lophozonia> <CAGETcx-MuMVvj0O-MFdfmLADEq=cQY_=x+irvhgwHhG4VeeSdg@mail.gmail.com>
 <20191101114148.GA2694906@lophozonia> <20191101122825.GA318@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191101122825.GA318@e121166-lin.cambridge.arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Nov 2019 14:26:05 -0700
Message-ID: <CAGETcx_U1huHHT=_xo6ArTWpmKMkr=rAy4ceoVUQv6XZGEDA_w@mail.gmail.com>
Subject: Re: [PATCH 0/7] iommu: Permit modular builds of ARM SMMU[v3] drivers
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 5:28 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Nov 01, 2019 at 12:41:48PM +0100, Jean-Philippe Brucker wrote:
>
> [...]
>
> > > > I'm also wondering about ACPI support.
> > >
> > > I'd love to add ACPI support too, but I have zero knowledge of ACPI.
> > > I'd be happy to help anyone who wants to add ACPI support that allows
> > > ACPI to add device links.
> >
> > It's not as generic as device-tree, each vendor has their own table to
> > describe the IOMMU topology. I don't see a nice way to transpose the
> > add_links() callback there. Links need to be created either in a common
> > path (iommu_probe_device()) or in the APCI IORT driver.
>
> We can create a generic stub that calls into respective firmware
> handling paths (eg iort_dma_setup() in acpi_dma_configure()).
>
> There are three arches booting with ACPI so stubbing it out in
> specific firmware handlers is not such a big deal, less generic
> sure, but not catastrophically bad.

Ok, good to know.

> Obviously this works for IOMMU masters links

It's unclear to me what you are referring to here and it's throwing me
off on the rest of the email.

Did you mean to say "IOMMU master's links"? As in the bus masters
whose accesses go through IOMMUs? And "links" as in device links?

OR

Do you mean device links from bus master devices to IOMMUs here?

> - for resources
> dependencies (eg power domains) it deserves some thought, keeping in
> mind that IOMMUs are static table entries in ACPI and not device objects
> so they are not even capable of expressing eg power resources and
> suchlike.

If you can reword this sentence for me with more context or split it
into separate sentences, I'd appreciate that very much. I'd help me
understand this better and allow me to try to help out.

> Long story short: adding IOMMU masters links in ACPI should be
> reasonably simple, everything else requires further thought.

-Saravana
