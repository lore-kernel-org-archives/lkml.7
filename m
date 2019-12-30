Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B76C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DB520658
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LOFA+mxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfL3UQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:16:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46088 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfL3UQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:16:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id p67so11425660oib.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 12:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGoYHJkV2sBuC/EabEMn2jT6G42n0LQcEtNTThbzJvo=;
        b=LOFA+mxlmd5oV8l+Ly2ITiGE7quCUFquXLsCfnDW9MllcsxJM+xgnpfdFKisb8BlW1
         GsO5VONykMGvsC/iRi6Eid6vExDoXX/AGXk3RgaQSaV/KJstjudxFNuYhLaX/O/sRVgI
         fCl75NApfe3sM2ibIn7p9xCxDkpU9lBZeIiHUmzhr+s8RGLjZMMlrnEOtoVPjzn7bz+8
         qAXlEZ4WIdspGkErzVHHtXGP+qBfG7Ig0sNFiB5LEExIhOb0uo+rkIgNuo/eDxEcTcVA
         mHuU2UpXe/KNqH19ffb+XBrtbUJmugSY6caSLnbRawTieig0KcwDS3330Y27EYSFO6nG
         GO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGoYHJkV2sBuC/EabEMn2jT6G42n0LQcEtNTThbzJvo=;
        b=dt3+j8LhxhxZ6ML4ZacuXD1umlURwAByQUKVtLCbiYVXySRo30gRb9EfH0xFjpOXSb
         QQXp3AkNfStGiwZTSzcALFnkge8Vq4HriTLMCmNFjrP7Lw8IYJA+EWqKZQ5rvJO1MipQ
         1bt4iBeYnK387H7U077fMAfgNPbX7+PtIRGNm9XcYHHriOTeGk0uuSPxNtZGHOWTaWFE
         UHoI59xpqXkeDAsSuSPn5G0Z7nqYuEpm5UIhXGGHZ3VSNHWZ8IbBXKhGTcWXPENtzLSa
         UuxN+nquEYg6ldSEsn68o8PzI2n+TztN+P2s8FuNdvujDULUbgHExVt+K7H701g40qqU
         kpeA==
X-Gm-Message-State: APjAAAXVBFnzsFIjdL1Nh0u1IXKXM/LyCwKhd1G4BHBtLWIlgpMIToCu
        5OzbZIuMyddZdpdBNoJhRNHsOYkXcHc+IgCAeCPlTA==
X-Google-Smtp-Source: APXvYqx3ceamtmJUChp1TLuDkDv4af0iLI+bwyDSS+upKsqsk+U0Ob0XHRDXqZ29dmIwB0CA1zn0kxN2oJlTNMRltC0=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr333228oia.73.1577737010159;
 Mon, 30 Dec 2019 12:16:50 -0800 (PST)
MIME-Version: 1.0
References: <20191204075233.GA10520@dhcp-128-65.nay.redhat.com>
 <CANTgghnsdijH90qnm24qat70T7FA5qOwmnXXt+NYVxHYa4SLJA@mail.gmail.com>
 <CAPcyv4iRdJO6xrCaN=vrSvYFLZanLazmJLArT5YMfdJ6rc-PEQ@mail.gmail.com> <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
In-Reply-To: <CAPcyv4hT9HXN2CqZw96zqgdNaapc=9oqSYvGrnEbeqSmx0t5xw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 30 Dec 2019 12:16:39 -0800
Message-ID: <CAPcyv4jLxqPaB22Ao9oV31Gm=b0+Phty+Uz33Snex4QchOUb0Q@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: update e820 about reserved EFI boot services
 data to fix kexec breakage
To:     Dan Williams <dan.j.williams.korg@gmail.com>
Cc:     Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec@lists.infradead.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 1:42 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> I'll send a patch to fix up efi_fake_memmap().

For others following this thread, that patch is here:

http://lore.kernel.org/r/157773590338.4153451.5898675419563883883.stgit@dwillia2-desk3.amr.corp.intel.com
