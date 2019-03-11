Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C7C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FF0206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfCKR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKR4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:56:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F92B30833B4;
        Mon, 11 Mar 2019 17:56:45 +0000 (UTC)
Received: from krava (ovpn-204-107.brq.redhat.com [10.40.204.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id 27B74608C8;
        Mon, 11 Mar 2019 17:56:41 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:56:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v7 perf,bpf 12/15] perf, bpf: enable annotation of bpf
 program
Message-ID: <20190311175641.GA19721@krava>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-13-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307175810.249857-13-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 11 Mar 2019 17:56:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:58:07AM -0800, Song Liu wrote:

SNIP

> +		if (linfo && btf) {
> +			srcline = btf__name_by_offset(btf, linfo->line_off);
> +			nr_skip++;
> +		} else
> +			srcline = NULL;
> +
> +		fprintf(s, "\n");
> +		prev_buf_size = buf_size;
> +		fflush(s);
> +
> +		if (!opts->hide_src_code && srcline) {
> +			args->offset = -1;
> +			args->line = strdup(srcline);
> +			args->line_nr = 0;
> +			args->ms.sym  = sym;
> +			dl = disasm_line__new(args);
> +			if (dl) {
> +				annotation_line__add(&dl->al,
> +						     &notes->src->source);
> +			}
> +		}

I still miss answer for why is the line added twice for
!opts->hide_src_code && srcline ? code up and down

jirka

> +
> +		args->offset = pc;
> +		args->line = buf + prev_buf_size;
> +		args->line_nr = 0;
> +		args->ms.sym  = sym;
> +		dl = disasm_line__new(args);
> +		if (dl)
> +			annotation_line__add(&dl->al, &notes->src->source);
> +
> +		pc += count;
> +	} while (count > 0 && pc < len);

SNIP
