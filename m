Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F0CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80F72077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfBaQ5Qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfD0QlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:41:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45263 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0QlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 12:41:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so3002281pls.12;
        Sat, 27 Apr 2019 09:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2wgOmjHmygiVTqAX0w6y4VcoX721WxiuBgRaT/Kgs4=;
        b=WfBaQ5Qr0pxSFWSxQoKoGdhEz++2xJYrpML8oCGjlqT0If8C5biJMXCsf+l0P32d2D
         MsFqZLVlKklvrVJPnKpv/FDx8INjZAgL7SQaDIgQMqLVlwNEj+Aap3xT4WXMVI6hBfJH
         MxZAERxfXqkcPIu3k/csao/Ij2Em2zSgmqggNgpLy+stDdG5yIQ0CX1lcO7OP8NSsHL7
         jTCpFljpk1KmyGBmaw//KrI2yMHsWFEPyxBL485uTIHICDeqtQdtmNpGhnSaeeA1ldgI
         cT8+YcSmwp6m9nyC59i0UGUwgzp32vmd9Fg0IeNoDV9VFgseXjuOiE8uAaEthoj2C+oU
         12UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2wgOmjHmygiVTqAX0w6y4VcoX721WxiuBgRaT/Kgs4=;
        b=k29BMupy2UhBZKBUdSh9BQEHPxskiLy2gvJtZnOU2Y4Gh+jyLEg1VgEl1NZ190A9JG
         r6nuznVcId/jMzlxvDmiPCoB5d6MsJmH7pNOJfYcPLMVYarTrHZpOFcqaJpGKe/RurSx
         aKplhRRwpkrQ+Xg3lzM+AWI1UUACiKQTQHoTN0yYsxkoLOZfv3DujGSAhIaKs+GRFWdX
         D1X3yJjUV7o8tOUUwhgofRE3YhpT5/jN+1vR2TlI5n01xDsNVGnhSq3Fag/2HgmNhVOT
         phwRTC7Jj8E8aDhR8wi5Rqv/QffKcCQVZmzmWMZO6p4tQZMcVpSQa73n4HL/1Og1+xRB
         wKxQ==
X-Gm-Message-State: APjAAAUu0Wa150Th+5eC0JAS7qGSHECaRpgidrUCN9arGl8Y8CCuQM4+
        4Ioo/bBDdSei6A3WXBJkwxLDsYJEyt7OeQw56sI=
X-Google-Smtp-Source: APXvYqy427ptengr4t2dYkXb9JjX6wE14sRCvIu4kLWcnq3lzjRa9/wJlk7D1FgYdBNhmO3Kvazh4J+/62wXtl9cdvU=
X-Received: by 2002:a17:902:758b:: with SMTP id j11mr15560561pll.87.1556383281759;
 Sat, 27 Apr 2019 09:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190426084038.6377-1-esben@geanix.com> <20190426084038.6377-2-esben@geanix.com>
 <20190426143946.GX9224@smile.fi.intel.com> <871s1og11u.fsf@haabendal.dk>
 <20190426215103.GD9224@smile.fi.intel.com> <87tvejakot.fsf@haabendal.dk>
In-Reply-To: <87tvejakot.fsf@haabendal.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 27 Apr 2019 19:41:10 +0300
Message-ID: <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk> wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >> The reason for this patch is to be able to do exactly that (set port
> >> type and UPF_FIXED_TYPE) without having UPF_BOOT_AUTOCONF added.
> >>
> >> In the current serial8250_register_8250_port() there is:
> >>
> >>     uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> >>
> >> So, even though I set UPF_FIXED_TYPE, I get
> >> UPF_FIXED_TYPE|UPF_BOOT_AUTOCONF.
> >
> > Yes.
> >
> >> So I need this patch.
> >
> > Why? I don't see any problems to have these flags set.
>
> The problem with having UPF_BOOT_AUTOCONF is the call to
> serial8250_request_std_resource().  It calls request_mem_region(), which
> fails if the MFD driver already have requested the memory region for the
> MFD device.

If it's MFD, why it requested the region for its child?
Isn't it a bug in MFD driver?

>  And I believe that is a valid thing to do.
>
> To workaround this, I first thought I could just avoid setting
> port->mapbase, causing serial8250_request_std_resource() to be a no-op.
> But this breaks with more than one UART port, as uart_match_port() will
> match the same line for all such UART ports, causing all but the last
> one to be removed.
>
> That said, the purpose of UPF_BOOT_AUTOCONF (for 8250 driver) is to
> request and map the register memory.  So when that is already done by
> the parent MFD driver, I think it is silly to workaround problems caused
> by UPF_BOOT_AUTOCONF being force setted, when it really shouldn't.


--
With Best Regards,
Andy Shevchenko
