Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C951C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1321743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558453177;
	bh=V6RrFwC69vaGpD6uEs9hsF3W8vWzKq46UtR2el3xg2Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=t0DDA7DcMNHu0R47tm8g16b96zi9p1zELdt5fE6eOXu45xvVj4h6cpbhIGb5262FG
	 F8AhxCmj1ZTQGxVjGtmbjSULFs7TR+NKb1WpOsa9jGQZHXm7GfHos1jXXewglUcrJN
	 NyCBRjzREUWPlm18anOYHf6MPloxbO27A2C6yfmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfEUPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbfEUPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:39:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF16208C3;
        Tue, 21 May 2019 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558453176;
        bh=V6RrFwC69vaGpD6uEs9hsF3W8vWzKq46UtR2el3xg2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NmweJBMKKPipUrO/xWliYq0PkG/2OYdsLDjTVv8k0+OPHFju09ddOLrwncFVN/Vxd
         Ye33Irohwzu07m2KuSY7kb7BVShTSMvE1ZK80k0tVHSFHyyfb+n4JGDFLsbFhGjRPY
         apf0eeVB36OB/y9MPimGNf3g4oUvlg966FMjkErw=
Date:   Wed, 22 May 2019 00:39:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] Enable new kprobe event at boot
Message-Id: <20190522003932.34367dcae6d9de27e254e174@kernel.org>
In-Reply-To: <20190521093317.7d698f79@gandalf.local.home>
References: <155842537599.4253.14690293652007233645.stgit@devnote2>
        <20190521093317.7d698f79@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 09:33:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 21 May 2019 16:56:16 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Note that 'trace_event=' option enables trace event at very early
> > timing, but the events added by 'kprobe_event=' are enabled right
> > before enabling device drivers at this point. It is enough for
> > tracing device driver initialization etc.
> 
> Nice!
> 
> I wonder if we can have this called before the trace_event boot is
> analyzed. Then have the kprobe_event work more like the kprobe_events
> file, and not enable the kprobes but only create them. If you want to
> enable them you do a trace_event=kprobes as well.

Yeah, I considered that, but there are several reasons to not to do that.
- trace_event seems enabled very early point than kprobes itself.(but this can
  be fixable)
- if user specifies kprobes at boot, he/she wants to enable that point at boot.
- it is redundant to specify kprobe_event= and trace_event=, especially command
  line size is very limited.

> Perhaps we could enable kprobes at early init?

It should be possible, I will try to find what blocks it. I guess after we
switch early_text_poke() to text_poke(), we can use kprobes on x86. But
for other archs, I need to investigate more.

> What do you think? Or is there something else in kprobes that prevents
> such an early enabling of it?

As I pointed above, I think we should enable it if user specify it. That's
less typing :). Anyway I'll recheck early kprobe availablity.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
