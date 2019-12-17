Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFA6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8702053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pxDmp1Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLQUnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:43:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58032 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfLQUnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x+Ec9IqzREstapl5wfLCmCMSJuQOX5mhkRIw0+geHOU=; b=pxDmp1JjioIRcXfSCH15Etec4
        +cjuQDDDffcXwI9/KhhV6cZxqsInpMGtKzV97eDAChbJ3pYZcje9MU1VphOmxcqSuWJzT0H3hfNMs
        jpUxAEk/awz0dCEemy0AhcD5WD6dL4yEKFkjO2Lx+lHzOpRwLfAxInWVglR1LHwMfpzo/Pv5k5F5d
        BYkA/oMVX5hrHZfiXaFp4Y7yi+M5Jyc7qn1mwhIM/R8SX8omFKCFg1Kq39ne1v3leR+G3O8LC/6Si
        Vqo/2eEoSTXCrvt5SXBDZg2N3ENm7Un9Q0FUhm2dkuId2No2VecZfFuL6gen+ueP8lUfTqpLv9s4c
        LKeL4qo1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihJg5-0006CS-UO; Tue, 17 Dec 2019 20:42:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CBFA306BB9;
        Tue, 17 Dec 2019 21:41:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BA462B2CEC3C; Tue, 17 Dec 2019 21:42:44 +0100 (CET)
Date:   Tue, 17 Dec 2019 21:42:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched
 hierarchy
Message-ID: <20191217204244.GJ2844@hirez.programming.kicks-ass.net>
References: <20191204200623.198897-1-joshdon@google.com>
 <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
 <CAKfTPtCJGT0axT5=E=hLWtMav_kLGVFrSvjZS8+cfvjYS72vqQ@mail.gmail.com>
 <CABk29Ntp5eRFn2otK2o5Fe=uYOvKpjHgKRSw0_er45CVC025Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Ntp5eRFn2otK2o5Fe=uYOvKpjHgKRSw0_er45CVC025Pg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:58:28AM -0800, Josh Don wrote:
> > Ingo, Peter, what do you think ?
> 
> I could add the Co-developed-by tag if that would be sufficient here.
> As a side note, I'm also looking at upstreaming our other sched
> fixes/patches, and some of these have the same issue with respect to
> the original author.  How would you prefer I handle these in general?

These internal patches that you have, don't they have a SoB on from the
original author?

Ingo, Greg, how do we handle patches where the original Author has
vanished/left etc and no SoB is present?

Now, in this case we know Venki was with Google in the US, and the US
allows/has copyright assignment to employers and therefore any old SoB
from a Google person should probably be sufficient, but that argument
doesn't work in general (Germany for example doesn't allow copyright
assignment/transfer).
