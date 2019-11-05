Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4423C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9454721D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 11:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF9B5Ug+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbfKELtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:49:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34002 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfKELtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 06:49:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id h2so15653476qto.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=68rczn7OyxeGKSaq0BpAGwbvXEAyyb5/nH3vd7TkL24=;
        b=fF9B5Ug+LEiBghwJbWUKYZH5v/wjn5XZl8bI6Ec28rgU20Wp1jIxTPH0sYhwUIJxIG
         mr09ysk9ASGmXKcbPyXJKoRbhOJh80u1OldOAiRodeJgBgu6XUUM9KREVvskRQWsdTn3
         bjiiCbDkINUJITw0Gm5AU9RG/zRDRtPn8m46UzH+Xyq4orkW5AzpevsjeDNOM50GvJgN
         c2j5fdwl8vE43koPgnBIENTtPQMM13WoQLKohC9uBJf8ax9np1veFBCCbLik+uQnOdqL
         jFAUgG3CuY8D2Xw4LCzxNnNFl6mgfg0M7jwv3yz5U0ntOwehVxxdLcUWtZ087xlzrOSu
         Pafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=68rczn7OyxeGKSaq0BpAGwbvXEAyyb5/nH3vd7TkL24=;
        b=hdanHihnV370uHfyHYiDTDt5J4mWlDaLhDk8q/g9Ik3fVjBnWG+JNoIJRNgTLaFQoX
         0pw8lkppuIBBjtrtq1R/0vL3gLvDLD2IEu9+dK74qufn8jjyHXIzKLPMmoOB3Bv+V6VN
         +3f33uVyGcv2mPWY723jqLcIywzZVLPkZz36MEmdRbrJrDgvAi0o2EXfJ3cehkbQv80o
         ohmmH32l2EI7XqnfX0rWnAAWlRn5thA2ad20ESHAA+vb4pZUnmdgldlDdAAOeWzFH23w
         a7l+Ygd3n/ZfZPZx2k6Nosg+XTv7SJcMR+iHr+JAD+mAUdEOwl+krIyxI/FwHB2yo+fD
         SnAg==
X-Gm-Message-State: APjAAAU8oWFWGb0oZUVvgDGN1STshsAZ+wMZzcd4gUwwyNmA3TGsyDRb
        +KK6/unvDJS8Jd1yJcF8HfE=
X-Google-Smtp-Source: APXvYqxH1WEYidkETBCbm/fQ7gZNoCjPsB6tqTBw7J+VWS68ZP5aKleKaWuWP2z+6mbDtRcHJVQJow==
X-Received: by 2002:ac8:6ec4:: with SMTP id f4mr17312531qtv.271.1572954584862;
        Tue, 05 Nov 2019 03:49:44 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a18sm10487213qkc.2.2019.11.05.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 03:49:43 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0F41408F8; Tue,  5 Nov 2019 08:49:41 -0300 (-03)
Date:   Tue, 5 Nov 2019 08:49:41 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix time sorting
Message-ID: <20191105114941.GA4218@kernel.org>
References: <20191104232711.16055-1-jolsa@kernel.org>
 <20191105004854.GA25308@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105004854.GA25308@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 04, 2019 at 04:48:54PM -0800, Andi Kleen escreveu:
> On Tue, Nov 05, 2019 at 12:27:11AM +0100, Jiri Olsa wrote:
> > The final sort might get confused when the comparison
> > is done over bigger numbers than int like for -s time.
> > 
> > Check following report for longer workloads:
> >   $ perf report -s time -F time,overhead --stdio
> > 
> > Fixing hist_entry__sort to properly return int64_t and
> > not possible cut int.
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Link: http://lkml.kernel.org/n/tip-uetl5z1eszpubzqykvdftaq6@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Looks good.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied after adding:

Fixes: 043ca389a318 ("perf tools: Use hpp formats to sort final output")
Cc: stable@vger.kernel.org # v3.16+

- Arnaldo
