Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6478BC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337F3207FA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e58SeKlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfI3VVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:21:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36466 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732356AbfI3VVV (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:21:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id o12so18962160qtf.3
        for <Linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MXa+hRiK3mVnZ1zzAHzBL3wtL/tQLnl/R24YjxSzj6s=;
        b=e58SeKlcPK2ZHO32YRNNUJHRWaZVuk9zNF1q2DORNk7Yuy10HzLkjvjn7kFdi6QYGn
         KqO/yr5mcunOoeU/pSjZl7aX6mDVjyM5YioEquxYncIch5poeS9yRK4pYA/2OjbjrJLS
         D4BdMR7uvPJ3tJqzyzzY0eIRt2+DI4C0noM5CimGKFNLT25fzLSN7tRrZVzyzVJFZpnW
         l/fPRI+5izXTYEczQb1ONHw8GQ0ichYKmAwujJPsKf8F1teFMuquTpuwso+JyonfeZBy
         5mUYjbIeLG1eEVAeasn2mxgrvcyrOpMZyDUE4/iCtJcj9yHWkm7iZdhM2VNS5slhmp2k
         dLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXa+hRiK3mVnZ1zzAHzBL3wtL/tQLnl/R24YjxSzj6s=;
        b=HkiqOnoEtDK2hpawYjWeC8ptPFG6OSQQ2zKxZUmp5omoDbM3r2qZx+WGyAng/LBWcJ
         TmGfCPk9W+aMpd/MVATVGRXWodWRf5CnL8ag/ZL6ea1r7k5GzQlYfP2rUAenZ0vHuzSq
         88wEGN+0cj1zkGIwsmjJV4ClxII3BdvQPq/i9mAoXo8VcJ4AKt43w7SNkiONG66T0rlj
         LhAhAbR+WHx3jmT9D+e2I4Fyuqi8uJdcNlyuYtGr5QI+J9H7dcNTuyK4C5T6zVvcxpvX
         EkVp9dzdyXKow6n87aOEkOl3p6ZFihQEleU2tuk6NJEavU8AHHbgcVEKSTRBExn7LToR
         XedA==
X-Gm-Message-State: APjAAAXaAJ8JDFCFlXU/CMeuGpnLrJe48z7vheqeNjCIdua9hzTjpiCa
        OSrUF4DXNcvDfFiBu0jROemN2vuE
X-Google-Smtp-Source: APXvYqzJ96kHgoLxlaLwercaKOqIZyx6puqMEoozkw+hMDHeZ113iyABtIi2UqWSip2dD8uWIe6OJw==
X-Received: by 2002:ac8:1e1a:: with SMTP id n26mr27160024qtl.357.1569871684328;
        Mon, 30 Sep 2019 12:28:04 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.208.35])
        by smtp.gmail.com with ESMTPSA id t32sm9456493qtb.64.2019.09.30.12.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 12:28:03 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2522240DA4; Mon, 30 Sep 2019 16:28:00 -0300 (-03)
Date:   Mon, 30 Sep 2019 16:28:00 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf stat: Support --all-kernel and --all-user
Message-ID: <20190930192800.GA13904@kernel.org>
References: <20190925020218.8288-1-yao.jin@linux.intel.com>
 <20190929151022.GA16309@krava>
 <20190930182136.GD8560@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930182136.GD8560@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2019 at 11:21:36AM -0700, Andi Kleen escreveu:
> On Sun, Sep 29, 2019 at 05:29:13PM +0200, Jiri Olsa wrote:
> > On Wed, Sep 25, 2019 at 10:02:16AM +0800, Jin Yao wrote:
> > > This patch series supports the new options "--all-kernel" and "--all-user"
> > > in perf-stat.

> > > For example,

> > > root@kbl:~# perf stat -e cycles,instructions --all-kernel --all-user -a -- sleep 1

> > >  Performance counter stats for 'system wide':

> > >         19,156,665      cycles:k
> > >          7,265,342      instructions:k            #    0.38  insn per cycle
> > >      4,511,186,293      cycles:u
> > >        121,881,436      instructions:u            #    0.03  insn per cycle

> > I think we should follow --all-kernel/--all-user behaviour from record
> > command, adding extra events seems like unnecesary complexity to me
 
> I think it's useful. Makes it easy to do kernel/user break downs.
> perf record should support the same.

Don't we have this already with:

[root@quaco ~]# perf stat -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1

 Performance counter stats for 'system wide':

        69,937,445      cycles:u
        23,459,595      instructions:u            #    0.34  insn per cycle
        51,040,704      cycles:k
        11,368,152      instructions:k            #    0.22  insn per cycle

       1.002887417 seconds time elapsed

[root@quaco ~]# perf record -e cycles:u,instructions:u,cycles:k,instructions:k -a -- sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.340 MB perf.data (927 samples) ]
[root@quaco ~]# perf evlist
cycles:u
instructions:u
cycles:k
instructions:k
[root@quaco ~]#

To make it shorter we could have:

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7469497cd28e..7df28b0e9682 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -313,11 +313,11 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 <<EOF>>			{ BEGIN(INITIAL); }
 }
 
-cpu-cycles|cycles				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
+cpu-cycles|cycles|cyc				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
-instructions					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
+instructions|insn|ins				{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_INSTRUCTIONS); }
 cache-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_CACHE_MISSES); }
 branch-instructions|branches			{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_INSTRUCTIONS); }
 branch-misses					{ return sym(yyscanner, PERF_TYPE_HARDWARE, PERF_COUNT_HW_BRANCH_MISSES); }

And another thing that comes to mind is to make -M metrics be accepted
as -e arg, as someone suggested recently (Andi?), and also make it set
its events honouring the :k or :u modifiers:

[root@quaco ~]# perf stat -M ipc
^C
 Performance counter stats for 'system wide':

        15,030,011      inst_retired.any          #      0.3 IPC
        54,449,797      cpu_clk_unhalted.thread

       1.186531715 seconds time elapsed


[root@quaco ~]# perf stat -M ipc:k,ipc:u
Cannot find metric or group `ipc:k'

 Usage: perf stat [<options>] [<command>]

    -M, --metrics <metric/metric group list>
                          monitor specified metrics or metric groups (separated by ,)
[root@quaco ~]#


- Arnaldo
