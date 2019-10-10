Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B7EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A6D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 12:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuXW1Jn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbfJJMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 08:33:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46205 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733010AbfJJMdO (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:33:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id u22so8367594qtq.13
        for <Linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CgEV3AWxKtncF58gsDUOlqYVqqhzG2IkmMWY3vFrELk=;
        b=AuXW1Jn3/VS2HoHeNpY8PnNdsqgwyKlnijaiv+vdWna4Bo3BOy5XfyNjWXrRX9wRt0
         DfFY1Ymno/PHrKy0elxth0gRRRXwigIMCvVHQ8fyjp92hNoPfXVk5Nbmo4r9m26o27+5
         AT/YjDnQNdSVd6MZpTTyuTcEwWR7ZdlnKcH0IB+ODtSP7YCkpI8+caDs9S53p1TfkmAK
         lAn4LNG1+GqLtzi/e6TBm2PV6XO9H5gFfLeNErR7o0GVlTLr+wWFCMXbCWB8nVeR3qZr
         5dfxHhPjSSusqI7frFUYwNyh7WRQnb6/QsDExFScHaZl4f+T4mAqYO/RR+hHEh77xP3S
         ooBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CgEV3AWxKtncF58gsDUOlqYVqqhzG2IkmMWY3vFrELk=;
        b=jMP4/1ww3ZFmUfoUfsL/ec7dA25HuTOoFFAgGJjo+J6n0d5/dkC6ZiPCqvXaS9F9b2
         dfNjeYex97CPZado7vgXAmyjk1kUIC1ea7R6IsO+eSKfjn8u8HiW3cWR5qqmt7cWDHZc
         FuT79AWs1UxFD+Eiz0J1R6+0oHe/2ppjQaUDzBbU/iaDOySOaB2a/Aw2Dvb0H2lxj/KE
         wyz0D5CreNa/5Igo5G1p3Fa6fCySTTqZJap5MvZtFLbhGsU/ob2W8Z8NV3Sbj/Vf+E2j
         /M3AEFk93C5coJWfNWA6/hQLJKWH1nDt4mEFP8iqZRaoqSuc5lg/XM/Xd/ayZ48keB8X
         iyGQ==
X-Gm-Message-State: APjAAAXnCdK5eX9D6DSK0ckSwm1FlzMNxPF5B/PLZZQLEzoD4uUgAFOv
        Cfxsu1ZmrW0S2NqWMoDoOzU=
X-Google-Smtp-Source: APXvYqwB/fHAmpeneAQ04e8YGXE/ODIDsIU73FsL7Mlv1Gw7myqM2ZPVe6nEISZWdAOo5DL3e/b92Q==
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr9344521qvv.41.1570710792739;
        Thu, 10 Oct 2019 05:33:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j7sm3622189qtc.73.2019.10.10.05.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 05:33:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A7F741199; Thu, 10 Oct 2019 09:33:09 -0300 (-03)
Date:   Thu, 10 Oct 2019 09:33:09 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20191010123309.GB19434@kernel.org>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava>
 <20190930182136.GD8560@tassilo.jf.intel.com>
 <20190930192800.GA13904@kernel.org>
 <20191001021755.GF8560@tassilo.jf.intel.com>
 <8a1cbcf6-2de7-3036-1c86-f3af6af077e2@linux.intel.com>
 <20191010080052.GB9616@krava>
 <9df9e60f-4998-32f2-f743-ebb0fdea4c0a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9df9e60f-4998-32f2-f743-ebb0fdea4c0a@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 10, 2019 at 04:33:57PM +0800, Jin, Yao escreveu:
> 
> 
> On 10/10/2019 4:00 PM, Jiri Olsa wrote:
> > On Thu, Oct 10, 2019 at 02:46:36PM +0800, Jin, Yao wrote:
> > > 
> > > 
> > > On 10/1/2019 10:17 AM, Andi Kleen wrote:
> > > > > > I think it's useful. Makes it easy to do kernel/user break downs.
> > > > > > perf record should support the same.
> > > > > 
> > > > > Don't we have this already with:
> > > > > 
> > > > > [root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1
> > > > 
> > > > This only works for simple cases. Try it for --topdown or multiple -M metrics.
> > > > 
> > > > -Andi
> > > > 
> > > 
> > > Hi Arnaldo, Jiri,
> > > 
> > > We think it should be very useful if --all-user / --all-kernel can be
> > > specified together, so that we can get a break down between user and kernel
> > > easily.
> > > 
> > > But yes, the patches for supporting this new semantics is much complicated
> > > than the patch which just follows original perf-record behavior. I fully
> > > understand this concern.
> > > 
> > > So if this new semantics can be accepted, that would be very good. But if
> > > you think the new semantics is too complicated, I'm also fine for posting a
> > > new patch which just follows the perf-record behavior.
> > 
> > I still need to think a bit more about this.. did you consider
> > other options like cloning of the perf_evlist/perf_evsel and
> > changing just the exclude* bits? might be event worse actualy ;-)
> > 
> 
> That should be another approach, but it might be a bit more complicated than
> just appending ":u"/":k" modifiers to the event name string.
> 
> > or maybe if we add modifier we could add extra events/groups
> > within the parser.. like:
> > 
> >    "{cycles,instructions}:A,{cache-misses,cache-references}:A,cycles:A"
> > 
> > but that might be still more complicated then what you did
> > 
> 
> Yes agree.
> 
> > also please add the perf record changes so we have same code
> > and logic for both if we are going to change it
 
> If this new semantics can be accepted, I'd like to add perf record
> supporting as well. :)

Changes in semantics should be avoided, when we add an option already
present in some other tool, we should strive to keep the semantics, so
that people can reuse their knowledge and just switch tools to go from
sampling to counting, say.

So if at all possible, and without having really looked deep in this
specific case, I would prefer that new semantics come with a new syntax,
would that be possible?

- Arnaldo
 
> Another difficulty for the new semantics is we need to create user and
> kernel stat type in runtime_stat rblist (see patch "perf stat: Support
> topdown with --all-kernel/--all-user"). That has to bring extra complexity.
> 
> Thanks
> Jin Yao
> 
> > jirka
> > 

-- 

- Arnaldo
