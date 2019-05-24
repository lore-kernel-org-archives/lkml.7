Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC6EC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA2217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liOkQIXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbfEXSqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:46:14 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38021 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfEXSqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:46:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id p26so6436990qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IoB71L3djsCZ7bHbX+R8KL8dGOgZjjWcP/e3MrnOUac=;
        b=liOkQIXL+nQ7v498p/4REooeG3rRjamBvyOSfvJWj9qRhCPy8LVsptkVgC4BAegbBG
         mpYJjrMyV6eC+uHVLWus84tfvXPzBBl37PV30A5UN4op2w6fAAO57g5OXWO8x1qTqIGW
         FI0KVN7nnXy7jtQuRo4yrfxEY44d/JDePJdB6F/WkCNjbzPtLMAaP5vV86/LS93z7fBC
         SmOrXJoHTCfKdppoW4ARHSVsVpD11ZTpgkNqS6zrlIOQ4vuecRCYc7o/rYSHJ0xLu6bm
         q2HkVgCLLSf8cMX71tWF4TBiyhcxcsyOzT5ATT/ElK6Cyq3BTPdxb4eY0Qk5ijMOiQj7
         UfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IoB71L3djsCZ7bHbX+R8KL8dGOgZjjWcP/e3MrnOUac=;
        b=MSWedzx/cC4K/CxuVdQKzu8z91ElGvtCjtQyHJTnKggbEXcIXMH/vHp/QrKxsF8n6K
         VlLmASMkFjMDSUfiCfuodFqApkiWZvXP+hE6YtvBUzjBzxNf7UkgBZ7NCaZPVLR4IZxs
         7S9FS9iNx4tui8OplD3VQZzLLs2vIXKpwRu9zearf4N9BJWtWFQN77edv8dEXtf9EQye
         hy+L9yA7EoBuv90Z0NhvwVHo3V9YOJFN1kcHAmTmnjvLe9MefnkX/nhORYDINJ8lae4V
         brvHN0LETpEacoLC+myz5zfaLwUhd0DVvRHBbugQaHdC3Ps512E5uj3NftU+BdoFyoAs
         LNbg==
X-Gm-Message-State: APjAAAXTExkuseiALiFXAeBmyI237jAOWNc1p4SPw4p2qG8K1wJVDzcU
        tSBzO6gb0nbt34rQZDlKzDEDZm3T
X-Google-Smtp-Source: APXvYqyQSbU8rR4+eC5QmKGq7a0bRumySciVNN4C7VIiFTYsBl5FFmNFcRUxnpS29FchhY2jN+vaYQ==
X-Received: by 2002:a0c:d2b0:: with SMTP id q45mr76886415qvh.185.1558723572357;
        Fri, 24 May 2019 11:46:12 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id i37sm1546901qtb.31.2019.05.24.11.46.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 11:46:11 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 585AF41149; Fri, 24 May 2019 15:46:07 -0300 (-03)
Date:   Fri, 24 May 2019 15:46:07 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/12] perf tools: Read also the end of the kernel
Message-ID: <20190524184607.GG17479@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-6-jolsa@kernel.org>
 <20190524181506.GE17479@kernel.org>
 <20190524181717.GF17479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524181717.GF17479@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 24, 2019 at 03:17:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, May 24, 2019 at 03:15:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, May 08, 2019 at 03:20:03PM +0200, Jiri Olsa escreveu:
> > > We mark the end of kernel based on the first module,
> > > but that could cover some bpf program maps. Reading
> > > _etext symbol if it's present to get precise kernel
> > > map end.
> > 
> > Investigating... Have you run 'perf test' before hitting the send
> > button? :-)
> 
> <SNIP>
> 
> > [root@quaco c]# perf test -v 1
> >  1: vmlinux symtab matches kallsyms                       :
> <SNIP>
> > --- start ---
> > ERR : 0xffffffff8cc00e41: __indirect_thunk_end not on kallsyms
> <SNIP>
> > test child finished with -1
> > ---- end ----
> > vmlinux symtab matches kallsyms: FAILED!
> > [root@quaco c]#
> 
> So...
> 
> [root@quaco c]# grep __indirect_thunk_end /proc/kallsyms
> ffffffff8cc00e41 T __indirect_thunk_end
> [root@quaco c]# grep -w _etext /proc/kallsyms
> ffffffff8cc00e41 T _etext
> [root@quaco c]#
> 
> [root@quaco c]# grep -w ffffffff8cc00e41 /proc/kallsyms
> ffffffff8cc00e41 T _etext
> ffffffff8cc00e41 T __indirect_thunk_end
> [root@quaco c]#
> 
> Lemme try to fix this.

So, I got this right before your patch:

commit 1d1c54c5bbf55256e691bedb47b0d14745043e80
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Fri May 24 15:39:00 2019 -0300

    perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
    
    No need to search for aliases for the symbol that marks the end of the
    kernel text segment, the following patch will make such symbols not to
    be found when searching in the kallsyms maps causing this test to fail.
    
    So as a prep patch to avoid breaking bisection, ignore such symbols.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Stanislav Fomichev <sdf@google.com>
    Cc: Thomas Richter <tmricht@linux.ibm.com>
    Link: https://lkml.kernel.org/n/tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 7691980b7df1..f101576d1c72 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -161,9 +161,16 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 				continue;
 			}
-		} else
+		} else if (mem_start == kallsyms.vmlinux_map->end) {
+			/*
+			 * Ignore aliases to _etext, i.e. to the end of the kernel text area,
+			 * such as __indirect_thunk_end.
+			 */
+			continue;
+		} else {
 			pr_debug("ERR : %#" PRIx64 ": %s not on kallsyms\n",
 				 mem_start, sym->name);
+		}
 
 		err = -1;
 	}
