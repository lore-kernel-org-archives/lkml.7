Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18702190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553192766;
	bh=eK4akvv9vfyB6MXmTIHrqSxGeRNEq+WUylHUBdSYnoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CdAwcXDSCIN4mNz9TCnrAxTKCtzY/IqTwF/LvKbQlEyCt9U0MUnBeimc1r5JOSwPM
	 u9a07K6PUVsrUAyKLJjq3tyxSTtncx66m0TYMLl1mKaIwOo+VqaEXCZQc9VcGYAf4O
	 W6R3NLkatco75mV/tCE+UYZcxd9IpHzNl4MATTJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfCUS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:26:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33513 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:26:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id v14so5340219lfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/sLkcWI+IqLXwGA4HB/cfzbCwXsagGZRIuweR3pF7A=;
        b=c2rPAKrTl0hlHQr8vFx67PTDeS9dFqRSaoAVm/ReRBR+qLMD25Lu8M/VCcVWrfwTKP
         NJp+z+1H1MjAMVpV44pMU9+aISZnTWfp3abCJZfwEkbCPn2n+4eTJTSbuBXq2Z77QWv1
         r0ETS0RwMluvuX2IHbWAENC1qTnHpcbxHx/O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/sLkcWI+IqLXwGA4HB/cfzbCwXsagGZRIuweR3pF7A=;
        b=eM4Luq06lk5ATND+g8ajGLmQK43mDfhTQRxtp9VsV+zKhl3RvBw64iY7SqhArXgqFU
         vuO8jgrhl1ZhLSL6xS+Ar02NmPPgyX35plKA68bWmrVIoISLflu3Iv3huXskrJ6aBJ1Q
         Jpmx69sTL44q3PbRk3LycWrjT4266KpwkhE8RpX//FToiGc5rKe45Y/tD+4AhxPoBad/
         x5IYYjJBxzvLxwkfw8M6vEVJ5g+XPXNaGeozczHZyp3dYWDVrfWFdy+ZhBjb6rM3bP/s
         th3PcVKYw/iIAy9jKpftcwOu0p7Vn+sM+cniBE67VLzpELqGYZ29NM1V+eNs7fL66uyE
         YwaA==
X-Gm-Message-State: APjAAAXZWKWBx5bX9gq/2ale2gnN7l5HU62uXpAjh7uvgoApOGj9/sSP
        jufxRXQPTh1k3Z+uXJJYknKgYJLFZmU=
X-Google-Smtp-Source: APXvYqyWdbZwjt6jDO5cnEeuT5VB0QZLJDjGwHl6RvhYGiU77wbAy8uCuy56Izq5vHhHMStCYUkElg==
X-Received: by 2002:a19:48c8:: with SMTP id v191mr2824413lfa.53.1553192762543;
        Thu, 21 Mar 2019 11:26:02 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o25sm980611ljg.76.2019.03.21.11.26.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:26:01 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id y6so6123489ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:26:01 -0700 (PDT)
X-Received: by 2002:a2e:7616:: with SMTP id r22mr2811099ljc.94.1553192760711;
 Thu, 21 Mar 2019 11:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190320221534.165ab87b@oasis.local.home> <20190321083317.GL6058@hirez.programming.kicks-ass.net>
 <20190321090241.GL6521@hirez.programming.kicks-ass.net> <20190321104517.GM6521@hirez.programming.kicks-ass.net>
 <20190321093242.4a948198@gandalf.local.home> <20190321172203.GS5996@hirez.programming.kicks-ass.net>
 <CALCETrXqmjJt7azNoEtxs2eBkDd-vjUAYvrjNh_RD30DAvksBw@mail.gmail.com>
 <CAHk-=whSeiDXVvhie_bBPqDw99JNJMdTuX8ef82BhNanyo7zRw@mail.gmail.com> <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
In-Reply-To: <CALCETrVaCZKjXj9ZqtvQgLk2DqXwNCh7b5DHvSnNAORsqJXCcQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Mar 2019 11:25:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
Message-ID: <CAHk-=wjEHqY1+DxJ-_oNWTuTNQwMPtJKJh_HE=e1F60V+TwUfQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] tracing/x86: Save CR2 before tracing irqsoff on error_entry
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Jan Beulich <jbeulich@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        He Zhe <zhe.he@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I dunno.  Lots of people at least use to have serious commercial interest in it.

Yes, it used to be a big deal. But full virtualization has gotten a
lot more common and better.

> Hey Xen folks, how close are we to being able to say "if you want to
> run a new kernel, you need to switch to PVH or similar"?

I'd also like to know if we could perhaps at least limit PV to just
the thing that people care most deeply about.

For example, maybe people notice that they really deeply care about
the PV spinlocks because they help a lot for some loads, but don't
care so much about the low-level CPU PV stuff any more because modern
CPUs do _those_ things so well these days.

So it might not be an all-or-nothing thing, but a gradual "let's stop
supporting xyz under PV, because it causes pain and isn't worth it".

                Linus
