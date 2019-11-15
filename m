Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF77C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E3A2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="mgHL1adT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfKORDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:03:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42911 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:03:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id m4so8630358qke.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFoRlwDVKq21mj3wCZljPYZAflK9jrHnXeJaUk0Q0qM=;
        b=mgHL1adTKa/qEfHqm030iM9EkOLjZshEI3Z+8bC9tR/VMhvftQVTg2Q6R+wP46Ooka
         Lyklpm371qKZPYXe9dmVCp8DwTEDueQFnRuDu88ZDjwQT8IObINTF/P2ptjqH6RveI6a
         3A7/O+TeNzm7bgfVtppDvt6CPqJiS30N8is4mOJkpOaO/ucvVbySagGdN9uqkN8r2iqA
         8zwdfUuAfUS4w/y7efYU8FPeCCMJKW4PEKHHugmmzcQ5avjtW7p18VgWoEKekLznx6gy
         5cPzIAVDvnQYrvm3h8whetULjlxEGSgS8dWcqwOa4CC0Y+4PFSo21IWGQzD51+DwBwEz
         GnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFoRlwDVKq21mj3wCZljPYZAflK9jrHnXeJaUk0Q0qM=;
        b=j7wRlcpH9adPXvAZggiZdeyTymCS8UF5Sv5Ou6IaOhqUIqCsIcHT38fToOTIHRVMKw
         5sKoQuklDAVIYLCcyqDwXuZNVIGThrkmCjLm2kCJO1oiLoV3xu672yEeTZbO7boX6BJA
         pX3Tr1umyfg07qxO5UDRQm9mM7PPIuPT04uKiLITnO+VUGK4ZOocvKw9ZwXFypeU+Ipq
         fjAPxzBd3Psu43UqdSTKkFoaD0hu0A+SGaxz2pjqcRrDLdbYy5XPNf8XAHQi5pi4iuJb
         +PcZDwb6T3ceVdwa8EmR5SXIdnu+U0ivgINLHQu90IXnRBLCqGmnD6HhgY0Gcz77i4q/
         gPEQ==
X-Gm-Message-State: APjAAAX2EvWyWmX6qsUE2Syzgy45/aywjjjQ5kCfDH96wjF3gJlsvJx0
        /GpPi/0ICuyNXL2+sI1eTY6YSWSiXYguMkUx8HyCHA==
X-Google-Smtp-Source: APXvYqzSiUyJue4q4ZwgFrukwvwEhpZANriBvaS41QgcHeDSU6DbzITxCy01JmMzs4LLSk8OqcfYr06L1P+nrzsTljU=
X-Received: by 2002:a05:620a:7d3:: with SMTP id 19mr13436665qkb.457.1573837398931;
 Fri, 15 Nov 2019 09:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20191112223300.GA17891@debian> <20191113013026.GO8496@sasha-vm> <CAG=yYwnJKcriaHcZFFrznxq1V9-ZcLzC-O=fAhQ6Skmn4eFPAg@mail.gmail.com>
In-Reply-To: <CAG=yYwnJKcriaHcZFFrznxq1V9-ZcLzC-O=fAhQ6Skmn4eFPAg@mail.gmail.com>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Fri, 15 Nov 2019 22:32:41 +0530
Message-ID: <CAG=yYw=N6fRJfsQG08-h5SX1RBqgcZjhCU44e1QFHaJ6_YS_Ng@mail.gmail.com>
Subject: Re: PROBLEM: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com,
        christian@brauner.io, tj@kernel.org, peterz@infradead.org,
        prsood@codeaurora.org, avagin@gmail.com, aarcange@redhat.com,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 3:07 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
>
> On Wed, Nov 13, 2019 at 7:00 AM Sasha Levin <sashal@kernel.org> wrote:
> > Could you bisect it please? I'm not seeing the warning here, and
> > kernel/exit.c wasn't touched during the life of the 5.3 stable tree.
>
>
> I tried  using related to  "git bisect"  and managed to  check based
> on kernel revision related. The warning existed even on 5.3.5 and
> may be even back . i think may be it  is a compiler issue which creates
> the warning and not the kernel.

i saw a link related to our issue:
https://lore.kernel.org/lkml/20170726191008.jk2cdqr4wqnc33es@treble/
please see the above link.





-- 
software engineer
rajagiri school of engineering and technology
