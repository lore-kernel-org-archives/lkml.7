Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48455C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9F82146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 19:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbfDETcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 15:32:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfDETcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 15:32:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCUZn-0003KL-U0; Fri, 05 Apr 2019 21:32:36 +0200
Date:   Fri, 5 Apr 2019 21:32:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Aubrey Li <aubrey.li@linux.intel.com>
cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, aubrey.li@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
In-Reply-To: <20190224044400.34975-1-aubrey.li@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2019, Aubrey Li wrote:

> The architecture specific information of the running processes could
> be useful to the userland. Add support to examine process architecture
> specific information externally.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Arjan van de Ven <arjan@linux.intel.com>

This really lacks

Cc: Linux API <linux-api@vger.kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

Cc'ed now.

> ---
>  fs/proc/array.c         | 5 +++++
>  include/linux/proc_fs.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 9d428d5a0ac8..ea7a981f289c 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -401,6 +401,10 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>  
> +void __weak arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
> +{
> +}
> +
>  int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  			struct pid *pid, struct task_struct *task)
>  {
> @@ -424,6 +428,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  	task_cpus_allowed(m, task);
>  	cpuset_task_status_allowed(m, task);
>  	task_context_switch_counts(m, task);
> +	arch_proc_pid_status(m, task);
>  	return 0;
>  }
>  
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index d0e1f1522a78..1de9ba1b064f 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -73,6 +73,8 @@ struct proc_dir_entry *proc_create_net_single_write(const char *name, umode_t mo
>  						    int (*show)(struct seq_file *, void *),
>  						    proc_write_t write,
>  						    void *data);
> +/* Add support for architecture specific output in /proc/pid/status */
> +extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
>  
>  #else /* CONFIG_PROC_FS */
>  
> -- 
> 2.17.1
> 
> 
