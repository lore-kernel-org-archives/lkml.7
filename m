Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36198C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126092084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfJGKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:47:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfJGKrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:47:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5B89307D934;
        Mon,  7 Oct 2019 10:47:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id D26E85C1D4;
        Mon,  7 Oct 2019 10:47:47 +0000 (UTC)
Date:   Mon, 7 Oct 2019 12:47:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix mode setting in copyfile_mode_ns()
Message-ID: <20191007104747.GA6919@krava>
References: <20191007070221.11158-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007070221.11158-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 07 Oct 2019 10:47:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 10:02:21AM +0300, Adrian Hunter wrote:
> slow_copyfile() opens the file by name, so "write" permissions must not
> be removed in copyfile_mode_ns() before calling slow_copyfile().
> 
> Example:
> 
>  Before:
>   $ sudo chmod +r /proc/kcore
>   $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
>   $ tools/perf/perf buildid-cache -k /proc/kcore
>   Couldn't add /proc/kcore
> 
>  After:
>   $ sudo chmod +r /proc/kcore
>   $ sudo setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_sys_rawio=ep" tools/perf/perf
>   $ tools/perf/perf buildid-cache -v -k /proc/kcore
>   kcore added to build-id cache directory /home/ahunter/.debug/[kernel.kcore]/37e340b1b5a7cf4f57ba8de2bc777359588a957f/2019100709562289
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/copyfile.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/copyfile.c b/tools/perf/util/copyfile.c
> index 3fa0db136667..47e03de7c235 100644
> --- a/tools/perf/util/copyfile.c
> +++ b/tools/perf/util/copyfile.c
> @@ -101,14 +101,16 @@ static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
>  	if (tofd < 0)
>  		goto out;
>  
> -	if (fchmod(tofd, mode))
> -		goto out_close_to;
> -
>  	if (st.st_size == 0) { /* /proc? do it slowly... */
>  		err = slow_copyfile(from, tmp, nsi);
> +		if (!err && fchmod(tofd, mode))
> +			err = -1;
>  		goto out_close_to;
>  	}
>  
> +	if (fchmod(tofd, mode))
> +		goto out_close_to;
> +
>  	nsinfo__mountns_enter(nsi, &nsc);
>  	fromfd = open(from, O_RDONLY);
>  	nsinfo__mountns_exit(&nsc);
> -- 
> 2.17.1
> 
