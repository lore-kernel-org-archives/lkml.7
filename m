Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3A7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE07208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NCFa6377"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfFQP4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:56:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfFQP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mT2eF7yoMpbGbB1KKfo7CynIiGbmHbqUlQcCS6ws1RI=; b=NCFa6377EW/qugBywRCoVBAfQ
        acgqut1lgAn+r20nUaLx8v5nuBaRoU6EeGM57Vfib2XU13lJhC+hJQWen9owL3HLDmdcmDquMyhYM
        pfB81ZS0drLIcTXzoA6B3wKg+8oYrNeAyLxDW94U3pGeIVt6kbJ74OL1VzIAa4oaNeWZvf+T2o77X
        43iCd+avZVLjZa0ZnycHYYM5oWIyagSAOB40K4eJoEyBUKmgp22P2i7TuY2moH9kxg6RDw7eaqM/I
        XDih3DZ3l6OESu3Ic/pcTvFnoXb5uYM+JUzcDU1YOvI3DuuWqIX1vfD+KCC9S8ei4046MBP6lL8fS
        rSe51LmcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hctz5-0001gi-8N; Mon, 17 Jun 2019 15:55:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B9B7E201F4619; Mon, 17 Jun 2019 17:55:49 +0200 (CEST)
Date:   Mon, 17 Jun 2019 17:55:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 0/6] sched: Add new tracepoints required for EAS
 testing
Message-ID: <20190617155549.GI3436@hirez.programming.kicks-ass.net>
References: <20190604111459.2862-1-qais.yousef@arm.com>
 <20190617125122.ph4wb7mcvfjwpdce@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617125122.ph4wb7mcvfjwpdce@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:51:23PM +0100, Qais Yousef wrote:
> Hi Peter
> 
> On 06/04/19 12:14, Qais Yousef wrote:
> > Changes in v3:
> > 	- Split pelt_rq TP into pelt_cfs, pelt_rq, pelt_dl and pelt_irq
> > 	- Replace the fatty preprocessing wrappers with exported helper
> > 	  functions to access data in unexported structures.
> > 	- Remove the now unnecessary headers that were introduced in the
> > 	  previous versions.
> > 	- Postfix the tracepoints with '_tp' to make them standout more in the
> > 	  code as bare tracepoints with no events associated.
> > 	- Updated the example module in [2]
> > 		- It demonstrates now how to convert the tracepoints into trace
> > 		  events that extend the sched events subsystem in tracefs.
> 
> Does this look okay now? If you have further comments please let me know so
> I can address them in time in hope it'd make it to the next merge window.

Picked them up (with some minor edits). I feel there is far too much
#ifdef in patch #2, but I couldn't quickly come up with anything much
saner either.
