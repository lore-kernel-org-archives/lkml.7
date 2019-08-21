Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADBCC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DCC2339F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nmacleod-com.20150623.gappssmtp.com header.i=@nmacleod-com.20150623.gappssmtp.com header.b="vvOrvhDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfHUTuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:50:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43572 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbfHUTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:50:06 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so7027656ioe.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nmacleod-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1b30e6gRe2c0bwhomYfMsfRu3mToP8vKxwYhju17cQ=;
        b=vvOrvhDEVzmgnBfvyfoObEv3QGffiAKf9PLlUiVQvatWrrHjcfq6Ha6FhiO8jzY8I8
         NPtB1PjExIKpHPF2Gi8TIj9FVU0Tysg3kyfrIP62JTG4m1MCNesx/aQWDr5z2lBWC5QG
         qCSngpozli2XA5V/xbbhOxsvblxgBHBERhQn88XXu7iYB8Gelzwb4hg0hQK/4kLnhRzq
         dHHrkkLBq5aJQ0H/Y1sBEY7gdQS163wTQ/0SQ/FQNvsAQmPjMIFWrVpUonn6qI7SP0ZF
         rJ3AHe8OcWybEt3/U1nWWRGcFxGbvN/e7QHSaHcI95nllnTBm3IGG6y+ICv6kunKa1gZ
         tMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1b30e6gRe2c0bwhomYfMsfRu3mToP8vKxwYhju17cQ=;
        b=cgnYoJPa01wmGNU/zDSx5e3HBOD21LQa1YnkZ0tsb6G7v68EXYix4CsEJXYSRiQ1cu
         RbvBriNQrtD7euo7JiZoAYYwtbZWNTs8/vDDiZEpGKmFi6aTJin9q6qNhoWM6b4P8IUB
         anWunLToEJq7Q0eQc7LSXZRHz/CmtnYmyzIelXKodkvL18n4umyoDl8/FPWNcMJ0mBjb
         FQtJdTl7LEjWigGxuiBA+yOwBI8vo2nNKkPeiH+y4z8paaLsGysEwaBfUzkRB/A9MeSH
         FfcbC5aX592LAF7C/xzYl/+7ttsO+lScFgBROV77HUZdGUNPHjUICwytAfhBOpGhtsXq
         2Rng==
X-Gm-Message-State: APjAAAVQlzHYwPvbQGX1FnSnIS2Aak263aKbp2OUkbmjivhSALx3zplO
        DordNlJOjr+pkLDDM2u8YfBXSY7pS7Izx7DKM8zISW61
X-Google-Smtp-Source: APXvYqx1OHsysbZ4WL89OjpDSvCJCdzrzeq2U96Q8o98SnHISwPca3OhZMZvK2ebzomkct5+xTTCpPDZ7u+kscr9whU=
X-Received: by 2002:a5d:8908:: with SMTP id b8mr17430583ion.237.1566417005695;
 Wed, 21 Aug 2019 12:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com> <alpine.DEB.2.21.1908212047140.1983@nanos.tec.linutronix.de>
 <5b9b4c36-c28b-1644-61fe-dbdfe3c4a1d2@nvidia.com>
In-Reply-To: <5b9b4c36-c28b-1644-61fe-dbdfe3c4a1d2@nvidia.com>
From:   Neil MacLeod <neil@nmacleod.com>
Date:   Wed, 21 Aug 2019 20:49:46 +0100
Message-ID: <CAFbqK8mG0-f9BpwTykXq+P_pAzMrn_4-5QJ_jawJ1aYSTMGR7w@mail.gmail.com>
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix looks good - many thanks for the quick turnaround!

Neil

On Wed, 21 Aug 2019 at 19:56, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/21/19 11:51 AM, Thomas Gleixner wrote:
> > On Wed, 21 Aug 2019, John Hubbard wrote:
> >> On 8/21/19 10:05 AM, Neil MacLeod wrote:
> >> static void sanitize_boot_params(struct boot_params *boot_params)
> >> {
> >> ...
> >>              const struct boot_params_to_save to_save[] = {
> >>                      BOOT_PARAM_PRESERVE(screen_info),
> >>                      BOOT_PARAM_PRESERVE(apm_bios_info),
> >>                      BOOT_PARAM_PRESERVE(tboot_addr),
> >>                      BOOT_PARAM_PRESERVE(ist_info),
> >>                      BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> >>                      BOOT_PARAM_PRESERVE(hd0_info),
> >>                      BOOT_PARAM_PRESERVE(hd1_info),
> >>                      BOOT_PARAM_PRESERVE(sys_desc_table),
> >>                      BOOT_PARAM_PRESERVE(olpc_ofw_header),
> >>                      BOOT_PARAM_PRESERVE(efi_info),
> >>                      BOOT_PARAM_PRESERVE(alt_mem_k),
> >>                      BOOT_PARAM_PRESERVE(scratch),
> >>                      BOOT_PARAM_PRESERVE(e820_entries),
> >>                      BOOT_PARAM_PRESERVE(eddbuf_entries),
> >>                      BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
> >>                      BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
> >>                      BOOT_PARAM_PRESERVE(e820_table),
> >>                      BOOT_PARAM_PRESERVE(eddbuf),
> >>              };
> >
> > I think I spotted it:
> >
> > -               boot_params->acpi_rsdp_addr = 0;
> >
> > +                     BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
> >
> > And it does not preserve 'hdr'
> >
> > Grr. I surely was too tired when staring at this last time.
> >
>
> ohhh man, that's embarrassing. Especially hdr, which was the center of
> the whole thing...sigh. Patch coming shortly.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
