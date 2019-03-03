Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10712C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9E420842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551642860;
	bh=DMUtVnodQPgiF0A9LiJYF82TKVeaosUul0i/FIxarXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t26V8WkOX5MdcUUV2MSbQYEJ+wryzTr/FPwc8Q+KiTtcOXANC8to+i7QK9xsLTmZ3
	 JA2+jrbB+uQ+nZeRAVJh6p5bRG1gOXpO7wjN29gb14JkJP0Dw39jYYQq0MEiPjbwJ2
	 0iYEcoLZIz/6aMaHOk6Vs627ICOTk+mk7tMjXGWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfCCTyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 14:54:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46009 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCCTyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 14:54:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id d24so2435001ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MglDEe2SHJdp82PEtdo7wUaR2zOOEwLXh8i1+46F14s=;
        b=NRF+PU227LqLwTMF4ikD+vL3/w9E3CXR6xYQlae3Hc6q+u3WpCQHal0f1Gb62WcMGK
         6SoUTETv1/o4kkptzgG/Tkw8BDbbcKZ05A/3yvuDrrG3YLbHnkl1rqHjoX5JbRmJghHq
         Z4F1mMaU6mP0jl3RWbi+T1UaLH69iK7h2Nywg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MglDEe2SHJdp82PEtdo7wUaR2zOOEwLXh8i1+46F14s=;
        b=PMTt2uz0CqD0/JnhA2902gBe+rdFuN5EUlLm+xbIOT4RdrCP2R/BcIzit227QevZar
         vwWC8wtKzHfDFXr5p+W0TVChknjKH2jMO/GuXlpo7IvidrELDfja6Jodd9REOg8jPAjX
         6p6owpJQtzV7QUM6RF9KJK4IbsNxXiKXSsfTm1BaZ4j56OossI4Yfoddi3cKE1f9FxB3
         tI696Of3axlAgFzThgGZAtUnSkiK8glai6+1w7QQ6tG1HERUt2PMgxtXyUghUGuyIIrC
         iH8OdpqLkCWQ5WbNnzPfByQwF44TPMLDG5+XRGK0LViW8Bq2MqySgYhK3d8f/V0mw1AL
         LClg==
X-Gm-Message-State: APjAAAWlF3BQbibvfVACqrdjzmX+mOUEAfd/rx8zINgt7HjDhOx17Lgl
        IzD4Pukvjat7JBmFQ3J8rLfzGfnw2MA=
X-Google-Smtp-Source: APXvYqzZ7J2et9n/YWw2CNJubaNjqsK0obV+hqNnSQVLUNu2ietRYrr+Riwtj9GhOjfzKuYjIBoO+Q==
X-Received: by 2002:a2e:587:: with SMTP id 129mr8473692ljf.25.1551642856035;
        Sun, 03 Mar 2019 11:54:16 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z7sm1134504ljk.34.2019.03.03.11.54.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 11:54:15 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g80so2448284ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 11:54:14 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr8515432lji.2.1551642854494;
 Sun, 03 Mar 2019 11:54:14 -0800 (PST)
MIME-Version: 1.0
References: <155136980507.2968.15165201054223875356.stgit@devbox> <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
In-Reply-To: <20190303173954.kliegojbuigqi5tn@inn2.lkp.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Mar 2019 11:53:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
Message-ID: <CAHk-=wij8VLupHh1U-fFhFBjin9Fch3mG2_2=aL9h1L+WBvm2g@mail.gmail.com>
Subject: Re: [uaccess] 780464aed0: WARNING:at_arch/x86/include/asm/uaccess.h:#strnlen_user/0x
To:     kernel test robot <lkp@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 9:40 AM kernel test robot <lkp@intel.com> wrote:
>
> commit: 780464aed08ad00aa6d5f81ac8bef2e714dc8b06 ("[PATCH v5 2/6] uaccess: Use user_access_ok() in user_access_begin()")

Hmm. Not an upstream commit ID, so this is presumably a backport.

Ok, let's see what it is using the web link:

> url: https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-probes-uaccess-Add-support-user-space-access/20190303-203749

Yeah, that just gives a github 404 error.

I'm _assuming_ it's the WARN_ON_IN_IRQ() in the access_ok().

Which doesn't much make sense either (why wouldn't it happen in
mainline)? But without a useful web link to see what is actually being
tested, I guess it's not something I can even look at...

                      Linus
