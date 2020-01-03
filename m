Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C64C3276F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746C921D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 03:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgACDH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 22:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgACDH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 22:07:57 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6774321D7D;
        Fri,  3 Jan 2020 03:07:56 +0000 (UTC)
Date:   Thu, 2 Jan 2020 22:07:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel//trace/fgraph.c:111:35: error: 'MCOUNT_INSN_SIZE'
 undeclared; did you mean 'UCOUNT_COUNTS'?
Message-ID: <20200102220754.5dc61fcc@rorschach.local.home>
In-Reply-To: <202001020219.zvE3vsty%lkp@intel.com>
References: <202001020219.zvE3vsty%lkp@intel.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 02:09:22 +0800
kbuild test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   738d2902773e30939a982c8df7a7f94293659810
> commit: ff205766dbbee024a4a716638868d98ffb17748a ftrace: Fix function_graph tracer interaction with BPF trampoline
> date:   3 weeks ago
> config: riscv-randconfig-a001-20200102 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ff205766dbbee024a4a716638868d98ffb17748a
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel//trace/fgraph.c: In function 'function_graph_enter':
> >> kernel//trace/fgraph.c:111:35: error: 'MCOUNT_INSN_SIZE' undeclared (first use in this function); did you mean 'UCOUNT_COUNTS'?  
>          ftrace_find_rec_direct(ret - MCOUNT_INSN_SIZE))
>                                       ^~~~~~~~~~~~~~~~
>                                       UCOUNT_COUNTS
>    kernel//trace/fgraph.c:111:35: note: each undeclared identifier is reported only once for each function it appears in
> 
>

The next two patches should fix this. The second patch fixes a
different location with the same problem. It appears that without
DYNAMIC_FTRACE (which x86 always has now) that this isn't defined.

-- Steve
