Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35189C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390556AbfEXKGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:06:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390248AbfEXKGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:06:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C10AF128B5;
        Fri, 24 May 2019 10:06:25 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7C1361001E77;
        Fri, 24 May 2019 10:06:19 +0000 (UTC)
Date:   Fri, 24 May 2019 12:06:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3 00/12] perf tools: Display eBPF code in intel_pt trace
Message-ID: <20190524100618.GB15339@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190524002721.GA17479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524002721.GA17479@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 24 May 2019 10:06:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 09:27:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 08, 2019 at 03:19:58PM +0200, Jiri Olsa escreveu:
> > hi,
> > this patchset adds dso support to read and display
> > bpf code in intel_pt trace output. I had to change
> > some of the kernel maps processing code, so hopefully
> > I did not break too many things ;-)
> 
> One of these patches need some uintptr_t (IIRC) somewhere:
> 
>   CC       /tmp/build/perf/util/color_config.o
> util/dso.c: In function 'bpf_read':
> util/dso.c:725:8: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   buf = (u8 *) node->info_linear->info.jited_prog_insns;
>         ^

would something like below help? we already do that
in the annotation code

thanks,
jirka


---
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 6b8ef5b427f5..f0d9ca5805a6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -722,7 +722,7 @@ static ssize_t bpf_read(struct dso *dso, u64 offset, char *data)
 	}
 
 	len = node->info_linear->info.jited_prog_len;
-	buf = (u8 *) node->info_linear->info.jited_prog_insns;
+	buf = (u8 *)(uintptr_t) node->info_linear->info.jited_prog_insns;
 
 	if (offset >= len)
 		return -1;
