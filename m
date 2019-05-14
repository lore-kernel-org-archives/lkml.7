Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A453BC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6552F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 21:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0nfuYRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfENVqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 17:46:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44671 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENVqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 17:46:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id f24so871396qtk.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ihW11phzc9Qo9qPh9rCwT+VZCf/Ma8yV/b8VK1mEZRI=;
        b=M0nfuYRHMyR37KCI7m4i6Tpj/uohxKsi7fp+1vFy/m/RtBN7s9mOdHREU4jKiU/41d
         7B1c1PxIeBrQVpB9Rl8S3NXBG7lSQOs9KQ4HAh4dDyhZcpVf+IStmcVP7Ka0Kg2hyMVJ
         ReBFssDSPFGiP/0l3/XOPnWN6mmtPph6/2aXFBKo3/Tw8FJdbLJETLJL1QiLOy0wx42D
         0FYAYT76gpwu5Cg2+Br8mMUOZu65skxDF35Wf3G9N5qaDmWrafhO82SdQ03UKTk+dLzZ
         zlvU1E35QKY/YO28mXyiWlgqkmuvrgz6Z6DQTaolgVvGqr1Dr21joomH8RMBk/Zf3qY8
         US7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ihW11phzc9Qo9qPh9rCwT+VZCf/Ma8yV/b8VK1mEZRI=;
        b=TFDAfECMuvbrKZbjxgB6chLDk5CatT4M8TIoKIu9mxyZeye2D8xATg7/amZMI6aZAq
         6vkkiNnsEByVh6Cm5IPurQ42MaeB10zRzuVynb7m+yzbraLfY94JnXsmpYfY1jj9o3rS
         u7t9REgC3TJ7oq3uav68Io4G+iMqREILcnWqtaDX8HoHMPmiRmxK0ZKy1Df2Y5kEElGE
         NOZmzsFPeYwUX9KkovTuyfcP/YihZiZ+DWKf33vMSFch4CRCm+qXsacVrmWOo7k36u50
         4rFMVwnJMWLKarQSaOJvdmtVLj70OXULyuQ+1DRWi6rqVDqkwSnvLh4c4M9K4R8kqrDz
         j8EA==
X-Gm-Message-State: APjAAAWCaExvnIxYezbdeVu2+qU2wdxBOjd4+A0pE4Bd78F0hGdFwxFm
        jUCj3KDCvhfh591iyRY0JUE=
X-Google-Smtp-Source: APXvYqxp2L9unq6EelhXIgpz1T1KVt9LSJAsYhbreMoKlCeQEj4nmk3CmgSSzoJHUvMfeHdUAFH7WA==
X-Received: by 2002:ac8:22d3:: with SMTP id g19mr10101733qta.236.1557870396569;
        Tue, 14 May 2019 14:46:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.181.141.36])
        by smtp.gmail.com with ESMTPSA id t57sm159526qtt.7.2019.05.14.14.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 14:46:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2DA3C403AD; Tue, 14 May 2019 18:46:31 -0300 (-03)
Date:   Tue, 14 May 2019 18:46:31 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
Message-ID: <20190514214631.GD8945@kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
 <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
 <20190514202041.GC8945@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514202041.GC8945@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 14, 2019 at 05:20:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
> > 
> > Implemented -z,--compression_level[=<n>] option that enables compression
> > of mmaped kernel data buffers content in runtime during perf record
> > mode collection. Default option value is 1 (fastest compression).

<SNIP>
 
> [root@quaco ~]# perf record -z2
> ^C[ perf record: Woken up 1 times to write data ]
> 0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
> [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]
> 
> [root@quaco ~]#

So, its the buildid processing at the end, so we can't do build-id
processing when using PERF_RECORD_COMPRESSED, otherwise we'd have to
uncompress at the end to find the PERF_RECORD_FORK/PERF_RECORD_MMAP,
etc.

[root@quaco ~]# perf record -z2  --no-buildid sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data, compressed (original 0.001 MB, ratio is 2.153) ]
[root@quaco ~]# perf report -D | grep PERF_RECORD_COMP
0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
Error:
failed to process sample
0 0x4f40 [0x195]: PERF_RECORD_COMPRESSED
[root@quaco ~]#

I'll play with it tomorrow.

- Arnaldo
 
> I've pushed what I have to the tmp.perf/core branch, please try to see
> if I made any mistake in fixing up conflicts with BPF_PROG_INFO and
> BPF_BTF header features. I'll continue tomorrow with 10-12/12.
