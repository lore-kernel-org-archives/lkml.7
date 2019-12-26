Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CDDC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 02:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F152920828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 02:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577328354;
	bh=yv/C6ljrIx/+HyZFKoUjNShUUTPWwuzsvZUkhYKmp/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s0rhXCWHruSwds3cqO10z57AT4Sg4mJl2SYPTNEmrttbLUKhAoH6M1dvQnP9EVrAT
	 i25SmrNwoFeLtGBU4CJOFhPYitJUGkzfhL8du5N7KnFdPcGhJ3qtH3sENaAZH4Ta3k
	 fUchAqf+gtTSYXysNVhGzyNx4MROMJMpzO2tslHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLZCpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 21:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfLZCpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 21:45:53 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B762075B;
        Thu, 26 Dec 2019 02:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577328352;
        bh=yv/C6ljrIx/+HyZFKoUjNShUUTPWwuzsvZUkhYKmp/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sw/DrybP2qxeugrbQatqVZwWIem16gtpKDpAM5KEYW+DDcj0+ciN5hUIHYRnqLMG4
         a/xVf3l2RMRBwhyIDMOaGzjFMpQ0i0RUWT525uT2XvUNfe8fa5pLiSAQE5t3cFIH2i
         js6ogOvSBDDeV5fmYqrUHt/HX0INiiU73O+3rGow=
Date:   Thu, 26 Dec 2019 11:45:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] ftrace: introduce FTRACE_IP_EXTENSION
Message-Id: <20191226114547.bb5bc2d5ae5ecf6290a90fa7@kernel.org>
In-Reply-To: <20191225172836.7f381759@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225172836.7f381759@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Dec 2019 09:42:52 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On some architectures, the DYNAMIC_FTRACE_WITH_REGS is implemented by
> gcc's -fpatchable-function-entry option. Take arm64 for example, arm64
> makes use of GCC -fpatchable-function-entry=2 option to insert two
> nops. When the function is traced, the first nop will be modified to
> the LR saver, then the second nop to "bl <ftrace-entry>". we need to
> update ftrace_location() to recognise these two instructions  as being
> part of ftrace. To do this, we introduce FTRACE_IP_EXTENSION to let
> ftrace_location search IP, IP + FTRACE_IP_EXTENSION range.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h | 4 ++++
>  kernel/trace/ftrace.c  | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7247d35c3d16..05a03b2a2f39 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -20,6 +20,10 @@
>  
>  #include <asm/ftrace.h>
>  
> +#ifndef FTRACE_IP_EXTENSION
> +#define  FTRACE_IP_EXTENSION 0
> +#endif
> +
>  /*
>   * If the arch supports passing the variable contents of
>   * function_trace_op as the third parameter back from the
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 74439ab5c2b6..a8cfea502369 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1590,7 +1590,7 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	return ftrace_location_range(ip, ip);
> +	return ftrace_location_range(ip, ip + FTRACE_IP_EXTENSION);
>  }
>  
>  /**
> -- 
> 2.24.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
