Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98803C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D81920722
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575323899;
	bh=RFyQOZq83qYdIN6R6bKMfwpnyADQiSNkcTiQSqDTWx4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cylBZWO2s71/mj6QS1YHke3dAyCVSYkzn5dg42Gk4MPHxWgXJZKgkCLATlFQJmU1A
	 rgxbgd3zXslkwgqOMn62NYUo8lRO9AyapEw3BWZjn9I5hId1SYokZPdNZKx0+7CgAg
	 FUvg+Vy6QNSJvMXnVFjGBDjkZcvySJ+LvD+LB72c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLBV6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 16:58:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34022 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfLBV6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 16:58:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id m6so1326847ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AouDAgA+J4VybjzNvK6JJ1TaiqXLV/JGnpANufytYVM=;
        b=NWARLlNt+JDbaPQTlbt/lW+z4ZiRUQtoroXOODH5gyyBcR1jSXyl99/JGwHHvI6rjG
         ilQ6WOfhi1QDoOdZ6MgYvA4Ur6Mi4YohIK3ZW3Dp7b/Fg7mABEzEeRZ9HfixQdriPM3I
         hXluwApQE6wB/zXtq0ygo/a7X7Oyr+BrlkUV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AouDAgA+J4VybjzNvK6JJ1TaiqXLV/JGnpANufytYVM=;
        b=OCbkhjX1jEY77aIn4Qc3pde8lYrRpXOFPjTW4twydEf5avCRXhbXPPxIIPlwnD+Ksu
         sBiphV/vxXSwAxZvdjqiAF5bKwbWwpqGIqGdBR+zHnc0meLefCrgugc+o7dg8BFo8dra
         lmh3+0M2NpI6LjVhHrXGgJ87MNHM2OwMqFxhh1zeV6Hts9mvaITobkb9hPq9UbMNlMl8
         sEb64LXN+cf1F7ohGJR3umaCo7Kq52STZISa0oHLSbOnsRK2r0wf5IXqsDoJ4b6gyL9A
         8f1ojmb5rbwgvEdZ9L3TFYoe37jS4CdgnolGTaifXT1baf/WV0SSBMg03hD4dX+JrpIp
         wwBw==
X-Gm-Message-State: APjAAAX195JluCSMumLo0atRvhmoilMuqRQ0p0NUX0HK7EOTxznmkj1G
        LGgxwwr54cBJo9n3QDTZevO3E8N0e2o=
X-Google-Smtp-Source: APXvYqwPgWKOxS4n79qry4oxwHTky6lm8voHpRv2uccgSoPxrsebRuS8t3f5SxkdMyEBFxi7+G9zow==
X-Received: by 2002:a2e:161b:: with SMTP id w27mr565865ljd.183.1575323894650;
        Mon, 02 Dec 2019 13:58:14 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id b190sm219852lfd.39.2019.12.02.13.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 13:58:13 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id z17so1234535ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 13:58:13 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr568601ljg.133.1575323892985;
 Mon, 02 Dec 2019 13:58:12 -0800 (PST)
MIME-Version: 1.0
References: <1575137443.5563.18.camel@HansenPartnership.com>
In-Reply-To: <1575137443.5563.18.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Dec 2019 13:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWNpPW91wyEj4FC4pOimWEUtLVb_RwQgB+9h2OO6ynyA@mail.gmail.com>
Message-ID: <CAHk-=wjWNpPW91wyEj4FC4pOimWEUtLVb_RwQgB+9h2OO6ynyA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.4+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 30, 2019 at 10:10 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>    The two major core
> changes are Al Viro's reworking of sg's handling of copy to/from user,
> Ming Lei's removal of the host busy counter to avoid contention in the
> multiqueue case and Damien Le Moal's fixing of residual tracking across
> error handling.

Math is hard. You say "The two major core changes are.." and then you
list _three_ changes.

Anyway, the sg copyin/out changes by Al conflicted fairly badly with
Arnd's compat_ioctl changes.

Al did

  c35a5cfb4150 ("scsi: sg: sg_read(): simplify reading ->pack_id of
userland sg_io_hdr_t")

which avoided doing a whole allocation of an 'sg_io_hdr_t' to just
read the one field of it.

But Arnd did

  98aaaec4a150 ("compat_ioctl: reimplement SG_IO handling")

which created a get_sg_io_hdr() helper that copied the 'sg_io_hdr_t'
from user space the right way for both compat and native, which
basically relied on the old approach.

So I effectively reverted Al's patch in order to take Arnd's patch in
the crazy sg legacy case that presumably nobody really cares about
anyway, since everybody should use SG_IO rather than the sg_read()
thing. But I know not everybody is.

I added a comment in that place:

              /*
               * This is stupid.
               *
               * We're copying the whole sg_io_hdr_t from user
               * space just to get the 'pack_id' field. But the
               * field is at different offsets for the compat
               * case, so we'll use "get_sg_io_hdr()" to copy
               * the whole thing and convert it.
               *
               * We could do something like just calculating the
               * offset based of 'in_compat_syscall()', but the
               * 'compat_sg_io_hdr' definition is in the wrong
               * place for that.
               */

since it turns out that the one 'pack_id' field we want does have the
same format in compat  mode as in native mode ("int" and
"compat_int_t" are the same), it's just at different offsets. But the
definition of 'compat_sg_io_hdr' isn't available in that place.

I'm leaving it to Al and Arnd to decide if they want to fix the
stupidity. I tried to make the minimally invasive merge resolution.

Al, Arnd? Comments?

It looks like linux-next punted on this entirely, and took Al's
simplified version that doesn't work with the compat case. Maybe I
should have done the same - if you use read() on the /dev/sg* device,
you deserve to get broken for the compat case. And it didn't
historically work anyway. But it was kind of sad to see how Arnd fixed
it, and then it got broken again.

I really really wish we could get rid of sg_read/sg_write() entirely,
and have SG_IO_SUBMIT and SG_IO_RECEIVE ioctl's that can handle the
queued cases that apparently some people need. Because the read/write
case really is disgusting.

                Linus
