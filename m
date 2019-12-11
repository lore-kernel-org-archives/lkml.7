Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D24C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdruJzk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfLKNpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:45:34 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37335 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbfLKNpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:45:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id x18so15770243vsq.4;
        Wed, 11 Dec 2019 05:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h6iaaC/ZysMWw2yq1ayAfJEWzcGD5SfpZw0LM+PG5Xc=;
        b=IdruJzk2JNyzcV97HrSSa2wrfDo+1xFfhqhgOmCWs6L1Fs7uXDy4W7mTo6uQOi1gCN
         M/BtB7crbkEHU2eAUlc77fV7Vtwtvnog1q276H2kD4xGjR9rUIWp5LIy2PdDNY8qvylS
         Gz9LZ8FAJapQxirsBBHPreFi2+OyFEnKChkbM79brca4MoBBZIBhouKwkqGp4ob79wFR
         m9nOUrqnQ7Ayg/JajABHR54XxHcqhZeooSEG1I1GJqsPzDyerO6EMZeJbi0Sotd9J2mi
         zTs1KjgrEMDib/4WAo5DPnDzwAawrx57TiRi/MlY9TuHCMvY0F7oaEzX4cdWaBroMehn
         V2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6iaaC/ZysMWw2yq1ayAfJEWzcGD5SfpZw0LM+PG5Xc=;
        b=k72y+zy/lsh5mSutsF6HISRc2L9apHoGiohryuZJCPumAAwCjrWeoaG38hL+N1Wm+p
         6k868Gvo2PAduJ6JKzfRdJjJ8IaZO78Ij13BvPd+cT571E7Ck11MPzJkXv7QOAalIczk
         sRd1g1dqNpBExUQhiCQWTpsvgWSKOAB17RRSqzf6IY6HxnpMuxcgPtpSrlLDYDvTsRFw
         DhFXrRhTAB3P6CdkfxsRpqCLweWN+3HndjL2nMqrGY9Tm9Smuekj/BJuf0+ADFcbM3GT
         jDEtZggk+gvUhirO60eNgvJs75IYGgSqKrLTxxtB8wO/23wMdz5fdnD3H6g8jL8sx8S1
         qahw==
X-Gm-Message-State: APjAAAV16H0yBefuY1EnK2R4gZrfI5aSkzaOSsQSdrIAqEW9nLOlzy6k
        3jBysirfrfh6mI7PslYXX30=
X-Google-Smtp-Source: APXvYqx6WVGS/Ds8lX1CGUdz9o9yog/QyPFPEZBmir10Exu7My2T3F/QnIcVL8VtU3LFtHsoKMA1dQ==
X-Received: by 2002:a67:d592:: with SMTP id m18mr2716755vsj.85.1576071932181;
        Wed, 11 Dec 2019 05:45:32 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r1sm1021823vsi.33.2019.12.11.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:45:31 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDF2140352; Wed, 11 Dec 2019 10:45:28 -0300 (-03)
Date:   Wed, 11 Dec 2019 10:45:28 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events
Message-ID: <20191211134528.GC15181@kernel.org>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
 <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 04, 2019 at 12:25:22PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 11/20/19 2:10 PM, Kajol Jain wrote:
> > Commit f01642e4912b ("perf metricgroup: Support multiple
> > events for metricgroup") introduced support for multiple events
> > in a metric group. But with the current upstream, metric events
> > names are not printed properly
> > 
> > In power9 platform:
> > command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
> >       1.000208486
> >       2.000368863
> >       2.001400558
> > 
> > Similarly in skylake platform:
> > command:./perf stat --metric-only -M Power -I 1000
> >       1.000579994
> >       2.002189493
> > 
> > With current upstream version, issue is with event name comparison
> > logic in find_evsel_group(). Current logic is to compare events
> > belonging to a metric group to the events in perf_evlist.
> > Since the break statement is missing in the loop used for comparison
> > between metric group and perf_evlist events, the loop continues to
> > execute even after getting a pattern match, and end up in discarding
> > the matches.
> > Incase of single metric event belongs to metric group, its working fine,
> > because in case of single event once it compare all events it reaches to
> > end of perf_evlist.
> > 
> > Example for single metric event in power9 platform
> > command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
> >       1.000094653                  0.2
> >       1.001337059                  0.0
> > 
> > Patch fixes the issue by making sure once we found all events
> > belongs to that metric event matched in find_evsel_group(), we
> > successfully break from that loop by adding corresponding condition.
> > 
> > With this patch:
> > In power9 platform:
> > 
> > command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
> > result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
> >       derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
> >           dslb_miss_rate_percent islb_miss_rate_percent
> >       1.000135672                         0.0                  0.3
> >                    1.0                          0.0                  0.2
> >                   0.0                     0.0
> >       2.000380617                         0.0                  0.0
> >                                                0.0                  0.0
> >                  0.0                     0.0
> > 
> > command:# ./perf stat --metric-only -M Power -I 1000
> > 
> > Similarly in skylake platform:
> > result:#           time    Turbo_Utilization    C3_Core_Residency
> >              C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
> >               C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
> >       1.000563580                  0.3                  0.0
> >                    2.6                44.2                 21.9
> >                    0.0                  0.0                  0.0
> >       2.002235027                  0.4                  0.0
> >                    2.7           43.0                 20.7
> >                    0.0                  0.0               0.0
> > 
> > Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> > Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> > Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Fixes: f01642e4912b ("perf metricgroup: Support multiple events for metricgroup")
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Tested on a Skylake machine and applied.

> But while looking at the patch, I found that, commit f01642e4912b
> has (again) screwed up logic for metric with overlapping events.

Is someone looking into this?
 
>   $ sudo ./perf stat -M UPI,IPC sleep 1
> 
>    Performance counter stats for 'sleep 1':
> 
>            948,650      uops_retired.retire_slots
>            866,182      inst_retired.any          #      0.7 IPC
>            866,182      inst_retired.any
>          1,175,671      cpu_clk_unhalted.thread
> 
> This also needs to be fixed.
> 
> Ravi

-- 

- Arnaldo
