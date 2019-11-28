Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6C3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8115E2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQFsxBIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK1PEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:04:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47038 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfK1PEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:04:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so4670593pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvltRS7tnGgvqE3EEZrsHjqMlDwEFz3Z36QQmOc8VO4=;
        b=eQFsxBIUarCvPDsVgl8YZBqZBHcPtzLu4gfzHAnzR8E4QidJvqCV/hAjEINfdkg1my
         t90cdh/1ZrlpqAMzs2gRIpHunaGZEf5G4VmZmdQrRLYQfX7jWi2njqoQ02soPuVvyOnF
         6+bHiNX/B38O+FFEULlf9ysVJLkQgFHW0m6hjIe18a3N8pW+5ssqae0zptT1YF8T5U0b
         1npZXcbR8+QfbH5i+KEiuJycgRN6GHDazUQIp6CqyO5NDskJyjPJdt0mXfHyYEhaP2CY
         y1pjnLJVHsLm9LML4zoZS7bSwnkdYIoTeKJarmecrXWW4vtyGD7bRfKJTL3N5LU6OkmV
         yAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvltRS7tnGgvqE3EEZrsHjqMlDwEFz3Z36QQmOc8VO4=;
        b=T19byT5iOrrRkj785iCQ7kaIUmJohCs30tmRuvu4MWIs5VoiDrwMBd84BNXKXgJxBx
         nX+dEOvA5G+efygV4703nxRCP+1BlaLJpRl+eQN3QmrUaJVR/w5fUBE6tNFDEY/yD/nR
         ZxhSNue/zWDLxAE0Y53G80Ppk7v4Pc/lcQZqz1v/aydQl9xe1o9fweuCFbOSYupiu5IY
         ZXdjPDlTa+R18MSYt4xN4oaDm6Q3ieAc3pRCBi4EqM1KDCqf/FJTXODtK7sRGcvdUoa0
         cbwc2Ukti82wWGZKIAq8Mo9Esp0Wm97uCOuT75E3niWQWh8uo9Zk11CMXLfooOFhn4bw
         cing==
X-Gm-Message-State: APjAAAXLkF2htTBt1YqoheMnFHnXpLEZ2KUZk8QfK/KquhqpRj/ZA8Xv
        y9wJ9qDofti4zzdsgK6x2pU=
X-Google-Smtp-Source: APXvYqy2wECgqwxMxiYVlxFfEQGVKSs38HzHO/yVw4QdxuvoxqQ/jXjFhhwxpH13RAWXmBXB0w/4mQ==
X-Received: by 2002:a63:584a:: with SMTP id i10mr11118565pgm.29.1574953469489;
        Thu, 28 Nov 2019 07:04:29 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id x3sm10979804pjq.10.2019.11.28.07.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Nov 2019 07:04:29 -0800 (PST)
Date:   Thu, 28 Nov 2019 15:04:25 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191128150424.r6zvv3jwlegjkhcb@mail.google.com>
References: <20191126143720.10333-1-changbin.du@gmail.com>
 <87v9r6e6gw.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9r6e6gw.fsf@linux.intel.com>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 12:19:11PM -0800, Andi Kleen wrote:
> Changbin Du <changbin.du@gmail.com> writes:
> 
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> 
> This was already solved in
> 
> commit f78eaef0e0493f6068777a246b9c4d9d5cf2b7aa
> Author: Andi Kleen <ak@linux.intel.com>
> Date:   Fri Nov 21 13:38:00 2014 -0800
> 
>     perf tools: Allow to force redirect pr_debug to stderr.
> 
>     When debugging the tui browser I find it useful to redirect the
>     debug
>         log into a file. Currently it's always forced to the message
>     line.
> 
>     Add an option to force it to stderr. Then it can be easily
>     redirected.
>     
> You can do
> 
> perf report --debug stderr 2> file ...
>
Yes, this is a good alternate approach with existing code. I still think
a new option 'file' is not bad. And later maybe we can ouput debug messages
to file only while errors ouput to both.

> -Andi

-- 
Cheers,
Changbin Du
