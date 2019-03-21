Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A419C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64BF218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2bvrNzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfCUUHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:07:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfCUUHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3o8rNNR79KjbvJW9ZxtTG+6dKrElMem/IZjqCz79qTA=; b=o2bvrNzy2fHPR5oH5bGdlW3Ra
        DXqtFsHmLFthb4J/kYFs1ndtxMTJlHPeMGZNY5OLMwnyltbDU5iuE7hYfHIkQa6ov4x/kdF520Mek
        c52mrahXr/y/4prwUWOeKqnIE45LDuxpp/BrypWpJ0Df7OJ+zps1LB+eNDL0lts182UZqJKp23+ze
        KdMUkqIIXqKwKGkdoepAkpjQ7i5/XR3yysS7zwqvFuGM3XbD5o/qNNiHX8BL3vRaAKrc0G3u555qu
        RrZnh7wnnKc8TXkoqC3FhUMoPvhG0iwYQr2wHeSqvJ5RxKFtbY/xsEOUHVknD+pgA76/QWTyt6akR
        iEkRYv7tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h73xu-0004yF-DD; Thu, 21 Mar 2019 20:07:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6900A984EEA; Thu, 21 Mar 2019 21:07:00 +0100 (CET)
Date:   Thu, 21 Mar 2019 21:07:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "DSouza, Nelson" <nelson.dsouza@intel.com>
Cc:     Tony Jones <tonyj@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Message-ID: <20190321200700.GD2490@worktop.programming.kicks-ass.net>
References: <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
 <20190321182011.GT5996@hirez.programming.kicks-ass.net>
 <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
 <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A745@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A745@ORSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:47:50PM +0000, DSouza, Nelson wrote:
> Is the request to check whether the msr gets reset to default upon reboot of the machine ?

basically:

 - apply patch
 - start workload with 4 counter (on all CPUs), such that tfa-msr=1
 - try the following:
   o cpu hotplug
   o kexec

to see if the new WARN will trigger -- it should not.
