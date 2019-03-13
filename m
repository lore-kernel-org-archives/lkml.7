Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A941C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF8D2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCMQv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfCMQv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:51:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E73C92087C;
        Wed, 13 Mar 2019 16:51:26 +0000 (UTC)
Date:   Wed, 13 Mar 2019 12:51:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190313125125.1a1fb2f3@gandalf.local.home>
In-Reply-To: <20190313155155.GN13351@linux.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
        <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
        <20190311133939.GA29747@google.com>
        <20190311222903.GR13351@linux.ibm.com>
        <20190312150514.GB249405@google.com>
        <20190312152034.GZ13351@linux.ibm.com>
        <20190313150948.GA84821@google.com>
        <20190313112726.01d974fc@gandalf.local.home>
        <20190313155155.GN13351@linux.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 08:51:55 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> Does this mean that there is a better approach that Joel's suggestion?
> I believe he would end up with something like this:
> 
> 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && !in_irq());
> 
> It would be nice if there is something like this:
> 
> 	lockdep_assert_in_irq_handler();
> 
> But I haven't seen this.  (Not that I have looked particularly hard for
> such a thing, mind you!)

That would be trivial to implement:

#define lockdep_assert_in_irq() do {
		WARN_ON(debug_locks && !current->hardirq_context);
	} while (0)

-- Steve
