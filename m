Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8EB21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA3+Aoq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfGCSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:30:58 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:33777 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCSa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:30:57 -0400
Received: by mail-qk1-f175.google.com with SMTP id r6so3634434qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n7VNjaI2aCGOMzbyzYJu0FlkDpcbiq36WN05mA2Mw60=;
        b=uA3+Aoq0vcQ2HU7BW0W3uFIvooxh5zJAicAdJlnII3k0YyHR9E+Q7QsEDCVD/dLyg0
         PeD4xk04TmX+FO2VbyFeSXhY71p6099MP0Wr9To1Pfw/vWsf1Wi84bzpVHCol2x2wxql
         yaJsin96M4FHUJVvyoamZ1fokSAO1MJ2kgn08DcNTgX92XBcX+Z0yhjgo0+rMpBX+xyB
         qig59D/j4PkAS0LpU1vLVK6BG+l/6qMHoKSgUlC7IPtuRZxkUqTgvtxImHu9eswCX7RO
         9rfoca+rLCKZh54KVGbXfprPkKpIhVANQbtINB5ZpPZ2sHZgft3z27X0bif3dafOGvpv
         Kcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n7VNjaI2aCGOMzbyzYJu0FlkDpcbiq36WN05mA2Mw60=;
        b=PLGI1JTwvCsfxEMFCxAOUKIV6yJ3yhMM6qahly3TM93bds5choLtlItwFR6+rSBWRt
         8LaknC2vj6yeyAoditPiATfCXDPLU9uE9SOxY5Rj9Ud6TIL1/kjzpU9zBZj0PM/ctSX1
         sM5orMAqVkUhxsKSXQSjLvlG3sQFoHghjRNtpNlUlmqddnkClmVIq62jX3k7j3Rtqr0D
         5E/CV613g7qBTm/xMNwvxUGUE3LN7M89hlg3B0Jf5lKdJFYkin368KCI9tTc7/XgqBXZ
         Mv5CTgWbVaf93QggUox70rXJqt+ivwObjX0qDjeRql4DjMciPzcJ07UjqPNzroNUcNKz
         FiRQ==
X-Gm-Message-State: APjAAAX3OczcHWcQrliUBAa7ZKR54L7d8Ph32kPGsMmFcflnIjGrcttp
        sD2fbaz2L+x858OSgAH54y0=
X-Google-Smtp-Source: APXvYqxYzy1qzCyHjrrJfVEVrY9v2gcLdlabSBzmkUU2CYn+nzk3tyX/7QuHrY/L/m86oMEMDCtI5Q==
X-Received: by 2002:a37:aa0d:: with SMTP id t13mr33660607qke.167.1562178656551;
        Wed, 03 Jul 2019 11:30:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id p21sm1195100qtq.17.2019.07.03.11.30.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:30:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5542A41153; Wed,  3 Jul 2019 15:30:49 -0300 (-03)
Date:   Wed, 3 Jul 2019 15:30:49 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 03/11] perf top: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190703183049.GD10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-4-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 06:34:12PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.
> 
>   tools/perf/builtin-top.c:109
>   perf_top__parse_source() warn: variable dereferenced before check 'he'
>   (see line 103)
> 
>   tools/perf/builtin-top.c:233
>   perf_top__show_details() warn: variable dereferenced before check 'he'
>   (see line 228)
> 
> tools/perf/builtin-top.c
> 101 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
> 102 {
> 103         struct perf_evsel *evsel = hists_to_evsel(he->hists);
>                                                       ^^^^
> 104         struct symbol *sym;
> 105         struct annotation *notes;
> 106         struct map *map;
> 107         int err = -1;
> 108
> 109         if (!he || !he->ms.sym)
> 110                 return -1;
> 
> This patch moves the values assignment after validating pointer 'he'.

Applied, thanks,

- Arnaldo
