Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF99C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B085121783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxbvjWDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLLhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:37:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44808 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLLhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:37:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so14074434qki.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9//t3TUYIBVJJ+ZsbDX5vpCRXW0J+fdm65ilHOMTvU=;
        b=LxbvjWDMII7MOqbO4KB0f4s/ey4o9svsUbvaDVZC2pbXSqipr80HnxZnlO4uznUaP/
         61zCFhajNSBxljN5tXhuApLNgteHfRd0anhkBO32F6xgPIn7oDUKUTD8vmwbl0KfrnxF
         MSuxss2sfIbDq9FzLQ8NfPgTr54Lynl+cE/guXdqSG0EIFLxpCgYoNNrljsQLexN2xS9
         YtUE6RrGuoXE8FQ/RDQnIN4jE/acDDKVC8174gRfP4sXl9OpMkSsvC8iEsNKg57QWFqg
         P0lyueveWFTMQcP8uEXox1CIRlira+0wIRY3b75wJ4xDk+boz4hwyfkuJo+rBVxPxz69
         l0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9//t3TUYIBVJJ+ZsbDX5vpCRXW0J+fdm65ilHOMTvU=;
        b=WXRu0pxgoHCyrEZVp8FaPLUdlmKEieCTQDJUNiMKpMoiri5tcNKWr6lbPybBdbY/bq
         GRdtg7QdDetz8fVjyhXU/T5UlQdeIybqHwQdmlGMrMmq86fKG4eZ1UUyH9jMM9phYuDL
         92KAqwvxR8BEOdbkThQh1I0XKbPOSxjbP9k3TIGGzs1HfyM/DcVef4pfAKFMQb5tW2Rw
         YH/201uMCDHaXC9amazLQkd/5vyJpfmskcnQhgd4pqX1UEPOont590VbtCJx2yX5YYjO
         0OppKwGQ8K4XleeR+7Cb3rIbEvegGdvhWRMctuJL6llaY8+L7uqvGhGk2SngezSbQkuS
         /aNw==
X-Gm-Message-State: APjAAAWgNF/gfar4B/xRJxvfDbhtUm3MBSGKnwRsjZEO8Be+/1e06+il
        rw7idAWDJERttZWOOc6O6KJPzEsn
X-Google-Smtp-Source: APXvYqxqZiWq4ZziOEV7wQXWTeAUbCAUSsimtBgwwpX9k2+4S9+jzn12Ks74OzV058QY7wKYqeFzeA==
X-Received: by 2002:a37:9343:: with SMTP id v64mr14039857qkd.241.1573558672859;
        Tue, 12 Nov 2019 03:37:52 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.182.211.47])
        by smtp.gmail.com with ESMTPSA id w18sm9665277qkb.41.2019.11.12.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 03:37:52 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC7C0411B3; Tue, 12 Nov 2019 08:37:48 -0300 (-03)
Date:   Tue, 12 Nov 2019 08:37:48 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf tool: Provide an option to print perf_event_open
 args and return value
Message-ID: <20191112113748.GL9365@kernel.org>
References: <20191108093024.27077-1-ravi.bangoria@linux.ibm.com>
 <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
 <20191108110009.GE18723@krava>
 <20191112112910.GK9365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112112910.GK9365@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 12, 2019 at 08:29:10AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 08, 2019 at 12:00:09PM +0100, Jiri Olsa escreveu:
> > On Fri, Nov 08, 2019 at 03:11:28PM +0530, Ravi Bangoria wrote:
> > > Perf record with verbose=2 already prints this information along with
> > > whole lot of other traces which requires lot of scrolling. Introduce
> > > an option to print only perf_event_open() arguments and return value.
> > > 
> > > Sample o/p:
> > >   $ ./perf --debug perf-event-open=1 record -- ls > /dev/null
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     size                             112
> > >     { sample_period, sample_freq }   4000
> > >     sample_type                      IP|TID|TIME|PERIOD
> > >     read_format                      ID
> > >     disabled                         1
> > >     inherit                          1
> > >     exclude_kernel                   1
> > >     mmap                             1
> > >     comm                             1
> > >     freq                             1
> > >     enable_on_exec                   1
> > >     task                             1
> > >     precise_ip                       3
> > >     sample_id_all                    1
> > >     exclude_guest                    1
> > >     mmap2                            1
> > >     comm_exec                        1
> > >     ksymbol                          1
> > >     bpf_event                        1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid 4308  cpu 0  group_fd -1  flags 0x8 = 4
> > >   sys_perf_event_open: pid 4308  cpu 1  group_fd -1  flags 0x8 = 5
> > >   sys_perf_event_open: pid 4308  cpu 2  group_fd -1  flags 0x8 = 6
> > >   sys_perf_event_open: pid 4308  cpu 3  group_fd -1  flags 0x8 = 8
> > >   sys_perf_event_open: pid 4308  cpu 4  group_fd -1  flags 0x8 = 9
> > >   sys_perf_event_open: pid 4308  cpu 5  group_fd -1  flags 0x8 = 10
> > >   sys_perf_event_open: pid 4308  cpu 6  group_fd -1  flags 0x8 = 11
> > >   sys_perf_event_open: pid 4308  cpu 7  group_fd -1  flags 0x8 = 12
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     type                             1
> > >     size                             112
> > >     config                           0x9
> > >     watermark                        1
> > >     sample_id_all                    1
> > >     bpf_event                        1
> > >     { wakeup_events, wakeup_watermark } 1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
> > >   sys_perf_event_open failed, error -13
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]
> > > 
> > > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > ---
> > > v1->v2:
> > >  - man page updates.
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> [root@quaco ~]# perf test -v python
> 18: 'import perf' in python                               :
> --- start ---
> test child forked, pid 19237
> Traceback (most recent call last):
>   File "<stdin>", line 1, in <module>
> ImportError: /tmp/build/perf/python/perf.so: undefined symbol: debug_peo_args
> test child finished with -1
> ---- end ----
> 'import perf' in python: FAILED!
> [root@quaco ~]#
> 
> Please always test your changes using 'perf test', before and after, to
> see if some regression is being added. I'm trying to fix this one.

I added this to fix this issue,

- Thanks,

- Arnaldo

[acme@quaco perf]$ git diff -U5
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 25118605f3f8..83212c65848b 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -63,10 +63,11 @@ struct perf_env perf_env;
 /*
  * Support debug printing even though util/debug.c is not linked.  That means
  * implementing 'verbose' and 'eprintf'.
  */
 int verbose;
+int debug_peo_args;

 int eprintf(int level, int var, const char *fmt, ...);

 int eprintf(int level, int var, const char *fmt, ...)
 {
[acme@quaco perf]$
