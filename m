Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD75C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617C420883
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCLLNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:13:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfCLLNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:13:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77642374;
        Tue, 12 Mar 2019 04:13:31 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A98043F59C;
        Tue, 12 Mar 2019 04:13:29 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:13:26 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [RFC][PATCH] Export supported trace features in debugfs
Message-ID: <20190312111326.nz3wgdy64g2nk44v@e107158-lin.cambridge.arm.com>
References: <20190312110437.5977-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190312110437.5977-1-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/19 11:07, Qais Yousef wrote:
> eBPF tools like bcc-tools have hard time figuring out when features like
> raw_tracepoint are supported in the kernel on which we are running. At
> the moment a fragile mechanism of matching bpf_find_raw_tracepoint()
> function in /proc/kallsyms is used to find out whether raw tracepoints
> can be used or not. But when this function was renamed recently to
> bpf_get_raw_tracepoint() the tool started to fail to use raw
> tracepoints.
> 
> To help in providing a more reliable way to detect features like
> RAW_TRACEPOINT, add a new file in trace debugfs to export the supported
> features.
> 
> $cat /sys/kernel/debug/tracing/supported_features
> RAW_TRACEPOINT
> EXAMPLE_FEATURE_1
> EXAMPLE_FEATURE_2
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
> 
> This is a half baked patch to probe the potential of this solution.
> 
> The breakage mentioned in the commit message is here:
> 
> https://github.com/iovisor/bcc/pull/2241/commits/0f5849187972a50adf0d9eaa8788c11f9fd926ea
> 
> I am not sure what else beside raw_tracepoint makes sense to expose right now.
> 
>  kernel/trace/trace.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c4238b441624..daae09238e62 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6670,6 +6670,28 @@ static const struct file_operations snapshot_raw_fops = {
> 
>  #endif /* CONFIG_TRACER_SNAPSHOT */
> 
> +#define TRACE_FEATURE(feat)__stringify(feat) "\n"
> +
> +#define TRACE_FEATURES\
> +TRACE_FEATURE(RAW_TRACEPOINT)\
> +TRACE_FEATURE(EXAMPLE_FEATUTE_1)\
> +TRACE_FEATURE(EXAMPLE_FEATUTE_2)
> +
> +static ssize_t
> +tracing_read_trace_features(struct file *filp, char __user *ubuf,
> +size_t cnt, loff_t *ppos)
> +{
> +char *buf = TRACE_FEATURES;
> +size_t len = sizeof(TRACE_FEATURES);
> +
> +return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
> +}
> +
> +static const struct file_operations show_trace_features_fops = {
> +.read           = tracing_read_trace_features,
> +.llseek         = no_llseek,
> +};
> +
>  static int tracing_buffers_open(struct inode *inode, struct file *filp)
>  {
>  struct trace_array *tr = inode->i_private;
> @@ -8242,6 +8264,9 @@ static __init int tracer_init_tracefs(void)
>  &ftrace_update_tot_cnt, &tracing_dyn_info_fops);
>  #endif
> 
> +trace_create_file("trace_features", 0444, d_tracer,
> +NULL, &show_trace_features_fops);
> +
>  create_trace_instances(d_tracer);
> 
>  update_tracer_options(&global_trace);
> --
> 2.17.1
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

Apologies that shouldn't have appeared. I can resend the patch if it matters.

--
Qais Yousef
