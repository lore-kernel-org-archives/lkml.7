Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDADC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1B620880
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566031465;
	bh=xnk0foHr5eVzrhf+yc+U9KxGcR81WYz40HGDjrFJXws=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fmV+9a/fBSCegHlsG2lGjPXeGsyKgQHzSKxLMk+SGDeQhZqcbHhMiybVeW0yCpz9H
	 ACOKrrPjmHazNAHv/J06emsU8TrW/Ge8CnEMpAWu4wi1epOULoyrrj8uOQ3eLswVjK
	 vdtgAH38dvWFaDJrQewaUJHmfpuYlFPkIJfX0SMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfHQIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:44:24 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41777 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQIoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:44:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so5640016lfa.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrUwO9RfFpaVVoxhWFOuepL5hpbjdf+YLX/sIn6Qvw8=;
        b=GnMXBzCxRXs0q6nwlVqQCebjZx2tEtjUtn7BBOgwI08iIP8yJTDRYaihakhlVjfsAS
         FhElEv5Vc3dimolG1L91WOW8f5junzLtsfH2N0rKSgMQ2e7ARazvF7A+ilSZWcFl3DF9
         3O0BNELhuHk35WHom64SoyU87zSWfl3gqNq7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrUwO9RfFpaVVoxhWFOuepL5hpbjdf+YLX/sIn6Qvw8=;
        b=UTlTe6oLgEoVmOhvaKM504MQBRaEKdk1JhdC2WgEhA5ph0BEXuUsp4GC5wvhMGkD+P
         SZTelHRFZLI80aRgr5JKBPdqy7SDy6PNXIoCvgD3Oc1rZchKlkIdkVh4a+398vco+JoJ
         Vzw/ua7LWZ3VlPMOrWjbAz/Bxxde+ZhwfeQketNF6XL33EzJYknbP1TOeF29EEgwkrxv
         rWyaaDiDMugw73p4ceIJWZK3FoG+KHjd3rketx2eJqRmsxlMMaZkJBGa3I+tzF+mKqG/
         CsX0Uc3JDb4bkv3mqwewU508Edjm10mXWwgLfQ3fNKl/Nxb59PXw7WpB0IKkkmW0hnsi
         8iTg==
X-Gm-Message-State: APjAAAX0z3Py9ZcqRCtOnwpKOzIj5L8sQciriSCWkQ4QgAKbS90w1fM0
        /RoKN7PlstKIardQNgMSXCs8npGKPMg=
X-Google-Smtp-Source: APXvYqzvVAZ3tj5q3mj41bV4+TBPP4bvUtIXH2lwF/MEXbexwazRUy3qfmFYEHysXXPmVPTft0MFqw==
X-Received: by 2002:a19:4c88:: with SMTP id z130mr7366525lfa.149.1566031461614;
        Sat, 17 Aug 2019 01:44:21 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y66sm1349312lje.61.2019.08.17.01.44.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 01:44:20 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u15so7338049ljl.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 01:44:20 -0700 (PDT)
X-Received: by 2002:a2e:8ed5:: with SMTP id e21mr7751314ljl.156.1566031460440;
 Sat, 17 Aug 2019 01:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com> <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com> <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
In-Reply-To: <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Aug 2019 01:44:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
Message-ID: <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 1:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    unsigned int bits = some_global_value;
>    ...test different bits in in 'bits' ...
>
> can easily cause multiple reads (particularly on a CPU that has a
> "test bits in memory" instruction and a lack of registers.
>
> So then doing it as
>
>    unsigned int bits = READ_ONCE(some_global_value);
>    .. test different bits in 'bits'...

Side note: this is likely the best example of actual WRITE_ONCE() use
too: if you have that global value with multiple bits that actually
have some interdependencies, then doing

    some_global_value = some_complex_expression();

might be reasonably compiled to do several rmw instructions to update
'some_global_value'

So then

   WRITE_ONCE(some_global_value, some_complex_expression());

really can be a good thing - it clearly just writes things once, and
it also documents the whole "write one or the other" value, not some
mid-way one, when you then look at the READ_ONCE() thing.

But I'm seeing a lot of WRITE_ONCE(x, constantvalue) kind of things
and don't seem to find a lot of reason to think that they are any
inherently better than "x = constantvalue".

(In contrast, using "smp_store_release(flag, true)" has inherent
value, because it actually implies a memory barrier wrt previous
writes, in ways that WRITE_ONCE() or a direct assignment does not.)

Ok, enough blathering. I think I've made my point.

              Linus
