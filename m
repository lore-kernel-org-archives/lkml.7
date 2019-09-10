Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7234C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08221479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfIJR7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:59:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13369 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfIJR7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:59:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A90DA2667D;
        Tue, 10 Sep 2019 17:59:14 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-20.ams2.redhat.com [10.36.112.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EC3660BF3;
        Tue, 10 Sep 2019 17:59:06 +0000 (UTC)
Date:   Tue, 10 Sep 2019 18:58:39 +0100
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v2] fork: check exit_signal passed in clone3() call
Message-ID: <20190910175839.GA27330@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 10 Sep 2019 17:59:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

After some consideration, I've decided to utilise Oleg's proposal[1]
"(args.exit_signal & ~((u64)CSIGNAL))" as a check. I still don't like
it, as it mixes argument copy check (I'm not sure if it's ever needed,
however, as I'm not sure if there's a reason for exit_signal field
of struct kernel_clone_args to have int type) with argument sanity
check; moreover, it covers only clone3 case, and the code in
copy_process is still error-prone in the long run.  Ideally, the check
should be somewhere in the one place, but as of now this one place
is likely _do_fork, but it's kinda weir to have argument check there
as of now.

Changes since v1[2]:
 - Check changed to comparison against negated CSIGNAL to address
   the bug reported by Oleg[3].
 - Added a comment to _do_fork that exit_signal has to be checked
   by the caller.

[1] https://lkml.org/lkml/2019/9/10/581
[2] https://lkml.org/lkml/2019/9/10/411
[3] https://lkml.org/lkml/2019/9/10/467

Eugene Syromiatnikov (1):
  fork: check exit_signal passed in clone3() call

 kernel/fork.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

-- 
2.1.4

