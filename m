Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED944C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE372054F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698616;
	bh=SWvHMkJXLgKkRwF+Dlr5Did5qCOrYjbhLQGASSZsi9A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j3ae3l++KizBdau9oitIH/+tCT0zvrY1Q5HklZHVhZH+GMKSZE5Hl/ViNZvYNe0EU
	 kIiGo6Qcf8jjsoTo0bxIgjN2+CF0uV5/gsBw15setrhMvSyfT1vrsRAKatphDgpyio
	 QmoB9vra+uUD/mb/xg/2q0ZYuZ/L2bW8Wj7xzza4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfDSS35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:57 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:45176 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfDSS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:55 -0400
Received: by mail-lf1-f48.google.com with SMTP id t11so4571643lfl.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4Pa6AaD11YFWbmWnx+oyTpQprnUAPqORvuUTpM5Xuw=;
        b=O6Q5+GrAK7AxKAU6R3bcr5tL2B2L81VIjsIgmsOOhsZVD8iJ86wAGcqox7QC0zGGm1
         W9L53HaLy/EVleG8CNrqtDGYiTHd8nr/LevmYFsuM9BgGpzLymCavDN+bBC9M/z6DcVF
         g3axT4iMKotCNYPdxBtlwANC2CxFrlsBybWog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4Pa6AaD11YFWbmWnx+oyTpQprnUAPqORvuUTpM5Xuw=;
        b=mXmRq9UDnq6KqGSVM7OqTUcyZSQLYHV+wghcnzBTUxMXBllz99yvJ61oRT3DByCo80
         gVtcFMBswBNPZHbnfTaJRHX4f0QkfFXnfGMoQq4G55zVIB5BQzXKxhkq4G3PZDhdfBhq
         kfUoFu1E5DeA14M7PSTSe04xHQpgx0op7Or5h3BUApSd9QTa9MBWiJmfBqT2Guy7QgB4
         eIqwRU3QyZx3Xa9yFuiRYb+6jRrnnOiBec1UPLxIsGnht+0oHryeVRGUfph4QiMthbAm
         +hjH9q4iIaYrVtdbw26ECF7cR67cO+Cm6CmiFmaj5ztZuzRk5TcGb5tS817GJL7Cu2Y6
         PD3g==
X-Gm-Message-State: APjAAAV1+Ex/i/zp2GMfZ5L23Cq3/rGV7vT5b0t0depABx+wpL9DHvce
        ESRVjxI/QzmdJ4ABEy+SXJFBF3src0Q=
X-Google-Smtp-Source: APXvYqzM3HEYNkJT1riEn2RoX6PF8dPUx3G9t9IvIBKqzvstOwwiOK748nZIgpsCCGf/OXPb9OW/nA==
X-Received: by 2002:a19:f24c:: with SMTP id d12mr2866824lfk.163.1555694855894;
        Fri, 19 Apr 2019 10:27:35 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c5sm1330546ljd.18.2019.04.19.10.27.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 10:27:34 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h16so5177155ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 10:27:34 -0700 (PDT)
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr2872561lja.125.1555694853846;
 Fri, 19 Apr 2019 10:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <20190416110906.6c773aff@mschwideX1> <20190416140658.2cb73a3f@mschwideX1>
 <CAHk-=wjKi5C+Onhp5Vs5BQxHbaBud9M3cTS-S6Tr9yDY4dS-Sw@mail.gmail.com>
 <CAHk-=wj2SW0Zno0Yn=S9wrsmHOKV0FiFPiPS4TM=Gn8yjfYXAg@mail.gmail.com>
 <20190417094637.51ad4c67@mschwideX1> <20190417100244.42e29736@mschwideX1>
 <CAHk-=wj5j-zMo7hVNxiw3+5L2d1WQVm3x4fbpg=OXLzDh8FhYg@mail.gmail.com>
 <20190418100218.0a4afd51@mschwideX1> <CAHk-=whajv8Fw2VcBqZUs0hfx1Dq4fYj3TEEx4yfR3E8+rLS1A@mail.gmail.com>
 <20190418204144.16adf2a0@mschwideX1> <20190419153307.4f2911b5@mschwideX1>
In-Reply-To: <20190419153307.4f2911b5@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Apr 2019 10:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
Message-ID: <CAHk-=wj6yp7hkJ_wR38dhdDRkAHQaEx28v2FkVT9hDFXX_qfjA@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 6:33 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> That problem got stuck in my head and I thought more about it. Why not
> emulate the static folding sequence in the s390 page table code?

So this model seems much closer to what x86 does in its folding, where
the pattern is basically

> static inline pX-1d_t *pXd_offset(pXd_t *pXd, unsigned long address)
> {
>         if (pXd_folded(pXd)
>                 return (pX-1d_t *) pXd;
>         return (pX-1d_t *) pXd_deref(*pXd) + pXd_index(address);
> }

which is really how the code is designed to work (ie the folded entry
doesn't actually do anything to the page directory pointer, it just
says "ok, we'll use this exact page directory pointer for the next
lower level instead".

And that's very much what allows the generic gup code to load the
entry once, and use a temporary, and as you walk down the chain, if it
is folded it just then uses that (previous) temporary value for the
next level instead. IOW, the lower level page table is hidden inside
the upper level one, and folding just means "don't do any offsets,
don't change any values, just use the entry as-is for the next lower
level".

So I think that's the right thing to do.

Looking at the s390 code, it seems to fold things the other way,
conceptually hiding the upper level inside the lower one, and always
doing the offset thing (but just avoiding the dereference).

Maybe there's some reason why the s390 code does it that way, but I
think your new model is the right one, and hopefully means you can use
the generic page table walking more easily.

Of course, the s390 folding is very different from the x86 one (or the
generic fixed 3-level of 4-level cases). The x86 folding doesn't
depend on the contents of the page tables, it's just entirely static
(well, the 5th level is conditional, but it's conditional on a static
key, not on what is in the page tables). So maybe the old model of
s390 made more sense in that context, but I look at your new suggested
pXd_offset() functions and I go "yeah, that's the way it's supposed to
work".

                 Linus
