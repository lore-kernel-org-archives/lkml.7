Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87947C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DB213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560874728;
	bh=8IT6mIl1+85XfJ48HhaLGTHawDDCTjPYWxwxwjPe+zU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G4gsgsX0t+KHzX2dRDwM6KoHtU6zLDSvrwCAJN8MwUYeNz4kFULZj5uCSCTowGKUb
	 9vTNukETGW3Pzqu2K/rqS+HPdEDmNIM7dwM6oboXudouJKSL2OKnkRWTNsfxZlUlXt
	 pLkTbwpV2mtuj3DMMj3zPz4U4+PwvIGaPL0y9J/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfFRQSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfFRQSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:18:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E8E20B1F;
        Tue, 18 Jun 2019 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560874725;
        bh=8IT6mIl1+85XfJ48HhaLGTHawDDCTjPYWxwxwjPe+zU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sWJEFZz9ZFAS+uZls7FFlRMq/x5Rdp1sbr7PlfyPXlcN7024WuynlYUS8/pIBDGe4
         x5uHzpJzncvS9jqXz0NYAHnsnchqCJFNOnvRCrkHKieLw6drMrowwhgiICkEfkpt0B
         PmFY4OGpcRUMSZl2Im/E+3Ax+SGAFNlx/nCHgKLw=
Date:   Wed, 19 Jun 2019 01:18:41 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 16/21] tracing/uprobe: Add per-probe delete from event
Message-Id: <20190619011841.99e204671417bd66a8d604fc@kernel.org>
In-Reply-To: <20190617221646.7c848beb@oasis.local.home>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931595698.28323.17594202275209962525.stgit@devnote2>
        <20190617221646.7c848beb@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019 22:16:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat,  1 Jun 2019 00:19:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
> > +					    int argc, const char **argv)
> > +{
> > +	char buf[MAX_ARGSTR_LEN + 1];
> > +	int len;
> > +
> > +	if (!argc)
> > +		return true;
> > +
> > +	len = strlen(tu->filename);
> > +	if (argv[0][len] != ':' || strncmp(tu->filename, argv[0], len))
> 
> Hmm, isn't it possible that 'len' can be greater than whatever argv[0] is?
> 
> The argv[0][len] looks very dangerous to me.

Ah, right! it can lead an unexpected memory access! 

> 
> Perhaps that should be changed to:
> 
> 	if (!(!strncmp(tu->filename, argv[0], len) && argv[0][len] == ':'))
> 
> That way, the test of argv[0][len] will only happen if argv[0] is of length len.

OK, I'll take it! Thank you!

> 
> -- Steve
> 
> 
> > +		return false;
> > +
> > +	if (tu->ref_ctr_offset == 0)
> > +		snprintf(buf, sizeof(buf), "0x%0*lx",
> > +				(int)(sizeof(void *) * 2), tu->offset);
> > +	else
> > +		snprintf(buf, sizeof(buf), "0x%0*lx(0x%lx)",
> > +				(int)(sizeof(void *) * 2), tu->offset,
> > +				tu->ref_ctr_offset);
> > +	if (strcmp(buf, &argv[0][len + 1]))
> > +		return false;
> > +
> > +	argc--; argv++;
> > +
> > +	return trace_probe_match_command_args(&tu->tp, argc, argv);
> > +}
> > +


-- 
Masami Hiramatsu <mhiramat@kernel.org>
