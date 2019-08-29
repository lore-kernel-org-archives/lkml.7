Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B71FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185AC21874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 22:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567117612;
	bh=vc/qy5Amex2LjORYRLjNMXcqR9OCjl/mCJr5Gd8aIrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZZGPBRUEbye5nEznk0t8yzD8iTcvyKKSBOvwb0YZGbPygqF8J+Ob+aIhUWgeHKc+F
	 3LPJaVGQzjnrEum3DicusqQYmSe0/FKGvQ4dto1xG6C2CpExqYlUnHnuvkLqXqu7S7
	 GKzk7dlz4l5aB96kBPncxgtiVx4QvXUivogBkAXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfH2W0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:26:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45674 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH2W0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:26:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so2874473lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d1p6twckm5kR9a3U7GQAO7MCvELV5xge+cqb1gwqLOM=;
        b=BP0dXFaA/q/Ca532wQCMkOWVtC3hI3Y/vN6Xhquexzk+Pgrk0nN5zqmPLlobZEOOjt
         fk9jlinARLDjdmNvmSuhCPeg4xd68FSGvYf8YzFLW3VsPOrAzVlPcuJBAzZx9BGJyHhx
         fTtuWYtrxkQa/2jDolHGSYFixcTm2WdQdHyqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1p6twckm5kR9a3U7GQAO7MCvELV5xge+cqb1gwqLOM=;
        b=o8qEUTPwrJ4M+PIEeUyPYNpQ2s1TVKE4gTWvtfaVdu3Mf7SdiJh14LVpORw3yI0oU/
         6WPoGme1/gs2Rz8q7S7ng5PZ2eK1vb2rhvjx1+YmxQtLYxw7/fYirFoN08a77u2BqdqP
         TIOXa0gi3Rb/YWC7aK60ghI9sfaoqVT+TamRhRmv9HxC6EO41zsinUlFxr4UUf4IvtMA
         Ml2T4fRCa1pZCki+JKBVriekdFCuRCvyGskdPz4EAUpTr7NvnPgVdfd/mEDTnnkQthek
         G8QCScMDY9/6dA7J8BErGAnYn6vB6PDq+EQVUA6a61pxMQlWqvo4hcr8DMFFHnNvI/qu
         zlKQ==
X-Gm-Message-State: APjAAAWUJbqDX3atH2qs3MQPxHTPe1Y0d24dw9/MCYcUwLxSvkGrtaBB
        iZ07wFf9pDPwxhppJnId276JrxW/J38=
X-Google-Smtp-Source: APXvYqwgQ3sNta+O/v9vmaVQbb/HwwPbMDo4u6YGNr1MqtaxWyJyd6z/BD+3mMIJS/n0m2MjC8c4mg==
X-Received: by 2002:a19:c649:: with SMTP id w70mr7805455lff.33.1567117608194;
        Thu, 29 Aug 2019 15:26:48 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z30sm656630lfj.63.2019.08.29.15.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2019 15:26:47 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id e27so4565286ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 15:26:46 -0700 (PDT)
X-Received: by 2002:a2e:88c7:: with SMTP id a7mr6938647ljk.72.1567117606631;
 Thu, 29 Aug 2019 15:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190827145102.p7lmkpytf3mngxbj@treble> <CAHFW8PRsmmCR6TWoXpQ9gyTA7azX9YOerPErCMggcQX-=fAqng@mail.gmail.com>
 <CAK8P3a2TeaMc_tWzzjuqO-eQjZwJdpbR1yH8yzSQbbVKdWCwSg@mail.gmail.com>
 <20190827192255.wbyn732llzckmqmq@treble> <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble> <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble> <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Aug 2019 15:26:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
Message-ID: <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
Subject: Re: objtool warning "uses BP as a scratch register" with clang-9
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 1:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Maybe we can just pass -fno-builtin-memcpy -fno-builtin-memset
> for clang when CONFIG_KASAN is set and hope for the best?

I really hate how that disables conversions both ways, which is kind
of pointless and wrong.  It's really just "we don't want surprising
memcpy calls for single writes".

Disabling all the *good* "optimize memset/memcpy" cases is really sad.

We actually have a lot of small structures in the kernel on purpose
(often for type safety), and I bet we use memcpy on them on purpose at
times. I'd hate to see that become a function call rather than "copy
two words by hand".

Even for KASAN.

And I guess that when the compiler sees 20+ "set to zero" it's quite
reasonable to say "just turn it into a memset".

So maybe the right thing to do is to just special-case this code, and
hope for the best. If moving the sas_ss_reset() out of the try/catch
thing works, then by all means lets just do that.

(Partly because I've actually wanted to turn the try/catchj thing into
a _real_ try/catch, not a "fall through and check at the end" like it
just happens to be now - the try/catch is actually very misleading as
it is now. So if this is the only case that matters, then...).

                Linus
