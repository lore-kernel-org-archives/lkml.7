Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85371C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5148020674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfDWO64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:58:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40421 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfDWO6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:58:55 -0400
Received: from [177.198.83.244] (helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1hIwsn-0007ep-5j; Tue, 23 Apr 2019 14:58:53 +0000
Date:   Tue, 23 Apr 2019 11:58:48 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, acme@redhat.com,
        tglx@linutronix.de
Subject: PING: Re: [PATCH] perf annotate: Fix build on 32 bit for BPF
 annotation
Message-ID: <20190423145847.GC5376@calabresa>
References: <20190403194452.10845-1-cascardo@canonical.com>
 <ABAEFCEA-E8C6-4246-B109-6D6A12AAB75B@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ABAEFCEA-E8C6-4246-B109-6D6A12AAB75B@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 09:34:02PM +0000, Song Liu wrote:
> 
> 
> > On Apr 3, 2019, at 12:44 PM, Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> > 
> > Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") adds
> > support for BPF programs annotations but the new code does not build on 32-bit.
> > 
> > Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> Thanks for the fix!
> Song
> 

Thanks for the ack.

Pinging for getting this applied, as this is a build failure on i386.

Thanks.
Cascardo.

> > ---
> > tools/perf/util/annotate.c | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index c8b01176c9e1..09762985c713 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1714,8 +1714,8 @@ static int symbol__disassemble_bpf(struct symbol *sym,
> > 	if (dso->binary_type != DSO_BINARY_TYPE__BPF_PROG_INFO)
> > 		return -1;
> > 
> > -	pr_debug("%s: handling sym %s addr %lx len %lx\n", __func__,
> > -		 sym->name, sym->start, sym->end - sym->start);
> > +	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
> > +		  sym->name, sym->start, sym->end - sym->start);
> > 
> > 	memset(tpath, 0, sizeof(tpath));
> > 	perf_exe(tpath, sizeof(tpath));
> > @@ -1740,7 +1740,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
> > 	info_linear = info_node->info_linear;
> > 	sub_id = dso->bpf_prog.sub_id;
> > 
> > -	info.buffer = (void *)(info_linear->info.jited_prog_insns);
> > +	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
> > 	info.buffer_length = info_linear->info.jited_prog_len;
> > 
> > 	if (info_linear->info.nr_line_info)
> > @@ -1776,7 +1776,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
> > 		const char *srcline;
> > 		u64 addr;
> > 
> > -		addr = pc + ((u64 *)(info_linear->info.jited_ksyms))[sub_id];
> > +		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
> > 		count = disassemble(pc, &info);
> > 
> > 		if (prog_linfo)
> > -- 
> > 2.20.1
> > 
> 
