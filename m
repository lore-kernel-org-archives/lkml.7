Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E07C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A51A20844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUdyA0AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfGHIIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:08:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53176 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfGHIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FUCY1YwB/R6KzNtkKi2x6Os1qnizb1f0SoTtRRtZD2A=; b=SUdyA0AWMY8khw0UPLe6tbgfZ
        eCLU1CRCRERKczG1r8Pia4WtZ72Uuswsu7Yx/4phnU00dlxVjSG1CaFlGX0vZv7Gvo7Y3iZKcDkUk
        B1xSnmvcsHRpj1sFC1hCJ+vfiKui+mYV4kpDeugcVolpiJKOebZP5D6vVBKLZ5gFPqLIxvbUemmoM
        GRKqOqEhxdcGJZUPGRYIh98WfShwAWPGNmJjA+cFpDH77zPwQotm5D3G7Uf4F1RWSpqqUrd0Nfa3J
        34ucxvzP3hlhEBTV/neDtgwyFP3WWENp1N93ifqMS8QUFONHkLcZJ9/i7X0HWzpiP+o6s85sTp0sK
        ohEGj2GDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkOhS-0002sL-HC; Mon, 08 Jul 2019 08:08:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 413C420977821; Mon,  8 Jul 2019 10:08:36 +0200 (CEST)
Date:   Mon, 8 Jul 2019 10:08:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, subhra.mazumdar@oracle.com
Subject: Re: [RFC 0/2] Optimize the idle CPU search
Message-ID: <20190708080836.GW3402@hirez.programming.kicks-ass.net>
References: <20190708045432.18774-1-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708045432.18774-1-parth@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:24:30AM +0530, Parth Shah wrote:
> When searching for an idle_sibling, scheduler first iterates to search for
> an idle core and then for an idle CPU. By maintaining the idle CPU mask
> while iterating through idle cores, we can mark non-idle CPUs for which
> idle CPU search would not have to iterate through again. This is especially
> true in a moderately load system
> 
> Optimize idle CPUs search by marking already found non idle CPUs during
> idle core search. This reduces iteration count when searching for idle
> CPUs, resulting in lower iteration count.

Have you seen these patches:

  https://lkml.kernel.org/r/20180530142236.667774973@infradead.org

I've meant to get back to that, but never quite had the time :/
