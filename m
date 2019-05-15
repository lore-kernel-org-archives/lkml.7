Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39432C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051892082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfNL6Tz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfEOM76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:59:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36665 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOM74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:59:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so3119528qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H7vWHPEOfUWQDCdRb9nMH9UJg5JpATd6V9Ekx6lEzJQ=;
        b=OfNL6Tz4S173yaERsPtxIRkuP3qnpflx3fAgjuqvozsEId6hV8JT8ns91A9XcqH2WX
         OdRr+KyJ+uydSlWhK/EcxzWEJ2tzJ/jNRqR5pl+uQUD5gC9GvSlw3FDte5SEZWRLr1OD
         dpfBMUlI9ZjELTNXt6Jy6xW9A7n/UhUDK72TG+MeXlGOCdQA3pVyjeo6hnSVTTkRMMKM
         nPbs3eEPMpHs6QO5x1f5hddH6SpEBDX4013C1x+MbRQfM3+zHu13TyUJXTXrx8IYLFXX
         54kUpqZOfTcPr1xqeEMkka24OptqXvqDYtxhqeTkabnKQcL9fHbv/eBCRhUMfPLAwR+Q
         xN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H7vWHPEOfUWQDCdRb9nMH9UJg5JpATd6V9Ekx6lEzJQ=;
        b=X0AL+on/cx1o+P7zUeu3Iwv1yq6+FH7WBiuS0SYclZGj6yNgdGgmbPoYYQcvGTT7QV
         JT1w/Ckhk7URU4xicYpvSV9sm+RlxbztV3ClV1WxuLvvDr7rtJZMc6xvWe+L31M20CW8
         hvc+k9Baae7IyjEXxeBxzC1yt5OVtjDNWnc9umehcWWHA/4IL3dZo+JPOFZsh6SX8ran
         XnuutF/pj8bWKh8GkRpMy/cNRgOIwcmNycDexyv+3cM/rgmFMZjzn6ZxWZIWOV9rOLBs
         ssmGi7IBfmmtkFtUxZST+KVKSFUnq1aeI7W0yW2kmHT6GGuRouqzxE4ocNTt634soSiw
         utNw==
X-Gm-Message-State: APjAAAU+LYOWfvxR70a9i8kNpBmnJ2pYcH1vw0A7fClDOl4Qdx4LM+Tw
        XN9WhUJBIEF8QLd+pU+/h+Y=
X-Google-Smtp-Source: APXvYqzmZMY7HN3qlpWZSA9DoxeCytGwyW5AmeTv5Pe8fBohxkuuJq/X6MkvWFKWA4kzroJYjq9CuA==
X-Received: by 2002:ac8:6887:: with SMTP id m7mr16787450qtq.309.1557925194378;
        Wed, 15 May 2019 05:59:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id b1sm1043604qti.50.2019.05.15.05.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 05:59:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FF16404A1; Wed, 15 May 2019 09:59:51 -0300 (-03)
Date:   Wed, 15 May 2019 09:59:51 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
Message-ID: <20190515123802.GA23162@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 15, 2019 at 11:43:30AM +0300, Alexey Budankov escreveu:
> On 15.05.2019 0:46, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 14, 2019 at 05:20:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:

> >>> Implemented -z,--compression_level[=<n>] option that enables compression
> >>> of mmaped kernel data buffers content in runtime during perf record
> >>> mode collection. Default option value is 1 (fastest compression).

> > <SNIP>

> >> [root@quaco ~]# perf record -z2
> >> ^C[ perf record: Woken up 1 times to write data ]
> >> 0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
> >> [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]

> >> [root@quaco ~]#

> > So, its the buildid processing at the end, so we can't do build-id
> > processing when using PERF_RECORD_COMPRESSED, otherwise we'd have to
> > uncompress at the end to find the PERF_RECORD_FORK/PERF_RECORD_MMAP,
> > etc.

> > [root@quaco ~]# perf record -z2  --no-buildid sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.020 MB perf.data, compressed (original 0.001 MB, ratio is 2.153) ]
> > [root@quaco ~]# perf report -D | grep PERF_RECORD_COMP
> > 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
> > Error:
> > failed to process sample
> > 0 0x4f40 [0x195]: PERF_RECORD_COMPRESSED
> > [root@quaco ~]#

> > I'll play with it tomorrow.

> Applied the whole patch set on top of the current perf/core 
> and the whole thing functions as expected.

It doesn't, see the reported error above, these three lines, that
shouldn't be there:

0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
Error:
failed to process sample

That is because at this point in the patch series a record was
introduced that is not being handled by the build id processing done, by
default, at the end of the 'perf record' session, and, as explained
above, needs fixing so that when we do 'git bisect' looking for a non
expected "failed to process type: 81" kind of error, this doesn't
appear.

I added the changes below to this cset and will continue from there:

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d84a4885e341..f8d21991f94c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2284,6 +2284,12 @@ int cmd_record(int argc, const char **argv)
 			"cgroup monitoring only available in system-wide mode");
 
 	}
+
+	if (rec->opts.comp_level != 0) {
+		pr_debug("Compression enabled, disabling build id collection at the end of the session\n");
+		rec->no_buildid = true;
+	}
+
 	if (rec->opts.record_switch_events &&
 	    !perf_can_record_switch_events()) {
 		ui__error("kernel does not support recording context switch events\n");

---------------------------------------------------------------------------

[acme@quaco perf]$ perf record -z2 sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.292) ]
[acme@quaco perf]$ perf record -v -z2 sleep 1
Compression enabled, disabling build id collection at the end of the session
Using CPUID GenuineIntel-6-8E-A
nr_cblocks: 0
affinity: SYS
mmap flush: 1
comp level: 2
mmap size 528384B
Couldn't start the BPF side band thread:
BPF programs starting from now on won't be annotatable
perf_event__synthesize_bpf_events: can't get next program: Operation not permitted
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.305) ]
[acme@quaco perf]$

Will check if its possible to get rid of the following in this patch, to
keep bisection working for this case as well:

[acme@quaco perf]$ perf report -D | grep COMPRESS
0x1b8 [0x169]: failed to process type: 81 [Invalid argument]
Error:
failed to process sample
0 0x1b8 [0x169]: PERF_RECORD_COMPRESSED
[acme@quaco perf]$

- Arnaldo
