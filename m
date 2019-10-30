Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC2DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6E42067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfJ3RC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 13:02:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfJ3RC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:02:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A82D6B374;
        Wed, 30 Oct 2019 17:02:26 +0000 (UTC)
Date:   Wed, 30 Oct 2019 18:02:24 +0100
From:   Torsten Duwe <duwe@suse.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        James.Bottomley@hansenpartnership.com, james.morse@arm.com,
        jeyu@kernel.org, jpoimboe@redhat.com, jthierry@redhat.com,
        linux-parisc@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, svens@stackframe.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Message-ID: <20191030170224.GB965@suse.de>
References: <20191029165832.33606-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Whole series, on top of Linus' HEAD 320000e72ec0613e164ce9 (5.4.0-rc5)

[    0.418079] Testing dynamic ftrace: PASSED
[    0.670416] Testing dynamic ftrace ops #1: 
[    0.751367] (1 0 1 0 0) 
[    0.751374] (1 1 2 0 0) 
[    0.857303] (2 1 3 0 281230) 
[    0.857327] (2 2 4 0 281332) PASSED
[    0.930124] Testing dynamic ftrace ops #2: 
[    1.110333] (1 0 1 281189 0) 
[    1.110360] (1 1 2 281329 0) 
[    1.110815] (2 1 3 1 2) 
[    1.110841] (2 2 4 113 114) PASSED
[    1.170653] Testing ftrace recursion: PASSED
[    1.192250] Testing ftrace recursion safe: PASSED
[    1.213819] Testing ftrace regs: PASSED
[    1.235397] Testing tracer nop: PASSED
[    1.235404] Testing tracer wakeup: PASSED
[    1.363921] Testing tracer wakeup_rt: PASSED
[    1.494283] Testing tracer wakeup_dl: PASSED
[    1.623948] Testing tracer function_graph: PASSED

# tracer: function_graph
#
# CPU  DURATION                  FUNCTION CALLS
# |     |   |                     |   |   |   |
 0)               |  wake_up_process() {
 0)               |    try_to_wake_up() {
 0)               |      select_task_rq_fair() {
 0)               |        select_idle_sibling() {
 0)   3.360 us    |          available_idle_cpu();
 0) + 10.940 us   |        }
[...]

The graph tracer is the trickiest part to get working correctly, from my
experience. IOW: everything looks fine.

Whole series,
Tested-by: Torsten Duwe <duwe@suse.de>

	Torsten

