Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7034C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9473021655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfJGLUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfJGLUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:20:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 437EC30832C8;
        Mon,  7 Oct 2019 11:20:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6FB0C60A9D;
        Mon,  7 Oct 2019 11:20:40 +0000 (UTC)
Date:   Mon, 7 Oct 2019 13:20:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] perf record: Put a copy of kcore into the perf.data
 directory
Message-ID: <20191007112039.GF6919@krava>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004083121.12182-6-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 07 Oct 2019 11:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:31:21AM +0300, Adrian Hunter wrote:

SNIP

>  	bool	      strict_freq;
>  	bool	      sample_id;
>  	bool	      no_bpf_event;
> +	bool	      kcore;
>  	unsigned int  freq;
>  	unsigned int  mmap_pages;
>  	unsigned int  auxtrace_mmap_pages;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 061bb4d6a3f5..bfa80fe8d369 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -230,6 +230,10 @@ struct perf_session *perf_session__new(struct perf_data *data,
>  			if (ret)
>  				goto out_delete;
>  			}
> +
> +			if (!symbol_conf.kallsyms_name &&
> +			    !symbol_conf.vmlinux_name)
> +				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);

hum, should this also depend on rec->opts.kcore ?

jirka
