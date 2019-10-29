Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC1CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA95421920
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jyz7BkXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfJ2DHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 23:07:11 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37975 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfJ2DHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:07:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id r14so3776691otn.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qnT1ZP3CJMcSq6L0LWTa2iyPLJWEkUMtmJ85EPCi4g=;
        b=jyz7BkXWDwIX8GIPgfsfU1Pk6DOEgI+jy3ge8ri0/tATonbTF5qMMpBr8OzN84eXdp
         PPt89jzMeUxP8VByrdcY6vy+QfDNxLaz5t3bfOpjE3qK/z0Y6sVf/67nxVjzgDMT6LwA
         CoHFbgv1Yxc/p9ZwMpRlaW4qe3M/lf+xa+L1uePYN9n4O6BRpFkzmZ0Y6YA7+lcE00C9
         BA5GAq+HwCw+Luc/VgNTBdTfTjFIZ0ciIfSzHseq3VqwQyL/ch+xTZG9+AotHo9RWzRO
         14xtUdOKCD/RezUjBH09AEwDzLaEs0vk4d1wEu36ShlQheSwdhpQNHw2QyktRxd5VdNH
         boZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qnT1ZP3CJMcSq6L0LWTa2iyPLJWEkUMtmJ85EPCi4g=;
        b=iwrUO0VMbGMxUTCVBZMIeNSx4nWm9A76PdKIFRW+ZSsyRBd3XtTboIFHX/A5BDEVAd
         agsnOfECdY1WEBpecJOClFHxfx3d1Kl/+dj7y7UBminuJuF2nKH/5MhTWmNxaXEA7X5Z
         pphlGYN7tHplE86qLbYpYYtNE89t3FiBOs5AM1QYANurzQYRTacZoqIPGANTb76Ygaaj
         KaKmCNbTO+laxwF1T78wKv3+OFPgd3ApSA5g5GPSGVjC21FHmh44IAmWomIlnoAyaCrR
         VxUqHrqxyEyTB2Ks7vJbbtN9k34KBON7003ZuB7whu5cO+w7Mu9DmG4prdoJKpSV/PDP
         GquA==
X-Gm-Message-State: APjAAAUIlclEMhchM/Imn9BLhtmFQ2Pi0gHlvz8pDy2V/6aFtb3RMNVs
        DmxBv0Np68NtRX7g5ZTz7K4bNSkBJgytebB2TJyvkg==
X-Google-Smtp-Source: APXvYqy4FOA2jwEsa1Q9F6uRXTEMb/1i6qDZEx0Kz8n+9VLiVD9T6IqpNu6c/DSljpUoRARs+eP4jGbnneNiRziV86M=
X-Received: by 2002:a05:6830:18d1:: with SMTP id v17mr2212366ote.71.1572318429791;
 Mon, 28 Oct 2019 20:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <157118756627.2063440.9878062995925617180.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0j_-iSqiysZiW=J8Y5FCAjnPC7ZvevrLsYhngWr6mT6GQ@mail.gmail.com>
 <CAPcyv4js1XqSe1kNeWob=ftscYFKQF+04PrKj7XDiEWUWvnMvQ@mail.gmail.com> <1666116.19LcctqB44@kreacher>
In-Reply-To: <1666116.19LcctqB44@kreacher>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Oct 2019 20:06:58 -0700
Message-ID: <CAPcyv4i2gxocbT9nB5k9+Qea5WftJLSoArXjymkwyZ=+8GBFcQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 8:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, October 22, 2019 6:48:12 PM CET Dan Williams wrote:
> > On Tue, Oct 22, 2019 at 3:02 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Oct 18, 2019 at 11:25 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > >  On Wed, Oct 16, 2019 at 3:13 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > Currently hmat.c lives under an "hmat" directory which does not enhance
> > > > > the description of the file. The initial motivation for giving hmat.c
> > > > > its own directory was to delineate it as mm functionality in contrast to
> > > > > ACPI device driver functionality.
> > > > >
> > > > > As ACPI continues to play an increasing role in conveying
> > > > > memory location and performance topology information to the OS take the
> > > > > opportunity to co-locate these NUMA relevant tables in a combined
> > > > > directory.
> > > > >
> > > > > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > > > > hmat.c.
> > > > >
> > > > > Cc: Len Brown <lenb@kernel.org>
> > > > > Cc: Keith Busch <kbusch@kernel.org>
> > > > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > >
> > > > Please note that https://patchwork.kernel.org/patch/11078171/ is being
> > > > pushed to Linus (it is overdue anyway), so if it is pulled, there will
> > > > be a merge conflict with this patch.
> > > >
> > > > Respin maybe?
> > >
> > > Actually, would you mind it if I took this one into the ACPI tree right away?
> > >
> > > There's https://patchwork.kernel.org/patch/11198373/ queued up that,
> > > again, will clash with it.
> > >
> > > Also, there is the generic Initiator proximity domains series from
> > > Jonathan depending on it and I would like to move forward with that
> > > one if there are no objections.
> >
> > Given Ard has acked all the EFI core and ARM changes can we proceed
> > with merging the EFI Specific Purpose Memory series through Rafael's
> > tree? It would need acks from x86 maintainers.
>
> In the face of the lack of responses here, I think I will apply this patch
> alone and expose a stable branch containing it in case somebody else wants
> to pull it in.

Ok.

x86 folks, any concerns about Rafael taking the whole lot?
