Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FA42081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oNACwLNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbfGYHus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:50:48 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38814 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388335AbfGYHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sSnc4ye50iFzkQA4DuyPd40miDZ+V1ZBX9DZldiUU5Q=; b=oNACwLNE3jGQfX1IdihJRRDJn
        D8Gun0Uj2YNls8hcDAvno931xYpLpH1ymjsikw27SfpLFxqLEPMMUx9eHmOJ3Wd4DEdtqc88VmiXX
        4cf/xaU9EQDve9fXY3qbs8GXt4TZpeDM/UX3MX7VeJXwaMjP+UUPvmy9c12xMp5J8nPxXu2eB1lsX
        slgiQ5eCzEtsWE0CJUm3YNx6RvPAtp1mheGsgIRBs1zArfMPXiaqERvFzRVBAkNUHl8772H9oFAWB
        V7qIWkiMew2Xx3sMJRdAOO/OVH38/Vd8U1VXCtCh33U0KfWvpz16LUcBuzs34awbSbV9qLUIyJDFA
        PwWL+mwxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqYWH-0000eA-NB; Thu, 25 Jul 2019 07:50:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26E15202674D6; Thu, 25 Jul 2019 09:50:31 +0200 (CEST)
Date:   Thu, 25 Jul 2019 09:50:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Yunying Sun <yunying.sun@intel.com>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, hpa@zytor.com, ak@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] perf/x86/intel: Bit 13 is valid for Icelake
 MSR_OFFCORE_RSP_x register
Message-ID: <20190725075031.GG31381@hirez.programming.kicks-ass.net>
References: <20190724073911.12177-1-yunying.sun@intel.com>
 <20190724082932.12833-1-yunying.sun@intel.com>
 <1022fe65-0f9a-52d3-2765-25aa2a326848@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1022fe65-0f9a-52d3-2765-25aa2a326848@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:11:01AM -0400, Liang, Kan wrote:
> 
> 
> On 7/24/2019 4:29 AM, Yunying Sun wrote:
> >  From Intel SDM, bit 13 of Icelake MSR_OFFCORE_RSP_x register is valid for
> > counting hardware generated prefetches of L3 cache. But current bitmasks
> > in driver takes bit 13 as invalid. Here to fix it.
> > 
> > Before:
> > $ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
> >   Performance counter stats for 'sleep 3':
> >     <not supported>      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u
> > 
> > After:
> > $ perf stat -e cpu/event=0xb7,umask=0x1,config1=0x1bfff/u sleep 3
> >   Performance counter stats for 'sleep 3':
> >               9,293      cpu/event=0xb7,umask=0x1,config1=0x1bfff/u
> > 
> > Signed-off-by: Yunying Sun <yunying.sun@intel.com>
> 
> Thanks Yunying.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!
