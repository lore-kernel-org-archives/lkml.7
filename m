Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6840C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7762320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYRHGnDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfFGItd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:49:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38238 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfFGItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:49:33 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so1556606itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=adnKoWQTMzO2+3oj6bzIQQSJxMqy6PQK9AaINLk4VKk=;
        b=fYRHGnDBC83ZNMfN01VXg8LH+MDfZ2+Mrl7HGcO/O0vYbnZ6xMKpuM3zSUENZko1o3
         2j8a16D64nA8xzTKEwIBH/5oo0qfrFzjWrnMIGJZu8P0N3Rnqg3Hfjwdus2b8hdwaXKW
         CQa8oRnRTooeVogOV9B6hmD1BL9+bUMH/rksuw9AoLdZgllJXQDP/I4WjKS3FBBPFy9B
         8mzVB1VgTRZXF6SiF61kXAdkjnFD8Ejy4XeWG5f9Yq+s9gmeoDHfJ2SOUvxhB6e25YE4
         9jXKe3Cbo5CBp6bJLSPMS9cKfzvwlnIbmrva6BrwqX+NqGZg0RCCUKxlbvUCaeJDi6+9
         XcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=adnKoWQTMzO2+3oj6bzIQQSJxMqy6PQK9AaINLk4VKk=;
        b=Ury2NRjv56K2rUonWLslJb7L71TrQsrwTSQULwoFOj0vYz3/+KgjQUIb1tueS1Zu2N
         bZLSOcbNDN3pWqhEgt3ySyg5H7QID0x0g7G1/bRVgv5btA/8E5llfjUah6edVO0fdw3R
         BRvCQp301bAkgGTwhXY3gcTLv9+zGoiCbF2aQwOfMc2/SMeU16kf4gMI9kzxZ8Ngj3d7
         2sgB68KQBk1tCUh4B/wZzXYN8bNA3eh21Tlak2q6dJV6Kv4KFOdgbDw5sD70nI1al1Ju
         gkneJOwdew22UYqowVBEVUYbUeE+Rjf1ITUbZYoMEM4M86MQwi5Oere1ZSHQhD/ROEZx
         iXWA==
X-Gm-Message-State: APjAAAVhY2nGEcAa1Lm3jGvHyheP3qDy4y5hCzIRZMdG6rIXoBPoX/ll
        fd4r6ttvEVMA+5BDBxSmFn2Ox53Jgu2UmI3DuRmjBWu0SIA19g==
X-Google-Smtp-Source: APXvYqyO8g27gbZ/n5zmlwXplxQ6DyFH8ip6uXzyHI+o1yCx3Wapw0TWmXNpP3u8qN2VsWZcoB8baklytZ7g7GG1fLM=
X-Received: by 2002:a02:b01c:: with SMTP id p28mr34991386jah.130.1559897372103;
 Fri, 07 Jun 2019 01:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190605130753.327195108@infradead.org> <20190605131945.125037517@infradead.org>
 <DD54886F-77C6-4230-A711-BF10DD44C52C@vmware.com> <20190607082851.GV3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190607082851.GV3419@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 7 Jun 2019 10:49:18 +0200
Message-ID: <CAKv+Gu-rsZ2UsyEHbsZcSv9VVnFBqG70q+vk6thgMGFBi+vLSA@mail.gmail.com>
Subject: Re: [PATCH 10/15] static_call: Add basic static call infrastructure
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 10:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 06, 2019 at 10:44:23PM +0000, Nadav Amit wrote:
> > > + * Usage example:
> > > + *
> > > + *   # Start with the following functions (with identical prototypes=
):
> > > + *   int func_a(int arg1, int arg2);
> > > + *   int func_b(int arg1, int arg2);
> > > + *
> > > + *   # Define a 'my_key' reference, associated with func_a() by defa=
ult
> > > + *   DEFINE_STATIC_CALL(my_key, func_a);
> > > + *
> > > + *   # Call func_a()
> > > + *   static_call(my_key, arg1, arg2);
> > > + *
> > > + *   # Update 'my_key' to point to func_b()
> > > + *   static_call_update(my_key, func_b);
> > > + *
> > > + *   # Call func_b()
> > > + *   static_call(my_key, arg1, arg2);
> >
> > I think that this calling interface is not very intuitive.
>
> Yeah, it is somewhat unfortunate..
>

Another thing I brought up at the time is that it would be useful to
have the ability to 'reset' a static call to its default target. E.g.,
for crypto modules that implement an accelerated version of a library
interface, removing the module should revert those call sites back to
the original target, without putting a disproportionate burden on the
module itself to implement the logic to support this.


> > I understand that
> > the macros/objtool cannot allow the calling interface to be completely
> > transparent (as compiler plugin could). But, can the macros be used to
> > paste the key with the =E2=80=9Cstatic_call=E2=80=9D? I think that havi=
ng something like:
> >
> >   static_call__func(arg1, arg2)
> >
> > Is more readable than
> >
> >   static_call(func, arg1, arg2)
>
> Doesn't really make it much better for me; I think I'd prefer to switch
> to the GCC plugin scheme over this.  ISTR there being some propotypes
> there, but I couldn't quickly locate them.
>

I implemented the GCC plugin here

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=3Dsta=
tic-calls

but IIRC, all it does is annotate call sites exactly how objtool does it.

> > > +}
> > > +
> > > +#define static_call_update(key, func)                               =
       \
> > > +({                                                                 \
> > > +   BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));       \
> > > +   __static_call_update(&key, func);                               \
> > > +})
> >
> > Is this safe against concurrent module removal?
>
> It is for CONFIG_MODULE=3Dn :-)
