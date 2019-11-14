Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B2C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01CD2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6k1NDFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNSRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:17:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37210 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so7610569wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoUpilweQjHgtXk5HCyiVUUZulfkmQsEgCa5inFkUPc=;
        b=g6k1NDFAmLpSetMfOjhmZXPxuvchvPIgccZyzCAGLxTznMScmQMHI4nGDaCDxrO0Wg
         4aUzCj+8EXOZrSSVf4VQPVSTZ9OSWMg6OBPFTmDLf5iwQLXYyVH35p8u8DYdbL7n/J/X
         MM32/C5SwGBPvk5OfqJU47bOF5dGXwUBomcgIvt7h3aUFHR17rPMYiPoCvcm6vyfxzTo
         pft2cQQdkED5fuzJDGhM/gjd3+lavfYio1Zc0jlmYKl6Spdxn0FFCvdX8Y2jgq0Z+fs+
         zBzYVcZort8+wOasrfxTFHagUTnnppMpVR4nAZcZNXiarqg/KkaaWzan/lXS2mHTzxKK
         nsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoUpilweQjHgtXk5HCyiVUUZulfkmQsEgCa5inFkUPc=;
        b=gMMcEeh2IaFmlf8kqWum3YiK4DHQUj4iJh5csOy0T5SKYW31OJt+kQJ88clgM1Obu1
         l2FXt+tZff+aGpV/8ivnGJIpb8+zMlEKrCJUJwpRBb02E7akqfxJAVSEMEkEoUD0VLfI
         d5oW/lFocKi5GuPv3LmAza+Vgy6Mu+5WdcuPt+Vc41motyax5yqqcFdVeQsVcsgm8kGA
         Si8rolWvjA3WqLSFV1VFW1QsXEHT5KjltQ32fY406+lJMdvVX6DdGOdZskoIithUJhGe
         J27AnKevh1BHm/KEFHWOIaKZjNcvHHC6+ydwrXwn91J8yFRHpqqJeQ2Scd+FZNZmrGx1
         hszA==
X-Gm-Message-State: APjAAAWCn0yMSveFcIySQlHQVQxTovhvx5Kag18NHtbhpW4yF95hGZSa
        5oDr6J0++v47ssmNHcYv/ZjVWs+WF9rGHhs0G/08xQ==
X-Google-Smtp-Source: APXvYqzICnXzXYbCXP+hgq76DeS4is37c5xkVLtYubnoj9SiNC0fuwyMbwcWvqCbZcFPI1skMD3nuOBOxmBBQXtXbZM=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr9461275wrr.174.1573755433567;
 Thu, 14 Nov 2019 10:17:13 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com> <20191114104525.GU4131@hirez.programming.kicks-ass.net>
In-Reply-To: <20191114104525.GU4131@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 Nov 2019 10:17:01 -0800
Message-ID: <CAP-5=fU9b-qTH=whjfpkPjnUJQQTmtjZ3GFT5zYEnJ69gGO4+Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Optimize cgroup context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:45 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Nov 13, 2019 at 04:30:32PM -0800, Ian Rogers wrote:
> > Avoid iterating over all per-CPU events during cgroup changing context
> > switches by organizing events by cgroup.
>
> When last we spoke (Plumbers in Lisbon) you mentioned that this
> optimization was yielding far less than expected. You had graphs showing
> how the use of cgroups impacted event scheduling time and how this patch
> set only reduced that a little.
>
> Any update on all that? There seems to be a conspicuous lack of such
> data here.

I'm working on giving an update on the numbers but I suspect they are
better than I'd measured ahead of LPC due to a bug in a script.

Thanks,
Ian
