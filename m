Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E31C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B7220659
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EaRdgeoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfJHOiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:38:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJHOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t3TAGrSwNyqu0l9I73T4aQsF2AAmpzQqRNglFdEZsCU=; b=EaRdgeoaqDDLChlJjTzE4vuQG
        AKmCATMSWrmmdPnwiziN8o9RBYg07Rb+bdWSQzvxUjaJopBPkhE3Qj710TGiakcHplDsK50MK0V+V
        Hm+5XULSfmb8aR0YzfVFLnpZrnrX+9D9VevtGW5ST+Bzcv/W04HuxyW1FJfnnd0AzYlRCSc5k0GnK
        jzw7QvKKaH+c7kkfCzDDFY6ETH0XEuL75gQROcvLpYTSQTRc0fvpnTj1ZW+CnWEzpVaOoz3BFGM7j
        d3Uf/46vonS3/oxpapnttjPhUWLoTQIF4FecO00V14/VkOuvA5uqteA+GSycn77NKmmBriU6fbOse
        VjU5IjX0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHqdY-0007Ki-Hg; Tue, 08 Oct 2019 14:38:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06469305E32;
        Tue,  8 Oct 2019 16:37:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F4162020725A; Tue,  8 Oct 2019 16:38:50 +0200 (CEST)
Date:   Tue, 8 Oct 2019 16:38:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com
Subject: Re: [PATCH 01/10] perf/core, x86: Add PERF_SAMPLE_LBR_TOS
Message-ID: <20191008143850.GB2328@hirez.programming.kicks-ass.net>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
 <20191007175910.2805-2-kan.liang@linux.intel.com>
 <20191008083141.GH2294@hirez.programming.kicks-ass.net>
 <3ac026c3-6b9c-a6c1-2c2b-c7ecdbb22b1d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac026c3-6b9c-a6c1-2c2b-c7ecdbb22b1d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:53:24AM -0400, Liang, Kan wrote:
> 
> 
> On 10/8/2019 4:31 AM, Peter Zijlstra wrote:
> > On Mon, Oct 07, 2019 at 10:59:01AM -0700, kan.liang@linux.intel.com wrote:
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index 61448c19a132..ee9ef0c4cb08 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -100,6 +100,7 @@ struct perf_raw_record {
> > >    */
> > >   struct perf_branch_stack {
> > >   	__u64				nr;
> > > +	__u64				tos;
> > >   	struct perf_branch_entry	entries[0];
> > >   };
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index bb7b271397a6..fe36ebb7dc2e 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -141,8 +141,9 @@ enum perf_event_sample_format {
> > >   	PERF_SAMPLE_TRANSACTION			= 1U << 17,
> > >   	PERF_SAMPLE_REGS_INTR			= 1U << 18,
> > >   	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> > > +	PERF_SAMPLE_LBR_TOS			= 1U << 20,
> > > -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> > > +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
> > >   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
> > >   };
> > > @@ -864,6 +865,7 @@ enum perf_event_type {
> > >   	 *	{ u64			abi; # enum perf_sample_regs_abi
> > >   	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
> > >   	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> > > +	 *	{ u64			tos;} && PERF_SAMPLE_LBR_TOS
> > >   	 * };
> > >   	 */
> > >   	PERF_RECORD_SAMPLE			= 9,
> > 
> > I have problems with the API.. You're introducing the intel specific LBR
> > naming, and adding a whole new sample type vs extending the existing
> > BRANCH_STACK (like you really already do with struct perf_branch_stack). >
> > So why not add a bit to PERF_SAMPLE_BRANCH_* to request the presence of
> > the TOS field in the PERF_SAMPLE_BRANCH_STACK output?
> 
> We never store PERF_SAMPLE_BRANCH_* in a sample. The perf tool cannot tell
> if the sample includes TOS field.

The perf tool bloody sets the perf_event_attr::branch_sample_type value!
Of course it knows to expect the TOS field when it asks for it in the
first place.

> There will be a problem when a new perf tool parsing the data generated by
> an old kernel.

ISTR perf stores the full perf_event_attr in the .data file these days,
and therefore such confusion should never happen.
