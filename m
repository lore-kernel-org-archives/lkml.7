Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2779C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961CB2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfD2LIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:08:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:42188 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727710AbfD2LIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:08:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B81C6ACD1;
        Mon, 29 Apr 2019 11:08:02 +0000 (UTC)
Date:   Mon, 29 Apr 2019 13:08:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        me@tobin.cc, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next] lib/vsprintf: Make function pointer_string static
Message-ID: <20190429110801.awvdxawpee3sxujs@pathway.suse.cz>
References: <20190426164630.22104-1-yuehaibing@huawei.com>
 <20190426130204.23a5a05c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426130204.23a5a05c@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-04-26 13:02:04, Steven Rostedt wrote:
> On Sat, 27 Apr 2019 00:46:30 +0800
> Yue Haibing <yuehaibing@huawei.com> wrote:
> 
> > From: YueHaibing <yuehaibing@huawei.com>
> > 
> > Fix sparse warning:
> > 
> > lib/vsprintf.c:673:6: warning:
> >  symbol 'pointer_string' was not declared. Should it be static?
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  lib/vsprintf.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 1f367f3..7b0a614 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -670,8 +670,9 @@ char *string(char *buf, char *end, const char *s,
> >  	return string_nocheck(buf, end, s, spec);
> >  }
> >  
> > -char *pointer_string(char *buf, char *end, const void *ptr,
> > -		     struct printf_spec spec)
> > +static char *pointer_string(char *buf, char *end,
> 
> Looks like commit "vsprintf: Do not check address of well-known
> strings" removed the: "static noinline_for_stack"
> 
> Does pointer_string() need that still?

Heh, it was removed by mistake and well hidden in the diff.

I have pushed Yue's fix into printk.git, branch
for-5.2-vsprintf-hardening

Thanks for the patch.

Best Regards,
Petr
