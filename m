Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A82CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B842217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572634150;
	bh=UtotsVrBU3BoxXHlblzEP9xmV6Kfj7U2PcegPJZRp4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d/wnALIzPGdsK7ajIWM+Adw1jv6i+bK2Ub2Bi7vcUEGjn2xTWaL49wNyHUNYYVztN
	 pMe4VX72V5JLlTi8bwDjfbni+5+s/qCB5QAcuElpRMntN0JA7XiMi9QFxaXGJHSXgS
	 lJJUMu18/hdC4+831OxQW8KSDC5BMMKWgMtwV8po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKAStJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:49:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34240 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKAStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:49:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id f5so7937043lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOMWJgPM1rDLmkw/2ygHrVXuEmkEd1D0/JlMXiMe9Cs=;
        b=MAQEB0bjYlwnpicMwJ0hpvQfShzzNnbkhVUWFhCx8LmPdFf1VtrZRsRhYlpBiWxwDU
         6SYl+q81U3u4H3tge2/n+9uInRo/rkB7rpshebRyiFJfKyg3CH5z6P+T82/TjkFdiXOg
         XlHt7lD/HhHCjEU4zEIR0POrtffKJPcsovlxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOMWJgPM1rDLmkw/2ygHrVXuEmkEd1D0/JlMXiMe9Cs=;
        b=QDqMIDNHPeVtwMg3N6DzS5Kww04LIRM9gqCU0MGIdbAUtVWFp8pcnlmhFqxc9RXiIl
         nSz+XOYfWy7TWRbv/FnMeiLM9G7SqYqXDIn5mYslxTREwq5J6/2gl6NHKIikbtRGVVjG
         C8fDDFB4eqEhOhq7srqSJHDrvV3Hi3A5BxulwsG1Xmz5AZoG4WKAEOWGh44y4O9p/52t
         YidPFw+dwpYupq5d8ovlb9lAUs/Laui72zaV7E9lJDrb2ilK5aWiFbBVqEBApanAvnLg
         NXwQoCV0Yk7vubWI+/+2Q9ggDnDoVkXFcZ3QPeLwmDXW6DRggT3utUin4Dj+/Ih56Ewh
         qYfg==
X-Gm-Message-State: APjAAAXr0I2buE8rBk4DRxBTYcsEbDXOADDCXERpV6Ammr0it/C+stDG
        P0VolknfQJEl3fH7GhOCPaDIdeCRzhw=
X-Google-Smtp-Source: APXvYqwrpHGB3yB01adCK+26/1IExWc2YxEY0R5owJL6TxEjXGJ9fuOAGChppOHeZ09Dr7u6rV4F5A==
X-Received: by 2002:a19:40cf:: with SMTP id n198mr8261612lfa.189.1572634146148;
        Fri, 01 Nov 2019 11:49:06 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s27sm3057102lfc.43.2019.11.01.11.49.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2019 11:49:04 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r7so2546531ljg.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:49:04 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr9193922ljd.1.1572634144278;
 Fri, 01 Nov 2019 11:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191101174840.GA81963@gmail.com>
In-Reply-To: <20191101174840.GA81963@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Nov 2019 11:48:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
Message-ID: <CAHk-=wi_VHc=Q2JsPbVmCgpKekNJwnbBiYrmvnSSW8aiAkg7nQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 10:48 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Alexander Shishkin (1):
>       perf/core: Start rejecting the syscall with attr.__reserved_2 set

This seems to quite possibly break existing apps. Is there any reason
to believe that existing users have actually cleared that field?

It's suspect for another reason too: the commit that added that field
just added it to the end of the structure, with the argument that
"aux_watermark will only matter for new AUX-aware code, so the old
code should still be fine".

So by *definition* those old kinds of users would never have cleared
that field, because that field didn't exist.

Honestly, this all shows a worrying complete disregard for backwards
compatibility. Calling this a "fix" is questionable, when it is much
more likely to break some old user.

I've pulled it, but I need people to be aware that this is utter
garbage, and that if anybody ever reports it, this needs to be
immediately reverted.

And the people involved should stop claiming this "fixes" anything,
and should look hard at their random ABI expansions and "fixes".

The original code that said "old users would not be impacted" is
correct. But this "fix" is very very very questionable indeed, and I
get the feeling that somebody doesn't understand what ABI is, when
they claim that this "fixes" anything.

      Linus
