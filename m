Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496EFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE1C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCIQEiH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfCSOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:46:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37794 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfCSOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:46:37 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so22382269qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eyU1R0yIwpptDyrRfTZwBIyDTGolCltYsBnryjXkS3c=;
        b=OCIQEiH5s0dqfLIl9O6G2kWCezQUAXwY+VO0FymwX36qJaw8t3RPBdfIzPaJ+snvWt
         miTC4nB23RidqkITfvC4+XkltB3jHTqmaoz7jLm19arFBVBqS7HhLbeBlJPRE3lefVQ7
         vJfjm08gF+7MTLsbGYiQ+HyO6wXJ5O7hFzscoD9pJbIPTcS/JTr4yFoqz/adtX3aev41
         8xF/QEdQY79XtpTisQc4Rwyha0yFYDnLKp0uHkYWu0t9WCaOmLXrDULA5S0qrtz3oGsc
         c7Yd9E8CFxH4rg99LAO/nxS6jdgEx0gFFJEuZs78DLNhAvD78fD51yvwKoYAKHWkS18Z
         Jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eyU1R0yIwpptDyrRfTZwBIyDTGolCltYsBnryjXkS3c=;
        b=avZuVkDmmeaTmIkv/8c9Sk8ybiUC0J3P8G2ree/F6slX/Pzndg+CsFZ/gD6DIOL0hz
         Wn+cQh9rhJ5rmPkiVRIctMNZOeIA6mNzQ44A6YidRXBWIKHtBMJSGTTG0XgF1cie3Cdj
         D2XvGGsdw9nGtyiUQ5E7aPdHNcwG5JHxa7sajGQuJLS7lLB2v0NR5YrgKVPZZDyT3pmd
         /Pbwq5hkOY1oZs9sov6abS6RL1bf2Lkqsabbe5u7OYJEQOfx9w84OwC6PXENxxAcT1jH
         eIVttzy9uXVzfzt9/CAmdkAfHwoUU3JYygyXRPsR/31jCeIPezxwaWEHjMXZKsPUMs8N
         Y4HA==
X-Gm-Message-State: APjAAAXrhWO4NkLHuupF7U7xlHcOsVP+mfuiD13Ul3fKKtjRrnoJwkAj
        /8qfjqfNGE9qXEyn5FwXTtc=
X-Google-Smtp-Source: APXvYqxRtE0nh0eOge2P46DAfT4hS2MerX8Gmh4vyDC5eKm+GyEOnnCaah2AsdczWnRN5Gi8WGYjKw==
X-Received: by 2002:ac8:2f10:: with SMTP id j16mr2345107qta.29.1553006794905;
        Tue, 19 Mar 2019 07:46:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id j139sm7513019qke.26.2019.03.19.07.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:46:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 301B04039C; Tue, 19 Mar 2019 11:46:31 -0300 (-03)
Date:   Tue, 19 Mar 2019 11:46:31 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf tools: return errcode in
 cs_etm__process_auxtrace_info
Message-ID: <20190319144631.GE3029@kernel.org>
References: <20190315022649.17848-1-yuehaibing@huawei.com>
 <20190318171518.GH22548@kernel.org>
 <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 08:38:32AM -0600, Mathieu Poirier escreveu:
> On Mon, 18 Mar 2019 at 11:15, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
> > > From: YueHaibing <yuehaibing@huawei.com>
> > >
> > > 'err' is set in err path, but it's not returned to callers.
> > > Also fix a pass zero to PTR_ERR issue.
> >
> > Next time please submit two patches, one for the PTR_ERR and another for
> > not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
> > doing it this time.
> >
> 
> Please hold off on that - I've asked for other modifications to be
> done on this patch.

Do you really think that it is necessary to hold? The fixes are trivial
and I already have them split and applied, see them below, I think
whatever other changes can be done in further patches, no?

- Arnaldo

From 6c5c248935a4da12a582b1518a38ec35044833ee Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 15 Mar 2019 10:26:49 +0800
Subject: [PATCH 24/42] perf cs-etm: return errcode in
 cs_etm__process_auxtrace_info()

'err' is set in err path, but it's not returned to callers. Don't always return
-EINVAL, return err.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 110804936fc3..2257ac4dbff2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 err_free_hdr:
 	zfree(&hdr);
 
-	return -EINVAL;
+	return err;
 }
-- 
2.20.1

From 4ab1e71e45a91220bdca7fc3b79c600df81d9234 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 15 Mar 2019 10:26:49 +0800
Subject: [PATCH 25/42] perf cs-etm: Remove errnoeous ERR_PTR() usage in in
 cs_etm__process_auxtrace_info

intlist__findnew() doesn't uses ERR_PTR() as a return mechanism so its callers
shouldn't try to extract the error using PTR_ERR(ret-from-intlist__findnew()),
make cs_etm__process_auxtrace_info9) return -ENOMEM instead.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2257ac4dbff2..111f33cd1204 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 
 		/* Something went wrong, no need to continue */
 		if (!inode) {
-			err = PTR_ERR(inode);
+			err = -ENOMEM;
 			goto err_free_metadata;
 		}
 
-- 
2.20.1

