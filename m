Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8986C10F24
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84932186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfDEQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbfDEQPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:15:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65681C0828B7;
        Fri,  5 Apr 2019 16:15:44 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BCE625D9C4;
        Fri,  5 Apr 2019 16:15:43 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:15:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405161541.6rs7iz4w4dj72azm@treble>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 05 Apr 2019 16:15:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 06:05:50PM +0200, Luis Ressel wrote:
> On Fri, Apr 05, 2019 at 09:39:26AM -0500, Josh Poimboeuf wrote:
> 
> > Hm, I would actually argue the reverse.  Warnings are generally bad and
> > -Werror is useful for ensuring that we don't have any.  For warnings
> > that don't provide value, we just disable those individual warnings.
> 
> Sure, during development it's an excellent idea to investigate compiler
> warnings, and -Werror can be useful for that. But the Linux kernel is
> built by countless users in wildly varying environments, and it's almost
> a given that someone will use a compiler that'll complain about a valid
> part of your code whose style it considers bad.

Maybe so, but objtool only supports two compilers: GCC and clang.  And
only one version of libelf ;-)

> As an example, the warning that's breaking the build for me is -Wundef
> complaining about several "#if UNDEFINED_IDENTIFIER" constructs in the
> libelf headers. (I agree with gcc in considering this bad style, but
> it's perfectly valid C, and there probably wasn't a warning about it
> back when this header was written.)

I consider that a good thing, because I *want* the build to be broken
when somebody uses a bad version of libelf.  A patch to produce a more
useful error message (e.g., "bad version of libelf") would be welcome of
course.

If/when we get to the point where there's a valid use case for warnings
in the objtool build, I would consider this patch.  But we don't seem to
be there yet.

-- 
Josh
