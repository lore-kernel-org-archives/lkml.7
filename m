Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEA720684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDxR0veK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfCHSjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:39:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34430 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCHSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:39:49 -0500
Received: by mail-qk1-f195.google.com with SMTP id n6so179722qkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZM+yrxKphWa35uK5bx0xYEpjBn9qXtjJbTsi7Jtv7k=;
        b=pDxR0veKOYOQLienHWJ26/UvA4rz+8mJmuMjvHjUADWQyuK8+He+hUkov6qNKc7xHo
         w5d2cusEnNXpxVDYSyEFm8KYp7Ls4AJQghQbSv+tc5gD/9zLdx24AckEIujqBRkbx4lG
         gK1yjoJzG3KcjqC/rVnoKq8kvEsdfF1ddPc99uNn6gXlp0YBVxdXZuiG5/SIrULtYUlC
         QfeFJgB5sO3Bk/IhwmevarLFufHeEtO6AdsHkFo3zaY91lDoqYct7Ux0vHrhQW3btvdx
         VL1lVOUbrv83VlOpdsmYOqUyYYsm1UfuRb7Ck8K5tShLpnLrwGVx2+21BmrUQtkF7iEj
         FquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZM+yrxKphWa35uK5bx0xYEpjBn9qXtjJbTsi7Jtv7k=;
        b=WJ24EnSigUJKdLh+0J9myHmR6unHrq7yVLXl5mC7WyELZndFmap1CGT5nycYmTBb8F
         gnRrRxXEzQFtSYthR3qkgVhgFNPEy82bzbZPfMYNH7Nk9b0ocD533M05/KANpR6tbQ3v
         zG1ciMReRy3G8HdS82Dj7I8tNTE33TEnaQFhN7/vvUf65UKejpxoUCmx8cRSNYuWLj+B
         8jz+BC6ViQv4vOg4INdJdBTdKFLQFMx3G8pMzQ7/+LeJ5EbkIGjVqa7IgL6kktcQ4PK4
         +tRyaau8l3dZ4LoiG3owf2SZFIgg/dJt5JxW7syTnzkmmEe2PmND8xbsBYqj5KjabUh8
         4cYw==
X-Gm-Message-State: APjAAAVcnK3B+NfWV6svxW+WDlpp5m93u1BCXi9/pwE71FkOGvimc9Mj
        3LZFvaPOljnkaOVLlRxMHhM=
X-Google-Smtp-Source: APXvYqweMjzcnA8F/VsbKq2tZDMBQS05Ef+frMjsvEqWsgMePms8qw+9356/7PJpxf054xgIwtfHNQ==
X-Received: by 2002:a37:4804:: with SMTP id v4mr15010925qka.104.1552070388135;
        Fri, 08 Mar 2019 10:39:48 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id o5sm5370558qkl.24.2019.03.08.10.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 10:39:46 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B9824039C; Fri,  8 Mar 2019 15:39:44 -0300 (-03)
Date:   Fri, 8 Mar 2019 15:39:44 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 07/11] perf session: Add
 __perf_session__process_dir_events function
Message-ID: <20190308183944.GH10690@kernel.org>
References: <20190308134745.5057-1-jolsa@kernel.org>
 <20190308134745.5057-8-jolsa@kernel.org>
 <20190308183805.GG10690@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308183805.GG10690@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 08, 2019 at 03:38:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 08, 2019 at 02:47:41PM +0100, Jiri Olsa escreveu:
> > +static int __perf_session__process_dir_events(struct perf_session *session)
> > +{
> > +	struct perf_data *data = session->data;
> > +	struct perf_tool *tool = session->tool;
> > +	struct reader rd = {
> > +		.fd		= perf_data__fd(session->data),
> > +		.data_size	= session->header.data_size,
> > +		.data_offset	= session->header.data_offset,
> > +		.process	= process_simple,
> > +	};
> > +	int i, ret = 0;
> > +	struct ui_progress prog;
> > +	u64 total_size = perf_data__size(session->data);
> > +
> > +	perf_tool__fill_defaults(tool);
> > +
> > +	ui_progress__init_size(&prog, total_size, "Processing events...");
> > +
> > +	/* Read data from the header file.. */
> > +	ret = reader__process_events(&rd, session, &prog);
> > +	if (ret)
> > +		goto out_err;
> > +
> > +	/* ... and continue with data files. */
> > +	for (i = 0; i < data->dir.nr ; i++) {
> > +		struct perf_data_file *file = &data->dir.files[i];
> > +
> > +		if (file->size == 0)
> > +			continue;
> > +
> > +		rd = (struct reader) {
> > +			.fd		= file->fd,
> > +			.data_size	= file->size,
> > +			.data_offset	= 0,
> > +			.process	= process_index,
> > +		};
> > +
> > +		ret = reader__process_events(&rd, session, &prog);
> > +		if (ret)
> > +			goto out_err;
 
> Don't we have to have some handling of PERF_RECORD_FINISHED_ROUND here?
> I.e. what happens if we fill th ordered events with just the contents
> of, say, the first CPU and then have those events flushed and processed
> before we start even looking at the events in the other CPUs?
 
> I think some detailed explanation of what happens here is in need, no?

Ah, I've pushed what I have merged so far to acme/perf/core on
git.kernel.org, please continue from there.

- Arnaldo
