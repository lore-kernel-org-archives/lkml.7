Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6949C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792DD2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570543253;
	bh=z8XVEDscMHzBcI3AQN73/CB4t6GUPrUbP3dBe1p7P78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rpxPx1nkof0mBiTgeV/KiDZUBlh37p9p7OAZKKQQOFWl7LBjtzbECnkTHyugCqZ+S
	 R+3oa1wTVY9wTedtkwBR7Fdnv/GHHC+y8lpGzGfAnJz1GUJqxgoKkKa2vkAzWP5KBy
	 vquWKX/DuXHHf1qYSt5AzZL925Ponj4av5EzfSA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfJHOAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:00:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:51468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJHOAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:00:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D70DB1A9;
        Tue,  8 Oct 2019 14:00:50 +0000 (UTC)
Date:   Tue, 8 Oct 2019 16:00:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Christian Kellner <ckellner@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] pidfd: show pids for nested pid namespaces in fdinfo
Message-ID: <20191008140049.GM6681@dhcp22.suse.cz>
References: <20191008133641.23019-1-ckellner@redhat.com>
 <20191008135258.mzc7o2djiq5yydko@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008135258.mzc7o2djiq5yydko@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 15:52:59, Christian Brauner wrote:
> On Tue, Oct 08, 2019 at 03:36:37PM +0200, Christian Kellner wrote:
> > From: Christian Kellner <christian@kellner.me>
> > 
> > The fdinfo file for a process file descriptor already contains the
> > pid of the process in the callers namespaces. Additionally, if pid
> > namespaces are configured, show the process ids of the process in
> > all nested namespaces in the same format as in the procfs status
> > file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> > of the processes in nested namespaces.
> > 
> > Signed-off-by: Christian Kellner <christian@kellner.me>
> 
> Yeah, makes sense to me.
> Note that if you send the pidfd to a sibling pid namespace NSpid won't
> show you anything useful. But that's what I'd expect security wise. You
> should only be able to snoop on descendant pid namespaces.
> 
> Please add a test for this to verify that this all works correctly and
> then resend. The tests live in tools/testing/selftests/pidfd/ and should
> already have most of the infrastructure there. The fdinfo parsing code
> should be in samples/pidfd/ which
> 
> For the patch itself:
> 
> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> You can resend with my Reviewed-by retained if you don't change
> anything. Before I see tests I'll hold off on merging this. ;)

This is also forming a new user visible "api" right? So the make sure
that linux-api is on the Cc list.

And one minore note. The ifdefery is just ugly, could you just make it a
separate function with ifdef hidden inside?
-- 
Michal Hocko
SUSE Labs
