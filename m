Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5B1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8305D207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+omIhKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfCJNTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:19:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfCJNTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jTl7ap6VQEMeV95tnO06X7A0+RAsQ+Eegz0P3fScQA4=; b=n+omIhKiu/25VNWSnBpxUO2Fo
        BA3gZjIhmg28XtfmvqyV+QDB5xebnpP8xkMMqvpUINC5zrZ9L660aiLogVt3QfPF00fffN0GunyVV
        hE6fBhNqOhc0+KBpjOsll8iZ8gsEdXxYphiV+QTUHEEZfURCPJaRoSQuwpyROUEl7N9O+XSOlFNIV
        ofMUlAHWtwYMqJ7prJ7PbUHCokj/lClBX3dotC9VhGGVo3RloXrRzG9PizHmZFZQcl3pjDGldXbam
        W2Q0WpT8s29nariKHdLiyuaIxdSmckUg8MltSMo/mfUwrsEzBPLPELh3OqMrqa/eper0n2I8XCbzz
        QzIaaMsDA==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2yMW-0008BA-EF; Sun, 10 Mar 2019 13:19:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C218F981BBE; Sun, 10 Mar 2019 14:19:29 +0100 (CET)
Date:   Sun, 10 Mar 2019 14:19:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
Message-ID: <20190310131929.GM2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.530608243@infradead.org>
 <20190308190038.ehrczmqnoulfkuoe@treble>
 <20190308190333.dba7s7dg2aj2mpr4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308190333.dba7s7dg2aj2mpr4@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 01:03:34PM -0600, Josh Poimboeuf wrote:
> On Fri, Mar 08, 2019 at 01:00:38PM -0600, Josh Poimboeuf wrote:
> > On Thu, Mar 07, 2019 at 12:45:16PM +0100, Peter Zijlstra wrote:

> > > XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
> > >      ANNOTATE_IGNORE_ALTERNATIVE.

> Also this you could get rid of the comment if there were an
> ANNOTATE_AC_SAFE macro which does a similar thing.

How about we just rename the one annotation we have? I figured it was a
waste of LoC to do yet another annotation that does the very same thing.
