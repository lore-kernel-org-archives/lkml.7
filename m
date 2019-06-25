Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BEC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC22208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tok9Ai+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbfFYQDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:03:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45448 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbfFYQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:02:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id m206so12895483oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkiN5Ln+LPD0we4Kre4BOb+XjSLjDB1oXBvT5k6ZR+o=;
        b=tok9Ai+imw0ti/EcFot/UsIPStgqvfECCWrXyRjK/gRgacHLbWM7vCjubSkcj1Hpsj
         q+6uM5UosQJb4cV2Z0kOIVkvNlDiA4GuY+UOfIh+NIvou+4acoWvbM3mVlLOW+gBkEx5
         iZNWXcdrnv6kV2msgQkytXjMaUqWaoegxpAmM+2bBDZMnFi9D5H+LL+AVzVm3yhbJGEB
         +i+K29BA6nW5BhZgVYTThD5y+9csIQJ41ugBlnXeWxNE8Qb0OGiG+66mWYT2yCZQAgLA
         cSTx5fvaG5orxkvAzOaPtdrMPabY8gnQPqJbEwaTebYx2/hhPt+XMtWgxWi1dN4oE/lX
         LrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkiN5Ln+LPD0we4Kre4BOb+XjSLjDB1oXBvT5k6ZR+o=;
        b=C2DRTBYS2abdJg+cqIB5RrybgbHhJbH7RG+i7EssbrkDOo2SDESOASmURO60Ncqn8G
         ibqv6SGVUbnBBtV1xk8MIZcyMdP3inHckDhu1jgyRV/aqVJdqYLLSIgB+iwz1gSAM0UC
         YaqjfUCzqlU351r7zAaB6wXlcr/XAhp42Y4x8B/36TvqB2KSTfEq+yLQhTaYYPl0viNf
         grfWCyCsUI21LsyaIEqj8kH8Aey1GK1u2+BDdjnRUb0ujDmoM0c7IuTndEVVgXxT0zS2
         pumaryEQSh/VIVrsLbsX369f7ZfJEc5KmJTuzvmPE+lw5qYZ5yujKLOmGELccMtJ/1zH
         WAmQ==
X-Gm-Message-State: APjAAAWS1jWJSWDNSgNqNCQRhdkKDZa8JVCMBLv/lwNsZ9NS5Xt9jcFq
        Ar1kzJQLyn0zTBoU3jt5SQ5RBZcBNxDaKuG/3zy/ng==
X-Google-Smtp-Source: APXvYqzijRCdiCgtAS54hIkOnWrg0lv445xZzpHZwxTcEM+ri/YbV9SOX0mHFP5P3gGhqU5blgGoR/P8TmZa3pACDUE=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr14122051oih.73.1561478577981;
 Tue, 25 Jun 2019 09:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190625155956.00002dc4@huawei.com>
In-Reply-To: <20190625155956.00002dc4@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Jun 2019 09:02:46 -0700
Message-ID: <CAPcyv4haG=Pu_-Se+CiGOXHuM1qZH8uLP-Pbr_KgDmL3GOf25g@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] acpi/numa: Establish a new drivers/acpi/numa/ directory
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     X86 ML <x86@kernel.org>, Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 8:01 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 24 Jun 2019 11:19:32 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Currently hmat.c lives under an "hmat" directory which does not enhance
> > the description of the file. The initial motivation for giving hmat.c
> > its own directory was to delineate it as mm functionality in contrast to
> > ACPI device driver functionality.
> >
> > As ACPI continues to play an increasing role in conveying
> > memory location and performance topology information to the OS take the
> > opportunity to co-locate these NUMA relevant tables in a combined
> > directory.
> >
> > numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> > hmat.c.
>
> Hi Dan,
>
> srat.c now includes processing for the slit table which is a bit odd.
>
> Now we could split this up in to a top level numa.c and then
> srat.c, slit.c and hmat.c....
>
> Does feel rather silly though.  Perhaps better to just leave it as
> numa.c?

The srat and slit tables go hand in hand, I'm not too bothered by the
fact that the slit table does not get top billing with its own source
file name.

The "numa" term is already in the path name, and calling numa.c leaves
out hmat details which are also "numa".

> I don't really feel strongly about this though.

Understood, I just did not see the justification for HMAT being off in
its own directory when it is a direct extension of the existing
ACPI_NUMA functionality, the other renames were my best effort to
rationalize the code organization.
