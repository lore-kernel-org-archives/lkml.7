Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE082082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDCVAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:00:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCVAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91D96E1F0A;
        Wed,  3 Apr 2019 21:00:45 +0000 (UTC)
Received: from treble (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A712F7FA2E;
        Wed,  3 Apr 2019 21:00:44 +0000 (UTC)
Date:   Wed, 3 Apr 2019 16:00:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [tip:core/objtool 2/25] arch/x86/kernel/dumpstack.o: warning:
 objtool: oops_end() falls through to next function show_regs()
Message-ID: <20190403210042.456ltdto5snznwyf@treble>
References: <201904040103.x1NI0DZi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201904040103.x1NI0DZi%lkp@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 03 Apr 2019 21:00:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:43:05AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/objtool
> head:   64604d54d3115fee89598bfb6d8d2252f8a2d114
> commit: 37686b1353cfc30e127cef811959cdbcd0495d98 [2/25] tracing: Improve "if" macro code generation
> config: x86_64-randconfig-e2-03311307 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 37686b1353cfc30e127cef811959cdbcd0495d98
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/kernel/dumpstack.o: warning: objtool: oops_end() falls through to next function show_regs()

This should be fixed by adding rewind_stack_do_exit() to the objtool
noreturn list.  I'll post a proper patch soon.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 38b0517dc49e..ac743a1d53ab 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -143,6 +143,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"fortify_panic",
 		"usercopy_abort",
 		"machine_real_restart",
+		"rewind_stack_do_exit",
 	};
 
 	if (func->bind == STB_WEAK)
