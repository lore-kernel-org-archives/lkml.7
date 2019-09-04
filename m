Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEDC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1987208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Upi8+Aiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732481AbfIDRxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:53:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbfIDRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:53:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id q27so16616884lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVuxddaCHhflkbZBXFm+YhEQBdKEAZG3dSIz77MNLHY=;
        b=Upi8+AivAt37q4HoCsU8AGx9KkLPpDqZigfbhcMCSsUPnnLIFN1mj+nTKYsjuL/pXL
         F4xbILdBb2zf4SPo3ummceM6zBpN3c/BDqg8+XoPcJDk91mbV8U7zzZKRLJCTTWKFdN6
         eGcm2F/VYmzFnJKrzFpEwFU9C//AzRySaxyNzDXTpE1KeOQVotT5V+NGG0mcoqZrs5uF
         Mt57goHvTd/Pkmi1Y/hc/HtdKbWivFU1ZqYgl7ccYB3X+cMsoKaINpBr4xZByHm9ZTJs
         kDknNrasUuyTUrMylcWszQvl2BbhtvYBsAAjVCta5JvlDKuH0CKbEzWnUFf458+hk6QH
         eNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVuxddaCHhflkbZBXFm+YhEQBdKEAZG3dSIz77MNLHY=;
        b=DE3Tk2yiJ8JBWRUz0Ho0luqbFkc+Wq0Q9YCKv/TxM9D23d2FA7NsCruRccgGhMb79I
         jWwbRCkfNh+Vkol4PLGRXCVUjXYwkXuHO/xDkO3vsoPc2E16C/fsEsGqLkewt29is/ao
         zRQ929mV/lSVsMz1t9jbeobZNEOpOCSpyaT2ktcEgJtg22m4CaGfAb3GCw8EEXFyWzEZ
         gL3D5elYLSVJpDxS3bNHZFmLAZ58J+DvCQSqmgpvj5V/thtzoi1rVR8c8l5t5lKNxH52
         GIhA/VkfMJwsxbWWNC194ifDyXT1E7a9Zxawh7799he5iHUXJb/gTnpKHiaCXzfK+SNE
         B9XA==
X-Gm-Message-State: APjAAAXb7qcdyuKD06FQAVXHWCjcDT5F5dj5Y702RraJPcBqX+rPwest
        zAFt2bpYTzPS4cnrhJaXJYV0g77eiZ2RA6l95BI=
X-Google-Smtp-Source: APXvYqxI7RDEom+xW8WF2r7OfFUfir8RHeU3Z/r/nPNAUp5MmKDRDBfEykuBTHwRnkxZ7cX01/ZUzlEBsGFd878r/G4=
X-Received: by 2002:ac2:558a:: with SMTP id v10mr3468562lfg.162.1567619629528;
 Wed, 04 Sep 2019 10:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190903154340.860299-1-rkrcmar@redhat.com> <20190903154340.860299-3-rkrcmar@redhat.com>
 <a2924d91-df68-42de-0709-af53649346d5@arm.com> <20190904042310.GA159235@google.com>
 <20190904104332.ogsjtbtuadhsglxh@e107158-lin.cambridge.arm.com>
 <20190904130628.GE144846@google.com> <CAADnVQJzgTRWUAaH+L6qwJvHk0vsLPX3eWdZNUr5X77TuEgvPw@mail.gmail.com>
 <20190904154000.GJ240514@google.com> <CAADnVQK+bSzFdZmgTnDSgibhJ81pR19P6hFArqmZa_xKA1r1VQ@mail.gmail.com>
 <20190904174707.GV2332@hirez.programming.kicks-ass.net>
In-Reply-To: <20190904174707.GV2332@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 4 Sep 2019 10:53:38 -0700
Message-ID: <CAADnVQJFXq0n1J+vFMwhNgGNBYXK+EsFaE_Zebp84wMOLN8TNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=C3=BD?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 04, 2019 at 08:51:21AM -0700, Alexei Starovoitov wrote:
> > Anything in tracing can be deleted.
> > Tracing is about debugging and introspection.
> > When underlying kernel code changes the introspection points change as well.
>
> Right; except when it breaks widely used tools; like say powertop. Been
> there, done that.

powertop was a lesson learned, but it's not a relevant example anymore.
There are more widely used tools today. Like bcc tools.
And bpftrace is quickly gaining momentum and large user base.
bcc tools did break already several times and people fixed them.
