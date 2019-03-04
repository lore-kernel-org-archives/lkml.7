Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E9220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCDUhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:37:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfCDUhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C51E83086246;
        Mon,  4 Mar 2019 20:37:16 +0000 (UTC)
Received: from krava (ovpn-204-135.brq.redhat.com [10.40.204.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 472BC600D7;
        Mon,  4 Mar 2019 20:37:14 +0000 (UTC)
Date:   Mon, 4 Mar 2019 21:37:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v5 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190304203713.GC2563@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-13-songliubraving@fb.com>
 <20190304135351.GL19809@krava>
 <01714139-9FE5-4DFF-A299-D758D1871BA0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01714139-9FE5-4DFF-A299-D758D1871BA0@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 04 Mar 2019 20:37:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:45:00PM +0000, Song Liu wrote:
> 
> 
> > On Mar 4, 2019, at 5:53 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Wed, Feb 27, 2019 at 09:06:40PM -0800, Song Liu wrote:
> > 
> > SNIP
> > 
> >> +	fflush(s);
> >> +	do {
> >> +		const struct bpf_line_info *linfo = NULL;
> >> +		struct disasm_line *dl;
> >> +		size_t prev_buf_size;
> >> +		const char *srcline;
> >> +		u64 addr;
> >> +
> >> +		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> >> +		count = disassemble(pc, &info);
> >> +
> >> +		if (prog_linfo)
> >> +			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
> >> +								addr, sub_id,
> >> +								nr_skip);
> >> +
> >> +		if (linfo && btf) {
> >> +			srcline = btf__name_by_offset(btf, linfo->line_off);
> >> +			nr_skip++;
> >> +		} else
> >> +			srcline = NULL;
> >> +
> >> +		fprintf(s, "\n");
> >> +		prev_buf_size = buf_size;
> >> +		fflush(s);
> >> +
> >> +		if (!opts->hide_src_code && srcline) {
> >> +			args->offset = -1;
> > 
> > why's the offset not needed in here?
> 
> This is the source code line. Based on my understanding of annotation
> code, we put -1 for source code line. Did I misunderstand something?

please double check, IIRC annotation_line__print will print
just more info if offset is present, together with the source,
but I haven't checked that code for some time, so I might be wrong

jirka
