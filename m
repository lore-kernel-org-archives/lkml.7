Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E547C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B42339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD3qjdxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfH2Njx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:39:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfH2Njx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:39:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3so1594309pgv.13;
        Thu, 29 Aug 2019 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QBCu5sQIYdsoPcHK5OZLgBPhFRcWyhNkit9YUb5Xfp4=;
        b=vD3qjdxgKZqv0+6BaaTxzCMp5GBt9ZpIE4Xbj9WaeysBRf9xzdbxNprqNtfFFTBbJ2
         +VH0LVDm6xgCj9DPdlVmOJaAUln8mpDLHhYu8vSxxnEB/WjCxxNuD7TfudDMU6jFZnhq
         QAp8atzvyTtypWR0UjAHLB25c1lJR5xBu9D/ZbQT94s/02P6ks0cQTeevsSwy8ftefvH
         6ICKsGMYhoIgHYF9tcWuBJqMbc3OIsDkvwPKjzASa6sBpYZJukCTlA9S778JpDR6GaKi
         +dSzbQ+QFM/ehyJfbhMTmAB1vEuBIaT2q4OFUrDNCO7Bnexx5G0376QYIg5Zd3A3CKPF
         EUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QBCu5sQIYdsoPcHK5OZLgBPhFRcWyhNkit9YUb5Xfp4=;
        b=HfGWhZRquPlwo0ocv60SHiGHaJv9QoHEAdnuVCX2JLoKiEw7Mdb3KCf73XZe3XO5SJ
         7DYHufyonUvuLW4YNgiP05LRxlErhIjLXX1D8hLs3xXuvzeAxp41b9fgSW8waTsolbzP
         eHUMA2NUXkLMCCFVZ9nukOwI2ELaHTV3ojdJdodeRarcYHCl8rU1dvsi3sbserCWGrGN
         7F1V82RoY1Tks1zvaYNGcdqd9r4IIpCdOcW/JhlkpDhN8ocrpJUDMQhhA4gGK/eMh2d8
         avmXyjBFAUDPvMQZQJzuXsOm/ir2NyU1mo/v8T53+ofwv5rDXh6+/WIPGvM/EIst+T9x
         eI6A==
X-Gm-Message-State: APjAAAXa4epWe6azuXX8xFuMgbhFw208EJKEjIiTrCgGV3u0al39UZTc
        +0kAdBBXbhmO9ym4ajBhHWLlvqIZqux5EOgcr/U=
X-Google-Smtp-Source: APXvYqzoOeXzNgUc23d/Hv1FLph/A7y/pStlOwKAjGLGD8szmTgfyaUQUJmHkcxWd7YOv4S/2h1dFtAMyPoYH0GS+Y8=
X-Received: by 2002:a63:c842:: with SMTP id l2mr6954366pgi.4.1567085992394;
 Thu, 29 Aug 2019 06:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
In-Reply-To: <20190827211244.7210-1-uwe@kleine-koenig.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Aug 2019 16:39:41 +0300
Message-ID: <CAHp75VehRSKj7SiWhZfVQVG70g=j9G5E1LDao6Pft9Jh4+SqCA@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Enrico@kleine-koenig.org, Weigelt@kleine-koenig.org,
        metux IT consult <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 12:14 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.o=
rg> wrote:
>
> The new format specifier %dE introduced with this patch pretty-prints
> the typical negative error values. So
>
>         pr_info("probing failed (%dE)\n", ret);
>
> yields
>
>         probing failed (EIO)
>
> if ret holds -EIO. This is easier to understand than the for now common
>
>         probing failed (-5)
>
> (which used %d instead of %dE) for kernel developers who don't know the
> numbers by heart, The error names are also known and understood by
> userspace coders as they match the values the errno variable can have.
> Also to debug the sitation that resulted in the above message very
> probably involves EIO, so the message already gives the string to look
> out for.
>
> glibc (and other libc variants)'s printf have a similar feature: %m
> expands to strerror(errno). I preferred using %dE however because %m in
> userspace doesn't consume an argument (which is however necessary in the
> kernel as there is no global errno variable). Also this is handled
> correctly by the compiler's format string checker as there is a matching
> int variable for the %d the compiler notices.
>
> There are quite some code locations that could be adapted to benefit
> from this:
>
>         $ git grep -E '^\s*(printk|(kv?as|sn?|vs(c?n)?)printf|(kvm|dev|pr=
)_(emerg|alert|crit|err|warn(ing)?|notice|info|cont|devel|debug|dbg))\(.*(\=
(%d\)|: %d)\\n' v5.3-rc5 | wc -l
>         9141
>
> I expect there are some false negatives where the match is distributed
> over two or more lines and so isn't found.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
> ---
> Hello,
>
> in v1 I handled both positive and negative errors which was challenged.
> I decided to drop that and only handle the (common) negative values.
> Readding handling of positive values later is easier than dropping it.
>
> Sergey Senozhatsky and Enrico Weigelt suggested to use strerror as name
> for the function that I called errno2errstr. (In v1 it was not a
> separate function). I didn't pick this up because the semantic of
> strerror in userspace is different. It returns something like
> "Interrupted system call" while errno2errstr only yields "EINTR".
>
> I dropped EWOULDBLOCK from the list of codes as it is on all Linux archs
> identical to EAGAIN and the way the lookup works now breaks otherwise.
> (And having it wasn't useful already in v1.)
>
> Rasmus Villemoes pointed out that the way I wrote the resulting string
> to the buffer was broken. This is fixed according to his suggestion by
> using string_nocheck(). I also added a test to lib/test_printf.c as he
> requested.
>
> Petr Mladek had some concerns:
> > The array is long, created by cpu&paste, the index of each code
> > is not obvious.
>
> Yeah right, the array is long. This cannot really be changed because we
> have that many error codes. I don't understand your concern about the
> index not being obvious. The array was just a list of (number, string)
> pairs where the position in the array didn't have any semantic.
>
> I agree it would be nice to have only one place that has a collection of
> error codes. I thought about reorganizing how the error constants are
> defined, i.e. doing something like:
>
>         DEFINE_ERROR(EIO, 5, "I/O error")
>
> but I don't see a possibility to let this expand to
>
>         #define EIO 5
>
> without resorting to another macro language. If that were possible the
> list of DEFINE_ERRORs could be reused to help generating the code for
> errno2errstr. So if you have a good idea, please speak up.
>
> > There are ideas to make the code even more tricky to reduce
> > the size, keep it fast.
>
> I think Enrico Weigelt's suggestion to use a case is the best
> performance-wise so that's what I picked up. Also I hope that
> performance isn't that important because the need to print an error
> should not be so common that it really hurts in production.
>
> > Both, %dE modifier and the output format (ECODE) is non-standard.
>
> Yeah, obviously right. The problem is that the new modifier does
> something that wasn't implemented before, so it cannot match any
> standard. %pI is only known on Linux either, so I think being
> non-standard is a weak argument. For user consumption it would be nice
> if we'd get
>
>         probing failed (I/O Error)
>
> from pr_info("probing failed (%dE)\n", -EIO); but that would be still
> more expensive because the collection of string constants would become
> bigger that it is already now and "EIO" is the right one to search for
> when debugging the underlaying problem. So I think "EIO" is even more
> useful than "I/O Error".
>
> > Upper letters gain a lot of attention. But the error code is
> > only helper information. Also many error codes are misleading because
> > they are used either wrongly or there was no better available.
>
> This isn't really an argument against the patch I think. Sure, if a
> function returned (say) EIO while ETIMEOUT would be better, my patch
> doesn't improve that detail. Still
>
>         mydev: Failed to initialize blablub: EIO
>
> is more expressive than
>
>         mydev: Failed to initialize blablub: -5
>
> . With "EIO" in the message it is not worse than with "-5" independant of=
 the
> question if EIO is the right error code used.
>
> > There is no proof that this approach would be widely acceptable for
> > subsystem maintainers. Some might not like mass and "blind" code
> > changes. Some might not like the output at all.
>
> I don't intend to mass convert existing code. I would restrict myself to
> updating the documentation and then maybe send a patch per subsystem as a=
n
> example to let maintainers know and judge for themselves if they like it =
or
> not. And if it doesn't get picked up, we can just remove the feature agai=
n next
> year (or so).
>
> I dropped the example conversion, I think the idea should be clear now
> even without an explicit example.
>

Hold on, can you in less than 20 words put WHY this is needed?

--=20
With Best Regards,
Andy Shevchenko
