Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691E4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A792217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkq+wuyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbfDRKux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:50:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33540 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbfDRKuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:50:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id t16so1007284plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TaEPzdQzb9YiAc5luUbkcAadoBjemtmmqZ85lSxM12w=;
        b=Qkq+wuyrU/FS6awy49SBkBUBS8XliNShSTnW0oVCk3wezEx68H9jayVUdMWyBO4aur
         /zQrCserqVx1xG0Itg5IrjMf3nk3WAAMWX2msLqeMQWbSiZC5RTsJahlQ1u6c0ogYX/9
         omO0jr1KcfHvjoeK30nInFGkJJJYcfmjoMoo7khS0PEjeR9TQ86KjXE1C/umq1OPrxaR
         oAciModSwFsB0RIRah7DQHkwZgPxNzS2zyjvPyFG3RS2vqtnfBVYuGK4sQnEGLL32M8z
         qWsSHQz+ZiSGgmboWIQe5MS9bXcxfswGdp6/+oFNEik8RLCEX8mtC28lqxozWKZQeQR9
         OzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TaEPzdQzb9YiAc5luUbkcAadoBjemtmmqZ85lSxM12w=;
        b=qsp4G3M9nLdk/f4c0Ytvkp78ysWgiPRB4DU5kw7IDPUgmdbXw1WgZSF6gtlaPnD+e7
         cZ2p3UXR3uB8tWc2KLv1CCDfUa5v46tcoG3iBqR76W29FZooXbodQdl/z3ZiT2HQS6N0
         cRh96Rt0xNUxfxdLv9WcNdyxQ2Ur6nZTjmRlMNqX3zBQJ6rko2jSSJn0GhJiaJLEgNfi
         q1IH/68XPTILbEKMaIPvFPQiNqhO4Z+xJ31PbllphKGINCUuIjy6+mmQHCmq43adl0GY
         2077hbGhVH/gyPWzfbZWspIb47kUDmhMFCsmB/lVZV+XkY0dRRRXJVzIv1IX0Uyo6JU7
         cjug==
X-Gm-Message-State: APjAAAWGabbhWekxDlowsxxOeJqvLyMW7UOjgMwzCUpVgYIbsO+3F93c
        GXOFWdqbJNOPSVuG3JbWydo=
X-Google-Smtp-Source: APXvYqw3EUjy5Rph7ok8AhBPEJAntlbBZvlZJdQNFq2sTXwgYGSxXWzVLiOW+CjmQrOHWmxCezHKcg==
X-Received: by 2002:a17:902:b94a:: with SMTP id h10mr95422947pls.82.1555584651939;
        Thu, 18 Apr 2019 03:50:51 -0700 (PDT)
Received: from localhost ([110.70.26.132])
        by smtp.gmail.com with ESMTPSA id y191sm1868108pgd.78.2019.04.18.03.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 03:50:50 -0700 (PDT)
Date:   Thu, 18 Apr 2019 19:50:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, ying.huang@intel.com
Subject: Re: [PATCH v2] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190418105046.GA13459@jagdpanzerIV>
References: <20190410153718.22905-1-feng.tang@intel.com>
 <20190416211922.d3c9c6987f0b992da343be52@linux-foundation.org>
 <20190417064844.ppyqxcx2mgek5455@shbuild888>
 <20190417091832.z252cvcf4ktxeamv@pathway.suse.cz>
 <20190417094614.GB4260@jagdpanzerIV>
 <20190417105010.GA8492@jagdpanzerIV>
 <20190417122458.mhl3orevzha7sp6h@pathway.suse.cz>
 <20190417151817.xsun2k7cxff5rknn@shbuild888>
 <20190418000014.GA2059@jagdpanzerIV>
 <20190418074552.x7bl7tr76dui64f5@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418074552.x7bl7tr76dui64f5@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/18/19 09:45), Petr Mladek wrote:
> The following functions are currently called from panic_print_sys_info():
> 
> + show_state():
> 	printk(KERN_INFO
> 		"  task                        PC stack   pid father\n");
> + show_mem():
> 	printk("Mem-Info:\n");
> 
> + sysrq_timer_list_show()
> 	no global header; but each section can be easily distinguished
> 	because there are several static strings that explains the
> 	content
> 
> + debug_show_all_locks()
> 	pr_warn("\nShowing all locks held in the system:\n");
> 
> + ftrace_dump():
> 	printk(KERN_TRACE "Dumping ftrace buffer:\n");

Oh, thanks.

> The person that enabled the debugging option might know what it did
> when it process the log the very same day. It might be less clear
> for others reading the log.
> 
> Also it still might be convenient to find the beginning easily.
> Or it might help to orientate when several test runs
> (over night test) are squashed in a single file. I see
> such logs pretty often.

OK, well since we are talking here about serial log, then we probably
can just add printk("dump logbuf:\n"). It will appear before the
FLUSH_ALL output. Or we can just tweak panic code a bit - anything
panic_print_sys_info() prints can be "after" end of panic marker.

Basically, just move pr_emerg("---[ end Kernel panic...") a bit. I don't
quite understand why is it at the bottom - we don't always print end of
panic maker, e.g. when panic_timeout != 0. Not sure if this was
intentional.

---
diff --git a/kernel/panic.c b/kernel/panic.c
index 50eacfc9bc7e..1940a142c26e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -282,6 +282,7 @@ void panic(const char *fmt, ...)
 	 */
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
+	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	panic_print_sys_info();
 
@@ -331,7 +332,6 @@ void panic(const char *fmt, ...)
 		disabled_wait(caller);
 	}
 #endif
-	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
---

	-ss
