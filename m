Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2209FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2128208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SS3FHZ6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfFZUBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:01:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47976 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rhSqThBTCa1k8P1tTRPVXVwrdSMZo/v6odhBP0gdvBk=; b=SS3FHZ6u9lz4R2EUrAQpCQI5li
        HrRK43VRWLnnnykP67sWXJbu2X9zYvTA56MH/pJ7XJZ0n54mGXyPkpMNhFhs1iSrlIEosjXe450zW
        BsxLWbz42F0NEACZK6XswOljjcsspH3IbBvEKY5jD+Db4WcVNpe3joe61/YdVmZTU4g9jgz+th7AG
        sRiTg5NK3utvyfH8op3t/sGuPbJ5DIYXhWl4rC8SUTwnXeSvJ6y0K7Hdcq5Wb775sSt0OHgk0RFw5
        OTe5YBzlvOGEnLWzsJW7Vg+4raEhAt7aky5WdGO2rf0g0u53igmF6wg/Owyl6F7WiaHo3BcVPmhNZ
        Eyf3qaeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgE6h-0001Xf-QR; Wed, 26 Jun 2019 20:01:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11FF9209CEDA8; Wed, 26 Jun 2019 22:01:26 +0200 (CEST)
Date:   Wed, 26 Jun 2019 22:01:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kernellwp@gmail.com" <kernellwp@gmail.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: cputime takes cstate into consideration
Message-ID: <20190626200126.GQ3419@hirez.programming.kicks-ass.net>
References: <CANRm+Cyge6viybs63pt7W-cRdntx+wfyOq5EWE2qmEQ71SzMHg@mail.gmail.com>
 <alpine.DEB.2.21.1906261211410.32342@nanos.tec.linutronix.de>
 <20190626145413.GE6753@char.us.oracle.com>
 <20190626161608.GM3419@hirez.programming.kicks-ass.net>
 <20190626183016.GA16439@char.us.oracle.com>
 <alpine.DEB.2.21.1906262038040.32342@nanos.tec.linutronix.de>
 <1561575336.25880.7.camel@amazon.de>
 <20190626192100.GP3419@hirez.programming.kicks-ass.net>
 <1561577254.25880.15.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561577254.25880.15.camel@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 07:27:35PM +0000, Raslan, KarimAllah wrote:
> On Wed, 2019-06-26 at 21:21 +0200, Peter Zijlstra wrote:
> > On Wed, Jun 26, 2019 at 06:55:36PM +0000, Raslan, KarimAllah wrote:
> > 
> > > 
> > > If the host is completely in no_full_hz mode and the pCPU is dedicated to a 
> > > single vCPU/task (and the guest is 100% CPU bound and never exits), you would 
> > > still be ticking in the host once every second for housekeeping, right? Would 
> > > not updating the mwait-time once a second be enough here?
> > 
> > People are trying very hard to get rid of that remnant tick. Lets not
> > add dependencies to it.
> > 
> > IMO this is a really stupid issue, 100% time is correct if the guest
> > does idle in pinned vcpu mode.
> 
> One use case for proper accounting (obviously for a slightly relaxed definition 
> or *proper*) is *external* monitoring of CPU utilization for scaling group
> (i.e. more VMs will be launched when you reach a certain CPU utilization).
> These external monitoring tools needs to account CPU utilization properly.

That's utter nonsense; what's the point of exposing mwait to guests if
you're not doing vcpu pinning. For overloaded guests mwait makes no
sense what so ever.
