Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645C6C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BE220833
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfFRCQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfFRCQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:16:49 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C80F20833;
        Tue, 18 Jun 2019 02:16:48 +0000 (UTC)
Date:   Mon, 17 Jun 2019 22:16:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 16/21] tracing/uprobe: Add per-probe delete from event
Message-ID: <20190617221646.7c848beb@oasis.local.home>
In-Reply-To: <155931595698.28323.17594202275209962525.stgit@devnote2>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931595698.28323.17594202275209962525.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Jun 2019 00:19:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> +static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
> +					    int argc, const char **argv)
> +{
> +	char buf[MAX_ARGSTR_LEN + 1];
> +	int len;
> +
> +	if (!argc)
> +		return true;
> +
> +	len = strlen(tu->filename);
> +	if (argv[0][len] != ':' || strncmp(tu->filename, argv[0], len))

Hmm, isn't it possible that 'len' can be greater than whatever argv[0] is?

The argv[0][len] looks very dangerous to me.

Perhaps that should be changed to:

	if (!(!strncmp(tu->filename, argv[0], len) && argv[0][len] == ':'))

That way, the test of argv[0][len] will only happen if argv[0] is of length len.

-- Steve


> +		return false;
> +
> +	if (tu->ref_ctr_offset == 0)
> +		snprintf(buf, sizeof(buf), "0x%0*lx",
> +				(int)(sizeof(void *) * 2), tu->offset);
> +	else
> +		snprintf(buf, sizeof(buf), "0x%0*lx(0x%lx)",
> +				(int)(sizeof(void *) * 2), tu->offset,
> +				tu->ref_ctr_offset);
> +	if (strcmp(buf, &argv[0][len + 1]))
> +		return false;
> +
> +	argc--; argv++;
> +
> +	return trace_probe_match_command_args(&tu->tp, argc, argv);
> +}
> +
