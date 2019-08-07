Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9ED21BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbfHGLcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfHGLcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:32:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCF2451EE1;
        Wed,  7 Aug 2019 11:32:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE2C05DE5B;
        Wed,  7 Aug 2019 11:32:45 +0000 (UTC)
Date:   Wed, 7 Aug 2019 13:32:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        songliubraving@fb.com, mbd@fb.com, linux-kernel@vger.kernel.org,
        irogers@google.com, eranian@google.com
Subject: Re: [PATCH v2] Fix annotate.c use of uninitialized value error
Message-ID: <20190807113244.GA9605@krava>
References: <20190726194044.GC24867@kernel.org>
 <20190729205750.193289-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729205750.193289-1-nums@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 07 Aug 2019 11:32:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:57:50PM -0700, Numfor Mbiziwo-Tiapo wrote:
> Our local MSAN (Memory Sanitizer) build of perf throws a warning
> that comes from the "dso__disassemble_filename" function in
> "tools/perf/util/annotate.c" when running perf record.
> 
> The warning stems from the call to readlink, in which "build_id_path"
> was being read into "linkname". Since readlink does not null terminate,
> an uninitialized memory access would later occur when "linkname" is
> passed into the strstr function. This is simply fixed by null-terminating
> "linkname" after the call to readlink.
> 
> To reproduce this warning, build perf by running:
> make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
>  -fsanitize-memory-track-origins"
> 
> (Additionally, llvm might have to be installed and clang might have to
> be specified as the compiler - export CC=/usr/bin/clang)
> 
> then running:
> tools/perf/perf record -o - ls / | tools/perf/perf --no-pager annotate\
>  -i - --stdio
> 
> Please see the cover letter for why false positive warnings may be
> generated.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/annotate.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 70de8f6b3aee..e1b075b52dce 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1627,6 +1627,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	char *build_id_filename;
>  	char *build_id_path = NULL;
>  	char *pos;
> +	int len;
>  
>  	if (dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS &&
>  	    !dso__is_kcore(dso))
> @@ -1655,10 +1656,16 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
>  	if (pos && strlen(pos) < SBUILD_ID_SIZE - 2)
>  		dirname(build_id_path);
>  
> -	if (dso__is_kcore(dso) ||
> -	    readlink(build_id_path, linkname, sizeof(linkname)) < 0 ||
> -	    strstr(linkname, DSO__NAME_KALLSYMS) ||
> -	    access(filename, R_OK)) {
> +	if (dso__is_kcore(dso))
> +		goto fallback;
> +
> +	len = readlink(build_id_path, linkname, sizeof(linkname) - 1);
> +	if (len < 0)
> +		goto fallback;
> +
> +	linkname[len] = '\0';
> +	if (strstr(linkname, DSO__NAME_KALLSYMS) ||
> +		access(filename, R_OK)) {
>  fallback:
>  		/*
>  		 * If we don't have build-ids or the build-id file isn't in the
> -- 
> 2.22.0.709.g102302147b-goog
> 
