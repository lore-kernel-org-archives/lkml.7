Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35395C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E10B22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfIDM3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDM3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:29:13 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9269222DBF;
        Wed,  4 Sep 2019 12:29:10 +0000 (UTC)
Date:   Wed, 4 Sep 2019 08:29:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip v2] kprobes: Prohibit probing on BUG() and WARN()
 address
Message-ID: <20190904082903.0ae0656a@oasis.local.home>
In-Reply-To: <156750890133.19112.3393666300746167111.stgit@devnote2>
References: <156750890133.19112.3393666300746167111.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Sep 2019 20:08:21 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since BUG() and WARN() may use a trap (e.g. UD2 on x86) to
> get the address where the BUG() has occurred, kprobes can not
> do single-step out-of-line that instruction. So prohibit
> probing on such address.
> 
> Without this fix, if someone put a kprobe on WARN(), the
> kernel will crash with invalid opcode error instead of
> outputing warning message, because kernel can not find
> correct bug address.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>   Changes in v2:
>    - Add find_bug() stub function for !CONFIG_GENERIC_BUG
>    - Cast the p->addr to unsigned long.
> ---
>  include/linux/bug.h |    5 +++++
>  kernel/kprobes.c    |    3 ++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index fe5916550da8..f639bd0122f3 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -47,6 +47,11 @@ void generic_bug_clear_once(void);
>  
>  #else	/* !CONFIG_GENERIC_BUG */
>  
> +static inline void *find_bug(unsigned long bugaddr)
> +{
> +	return NULL;
> +}
> +
>  static inline enum bug_trap_type report_bug(unsigned long bug_addr,
>  					    struct pt_regs *regs)
>  {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 452151e79535..5bdf47190f09 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1514,7 +1514,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	/* Ensure it is not in reserved area nor out of text */
>  	if (!kernel_text_address((unsigned long) p->addr) ||
>  	    within_kprobe_blacklist((unsigned long) p->addr) ||
> -	    jump_label_text_reserved(p->addr, p->addr)) {
> +	    jump_label_text_reserved(p->addr, p->addr) ||
> +	    find_bug((unsigned long) p->addr)) {
>  		ret = -EINVAL;
>  		goto out;
>  	}

