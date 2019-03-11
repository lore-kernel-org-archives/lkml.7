Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B85D206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCKR7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:59:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfCKR7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:59:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D78C230821FF;
        Mon, 11 Mar 2019 17:59:35 +0000 (UTC)
Received: from treble (ovpn-123-151.rdu2.redhat.com [10.10.123.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A54A35C26D;
        Mon, 11 Mar 2019 17:59:31 +0000 (UTC)
Date:   Mon, 11 Mar 2019 12:59:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org, andrew.cooper3@citrix.com
Subject: Re: [PATCH 05/20] x86/uaccess/xen: Suppress SMAP warnings
Message-ID: <20190311175929.zojeczu5m4p2gugy@treble>
References: <20190307114511.870090179@infradead.org>
 <20190307115159.530608243@infradead.org>
 <20190308190038.ehrczmqnoulfkuoe@treble>
 <20190308190333.dba7s7dg2aj2mpr4@treble>
 <20190310131929.GM2482@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190310131929.GM2482@worktop.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 11 Mar 2019 17:59:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 02:19:29PM +0100, Peter Zijlstra wrote:
> On Fri, Mar 08, 2019 at 01:03:34PM -0600, Josh Poimboeuf wrote:
> > On Fri, Mar 08, 2019 at 01:00:38PM -0600, Josh Poimboeuf wrote:
> > > On Thu, Mar 07, 2019 at 12:45:16PM +0100, Peter Zijlstra wrote:
> 
> > > > XXX: arguably we should rename ANNOTATE_NOSPEC_ALTERNATIVE to
> > > >      ANNOTATE_IGNORE_ALTERNATIVE.
> 
> > Also this you could get rid of the comment if there were an
> > ANNOTATE_AC_SAFE macro which does a similar thing.
> 
> How about we just rename the one annotation we have? I figured it was a
> waste of LoC to do yet another annotation that does the very same thing.

I think ANNOTATE_IGNORE_ALTERNATIVE would hurt readability too.  How
about just

  #define ANNOTATE_UACCESS_SAFE ANNOTATE_NOSPEC_ALTERNATIVE

or, make both ANNOTATE_UACCESS_SAFE and ANNOTATE_NOSPEC_ALTERNATIVE
defined to the same OBJTOOL_IGNORE_ALTERNATIVE macro.

-- 
Josh
