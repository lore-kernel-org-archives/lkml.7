Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB417C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CABC2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT5iPOlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1OL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:11:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34222 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfC1OL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:11:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so23248442qtm.1;
        Thu, 28 Mar 2019 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6u9MKGrm1ZT3RfL6B29UBof4motHjjU50uRSCSEb0Iw=;
        b=BT5iPOlofm70JEwIDo+Tq45pu/J7YzaJQYiLTrdXWP8qglPODE7U+i7PqViwghup0d
         YBo2NFUvngOz83bQOJby0UH1shjzhKuaikmb7Gi8wCciJhcU3XLe8ZFDVgPOHrfvrjAj
         avcSWrQZ27NakoUsjnqttrO/tGBemfERQz0f4xJzykezYXKj6dohIpOMVyt/PMJKQ2oc
         7Ps5ZX3rfoHJa0910mI8sXRh6WcF55XruZiA+TDVZgo2BmLl0zNDtSMGj0FMFdGUWVMw
         cS+CLf9jNB/BeHh3BZ0Uxc65cw07Y4qyZC3PejBPionNGWcVGc/WBq3EwQyqk5DsC/O2
         jpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6u9MKGrm1ZT3RfL6B29UBof4motHjjU50uRSCSEb0Iw=;
        b=Ueppc18aOm2sPELWyshNSSrYUjVsO+MMPuYX/0ljljVp2bDs2hLQvso+v9/dg+dFOw
         KRPZ+kbatIu/KMMHcwomaDa5vDEzwrU1X3yVIinFznwwiyafA6uBVBoI3IlMfjqXAuwI
         GftbYV4xQHW9PFh41VwH+vOpiqkrbLNb6rLX5/ZPD7hJ0mxpboJaS/C6jWSrfaGOPf9W
         6UazfN/8r0aI/Lc7eLGdn/KGKwjlJIV0Ot+mUSWm1Ur3/rqhugqk756dNtZjDo5waX1Y
         Jd3OArmaZoGgquRNe0ywFblBKoqrultiU5BF65teRejJfeiMmOca/GJlxn5e7Td2Vy+G
         IakQ==
X-Gm-Message-State: APjAAAVwFUF2kIAs2wSsHkz6+o+po6D7JjFcbsPLjBrEJlBigonnZKSd
        9JyVf67yzKMdbbhi8d3CkssMtY0j
X-Google-Smtp-Source: APXvYqxcVP9tRWzRYtK8xucN3idYoBMa2AAe5g4IbtFYaHqfr0D9OS9vEBwdOecR0jX6vRSTB08p2w==
X-Received: by 2002:ac8:344a:: with SMTP id v10mr36372855qtb.9.1553782315014;
        Thu, 28 Mar 2019 07:11:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f22sm9386781qkm.22.2019.03.28.07.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 07:11:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C52474039C; Thu, 28 Mar 2019 11:11:51 -0300 (-03)
Date:   Thu, 28 Mar 2019 11:11:51 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf pmu: Fix parser error for uncore event alias
Message-ID: <20190328141151.GA9844@kernel.org>
References: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
 <20190318085322.GD5200@krava>
 <ff0cc658-7c71-3829-f54b-a786b35c5b79@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0cc658-7c71-3829-f54b-a786b35c5b79@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 27, 2019 at 03:53:30PM -0400, Liang, Kan escreveu:
> On 3/18/2019 4:53 AM, Jiri Olsa wrote:
> > On Fri, Mar 15, 2019 at 11:00:14AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > > Cc: stable@vger.kernel.org
> > > Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")

> > Acked-by: Jiri Olsa <jolsa@kernel.org>
 
> Could you please apply the fix?

yeah, applied.

- Arnaldo
