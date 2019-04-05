Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59003C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2404921855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfDEOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729641AbfDEOj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:39:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1378AC1306E5;
        Fri,  5 Apr 2019 14:39:29 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB835D9C4;
        Fri,  5 Apr 2019 14:39:28 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:39:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] objtool: Don't use -Werror
Message-ID: <20190405143926.wmrkjsazlheeg6qs@treble>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 05 Apr 2019 14:39:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 04:24:43PM +0200, Luis Ressel wrote:
> On Fri, Apr 05, 2019 at 07:39:09AM -0500, Josh Poimboeuf wrote:
> > What version of libelf are you using?  AFAIK, the non-elfutils version
> > of libelf is buggy and has been unmaintained for 10 years.
> 
> I'm using libelf 0.8.13, which is indeed 10y old, abandoned and rather
> suboptimal (elfutils OTOH is nonportable, and I haven't gotten around
> yet to fixing its incompatibilities with the musl libc).

If you can't use the elfutils version, I'd recommend just disabling all
the features which rely on objtool.  Because some of the libelf-related
bugs I've seen are pretty bad, and we rely on objtool for some pretty
fundamental things like ORC oops stack traces and live patching.

In fact I think we probably need a patch to fail the build if the
10-year-old libelf is used, as I've gotten several bug reports there and
the answer is always the same ("don't use old libelf").

> I can accept that you might not be interested in fixing issues related
> to libelf, but using -Werror is a more general problem which just
> happens to be triggered by my particular setup.

Hm, I would actually argue the reverse.  Warnings are generally bad and
-Werror is useful for ensuring that we don't have any.  For warnings
that don't provide value, we just disable those individual warnings.

-- 
Josh
