Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3ABC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964532178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVPgKi1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfKGPEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:04:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfKGPEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BzPm+y8gqdcfCyLbcdlqhlseD9elHtmAynAOq1Mexo8=; b=rVPgKi1cpg+X6K/+My50HQ1yI
        G82RP+Dxd8ttQcUyfkT/3SehOJI7FpWnjDRDJEkix8VwznbgDAx6+rDa0Wh7PTHOM0bESCzkyzQOQ
        1OJAd57mQPYEZ9LXlxvDf4pikZYwsQmA3sI7YtIu6qfuM0K/Fj42IiubCyI/oSdmXsGqdTgR3Suwk
        fyNb25pcWco+gTpeMUEX+iNMQSrhgBE0beflx+P+hCEj8gmCI3/p45kdW8c5URHGMKXXvPzGPPcMv
        X+3c/MMLrxpJ9rKXAx4OpQC466WAqXOpQNzrFAseHtyFFWdskm+4uI6todiJBjcUQWPaLpERFVvPa
        nv4KsbhXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSjKr-0000Fh-Q5; Thu, 07 Nov 2019 15:04:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A0DF300489;
        Thu,  7 Nov 2019 16:03:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC56D2B219005; Thu,  7 Nov 2019 16:04:31 +0100 (CET)
Date:   Thu, 7 Nov 2019 16:04:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ganapatrao Kulkarni <gklkml16@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH 1/2] perf/core: Adding capability to disable PMUs event
 multiplexing
Message-ID: <20191107150431.GC4114@hirez.programming.kicks-ass.net>
References: <1573002091-9744-1-git-send-email-gkulkarni@marvell.com>
 <1573002091-9744-2-git-send-email-gkulkarni@marvell.com>
 <20191106112810.GA50610@lakrids.cambridge.arm.com>
 <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKTKpr6U8gUp4C9muN2cL4wn33o2LAa5QnTO2MSmfnBz8oUc=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:28:46PM -0800, Ganapatrao Kulkarni wrote:
> Issue happens when the add and del are called too many times as seen
> with 6 event case.
> The PMU hardware control registers are programmed when add and del
> functions are called.
> For pmu->read no issues since no h/w issue with the data path.
> 
> Please suggest me, how can we fix this in back-end PMU driver without
> any perf core help?

As Mark already said, a (much) better description of the actual hardware
fail is required, but one possible solution would be to add a busy spin
delay when writing to the hardware registers.

Something like:

	u64 now, ts = this_cpu_read(tx2_throttle);

	while ((now = cycle_counter()) <= ts)
		cpu_relax();

	write_register(...);

	this_cpu_write(tx2_throttle, now + delay_ns);

Other known tricks include reading the register back until it contains
what you just wrote to it.

But really, first properly describe how your hardware is buggered.
