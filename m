Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B603C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD9B23405
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0yMw1wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfHaUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 16:19:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33160 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfHaUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:19:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so6256496qtd.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 13:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3x/KFNj9Fal2UjxNNlHOLl+MDJOTDJcATH16S/ZkpLw=;
        b=N0yMw1wdINTQ+jVQJvhW5J0PUex4FAzeJTXpw1VEie5ThsWISrbY/uitDy7j2Oe5l7
         ZaZazmBTflE3Nd3/FwjqMHI6w7lAOWzARnXnTRVmPFbx6X0MLMdd8LNyg/yu+C1GvXQr
         Z/1GzIcfTRicUv3r64ahwBixbKDvS3zuI3Tw56LljMsErfTaqhSA7tOdFzPc6/n108VI
         zm6TMszlb7pplzao5Tny+DwwkuJ+OIk18kNtAAO204ujR0VeQGp4z0c9RMTBJx6gW9Lb
         lq6XyHrP6/lDdZPhAwuhVnj7hgtU77IFW3Fz2LH8linjk0HjsTq2X82GNiEWD/hf6Vmx
         Kt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3x/KFNj9Fal2UjxNNlHOLl+MDJOTDJcATH16S/ZkpLw=;
        b=EfeUuq0m+6Db4MVic3zF90S1TfKcGtcEpirlR9OxBBJXKb/3Pge1O50KTVFUSvFNNp
         fitJxdZcNjw5E1gT5FcOTVnnInOu0rwjN7BP/S7p23sX7i5f6ZGzNyINPOXDXuUsDZWZ
         ECAEHjta1MRySqNlbN3v0Cb4Fnlk2l3lj0PEK7wr9LRiVgkFbDtpj/VpoVJqgIgP9cIg
         E3/3plKTLVQDMrcUi0qSDkIM0aTJ5QU/6eTOO05B7vc01H1Jl0whKTMN4afOiGa2TTdc
         liNx6477eEPbD1VQGOUnhPDRD2Y6fvpVFqMbyLtv0dghGLo464m+cuBn6ulZ2MNm8iip
         yjlg==
X-Gm-Message-State: APjAAAXror/+BM3k4uuvBXY7JipHcsUvsWD00iZMhAiUSC4gNpzkiqZb
        x0vjU0tV42ICh0G0rgMmmUYGReMh
X-Google-Smtp-Source: APXvYqxy72+prQOPZ9O56ufZglNEuy5uvR6Bw6TjvIGy1RAFizoyaFovVaKsGv9dJbTrn4fSCODPew==
X-Received: by 2002:ad4:4985:: with SMTP id t5mr13850670qvx.193.1567282775053;
        Sat, 31 Aug 2019 13:19:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o11sm2337538qkm.105.2019.08.31.13.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 13:19:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2581241146; Sat, 31 Aug 2019 17:19:31 -0300 (-03)
Date:   Sat, 31 Aug 2019 17:19:31 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190831201931.GA18202@kernel.org>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <20190830184020.GG28011@kernel.org>
 <20190830190058.GH28011@kernel.org>
 <20190830193109.p7jagidsrahoa4pn@treble>
 <20190830194845.GI28011@kernel.org>
 <20190831105152.bcacc88a7cc760070fc95d98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831105152.bcacc88a7cc760070fc95d98@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 31, 2019 at 10:51:52AM +0900, Masami Hiramatsu escreveu:
> On Fri, 30 Aug 2019 16:48:45 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Fri, Aug 30, 2019 at 02:31:09PM -0500, Josh Poimboeuf escreveu:
> > > On Fri, Aug 30, 2019 at 04:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > I.e. we need to make sure that it always gets the x86 stuff, not
> > > > something that is tied to the host arch, with the patch below we get it
> > > > to work, please take a look.
> > > > 
> > > > Probably this should go to the master copy, i.e. to the kernel sources,
> > > > no?
> 
> Interesting approach. Hmm, but I would like "diff -I" trick just
> for short term solution.

Ok, I'm in a hurry right now, plumbers and all, so I'll just add the
diff -I trick and will have your "I would like that trick" sentence
above as an Acked-by: you, ok?

- Arnaldo
 
> > > > That or we'll have to ask the check-headers.sh and objtool sync-check
> > > > (hey, this should be unified, each project could provide just the list
> > > > of things it uses, but I digress) to ignore those lines...
> > > > 
> > > > I.e. we want to decode intel_PT traces on other arches, ditto for
> > > > CoreSight (not affected here, but similar concept).
> > > > 
> > > > will kick the full container build process now.
> > > 
> > > Interesting, I didn't realize other arches would be using it.  The patch
> > 
> > Yeah, decoding CoreSight (aarch64) hardware traces on x86_64 should be
> > as possible as decoding Intel PT hardware traces on aarch64 :-)
> > 
> > > looks good to me.
> > > 
> > > Ideally there wouldn't be any differences between the headers, but if
> > > that's unavoidable then I guess we can just use the same 'diff -I' trick
> > 
> > I'll go with this now, but...
> > 
> > > we were using before in the check script(s).
> > 
> > Masami? What do you think of applying the patch to the main kernel
> > sources so that building a decoder for x86 on any other arch becomes
> > possible?
> 
> I think the build of kernel and user-space tools are different especially
> for "include/asm", since user-space tools may want to use all architecture
> features, but kernel needs only the architecture which it runs on.
> Maybe we need a special Makefile entries for the modules which depends
> on architecture dependent parts. e.g.
> 
> x86-objs = insn.o inat.o ...
> arm64-objs = coresight.o ...
> 
> and they should have different -I options ('-I arch/x86/include' or 
> '-I arch/arm64/include') for compiling.
> I think this is better and scalable, if you use common (clone) files in
> the kernel tree.
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
