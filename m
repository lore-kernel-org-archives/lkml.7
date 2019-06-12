Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD5EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BA020866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2tcCOnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbfFLN3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:29:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44553 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so18451114qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hRmk80uWUR7VrRgMq1qmYqdYni4E52YtJ0uOYQzQzsI=;
        b=o2tcCOnLfRipKMfsLNEjsMiaT8dVezFSqGbDqOcbTJGhy4irVj/rrKeJvAfTt2QUXy
         pPC5NCVFXfyz5uX8nel9gRSGPLhVc9TzsQSRpuGO+GWRoftEl/4Pj0+qOUNaemLuztNd
         LFcctTqAzbBO/WRBOwXD0acnOXPDHWVgHytnc5ibe7zcN8EdnioCVd4mcxtO72adrPkI
         7IGfT1X4hiF+ffLvT/uDoI4FHipVZu3Tgwbr1C/h4yBP4y9ZeBDxXKL+Bc5anMvKJ3/7
         IvuSqIy++VMLkuSZOf6yZhnrfSEwxUSMBTPVszBbkRkcRZbK3OSH/cUBRWjUs1mrUtFQ
         VmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hRmk80uWUR7VrRgMq1qmYqdYni4E52YtJ0uOYQzQzsI=;
        b=V/lIxfJNokdOjwMZXvRISexqY7U7vBE7AjeYe331Ld9+hztoa/LM9DY+Rq1QZX5Je1
         Unmk1Ehb08t+l3SgRI+8GcBcondBU3+8cSNJWAPv1NeOCYPKAKaNKxlgcVMg/+lJJS/W
         9GoKTOHLII9kkzibZe5//Yy+riyiYEBSkU8Gt0kQriTj5ai7aZ9S8aNyMRPkc6ZRVeFA
         8Njz8/6wsHei2vl9f2oUYjy2xuo4eckRjQvx9rI4QoxuULirkDnqzvyFQeuKrEJLeAhl
         GvTJ2RTDeCnVxDq1e2XXC1DEqexuWL3LzwWpnXwilsd/9qGJn/GvUa/VnW6MCz0nPFYG
         DUPg==
X-Gm-Message-State: APjAAAVSmFFtDvnIcqqMEawKSFF84UFMt4iRq2ADWORm5yuKJOJY0sSv
        gAvSqPO4CpBOxlMcWr3KyfM=
X-Google-Smtp-Source: APXvYqyfS1aNYPX0MnuBwFACy4NpEHqjjsfH5U+NmftvCWlWW7ylQZXXidVeCAAc6XljGb9GnYF2BQ==
X-Received: by 2002:aed:3b33:: with SMTP id p48mr63710269qte.143.1560346145378;
        Wed, 12 Jun 2019 06:29:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id x40sm4864089qta.20.2019.06.12.06.29.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:29:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8FA2241149; Wed, 12 Jun 2019 10:28:52 -0300 (-03)
Date:   Wed, 12 Jun 2019 10:28:52 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 01/11] perf intel-pt: Add new packets for PEBS via PT
Message-ID: <20190612132852.GB4836@kernel.org>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
 <20190610072803.10456-2-adrian.hunter@intel.com>
 <20190612000945.GE28689@kernel.org>
 <e0a9a4e9-6c49-ecd1-4729-79002c66fafe@intel.com>
 <20190612124140.GA4836@kernel.org>
 <a3efee50-cf64-d139-237f-b51be8f76f3c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3efee50-cf64-d139-237f-b51be8f76f3c@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 12, 2019 at 03:52:11PM +0300, Adrian Hunter escreveu:
> On 12/06/19 3:41 PM, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 12, 2019 at 08:58:00AM +0300, Adrian Hunter escreveu:
> >> On 12/06/19 3:09 AM, Arnaldo Carvalho de Melo wrote:
> >>> Em Mon, Jun 10, 2019 at 10:27:53AM +0300, Adrian Hunter escreveu:
> >>>> Add 3 new packets to supports PEBS via PT, namely Block Begin Packet (BBP),
> >>>> Block Item Packet (BIP) and Block End Packet (BEP). PEBS data is encoded
> >>>> into multiple BIP packets that come between BBP and BEP. The BEP packet
> >>>> might be associated with a FUP packet. That is indicated by using a
> >>>> separate packet type (INTEL_PT_BEP_IP) similar to other packets types with
> >>>> the _IP suffix.
> >>>>
> >>>> Refer to the Intel SDM for more information about PEBS via PT.
> >>>
> >>> In these cases would be nice to provide an URL and page number, for
> >>> convenience.
> >>
> >> Intel SDM:
> >>
> >> 	https://software.intel.com/en-us/articles/intel-sdm
> >>
> >> May 2019 version: Vol. 3B 18.5.5.2 PEBS output to Intel® Processor Trace
> > 
> > Thanks! I'll add to that cset.
> > 
> > What about the kernel bits?
> 
> Awaiting V2, here is a link to the patches:
> 
> 	https://lore.kernel.org/lkml/20190502105022.15534-1-alexander.shishkin@linux.intel.com/

yeah, I saw those and PeterZ's comments, that is why I asked about them
:-)
 
> There is also still a few more tools changes dependent upon the kernel patches.

But I think I can go ahead and push the decoder bits, when the kernel
patches get merged we'll be almost ready to make full use of what it
provides, right?

- Arnaldo
