Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C19C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6C421871
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfJGLUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:20:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfJGLUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:20:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1907E50F45;
        Mon,  7 Oct 2019 11:20:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 414A85D6D0;
        Mon,  7 Oct 2019 11:20:35 +0000 (UTC)
Date:   Mon, 7 Oct 2019 13:20:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] perf record: Put a copy of kcore into the perf.data
 directory
Message-ID: <20191007112034.GE6919@krava>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004083121.12182-6-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 07 Oct 2019 11:20:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:31:21AM +0300, Adrian Hunter wrote:

SNIP

> +}
> +
>  static int record__mmap_evlist(struct record *rec,
>  			       struct evlist *evlist)
>  {
> @@ -1383,6 +1417,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	session->header.env.comp_type  = PERF_COMP_ZSTD;
>  	session->header.env.comp_level = rec->opts.comp_level;
>  
> +	if (rec->opts.kcore &&
> +	    !record__kcore_readable(&session->machines.host)) {
> +		pr_err("ERROR: kcore is not readable.\n");
> +		return -1;
> +	}
> +

is there any reason why this change is not merged with the change below?


>  	record__init_features(rec);
>  
>  	if (rec->opts.use_clockid && rec->opts.clockid_res_ns)
> @@ -1414,6 +1454,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	}
>  	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
>  
> +	if (rec->opts.kcore) {
> +		err = record__kcore_copy(&session->machines.host, data);
> +		if (err) {
> +			pr_err("ERROR: Failed to copy kcore\n");
> +			goto out_child;
> +		}
> +	}
> +

thanks,
jirka
