Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33198C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0336121852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 21:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCVD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGCVD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 17:03:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 530B23001808;
        Wed,  3 Jul 2019 21:03:58 +0000 (UTC)
Received: from treble (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9CC31001925;
        Wed,  3 Jul 2019 21:03:55 +0000 (UTC)
Date:   Wed, 3 Jul 2019 16:03:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jul 2 (objtool)
Message-ID: <20190703210353.ejvwtew3zsl4o3zh@treble>
References: <20190702195158.79aa5517@canb.auug.org.au>
 <b0238309-72b4-1a5c-77ff-89c7e432e2ba@infradead.org>
 <20190703164458.imjawnoczygb2vvd@treble>
 <a3135000-c12d-9800-f58d-eabbfcfa1d3f@infradead.org>
 <20190703194528.7kk7v44whdp7ol5a@treble>
 <20190703194614.6bsyfspnpcf4dhfj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703194614.6bsyfspnpcf4dhfj@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 03 Jul 2019 21:03:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 02:46:14PM -0500, Josh Poimboeuf wrote:
> On Wed, Jul 03, 2019 at 02:45:28PM -0500, Josh Poimboeuf wrote:
> > On Wed, Jul 03, 2019 at 10:23:21AM -0700, Randy Dunlap wrote:
> > > On 7/3/19 9:44 AM, Josh Poimboeuf wrote:
> > > > On Tue, Jul 02, 2019 at 11:47:02AM -0700, Randy Dunlap wrote:
> > > >> On 7/2/19 2:51 AM, Stephen Rothwell wrote:
> > > >>> Hi all,
> > > >>>
> > > >>> Changes since 20190701:
> > > >>>
> > > >>
> > > >> on x86_64:
> > > >>
> > > >> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x22: can't find switch jump table
> > > > 
> > > > I don't see it on current linux-next/master.  Can you share the config
> > > > and .o?
> > > > 
> > > 
> > > This warning happened in 6 of 10 builds for 20190702.
> > > 
> > > Today (20190703) I don't see it at all, but I see this instead:
> > > kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xa3: sibling call from callable instruction with modified stack frame
> > > 
> > > Kernel (rand)config file and .o file for 20190702 are attached.
> > 
> > Thanks, I'm able to recreate the sibling call warning with a randconfig
> > on today's linux-next.
> > 
> > GCC is doing some funky stuff.  With my randconfig, ___bpf_prog_run()
> > has 166 indirect calls to its jump table.  Seems (a bit!) excessive.
> 
> s/calls/jumps/ obviously
> 
> > 
> > I'll need to look into it.

Hm, it looks like disabling CONFIG_RETPOLINE causes GCC to produce
vastly different code here.  Without retpolines, it's not shy at all
about indirect jumps.

-- 
Josh
