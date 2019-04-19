Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BB5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FD22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 02:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDSCE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:04:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:14611 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfDSCE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 22:04:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 19:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,368,1549958400"; 
   d="scan'208";a="224802287"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.147.114])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2019 19:04:55 -0700
Date:   Fri, 19 Apr 2019 10:08:35 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190419020835.xf6ccwdg3wfktwwl@shbuild888>
References: <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
 <20190417094614.GB4260@jagdpanzerIV>
 <20190417105010.GA8492@jagdpanzerIV>
 <20190417122458.mhl3orevzha7sp6h@pathway.suse.cz>
 <20190417151817.xsun2k7cxff5rknn@shbuild888>
 <20190418000014.GA2059@jagdpanzerIV>
 <20190418074552.x7bl7tr76dui64f5@pathway.suse.cz>
 <20190418090044.wqpc7wooboamvl6t@shbuild888>
 <20190418110152.szhc3rebqzgzrhjh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418110152.szhc3rebqzgzrhjh@pathway.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 01:01:52PM +0200, Petr Mladek wrote:
> On Thu 2019-04-18 17:00:44, Feng Tang wrote:
> > Hi Petr,
> > 
> > On Thu, Apr 18, 2019 at 09:45:52AM +0200, Petr Mladek wrote:
> > > On Thu 2019-04-18 09:00:14, Sergey Senozhatsky wrote:
> > > > I think that PANIC_PRINT_ALL_PRINTK_MSG is a debugging option; a quite
> > > > specific one. So people who ask the kernel to PANIC_PRINT_ALL_PRINTK_MSG
> > > > they know what they are doing, and we probably will not cofuse anyone.
> > > > After all, we don't print any headers when we ftrace_dump() or imitate
> > > > sysrq via sysrq_timer_list_show(), or for any other panic_print_sys_info()
> > > > printouts. So it's OK to just do the simple thing for
> > > > PANIC_PRINT_ALL_PRINTK_MSG.
> > > 
> > > The following functions are currently called from panic_print_sys_info():
> > > 
> > > + show_state():
> > > 	printk(KERN_INFO
> > > 		"  task                        PC stack   pid father\n");
> > > + show_mem():
> > > 	printk("Mem-Info:\n");
> > > 
> > > + sysrq_timer_list_show()
> > > 	no global header; but each section can be easily distinguished
> > > 	because there are several static strings that explains the
> > > 	content
> > > 
> > > + debug_show_all_locks()
> > > 	pr_warn("\nShowing all locks held in the system:\n");
> > > 
> > > + ftrace_dump():
> > > 	printk(KERN_TRACE "Dumping ftrace buffer:\n");
> > > 
> > > 
> > > The person that enabled the debugging option might know what it did
> > > when it process the log the very same day. It might be less clear
> > > for others reading the log.
> > > 
> > > Also it still might be convenient to find the beginning easily.
> > > Or it might help to orientate when several test runs
> > > (over night test) are squashed in a single file. I see
> > > such logs pretty often.
> > 
> > Thanks for checking all the info. For the note, how about adding
> > something like this inside panic_print_sys_info()?
> > 
> > 	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG) {
> > 		printk("\nprintk: will replay all the messages in buffer:\n");
> > 		console_flush_on_panic(CONSOLE_FLUSH_ALL);
> > 	}
> 
> This will store the message at the end of the buffer. It will repeat
> the message once again when replaying the log. I personally think
> that it is worse than printing nothing.

Got it :) 

> 
> 
> > If you are all fine with it, I'll go post a v3, thanks,
> 
> I suggest to wait few days. We might get opinion from someone
> else...
> 
> Then sent whatever approach makes most sense to you. In fact, you
> are the 3rd person in this triangle. I believe that we will
> respect it. Last many mails are just a bike shedding.
> 
> Just one thing. Please, use "replay" in the function or parameter
> name. The effect of console_flush_on_panic(CONSOLE_FLUSH_ALL)
> is really hard to guess from the name.

Ok. thanks

- Feng
