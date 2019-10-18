Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B1CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F6020700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 19:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI5aiYWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443202AbfJRTA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 15:00:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34207 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443193AbfJRTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 15:00:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so6129042oii.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 12:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t99ObJB56KhBS/WNpgsgAnYcJ+G543s7eRggbvF+GSc=;
        b=ZI5aiYWM+xn39N9ZL4bzOc/HegZiWV9I8vBroRd4GUo4BX8a7uWfmvRi1rOlQ0yOrm
         F2179cWsuL18gEZhsafeFRl2Kd1ODlkoge3lflx7dcGTLhP5mUamYddeu5/X3VGr74F9
         VWi93Dqdvc2LrlYCPsfEqE5NP58rgHfjloniDzkqOnOP4qFHLzxyCRYDZeJhxSQ0dQNg
         XzdQ6ua1WZ61PFAu9IJbUwo1iVS70dOWIMPFL7LvxLeUbsw1NOGnUy3xQ+qNVitnWQbW
         tfJfJJ/on8S90wHJ0FlTGGVjqegtf10GO1HyEhdxyJShol9qzaWIQXbdtRMuLFIdRj+G
         bttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t99ObJB56KhBS/WNpgsgAnYcJ+G543s7eRggbvF+GSc=;
        b=oe2Ztf7urwbtUuwGgl8v95e3fiwA5fVYPqZJQcKHPE1O+IT2ZMaMShTd/oTmrffhCJ
         w5qdwVqad9nsJO1wISJkPRCDwPaywjT8XkKnFPVYiLi1EvyTW8/62f40CzIc0mHpguvc
         YAk3JfhzopiL3oPUQ71kNyWXJezzJOyfmsF9JuomBH66bjCv1T8xC5dUkXX7W/uBqJEZ
         Z5jBTIpSWl9ohw/3jvM3Yr+CTn2iQ5G5h1U15pgWzPdI7VfY+dNISQ9DnRP64KidV/mO
         IL0s9rVYJ914XGNVVOd8B29e6CbalVE9xysQWtmQWQTx4CGtKjc89iEDjOWBO0jsTmQN
         fwyg==
X-Gm-Message-State: APjAAAXg4cVYCujszlX28NOcT+VWdVlUCoK6zE7ZZY0CO/Vsk7b3MsyF
        OW8p7yN1Rx095+z961qBXwM=
X-Google-Smtp-Source: APXvYqzCUlmptopKF+iqEPn/QEAG2McNNSZzczXsm6/Z8KP5BPeeLepxWUZOBD8o9+Z2WvXmnnIjSw==
X-Received: by 2002:aca:1b04:: with SMTP id b4mr2309849oib.81.1571425224537;
        Fri, 18 Oct 2019 12:00:24 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id u14sm1745760otj.61.2019.10.18.12.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 12:00:23 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:00:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
Message-ID: <20191018190022.GA1292@ubuntu-m2-xlarge-x86>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
 <20191014025101.18567-4-natechancellor@gmail.com>
 <20191014093501.GE28442@gate.crashing.org>
 <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
 <20191014191141.GK28442@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014191141.GK28442@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 02:11:41PM -0500, Segher Boessenkool wrote:
> On Mon, Oct 14, 2019 at 08:56:12AM -0700, Nick Desaulniers wrote:
> > On Mon, Oct 14, 2019 at 2:35 AM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > On Sun, Oct 13, 2019 at 07:51:01PM -0700, Nathan Chancellor wrote:
> > > > r374662 gives LLVM the ability to convert certain loops into a reference
> > > > to bcmp as an optimization; this breaks prom_init_check.sh:
> > >
> > > When/why does LLVM think this is okay?  This function has been removed
> > > from POSIX over a decade ago (and before that it always was marked as
> > > legacy).
> > 
> > Segher, do you have links for any of the above? If so, that would be
> > helpful to me.
> 
> Sure!
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap03.html
> 
> Older versions are harder to find online, unfortunately.  But there is
> 
> https://kernel.org/pub/linux/docs/man-pages/man-pages-posix/
> 
> in which man3p/bcmp.3p says:
> 
> FUTURE DIRECTIONS
>        This function may be withdrawn in a future version.
> 
> Finally, the Linux man pages say (man bcmp):
> 
> CONFORMING TO
>        4.3BSD.   This  function   is   deprecated   (marked   as   LEGACY   in
>        POSIX.1-2001): use memcmp(3) in new programs.  POSIX.1-2008 removes the
>        specification of bcmp().
> 
> 
> > I'm arguing against certain transforms that assume that
> > one library function is faster than another, when such claims are
> > based on measurements from one stdlib implementation.
> 
> Wow.  The difference between memcmp and bcmp is trivial (just the return
> value is different, and that costs hardly anything to add).  And memcmp
> is guaranteed to exist since C89/C90 at least.
> 
> > The rationale for why it was added was that memcmp takes a measurable
> > amount of time in Google's fleet, and most calls to memcmp don't care
> > about the position of the mismatch; bcmp is lower overhead (or at
> > least for our libc implementation, not sure about others).
> 
> You just have to do the read of the last words you compare as big-endian,
> and then you can just subtract the two words, convert that to "int" (which
> is very inconvenient to do, but hardly expensive), and there you go.
> 
> Or on x86 use the bswap insn, or something like it.
> 
> Or, if you use GCC, it has __builtin_memcmp but also __builtin_memcmp_eq,
> and those are automatically used, too.
> 
> 
> Segher

Just as an FYI, there was some more discussion around the availablity
and use of bcmp in this LLVM bug which spawned
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp").

https://bugs.llvm.org/show_bug.cgi?id=41035#c13

I believe this is the proper solution but I am fine with whatever works,
I just want our CI to be green without any out of tree patches again...

Cheers,
Nathan
