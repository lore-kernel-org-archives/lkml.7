Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474D7C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B9822449
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hicbRw4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSWdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:33:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46354 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:33:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id h15so19435478qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUxu2E7yq8HSrGs2Snujibznuu5fJg9NwhoB4yurP9Q=;
        b=hicbRw4ECbje8ifkawEBY07FlCN/R/GSwaaNqRGapBb55gyvgYQVB9OQZ4SSqJO7WY
         KI7Ovv1jE3DIaSMUg8u8ERgbQy9Ia+DTZFznqWNnnxFYinUfmVb/rn6Rli1cqN/YpktO
         v9K0CwxaoH99zTDVGsKPkfX1A/uUNVJ2PfizWAdm1jZvddalzAtV0eBDTK9NPue7k5q5
         sFtoDIRI2fjcCVoi9bBpaa29LiRSvR8AGeMq5x6rU2QrID1uUhLW+nr+HHS/oCWB/EfA
         /c7P++NJXeeCD0IlKOMwhqU7gughRpjf+36ivMzT5JWgFjS+Jefimad7C4Gw24wv8KaS
         mfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUxu2E7yq8HSrGs2Snujibznuu5fJg9NwhoB4yurP9Q=;
        b=RTt2ZdtebJjJFJSQnLi4Itx3dI3d4U3s9itZDNTZ9IRnkjAg/gFqkucCgSg1idDvEb
         KzPK+PvLPC/X6ae3yHsi9a2CXipVpzZlx+BXX1sZv70wNLi70tVl2WYaxAHnRZtNtNHR
         z8AB90S4a0uDJ292GFfSkZbb/JmJh9kzmJmGhteMKsyMac7lukUhpWSXjh29Sp/6zdYq
         XsKW8EzPPwjePMVRLh256GsRAOLjmDZOVnu9rs1r7cO5+OfsyjU0FQGzx8gBx66PwXGY
         iLG1rXxrsBWwBxulpEXDE4SBLfGe2/rYHI7K8hJLVRUpG1//RkJnogM163zHM+foyC/y
         cK/w==
X-Gm-Message-State: APjAAAV352QLICoQowOSWGKu2ZcX/gtYmiHJoxNzjXu09TOVsnTsA4K9
        MBDVis6zNflXYDCTeTbTvbs=
X-Google-Smtp-Source: APXvYqz+sVKpodZPVT0Im/7azy2x7ohAJLBdyBT+eiJxUCFQWKhKPlLBqgwQyHNuYJOxi/O1GqgXUw==
X-Received: by 2002:a37:a211:: with SMTP id l17mr30134923qke.139.1574202795667;
        Tue, 19 Nov 2019 14:33:15 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id a6sm12906431qth.74.2019.11.19.14.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:33:14 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 02DB140D3E; Tue, 19 Nov 2019 19:33:11 -0300 (-03)
Date:   Tue, 19 Nov 2019 19:33:11 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
Message-ID: <20191119223311.GD24290@kernel.org>
References: <cf782c34-f3f8-2f9f-d6ab-145cee0d5322@linux.intel.com>
 <20191119200510.GA7364@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119200510.GA7364@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 19, 2019 at 09:05:10PM +0100, Jiri Olsa escreveu:
> On Mon, Nov 18, 2019 at 05:21:03PM +0300, Alexey Budankov wrote:
> > 
> > Avoid termination of trace loading in case the last record in
> > the decompressed buffer partly resides in the following
> > mmaped PERF_RECORD_COMPRESSED record. In this case NULL value
> > returned by fetch_mmaped_event() means to proceed to the next
> > mmaped record then decompress it and load compressed events.
> > 
> > The issue can be reproduced like this:
> > 
> >   $ perf record -z -- some_long_running_workload
> >   $ perf report --stdio -vv
> >   decomp (B): 44519 to 163000
> >   decomp (B): 48119 to 174800
> >   decomp (B): 65527 to 131072
> >   fetch_mmaped_event: head=0x1ffe0 event->header_size=0x28, mmap_size=0x20000: fuzzed perf.data?
> >   Error:
> >   failed to process sample
> >   ...
> > 
> > Testing:
> > 
> >   71: Zstd perf.data compression/decompression              : Ok
> > 
> >   $ tools/perf/perf report -vv --stdio
> >   decomp (B): 59593 to 262160
> >   decomp (B): 4438 to 16512
> >   decomp (B): 285 to 880
> >   Looking at the vmlinux_path (8 entries long)
> >   Using vmlinux for symbols
> >   decomp (B): 57474 to 261248
> >   prefetch_event: head=0x3fc78 event->header_size=0x28, mmap_size=0x3fc80: fuzzed or compressed perf.data?
> >   decomp (B): 25 to 32
> >   decomp (B): 52 to 120
> >   ...
> > 
> > Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> > Link: https://marc.info/?l=linux-kernel&m=156580812427554&w=2
> > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
 
> thanks,
> jirka

-- 

- Arnaldo
