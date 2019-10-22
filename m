Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C2CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C7521920
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 12:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfJVMwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 08:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388655AbfJVMwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 08:52:06 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB26783F51
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 12:52:05 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id z136so88780qkb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 05:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yeQelJTclqqXcJSeLCRYJucLdCvZTdooL8LQ/VknXg=;
        b=WRRRVoYDdKEUCTU8nezcpOHqRPF9CA9Ey/VSWqXGR8S8JChnlyQ80VsVJf87SWwPGC
         NauNc02U22Ap6Wl9h5q8QW/GjOA/XfC9COshBSqmsBlEf2sDlPy6NZ+JUNaoKEGW6bEC
         3ebmTfwDj71die3ql+9QGQ/Md53dWI00yGD5CseABrwN3smFEnOdswb+fjvW12ZVEODC
         lLc+ARzK+kFK/A8hH9v07H2sKLPGoM772vjGG8hdD4Yjslfa0+Jik/X6O5ccDsV93NXn
         /nupmOJeW8cQ8AtwRujD2t0H9RVaWLYJKX1f6ED2lQgoQZwdAU9vzvDG+EMePnVkRNoN
         cU5g==
X-Gm-Message-State: APjAAAVgdnG2lePwja1aI9ynibdPKYTmL3lOQwQJhYCHzvcZ5E7mH11Y
        /BUrw6Qoo8Ey2vbJqEVcqi9BMMvX42IINV6gt5IJ1cw4NYgY9NduZG93/dZTY7Ld3qnTL50QhhN
        54UVBNH9TLTkP/NwbJXatPGl5aJb7tLQBmxM5/qEX
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr2853218qke.62.1571748724999;
        Tue, 22 Oct 2019 05:52:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTSf/89W7mLASTE6fmyhuNivQ1p+xmXUQgPgY57L2MD0+HVVER/VSyOJiIJsiIDyT24Z8QmXi/IjC27y0EsqE=
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr2853196qke.62.1571748724699;
 Tue, 22 Oct 2019 05:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACO55ttOJaXKWmKQQbMAQRJHLXF-VtNn58n4BZhFKYmAdfiJjA@mail.gmail.com>
 <20191016213722.GA72810@google.com> <CACO55tuXck7vqGVLmMBGFg6A2pr3h8koRuvvWHLNDH8XvBVxew@mail.gmail.com>
 <20191021133328.GI2819@lahna.fi.intel.com> <CACO55tujUZr+rKkyrkfN+wkNOJWdNEVhVc-eZ3RCXJD+G1z=7A@mail.gmail.com>
 <20191021140852.GM2819@lahna.fi.intel.com> <CACO55tvp6n2ahizwhc70xRJ1uTohs2ep962vwtHGQK-MkcLmsw@mail.gmail.com>
 <20191021154606.GT2819@lahna.fi.intel.com> <CACO55tsGhvG1qapRkdu_j7R534cFa5o=Gv2s4VZDrWUrxjBFwA@mail.gmail.com>
 <CACO55ts7hivYgN7=3bcAjWx2h8FfbR5UiKiOOExYY9m-TGRNfw@mail.gmail.com> <20191022124453.GK2819@lahna.fi.intel.com>
In-Reply-To: <20191022124453.GK2819@lahna.fi.intel.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 22 Oct 2019 14:51:53 +0200
Message-ID: <CACO55tvxvwUqzg=jLoO6bhmcaXQwRaTv9S4pt2t0V5TUi+HsEw@mail.gmail.com>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux ACPI Mailing List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 2:45 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Tue, Oct 22, 2019 at 11:16:14AM +0200, Karol Herbst wrote:
> > I think there is something I totally forgot about:
> >
> > When there was never a driver bound to the GPU, and if runtime power
> > management gets enabled on that device, runtime suspend/resume works
> > as expected (I am not 100% sure on if that always works, but I will
> > recheck that).
>
> AFAIK, if there is no driver bound to the PCI device it is left to D0
> regardless of the runtime PM state which could explain why it works in
> that case (it is never put into D3hot).
>
> I looked at the acpidump you sent and there is one thing that may
> explain the differences between Windows and Linux. Not sure if you were
> aware of this already, though. The power resource PGOF() method has
> this:
>
>    If (((OSYS <= 0x07D9) || ((OSYS == 0x07DF) && (_REV == 0x05)))) {
>       ...
>    }
>

I think this is the fallback to some older method of runtime
suspending the device, and I think it will end up touching different
registers on the bridge controller which do not show the broken
behaviour.

You'll find references to following variables which all cause a link
to be powered down: Q0L2 (newest), P0L2, P0LD (oldest, I think).

Maybe I remember incorrectly and have to read the code again... okay,
the fallback path uses P0LD indeed. That's actually the only register
of those being documented by Intel afaik.

> If I read it right, the later condition tries to detect Linux which
> fails nowadays but if you have acpi_rev_override in the command line (or
> the machine is listed in acpi_rev_dmi_table) this check passes and does
> some magic which is not clear to me. There is similar in PGON() side
> which is used to turn the device back on.
>
> You can check what actually happens when _ON()/_OFF() is called by
> passing something like below to the kernel command line:
>
>   acpi.trace_debug_layer=0x80 acpi.trace_debug_level=0x10 acpi.trace_method_name=\_SB.PCI0.PEG0.PG00._ON acpi.trace_state=method
>
> (See also Documentation/firmware-guide/acpi/method-tracing.rst).
>
> Trace goes to system dmesg.

This sounds to be very helpful, I'll give it a try.
