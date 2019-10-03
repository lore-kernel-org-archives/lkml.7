Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD5C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5055220862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P33VuDoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbfJCSGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:06:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbfJCSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WyPRuVAU5nKXtdZnfXrEV/Yh6ZzXoc85gldhc3aCFNI=; b=P33VuDoPb42L4/QiPVmsXeS/G
        +3bGheY/Sn22ZPzTNTT3Nkp8pZ4m8ruzt95pRoiZzZHenNRuwel5FM0O/RTLQ0OHX4t5EzwoK/QhL
        Iw4Odkd1AzUeOy7cmzLdcglIUeBs/dBXTxTpgWZ5pAhlK4hDlYlWLW8+cALuhvXDtb58pDZFuPHS3
        1U7xo0lVDUuJIEEq2eKsX72xgwxsuooZGd/q5fGnnP212jIEuvtARm86PtCHdTWSBmMc3Ic+Xet1W
        kJsr5zpeRnPCBPJOSp0ShE7iG1hQhV+J5/gFGqj5fGnTztCx3Iqn+iAByDHGtz720edoJPsrSY/cf
        hNRkXv53A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iG5Tn-0003ae-Ke; Thu, 03 Oct 2019 18:05:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 674389802BF; Thu,  3 Oct 2019 20:05:28 +0200 (CEST)
Date:   Thu, 3 Oct 2019 20:05:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>, David Howells <dhowells@redhat.com>,
        paulmck@kernel.org, rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Shane M Seymour <shane.seymour@hpe.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH tip/core/rcu 1/9] rcu: Upgrade rcu_swap_protected() to
 rcu_replace()
Message-ID: <20191003180528.GH4643@worktop.programming.kicks-ass.net>
References: <20191003014310.13262-1-paulmck@kernel.org>
 <20191003014153.GA13156@paulmck-ThinkPad-P72>
 <25408.1570091957@warthog.procyon.org.uk>
 <20191003090850.1e2561b3@gandalf.local.home>
 <561448323.948.1570120298211.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561448323.948.1570120298211.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:31:38PM -0400, Mathieu Desnoyers wrote:
> We might want to consider simply using xchg() here.

As stated elsewhere, xchg() is an atomic op with full ordering, IOW it
is stupid expensive for what needs to be done.
