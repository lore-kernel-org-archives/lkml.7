Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD4820815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfJHMgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:36:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfJHMgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 566FC87717;
        Tue,  8 Oct 2019 12:36:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2F4CA60605;
        Tue,  8 Oct 2019 12:36:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  8 Oct 2019 14:36:03 +0200 (CEST)
Date:   Tue, 8 Oct 2019 14:36:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Bruce Ashfield <bruce.ashfield@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
Message-ID: <20191008123601.GA28621@redhat.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com>
 <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com>
 <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
 <20191004000913.GA5519@castle.DHCP.thefacebook.com>
 <CADkTA4OJok3cmYCcDKtxBXQ5xtK1EMujh7_AgLnVaeRr18TH9w@mail.gmail.com>
 <CADkTA4PKc6VEQYvXk4-EWMJPyOrzWQEsk4p6O_BMFo6kvT2jYg@mail.gmail.com>
 <20191007232754.GB11171@tower.DHCP.thefacebook.com>
 <CADkTA4NKDn4jd2BQaGk+JEnM3B5GMDudsBi6V4YwK3Soq9q9pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADkTA4NKDn4jd2BQaGk+JEnM3B5GMDudsBi6V4YwK3Soq9q9pA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Tue, 08 Oct 2019 12:36:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08, Bruce Ashfield wrote:
>
> So I've been looking through the config delta's and late last night, I was
> able to move the runtime back to a failed 4 minute state by adding the
> CONFIG_PREEMPT settings that we have by default in our reference
> kernel.

Aha... Can you try the patch below?

Oleg.

--- x/kernel/signal.c
+++ x/kernel/signal.c
@@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 */
 		preempt_disable();
 		read_unlock(&tasklist_lock);
-		preempt_enable_no_resched();
 		cgroup_enter_frozen();
+		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
 	} else {

