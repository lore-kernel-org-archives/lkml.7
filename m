Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9863C00300
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847A22196E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502908AbfIWVAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502897AbfIWVAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B153308FBA9;
        Mon, 23 Sep 2019 21:00:31 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB55194BB;
        Mon, 23 Sep 2019 21:00:24 +0000 (UTC)
Date:   Mon, 23 Sep 2019 17:00:21 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>, linux-audit@redhat.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ntp audit spew.
Message-ID: <20190923210021.5vfc2fo4wopennj5@madcap2.tricolour.ca>
References: <20190923155041.GA14807@codemonkey.org.uk>
 <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 23 Sep 2019 21:00:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-23 12:14, Paul Moore wrote:
> On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
> >
> > I have some hosts that are constantly spewing audit messages like so:
> >
> > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
> > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244

Odd.  It appears these two above should have the same serial number and
should be accompanied by a syscall record.  It appears that it has no
context to update to connect the two records.  Is it possible it is not
being called in a task context?  If that were the case though, I'd
expect audit_dummy_context() to return 1...

Checking audit_enabled should not be necessary but might fix the
problem, but still not explain why we're getting these records.

> > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
> > [48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
> > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
> > [49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
> >
> > This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.
> >
> >
> > Audit isn't even enabled on these machines.
> >
> > # auditctl -l
> > No rules
> 
> [NOTE: added linux-audit to the CC line]
> 
> There is an audit mailing list, please CC it when you have audit
> concerns/questions/etc.
> 
> What happens when you run 'auditctl -a never,task'?  That *should*
> silence those messages as the audit_ntp_log() function has the
> requisite audit_dummy_context() check.  FWIW, this is the distro
> default for many (most? all?) distros; for example, check
> /etc/audit/audit.rules on a stock Fedora system.  A more selective
> configuration could simply exclude the TIME_ADJNTPVAL record (type
> 1333) from the records that the kernel emits.
> 
> We could also add a audit_enabled check at the top of
> audit_ntp_log()/__audit_ntp_log(), but I imagine some of that depends
> on the various security requirements (they can be bizzare and I can't
> say I'm up to date on all those - Steve Grubb should be able to
> comment on that).
> 
> -- 
> paul moore
> www.paul-moore.com
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
