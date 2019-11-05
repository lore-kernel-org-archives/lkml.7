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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4BBC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D03F21D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDXBPXTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389005AbfKENWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:22:32 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33007 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbfKENWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:22:32 -0500
Received: by mail-qk1-f193.google.com with SMTP id 71so21100918qkl.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3P76VWwyyzkMre5YqvpviiNEGEPtbC29s2FU2fEI35o=;
        b=UDXBPXTRyciJeb8UhdLDYWIX+j/I8VjRc+rJ6JLJmPOn9krsbr7FwDABPDxKRWCIxS
         2O2KvPxFsAJathqbJ0sCc8DHLCqh+nPoKGG1Aj9VHU7Te1IrgV7MLzvdobOALQvu/0EU
         aYCXSdRxK5IQZWZ8A0kvRYiQPCuASO+c2aPNNSz2jmXYiCRXW2Z++qivb+BzrRH/P6/0
         YVC3UsIAUP6w+7Ct3jcKWTDkoGz1q5d5pNYOxMScLZ3KbpbtIcZ0RmJMTnVbF/b20LQp
         A+triu/nTf3U6O85Ftlz3iYSN5HbQ5DoR+ML0cVsJLCoyZfjac79k6/7LeB3nhQ7TnsC
         JQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3P76VWwyyzkMre5YqvpviiNEGEPtbC29s2FU2fEI35o=;
        b=Nnh2kFTbiTdlAGm4oWFzFWyqAw9c1njLRIbu3Hb3ZEpc43LoE7c3CQtV622/HuZ9ze
         iGatUfugMx7YMeETqqc1xLYgzPTTTgz9noA4d2rMtuKRAQJY1eBcI9V3fkI2Yr6q8T/d
         3mqqLzkUzuDnST3mWG+ZFmsL/zheBO4INwl0pqpAU2KgKSG404xkX0be2giil+XITuUW
         eE93kds0pMp9geV5T7fFbhUnhuWa4sIcOk7h9YfRgq2zfPcyDi9CP4nQ46AOcNzryhEy
         sSqwX+yHx1H0WCXuASk4SH0BvJiuVjfg7/2Cb51Tq+CkKAOmJZhBmB7bKKNlVHSEFUAn
         tWdg==
X-Gm-Message-State: APjAAAWXOfE75CXEo88P4yMbgU28E1uMLocT239JShsNm+FyZy0O9DLB
        ZvuJM0cb5Bf9On/WYrCcbbTo73Tn
X-Google-Smtp-Source: APXvYqzbHPV883bvTRLnKwk82SspMM2YnbIzBjvXUy7/VgXJxTw3XQEIrAgwL8Y8S4XCJG+bwkxsNQ==
X-Received: by 2002:a37:6087:: with SMTP id u129mr5601953qkb.219.1572960151009;
        Tue, 05 Nov 2019 05:22:31 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 27sm12829167qtu.71.2019.11.05.05.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:22:30 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B1DF40B1D; Tue,  5 Nov 2019 10:22:27 -0300 (-03)
Date:   Tue, 5 Nov 2019 10:22:27 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix time sorting
Message-ID: <20191105132227.GA3636@kernel.org>
References: <20191104232711.16055-1-jolsa@kernel.org>
 <20191105004854.GA25308@tassilo.jf.intel.com>
 <20191105114941.GA4218@kernel.org>
 <20191105124150.GD29390@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105124150.GD29390@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 05, 2019 at 01:41:50PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 05, 2019 at 08:49:41AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Nov 04, 2019 at 04:48:54PM -0800, Andi Kleen escreveu:
> > > On Tue, Nov 05, 2019 at 12:27:11AM +0100, Jiri Olsa wrote:
> > > > The final sort might get confused when the comparison
> > > > is done over bigger numbers than int like for -s time.
> > > > 
> > > > Check following report for longer workloads:
> > > >   $ perf report -s time -F time,overhead --stdio
> > > > 
> > > > Fixing hist_entry__sort to properly return int64_t and
> > > > not possible cut int.
> > > > 
> > > > Cc: Andi Kleen <ak@linux.intel.com>
> > > > Link: http://lkml.kernel.org/n/tip-uetl5z1eszpubzqykvdftaq6@git.kernel.org
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > 
> > > Looks good.
> > > 
> > > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > 
> > Thanks, applied after adding:
> > 
> > Fixes: 043ca389a318 ("perf tools: Use hpp formats to sort final output")
> > Cc: stable@vger.kernel.org # v3.16+
> 
> I was wondering about putting some commit there,
> because it was there for long time.. but that
> commit you use seems to be old enough.. ;-)

Yeah, I think it predates that, but the one I picked should have fixed
that problem, as it was touching these routines, so I thought would be a
good one to stick in a fixes tag :-)

- Arnaldo
 
> thanks,
> jirka

-- 

- Arnaldo
