Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE38CC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5DA2173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfJGLU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:20:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfJGLU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7920E30833C1;
        Mon,  7 Oct 2019 11:20:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id A5C7C5C1D4;
        Mon,  7 Oct 2019 11:20:28 +0000 (UTC)
Date:   Mon, 7 Oct 2019 13:20:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] perf tools: Support single perf.data file directory
Message-ID: <20191007112027.GD6919@krava>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
 <20191004083121.12182-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004083121.12182-5-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 07 Oct 2019 11:20:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:31:20AM +0300, Adrian Hunter wrote:

SNIP

>  	u8 pad[8] = {0};
>  
> -	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
> +	if (!perf_data__is_pipe(data) && perf_data__is_single_file(data)) {
>  		off_t file_offset;
>  		int fd = perf_data__fd(data);
>  		int err;
> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index df173f0bf654..964ea101dba6 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -76,6 +76,13 @@ int perf_data__open_dir(struct perf_data *data)
>  	DIR *dir;
>  	int nr = 0;
>  
> +	/*
> +	 * Directory containing a single regular perf data file which is already
> +	 * open, means there is nothing more to do here.
> +	 */
> +	if (perf_data__is_single_file(data))
> +		return 0;
> +

cool, I like this approach much more than the previous flag

any change you (if there's repost) or Arnaldo
could squeeze in indent change below?

thanks,
jirka


---
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index bfa80fe8d369..7f567a521cea 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -227,8 +227,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 			/* Open the directory data. */
 			if (data->is_dir) {
 				ret = perf_data__open_dir(data);
-			if (ret)
-				goto out_delete;
+				if (ret)
+					goto out_delete;
 			}
 
 			if (!symbol_conf.kallsyms_name &&
