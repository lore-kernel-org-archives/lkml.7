Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1979C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8634207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 07:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BIp45yVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfL3HmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 02:42:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39034 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfL3HmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 02:42:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so45212433oty.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 23:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwlK7F0OhgofZ2g1c0eZ3ZVDb9GpV5ov9doTgWC0/9U=;
        b=BIp45yVziKNxpjGFASN8D5v/1fT7LjBa4Qn8eNSmrBq3xaVgnM44DM6PK7rx3YeBNi
         BDWg9AfiT3EWhYCOfZdHIo3SkBFKNmNUONsZnmcUK7pdKNwI11KFuoPkBLfBAXS5n8Fr
         mud8KAX20EIHYtiOXNQY/ktuH9N97++24K9VBM7ShhN4uC68X1Ta0t/VTCvKUNwQwhdV
         kf4ZRtK6H5V1Z3I5V5BgOY7krjGLjDje15J+E3eKmtgyyS0N/uXeW19g4XAnM/Tqcdv5
         jqhypWawBaFAHuyunqRhY0zOH+DDpiG8bRo7oS/Sx3iURFKo4RyorYe1PY4Q5ddsmfAZ
         Q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwlK7F0OhgofZ2g1c0eZ3ZVDb9GpV5ov9doTgWC0/9U=;
        b=VunQCA0KCnT2iZ7Fidw8XpxOJQGM6JdAjyw40Uo9LGUo9AiFJrSGtHjbYV8ASUNg99
         bp/VG+vAyM5HdtlM6qNO9iJbO/kDHI+OvQdlWB+L8UcSTHSkpKa/8LJMT2PjIEGun1NF
         Q61+Dj+nhudfEdjFpchcyLUQTy7Xix0T3khNPBlLWIIh/6OAeUoUtHhtsWai2tC8xuqN
         4RDMK341DGW9+Kc/22GGgUtr9yjVLPnO/EBWDEBMmd9Xcfx4b3j3KcL58ngMzWN8LaI5
         tpzH7KgeX5HAfgO8++PJyTgWzHxO+vVVTrkgs4xBmmHoRAiiTxm6Ud2bBLMdpEHqvsrC
         yPBg==
X-Gm-Message-State: APjAAAVEsw50i/YvnNV5PkTIHJ5W6cnnzjJgvbvxqNbfN1WmuEq4rwUC
        FlJ4MDqQVOgwRuCO5QycCC4dhY8lKyVwShz/q0qEWQ==
X-Google-Smtp-Source: APXvYqxZCdiUMDh71LNzQUqteO0QNtYqYbR0IterKvdS2rrqYRU7b1xSIGCSAE+kMAVQyN/LJmYR708bEBLXhWJ92iQ=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr64344596otm.247.1577691728093;
 Sun, 29 Dec 2019 23:42:08 -0800 (PST)
MIME-Version: 1.0
References: <1577122577157232@kroah.com> <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
 <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
 <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
 <20191228151526.GA6971@linux.intel.com> <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
In-Reply-To: <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 29 Dec 2019 23:41:56 -0800
Message-ID: <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Bundy <christianbundy@fraction.io>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 9:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sat, Dec 28, 2019 at 7:15 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Dec 27, 2019 at 08:11:50AM +0200, Jarkko Sakkinen wrote:
> > > Dan, please also test the branch and tell if other patches are needed.
> > > I'm a bit blind with this as I don't have direct access to the faulting
> > > hardware. Thanks. [*]
> > >
> > > [*] https://lkml.org/lkml/2019/12/27/12
> >
> > Given that:
> >
> > 1. I cannot reproduce the bug locally.
> > 2. Neither of the patches have any appropriate tags (tested-by and
> >    reviewed-by). [*]
> >
> > I'm sorry but how am I expected to include these patches?
>
> Thanks for the branch, I'll get it tested on the failing hardware.
> Might be a few days due to holiday lag.

This looked like the wrong revert to me, and testing confirms that
this does not fix the problem.

As I mentioned in the original report [1] the commit that bisect flagged was:

    5b359c7c4372 tpm_tis_core: Turn on the TPM before probing IRQ's

That commit moved tpm_chip_start() before irq probing. Commit
21df4a8b6018 "tpm_tis: reserve chip for duration of tpm_tis_core_init"
does not appear to change anything in that regard.

Perhaps this hardware has always had broken interrupts and needs to be
quirked off? I'm trying an experiment with tpm_tis_core.interrupts=0
workaround.


[1]: https://lore.kernel.org/linux-integrity/CAA9_cmeLnHK4y+usQaWo72nUG3RNsripuZnS-koY4XTRC+mwJA@mail.gmail.com/
