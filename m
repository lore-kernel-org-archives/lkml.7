Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E0EC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E364B20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 20:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGAUvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:51:15 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36256 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfGAUvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:51:15 -0400
Received: by mail-ua1-f67.google.com with SMTP id v20so5626783uao.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 13:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wESivRaOzdReZ9r3dQBJ6+auCoe5qPpy86Hfp/fZ9E8=;
        b=E8qUnaRi86DOYe4ykNLKZsrbv0jdLVwI+pq8I2EsHYEs0CcBbovV1y0Hei5KDm2Fmz
         KmHtA8xJqJ/vwuMgStkXzR5exybnjqwJ0U017XcMZljSVrkorpLmhd/gwEnrWbBG1kq4
         xaEWCeJQzSEXgr+vsfpwNtX9K4qT5eqLhACkUv7Sc4DxuoxAkeBHYXrhk/N4VR1SwZIg
         q3CfzDwMJTX+1EHGRMttwp/D6fSbZzJZChfSzouvgWW9ZiiGOLMyLm+9yiAmM/PDCN3c
         bW5auRal34ZjScoNNCcI0uPMPdlyhbHtV908sNtc+D0PYT0Y5SWeECSxjIt5+JSmAv10
         m1RQ==
X-Gm-Message-State: APjAAAV3g8WFMHb4Ti6Lm5P/3NEbJdysVDukxnx7kFOUbkzmUj8NLSwd
        Q5UHNCk09l+2Tm7/M9dkY1SxpxjeIYcO4Yv4euMqLQ==
X-Google-Smtp-Source: APXvYqwMzDPq7JpJflDPfeE/dnLsjBjSEFhiY3GM+/DWjW/AMVD2Nqv2V3R3T/2gUIf0fb+Zl6ZNq2nnxyTmlzmYxFg=
X-Received: by 2002:ab0:168a:: with SMTP id e10mr15443818uaf.87.1562014274511;
 Mon, 01 Jul 2019 13:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190626081522.GX24419@MiWiFi-R3L-srv> <20190626082907.GY24419@MiWiFi-R3L-srv>
In-Reply-To: <20190626082907.GY24419@MiWiFi-R3L-srv>
From:   David Airlie <airlied@redhat.com>
Date:   Tue, 2 Jul 2019 06:51:03 +1000
Message-ID: <CAMwc25oeskFG4bbrb3rwotqi1a5z4wYsGW=Qs_XJmhX_vAdNfQ@mail.gmail.com>
Subject: Re: mgag200 fails kdump kernel booting
To:     Baoquan He <bhe@redhat.com>
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, dyoung@redhat.com,
        Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 6:29 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 06/26/19 at 04:15pm, Baoquan He wrote:
> > Hi Dave,
> >
> > We met an kdump kernel boot failure on a lenovo system. Kdump kernel
> > failed to boot, but just reset to firmware to reboot system. And nothing
> > is printed out.
> >
> > The machine is a big server, with 6T memory and many cpu, its graphic
> > driver module is mgag200.
> >
> > When added 'earlyprintk=ttyS0' into kernel command line, it printed
> > out only one line to console during kdump kernel booting:
> >      KASLR disabled: 'nokaslr' on cmdline.
> >
> > Then reset to firmware to reboot system.
> >
> > By further code debugging, the failure happened in
> > arch/x86/boot/compressed/misc.c, during kernel decompressing stage. It's
> > triggered by the vga printing. As you can see, in __putstr() of
> > arch/x86/boot/compressed/misc.c, the code checks if earlyprintk= is
> > specified, and print out to the target. And no matter if earlyprintk= is
> > added or not, it will print to VGA. And printing to VGA caused it to
> > reset to firmware. That's why we see nothing when didn't specify
> > earlyprintk=, but see only one line of printing about the 'KASLR
> > disabled'.
>
> Here I mean:
> That's why we see nothing when didn't specify earlyprintk=, but see only
> one line of printing about the 'KASLR disabled' message when
> earlyprintk=ttyS0 added.

Just to clarify, the original kernel is booted with mgag200 turned
off, then kexec works, but if the original kernel loads mgag200, the
kexec kernels resets hard when the VGA is used to write stuff out.

This *might* be fixable in the controlled kexec case, but having an
mgag200 shutdown path that tries to put the gpu back into a state
where VGA doesn't die, but for the uncontrolled kexec it'll still be a
problem, since once the gpu is up and running and VGA is disabled, it
doesn't expect to see anymore VGA transactions.

Dave.
>
> >
> > To confirm it's caused by VGA printing, I blacklist the mgag200 by
> > writting it into /etc/modprobe.d/blacklist.conf. The kdump kernel can
> > boot up successfully. And add 'nomodeset' can also make it work. So it's
> > for sure mgag driver or related code have something wrong when booting
> > code tries to re-init it.
> >
> > This is the only case we ever see, tend to pursuit fix in mgag200 driver
> > side. Any idea or suggestion? We have two machines to be able to
> > reproduce it stablly.
> >
> > Thanks
> > Baoquan
