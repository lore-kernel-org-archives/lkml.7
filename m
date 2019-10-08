Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A026EC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7423920815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mRfIojx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfJHQeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:34:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfJHQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LxGaMkqOaVvBpkVPmUmLJlqT8yEBVyNhBC4qVA6fBh4=; b=mRfIojx7gWC8lLI7BRQ4v+LXs
        BZ7jrfy0PLhJVKY5bHgHqZXy43Cs4h1nYHSRutRBMouvnPwuF/G75FO+TbUqXeN4ZA3EgzWdUSw9q
        r7L1yCNSUqTmXVUkekaLLP08cnyVyLHzQx5KOZTcW2i2g2ISBMJEhvrp9kC//b3Mj1GeiDyuxFnJt
        l09GKlZUDk1Hk+/risdVcMcnDHIHtBZCNhLe6f1I/x8w94lMejQMc4J0Xp7UFEaW/iSIubxCghtr0
        jNTtrzczk2mQNQT9FGfKAHMeuf7LEV+yGKtCAkerz7mEB35SWK39FGrJAB6TiWXjJehvZHYBXzQID
        WmeKFTBZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHsQx-0000xV-Pe; Tue, 08 Oct 2019 16:33:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56D5A305E1D;
        Tue,  8 Oct 2019 18:33:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEC2420247CA6; Tue,  8 Oct 2019 18:33:57 +0200 (CEST)
Date:   Tue, 8 Oct 2019 18:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Phil Auld <pauld@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
Message-ID: <20191008163357.GF2328@hirez.programming.kicks-ass.net>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <c752dd1a-731e-aae3-6a2c-aecf88901ac0@arm.com>
 <CAKfTPtBQNJfNmBqpuaefsLzsTrGxJ=2bTs+tRdbOAa9J3eKuVw@mail.gmail.com>
 <31cac0c1-98e4-c70e-e156-51a70813beff@arm.com>
 <20191008141642.GQ2294@hirez.programming.kicks-ass.net>
 <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4e29e48-a97c-67e5-a284-6ddc13222c5b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:34:04PM +0100, Valentin Schneider wrote:
> On 08/10/2019 15:16, Peter Zijlstra wrote:
> > On Wed, Oct 02, 2019 at 11:47:59AM +0100, Valentin Schneider wrote:
> > 
> >> Yeah, right shift on signed negative values are implementation defined.
> > 
> > Seriously? Even under -fno-strict-overflow? There is a perfectly
> > sensible operation for signed shift right, this stuff should not be
> > undefined.
> > 
> 
> Mmm good point. I didn't see anything relevant in the description of that
> flag. All my copy of the C99 standard (draft) says at 6.5.7.5 is:
> 
> """
> The result of E1 >> E2 [...] If E1 has a signed type and a negative value,
> the resulting value is implementation-defined.
> """
> 
> Arithmetic shift would make sense, but I think this stems from twos'
> complement not being imposed: 6.2.6.2.2 says sign can be done with
> sign + magnitude, twos complement or ones' complement...

But -fno-strict-overflow mandates 2s complement for all such signed
issues.
