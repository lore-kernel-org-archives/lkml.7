Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FA1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291A2218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553337054;
	bh=HXC3j0GG7c73VC1iIbFLshNGxNZaZYRlFeVjuOUcK5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M9hMCOpVwCOF6duW8FEuEhyRIIUBAJLbbrDalnZb25CMSnYwniFbi+TdDk/Jy3x0Z
	 vFEEsQnMcuBw6GYV0WMCXfRZs6YKJ/E5QCBsXjR5r3igrmEAnxZVB44OpmzkIxaCwX
	 5BNm7zpr9N1khrIaZxr9SAetWWU0a82UT2Zd052I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfCWKaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfCWKaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:30:52 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4876320883;
        Sat, 23 Mar 2019 10:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553337052;
        bh=HXC3j0GG7c73VC1iIbFLshNGxNZaZYRlFeVjuOUcK5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0E9GuLxGO1ypXj+a9vIYJSaEbCXAQ50qQ/XQxK9rzqtR2dgGyl4cVCozIeLk9X60K
         Qh/5quJHLTz7arpU2BpqNXh0VkUM8+Qhul8sDLLlhCQnISLtQOExph9U8ZqBf8HFWS
         7yLr4gBA9u0Dn1VYczebK4F+tcsW9BGD9IrLHlaY=
Date:   Sat, 23 Mar 2019 19:30:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     frowand.list@gmail.com, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] tracing: initialize variable in create_dyn_event()
Message-Id: <20190323193048.35d96b86388552b0b7f7a36d@kernel.org>
In-Reply-To: <20190322152000.0a357bb1@gandalf.local.home>
References: <1553237900-8555-1-git-send-email-frowand.list@gmail.com>
        <20190322152000.0a357bb1@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2019 15:20:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 Mar 2019 23:58:20 -0700
> frowand.list@gmail.com wrote:
> 
> > From: Frank Rowand <frank.rowand@sony.com>
> > 
> > Fix compile warning in create_dyn_event(): 'ret' may be used uninitialized
> > in this function [-Wuninitialized].
> > 
> > Fixes: 5448d44c3855 ("tracing: Add unified dynamic event framework")
> > 
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 
> Applied. Thanks Frank!

Thank you Frank and Steve,

feel free to add my ack.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> -- Steve
> 
> > ---
> > 
> > changes since v1:
> >   - initialize to -ENODEV instead of 0, as suggested by Steve
> > 
> >  kernel/trace/trace_dynevent.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
> > index dd1f43588d70..fa100ed3b4de 100644
> > --- a/kernel/trace/trace_dynevent.c
> > +++ b/kernel/trace/trace_dynevent.c
> > @@ -74,7 +74,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
> >  static int create_dyn_event(int argc, char **argv)
> >  {
> >  	struct dyn_event_operations *ops;
> > -	int ret;
> > +	int ret = -ENODEV;
> >  
> >  	if (argv[0][0] == '-' || argv[0][0] == '!')
> >  		return dyn_event_release(argc, argv, NULL);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
