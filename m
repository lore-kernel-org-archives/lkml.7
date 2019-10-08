Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB4820815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfJHNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:53:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfJHNxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:53:03 -0400
Received: from p2e585ebf.dip0.t-ipconnect.de ([46.88.94.191] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHpvA-00053R-Oe; Tue, 08 Oct 2019 13:53:00 +0000
Date:   Tue, 8 Oct 2019 15:52:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <ckellner@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] pidfd: show pids for nested pid namespaces in fdinfo
Message-ID: <20191008135258.mzc7o2djiq5yydko@wittgenstein>
References: <20191008133641.23019-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191008133641.23019-1-ckellner@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 03:36:37PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> The fdinfo file for a process file descriptor already contains the
> pid of the process in the callers namespaces. Additionally, if pid
> namespaces are configured, show the process ids of the process in
> all nested namespaces in the same format as in the procfs status
> file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> of the processes in nested namespaces.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>

Yeah, makes sense to me.
Note that if you send the pidfd to a sibling pid namespace NSpid won't
show you anything useful. But that's what I'd expect security wise. You
should only be able to snoop on descendant pid namespaces.

Please add a test for this to verify that this all works correctly and
then resend. The tests live in tools/testing/selftests/pidfd/ and should
already have most of the infrastructure there. The fdinfo parsing code
should be in samples/pidfd/ which

For the patch itself:

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

You can resend with my Reviewed-by retained if you don't change
anything. Before I see tests I'll hold off on merging this. ;)

Thanks!
Christian
