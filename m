Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B2C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039FD20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559663790;
	bh=SAUy3ZL5gC5Eqdsf2dnzfyQ0sm9EqUOhkGszRoE8N2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2SEz6fcKxChkJr3MWmHTUw7l1m9idXumSaObwGk2D6TQgYu55FG+d9FmdHlCl4EGY
	 N20lZAsoZbqQQtOMSZ1pGkl8bVlLv3u7h7edOiFOo2CdAJf0WnG1D6wHMqA86lquLV
	 KPlNfuvMI7vH5doOacoIn4GR0flN+fHADV7Jg85U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfFDP43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:56:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfFDP42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:56:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879C52053B;
        Tue,  4 Jun 2019 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559663788;
        bh=SAUy3ZL5gC5Eqdsf2dnzfyQ0sm9EqUOhkGszRoE8N2s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SNrU9CWDdsR2vFXgFOHzqxWCRkOtOBGwWetmPqygLdpfs0eYkGpyMhqyPWfHmM9pI
         Bbe6waamcUTTuV58DLPOZ0mZ3eKHWUkOVJJzuV6gkc3cpIBD2KticmXiwPevJ3BOkP
         JVtOrKnxoqcQ+ui2Wd3/I4YFM7NBUWLfxysRSmnI=
Date:   Wed, 5 Jun 2019 00:56:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix to init kprobes in subsys_initcall
Message-Id: <20190605005623.80198859f1f1e6695b3d3976@kernel.org>
In-Reply-To: <20190604050629.11c7ef12@oasis.local.home>
References: <20190603214105.715a4072472ef4946123dc20@kernel.org>
        <155956708268.12228.10363800793132214198.stgit@devnote2>
        <20190604050629.11c7ef12@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019 05:06:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  3 Jun 2019 22:04:42 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since arm64 kernel initializes breakpoint trap vector in arch_initcall(),
> > initializing kprobe (and run smoke test) in postcore_initcall() causes
> > a kernel panic.
> > 
> > To fix this issue, move the kprobe initialization in subsys_initcall()
> > (which is called right afer the arch_initcall).
> > 
> > In-kernel kprobe users (ftrace and bpf) are using fs_initcall() which is
> > called after subsys_initcall(), so this shouldn't cause more problem.
> > 
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
> 
> Hi Masami,
> 
> Is this really a fix, or is this just needed to add kprobes to the command line?

Hi Steve,

Yes, this is a real fix, not related to the kprobes command line feature.

First of all, the problem was that kprobes(module_init) was initialized
later than trace_kprobe(fs_initcall). the commit b5f8b32c93b2 is to solve
it. But I missed that the break-point hander initialization can be done 
in arch_initcall on some archs. This is fixing that bug.

Thank you,


> 
> -- Steve
> 
> 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 54aaaad00a47..5471efbeb937 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2289,7 +2289,7 @@ static int __init init_kprobes(void)
> >  		init_test_probes();
> >  	return err;
> >  }
> > -postcore_initcall(init_kprobes);
> > +subsys_initcall(init_kprobes);
> >  
> >  #ifdef CONFIG_DEBUG_FS
> >  static void report_probe(struct seq_file *pi, struct kprobe *p,
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
