Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA0FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1254E2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 19:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0VLdoGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfEMTWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 15:22:30 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36198 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfEMTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 15:22:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so8791399qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IDW+SWgrzfGK/r1Yzo1GqZUV1GP7IXHMx2pAT0TmT2A=;
        b=V0VLdoGfA8+Le8QtVVPztvBPfArOhsf3n/jYnA5ijClYwo/oZlXDXNX7p22zS8GUvV
         rRWQzRll5iD/R3O55apvC1gmWIOR7VI3ZDw2QBMXxvm+BR6W2doPqvs/CBrwP9kniZxU
         7jSZV7C+ItEhrHDhAEl96vhYIgPweSPxQnIAM9sg3Awkf2a+NU6joaxNLruhU9GDylR9
         yCseO8UmSNbp7i6dt5DA8ickjzTb1gtSAGvrNkadc41ytLJMorCxzqAH4nzr79272kg4
         o+HB2K+xyWAXiIO/93Rok4XqCtYP4pZlTJloNKTQAVIi+h2YyueWUWjWAD6opBEEUgKx
         a5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IDW+SWgrzfGK/r1Yzo1GqZUV1GP7IXHMx2pAT0TmT2A=;
        b=nOwrI0w45j6X1/QF2csqOMz5C/usXK6r0jo+rM4RM7p/bSh6q0s2nYj68uLvmHm2es
         WDFKzyMfE9tr0DhHsv7BzLWD2fAqcHM+1stSu64ePKVKvfLZtSgpTWrwyl73doXpIqCx
         kpkOxmK/0i/HLWsQOhiPNaBoEyHlj4m5QnCI5gmMJ86ge2sX2DZlInb1OHgPv+U1EihI
         rnILxpHPtZUp9QycEUqJyMg5pVcd+ONxysfCCVPD/XA7B0WAqXOGOQ7ctfEEsSzmhwpK
         CgRauy1vtdc7YrGN5ivv9apHhYBa8rCBZa3boOKXvJe3JPXtU/T0Rvz5shkP/+DlFM5K
         cG9g==
X-Gm-Message-State: APjAAAUEkxzXuCx0ID1Rfa4a1cW4xy7e9L5ds9mFn5Oo49rJyt2DLim+
        9vfF7U90e/h6zi33aM1wpNcb0ORJ
X-Google-Smtp-Source: APXvYqyjtEh7MC0tcRWglH1e/GInuHfPyyU0zwIlKYiS8S3yMc/1yZjGZHLSrv0TpzeN90Fsb0HYwg==
X-Received: by 2002:a37:648d:: with SMTP id y135mr24776857qkb.237.1557775348849;
        Mon, 13 May 2019 12:22:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q2sm2912514qkf.44.2019.05.13.12.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 12:22:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5BC31403AD; Mon, 13 May 2019 16:22:24 -0300 (-03)
Date:   Mon, 13 May 2019 16:22:24 -0300
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf vendor events arm64: Map Brahma-B53 CPUID to
 cortex-a53 events
Message-ID: <20190513192224.GA2470@kernel.org>
References: <20190405165047.15847-1-f.fainelli@gmail.com>
 <20190408162607.GB7872@fuggles.cambridge.arm.com>
 <46ac3066-fa55-9fb8-dd54-32fb702030cb@gmail.com>
 <20190502235725.GB22982@kernel.org>
 <60f367b4-1c5b-0778-eaa6-1a78d58f33a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f367b4-1c5b-0778-eaa6-1a78d58f33a1@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 13, 2019 at 11:04:49AM -0700, Florian Fainelli escreveu:
> On 5/2/19 4:57 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 02, 2019 at 02:28:02PM -0700, Florian Fainelli escreveu:
> >> On 4/8/19 9:26 AM, Will Deacon wrote:
> >>> Acked-by: Will Deacon <will.deacon@arm.com>

> >> Thanks! Can this be picked up?

> > Thanks, applied to perf/core.

> Thanks, I don't seem to be able to find it being pushed out to that tree
> or in linux-next.

What tree? acme/perf/core? That is the one I referred to, have you
looked instead at tip/perf/core? That one still doesn't have it, as I
was in LSFMM/BPF and then vacation and haven't pushed that to Ingo yet,
look at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=c0c410e9c4f36972c393a4cc61368d92feb23d67

I can remove it and wait for your resubmit addressing the issues
discussed in that other message, ok?

- Arnaldo
