Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D05C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589222146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBut9G4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGBPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:53:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45897 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfGBPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:53:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id s22so14499510qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BxB9Tl2bXtJ3atZnYg8/Qz4JqG30kxmg1I7DaT0xgrs=;
        b=sBut9G4DQmYqBK8Lwl+wBqQHZ8JeuTwdzjcNohb+f16pi0PjIFqpOgIjPkRI8rP7Dc
         cygwa4+ewYavgxgJ5rFjMFmFlrdIf8fcMDAfiU/lXVizLjAejFlsqponEABJmE3vQIUw
         3zV9cP6mtuybyBO3UhBt+Kkf4yCQe8F6gmiI6MAigy64gVtbyxuOoi8yPU3eWHPijXS8
         njsE4NINjRx2ItShIAcOsa17HAi9D862aPX2O+nMlXjyd3QlmwFYZdW3v3hICPwTiru+
         e/jB9bx4Rn6SVFMx0oOf3Caolf4ADxfh2+jjBwfKPAp0zIZXOS+lCA89/8X9wx7yZO0U
         jNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxB9Tl2bXtJ3atZnYg8/Qz4JqG30kxmg1I7DaT0xgrs=;
        b=jOHOa0i2rybvmSFE/iqfeHs617MWOHzkfMWsG/MwmrK30Wvlu0WelH37xPdqvPhw96
         kzHBz5rBF+PtGktQoOX8nkYHlzU/P/uREgDUPw6P+NCVMTjJ5YZYuNw31J4wHs1tJ3Eo
         emd8hS9QjbAj7AUAaWNeEg26QsYUyNTv+qgIcjux9K3pYFy68iwJ9gO27WvuwgGCxOAg
         QA1bG8sIpQntc4M8TSlS8a8pFc/wRpPuoQVsU19Gpdm/vPqSYZeTzqlTssjN3MHwf0KC
         WH6FhIoHvzx1UFfiztfE5jlC8X4QbI2iyf6gJx9N03SG1w1mHZ/F2eqlqzLZAUZ3CsFs
         GpGQ==
X-Gm-Message-State: APjAAAWYbWm//w/r9PC3fn7ENmCeIyZOIqhsowWKj+Ldwf4evyP8G+M1
        UEx3ifTlw88lAKVIdF7ggFg=
X-Google-Smtp-Source: APXvYqzGuDinmE4cVK+0aPZLo2+/8f40722qYF66Je1Q5D0ovm5p0O47bSOE7a0RL58cyE1qJlnOAA==
X-Received: by 2002:ae9:c108:: with SMTP id z8mr24722879qki.57.1562082823281;
        Tue, 02 Jul 2019 08:53:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m4sm5986120qka.70.2019.07.02.08.53.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:53:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8279841153; Tue,  2 Jul 2019 12:53:40 -0300 (-03)
Date:   Tue, 2 Jul 2019 12:53:40 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, tmricht@linux.ibm.com,
        brueckner@linux.ibm.com, kan.liang@linux.intel.com,
        ben@decadent.org.uk, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com,
        ak@linux.intel.com
Subject: Re: [PATCH v3 0/4] Perf uncore PMU event alias support for Hisi
 hip08 ARM64 platform
Message-ID: <20190702155340.GE15462@kernel.org>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
 <20190628145406.GA22863@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628145406.GA22863@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 04:54:06PM +0200, Jiri Olsa escreveu:
> On Fri, Jun 28, 2019 at 10:35:48PM +0800, John Garry wrote:
> > This patchset adds support for uncore PMU event aliasing for HiSilicon
> > hip08 ARM64 platform.
> > 
> > We can now get proper event description for uncore events for the
> > perf tool.
> > 
> > For HHA, DDRC, and L3C JSONs, we don't have all the event info yet, so
> > I will seek it out to update the JSONs later.
> > 
> > Changes to v3:
> > - Omit "perf pmu: Fix uncore PMU alias list for ARM64", as it has already
> >   been picked up
> > - Add comment for pmu_uncore_alias_match()
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
