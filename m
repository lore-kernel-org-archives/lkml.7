Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AE9C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FDB2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="aXrN+CKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388579AbfGWPGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:06:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46021 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731767AbfGWPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:06:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so31384641qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=aCAAdPR+vzZvbtfyN75VsMsViqAvyUvVOJJxgwLDuvQ=;
        b=aXrN+CKA9Wne+VdWgteAfrggZb7XCWrZKmRzDn9qcSkxVnkxGR2A6tDBVMY/jcgYKv
         c6XJzZ8c19D3gaYAyeXCWH9aIJ3NUVFXrMsEtMusSz+IMaLp0vlrJ2OTMg7mlv8ztrmi
         MQCns1BkK7yjkrZMa59WVmRxf9ZaljT4HOF44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=aCAAdPR+vzZvbtfyN75VsMsViqAvyUvVOJJxgwLDuvQ=;
        b=Lh19J1g75w3dZJAsOlN9hPOyX0eWqDJMqM6VKeEGl8FP9TnXYLYcSmiFnoUPWCDHeR
         ovKoJTWy3TEjD3rk4UYeQeB8dduS/QjX31ebhZ0DXDZxi2nrbfrkGZmnotPR7Wdso1vy
         PivO2Sz+d6fAUnjK74C5Ur28G6X0GDHpsybY2EaouOe26TpY14hqbD/98nt0Ir/Ehho0
         8rM2YpNkzetcO2lOurAFWFKG36bke9XtAtBvErNXgkLiohuWCFll0RqQvxpbeANnJyzN
         c5POWx2VgITOHWN4g6yb7qCB8ZEOmrTp9IhDdGmfFOGCCcpspgPS2NGkpN+13wjHpu+D
         yxFw==
X-Gm-Message-State: APjAAAWPGcKSV1ZvPzbESCzgv+iT+7f9eNwtOVV5U32CL0fgQgUt2Lhl
        WNBkvzX91efxMNlnDVh+b1RORLU2n+0=
X-Google-Smtp-Source: APXvYqx/zssfVwQu40XGl7xRTA+bqaq8j/0ifpkJN2hF3XJY9trovgwa52mGDbPiFZ5QxVxtx9wloA==
X-Received: by 2002:a37:749:: with SMTP id 70mr50568757qkh.399.1563894365952;
        Tue, 23 Jul 2019 08:06:05 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id r26sm18950094qkm.57.2019.07.23.08.06.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 08:06:04 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 23 Jul 2019 11:06:01 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [patch] perf tool divide by zero error if f_header.attr_size==0
Message-ID: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

so I have been having lots of trouble with hand-crafted perf.data files 
causing segfaults and the like, so I have started fuzzing the perf tool.

First issue found:

If f_header.attr_size is 0 in the perf.data file, then perf will crash
with a divide-by-zero error.

Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index c24db7f4909c..26df60ee9460 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3559,6 +3559,10 @@ int perf_session__read_header(struct perf_session *session)
 			   data->file.path);
 	}
 
+	if (f_header.attr_size == 0) {
+		return -EINVAL;
+	}
+
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
