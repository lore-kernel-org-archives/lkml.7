Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CDFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDE02464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CvCXNPNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:01:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfLFMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WDGe9NNIN+jrDK16NuyUHcFjeEvddlNCAaErz6+/soE=; b=CvCXNPNew8FBsA+FN+LYn7os6
        S4tHptRoUEtk+BYeueBh2byPdWt0dwGvEZgXxeACiVl43DV1InEPPGoUg2SccqVlpEVUomRoak//C
        SpxXlxFGoh8RoxbCSBIFmsgSFoI3fhb1jqLryQVl1Ifb96k1EjLmBnDaFoGtlFhpYiQDwNuSJtcBl
        pBgQewubLX+wnBCf2G4z7svyAio8GgHoBETydrnolkYSz6xbAhLp2VYdi3sN+Oojie00IOjFeJNG3
        gTLl8eCSQIsPrItbgjQ1H6sr+/TQPdMl4loFkKfLgV5/Aio2DHV/a46VvqDpHTTTS7ec5gLYic8IM
        FLTmLo6ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idCIg-00039F-NH; Fri, 06 Dec 2019 12:01:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7124E303F45;
        Fri,  6 Dec 2019 13:00:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E270920B83957; Fri,  6 Dec 2019 13:01:31 +0100 (CET)
Date:   Fri, 6 Dec 2019 13:01:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     liu.song11@zte.com.cn
Cc:     fishland@aliyun.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] psi: Only collect online cpu time in collect_percpu_times
Message-ID: <20191206120131.GG2844@hirez.programming.kicks-ass.net>
References: <20191205103329.GH2810@hirez.programming.kicks-ass.net>
 <201912061229281310714@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912061229281310714@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:29:28PM +0800, liu.song11@zte.com.cn wrote:

> >No, the value will not change, but it need not be 0.
> 
> Hi,
> 
> Suppose there are 4 cpu online, then we take cpu 3 offline. In "collect_percpu_times",
> because "for_each_possible_cpu", will still collect the time of cpu 3 which is offline.

Correct, someone needs to collect the last deltas.

> However, it is clear that "nonidle" will remain at 0 until cpu 3 comes online again.

How does it become 0?

Consider

	CPU2		CPU3

			// runs crap, nonidle increases

	// offline CPU3

			// goes offline, nonidle is still >0


At this point someone needs to collect the delta from CPU3 to make it 0.
But if you only iterate online CPUs, that will not happen.

> And the value of "deltas[s]" will not change after collecting CPU 2. In "get_recent_times",
> the value of "groupc->times_prev[aggregator][s]" corresponding to cpu 3 will not change.

They will not change after the first collection after hot-un-plug. You
need at least one collection after it stops running crap.

> This is only a case where one CPU goes offline. If there are multiple CPUs offline,
> it will correspond to more meaningless operations. So here should be changed to
> "for_each_online_cpu", the effect is exactly the same as "for_each_possible_cpu",
> and the possible meaningless processes are excluded.

It is not. Or if it is, you failed to explain who collects on hotplug.
