Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6392C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E942133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hBFT4f3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfCSONX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:13:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2sJmba7q2WapxBs3gtHrofvBkiEmpmeNEgHHZpv5OH4=; b=hBFT4f3DlQI212sThLAOZ+uoG
        oRfk8/OTpxfhP2yFdTp0lIEBBGaCmkC14jTVZLv5vyDHveWLKvfYtMAvpK5YKyUzY9FQwsq9eyos1
        ZJZtqec1V9eP12fkSD0gU+y+EAd+8Q1TpCApVCdCkGUtfrXOXCfnFX97wmyJYXeuHgzf1q7h/FSEP
        7Oc7VVf5PZRcej/FV+U+WTLl3LEdFR5q5OfUEt45IcfjshBnVeo95QvU5RZXFUaBUG4Yyxj7hpRCD
        uSBEqDbF0BGdw7VsVKeB38wfXrPZoi8H85lfiJLkM13z2Ej0xKQDALp4ZYupqiK2QllPe/zIsolqw
        b1mi3SvOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6FUU-0005kq-8z; Tue, 19 Mar 2019 14:13:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5E6CB2829E4B2; Tue, 19 Mar 2019 15:13:16 +0100 (CET)
Date:   Tue, 19 Mar 2019 15:13:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 01/22] perf/core: Support outputting registers from a
 separate array
Message-ID: <20190319141316.GH6521@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-2-kan.liang@linux.intel.com>
 <20190319130004.GF5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319130004.GF5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:00:04PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 02:41:23PM -0700, kan.liang@linux.intel.com wrote:

> > @@ -6274,6 +6275,7 @@ void perf_output_sample(struct perf_output_handle *handle,
> >  			u64 mask = event->attr.sample_regs_user;
> >  			perf_output_sample_regs(handle,
> >  						data->regs_user.regs,
> > +						NULL,
> >  						mask);
> >  		}
> >  	}
> > @@ -6306,6 +6308,7 @@ void perf_output_sample(struct perf_output_handle *handle,
> >  
> >  			perf_output_sample_regs(handle,
> >  						data->regs_intr.regs,
> > +						data->extra_regs,
> >  						mask);
> >  		}
> >  	}
> 
> See, I think most of this is completely unnessecary. Both sites pass:
> &perf_regs::regs to perf_output_sample_regs()<-perf_reg_value().
> 
> So all you need to do is add the XMM crud to perf_regs, and use
> container_of() on the pt_regs pointer in perf_reg_value() to get back to
> perf_regs and voila, XMM registers.

Ah, that's not quite true, but I still think you can make something like
that work.
