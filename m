Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A46C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D232154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Rh/Py5iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbfK0VPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:15:36 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44071 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbfK0VPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:15:32 -0500
Received: by mail-qv1-f66.google.com with SMTP id t11so713254qvz.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F99XMPQ3TAH+uV2c/3H52TWBXa+PYGt7dcNa6t/ODb8=;
        b=Rh/Py5iAqTgPLbvtB+41QKoCIj+6ktjR+xDaZrX02/6GEvukEwIP3xD4GWKrP3JKDk
         PPwCUuGOLvKom9XlvMl2aRlAxZcPJh+uOz2LC+iatHYW3hZTCLsLHsPog/4yI/DL6xmR
         /Pi1xqBkEw2DqHAqh30+MSTyc6kwugXvPSlJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F99XMPQ3TAH+uV2c/3H52TWBXa+PYGt7dcNa6t/ODb8=;
        b=s9CXiEIalOa/7mNwzaoEoGMK+iClXhy6fLjWqiuVAOLOdnRPjRJHHMhCOaqVu4a2mO
         NnwcXpcahqRqDoAIVC7fNssAUr+gjYu06K2Z/J2ppH6O9ROud1REzg0Svhf68CjxvYrU
         ZyGGILA4hDY9MURCq4ygrfWFw71cYmMNgo0/hyDffLNF3Hk0H8J+CyyX/WI2Ktu0vvp6
         zPXYlMNIy7vXKx0EVN884I37en6BlaO8HN0C7MQjdumYi6meb7k9twKEVBUJvQdiB9ac
         uwclP1s5NrzTJlqVkSVCN4dwRmyKFuprBL2hCBwFopOZGY74GmhFtT5RqNOEQbEOoYxD
         PWrA==
X-Gm-Message-State: APjAAAWTQNdWZWTpKeXvoHq1ciZquCBLug1rnZw4HZFV86AW3ROLMh6N
        Y8hCZJRsTegzoqhydCO8Qz4aD42khF/NKN7+cmVg7DTUK2k=
X-Google-Smtp-Source: APXvYqx3fiQd2+CRzMpG4FjGt93LDYfrqxQEJovdF6Qh0gxMa602SiiBAJcRm/wKBl5Igo79dHDU0/X2S/hqockFg2o=
X-Received: by 2002:a0c:e408:: with SMTP id o8mr7391529qvl.236.1574889331134;
 Wed, 27 Nov 2019 13:15:31 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
In-Reply-To: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 27 Nov 2019 13:15:20 -0800
Message-ID: <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
Subject: Re: perf is unable to read dward from go programs
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were no response in linux-perf-users@, so I think it's fair to
ask maintainers.

On Fri, Nov 8, 2019 at 3:53 PM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> I have a simple piece of code that burns CPU for 1s:
>
> * https://gist.github.com/bobrik/cf022ff6950d09032fa13a984e2272ed
>
> I can build it just fine: go build -o /tmp/burn burn.go
>
> And I can see correct stacks if I record with fp:
>
> perf record -e cpu-clock -g -F 99 /tmp/burn
>
> But if I record with gwarf:
>
> perf record -e cpu-clock -g -F 99 --call-graph dwarf /tmp/burn
>
> Then stacks are lost with the following complaints during "perf script":
>
> BFD: Dwarf Error: found dwarf version '376', this reader only handles
> version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '31863', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '65271', this reader only
> handles version 2, 3 and 4 information.
> BFD: Dwarf Error: found dwarf version '289', this reader only handles
> version 2, 3 and 4 information.
> ...
>
> That's on Linux 5.4-rc5 with binutils 2.28. On Linux 4.19.80 with
> binutils 2.31.1 I don't see the error, but the stacks are not any
> better:
>
> burn   788  3994.230871:   10101010 cpu-clock:
>           479955 crypto/sha512.blockAVX2+0x965 (/tmp/burn)
>
> burn   786  3994.241393:   10101010 cpu-clock:
>           40b2a7 runtime.mallocgc+0x697 (/tmp/burn)
>
> burn   782  3994.248061:   10101010 cpu-clock:
>           4746f1 crypto/sha512.(*digest).Write+0x21 (/tmp/burn)
>
> Compare to an fp version:
>
> burn   762  3892.587246:   10101010 cpu-clock:
>           479b19 crypto/sha512.blockAVX2+0xb29 (/tmp/burn)
> d186b8c721c0c207 [unknown] ([unknown])
>
> burn   760  3892.597158:   10101010 cpu-clock:
>           474783 crypto/sha512.(*digest).Write+0xb3 (/tmp/burn)
>           474e52 crypto/sha512.(*digest).checkSum+0xd2 (/tmp/burn)
>           4749e3 crypto/sha512.(*digest).Sum+0xa3 (/tmp/burn)
>           4840d3 main.burn+0xe3 (/tmp/burn)
>           483fda main.main+0x2a (/tmp/burn)
>           4298ee runtime.main+0x21e (/tmp/burn)
>       c000016060 [unknown] ([unknown])
> 89481eebc0313474 [unknown] ([unknown])
>
> I can understand AVX being off, but other stacks should be in order.
>
> Interestingly, in production I can see that some binaries are not
> affected by this issue.
>
> Is this an expected outcome?
