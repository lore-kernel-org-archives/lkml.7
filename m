Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31930C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B44220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfCDNx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:53:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCDNxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:53:24 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32198308424E;
        Mon,  4 Mar 2019 13:53:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B9426085B;
        Mon,  4 Mar 2019 13:53:22 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:53:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v5 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190304135321.GJ19809@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-13-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228050643.958685-13-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 04 Mar 2019 13:53:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:06:40PM -0800, Song Liu wrote:

SNIP

> +
> +	disassemble_init_for_target(&info);
> +
> +#ifdef DISASM_FOUR_ARGS_SIGNATURE
> +	disassemble = disassembler(info.arch,
> +				   bfd_big_endian(bfdf),
> +				   info.mach,
> +				   bfdf);
> +#else
> +	disassemble = disassembler(bfdf);
> +#endif
> +	assert(disassemble);
> +
> +	fflush(s);

what's the reason for those fflush calls?

thanks,
jirka

> +	do {
> +		const struct bpf_line_info *linfo = NULL;
> +		struct disasm_line *dl;
> +		size_t prev_buf_size;
> +		const char *srcline;
> +		u64 addr;
> +
> +		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> +		count = disassemble(pc, &info);
> +
> +		if (prog_linfo)
> +			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
> +								addr, sub_id,
> +								nr_skip);
> +
> +		if (linfo && btf) {
> +			srcline = btf__name_by_offset(btf, linfo->line_off);
> +			nr_skip++;
> +		} else
> +			srcline = NULL;
> +
> +		fprintf(s, "\n");
> +		prev_buf_size = buf_size;
> +		fflush(s);

SNIP
