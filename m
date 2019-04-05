Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A934C10F24
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F95206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfDEQVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:21:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDEQVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:21:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8690F3060498;
        Fri,  5 Apr 2019 16:21:13 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 830FB26546;
        Fri,  5 Apr 2019 16:21:11 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:21:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405162109.4hv6lqpd6manzjju@treble>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 05 Apr 2019 16:21:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:16:14PM +0000, David Laight wrote:
> From: Luis Ressel
> > Sent: 05 April 2019 17:06
> > On Fri, Apr 05, 2019 at 09:39:26AM -0500, Josh Poimboeuf wrote:
> > 
> > > Hm, I would actually argue the reverse.  Warnings are generally bad and
> > > -Werror is useful for ensuring that we don't have any.  For warnings
> > > that don't provide value, we just disable those individual warnings.
> > 
> > Sure, during development it's an excellent idea to investigate compiler
> > warnings, and -Werror can be useful for that. But the Linux kernel is
> > built by countless users in wildly varying environments, and it's almost
> > a given that someone will use a compiler that'll complain about a valid
> > part of your code whose style it considers bad.
> > 
> > As an example, the warning that's breaking the build for me is -Wundef
> > complaining about several "#if UNDEFINED_IDENTIFIER" constructs in the
> > libelf headers. (I agree with gcc in considering this bad style, but
> > it's perfectly valid C, and there probably wasn't a warning about it
> > back when this header was written.)
> 
> In which case you should be looking at a way of removing -Wundef
> not removing -Werror.

Agreed.

> FWIW I had to update libelf.so from version 0.153 to 0.165 in
> order for the amd64 orc unwinder code in objtool to not generate
> corrupt output files.
> That is an Ubuntu 13.04 system - nothing like 10 years old.

Ah.  It would be great if we had a patch to fail the build for old
versions of elfutils-libelf as well.

-- 
Josh
