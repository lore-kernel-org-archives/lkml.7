Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0896C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AD720644
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AboJlEzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfHMOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:20:44 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:44018 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfHMOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:20:42 -0400
Received: by mail-qt1-f169.google.com with SMTP id b11so6700042qtp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+YPqjPZCrZJbdipSIWGCakf0rdeaXkvJ3zkU32yFlA=;
        b=AboJlEzHANLJuRvwN0qONHsiKJoXhyw7Nlm5/vIwJhyTtUNPBVZhqeeGU7K1oZqAac
         StIdo/k+xB8krR98tkjvzw4SLQhj+qK6/dUU6uYHD1rlxDHURtooD6vr616pPUXNzCeP
         0ygm+c9oWNIE/KBrdyeuZS82cLZE2GLXk4BWGwkMVHH5IDf0LWj//4RlSQVqLgk9E3x1
         hrH/aJVwHdakNnRclddzqosfchmwumWPDvXXVM9BP8RJu+UkJlJoxtJu4f+KT8iVmakk
         41mBEjke31QHaibFmnJpSW5kq37yZ75mBZu6O0s23gNMSCRc7lAUk3jnjkHEbfQDLxds
         V5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+YPqjPZCrZJbdipSIWGCakf0rdeaXkvJ3zkU32yFlA=;
        b=ZoszyABmKCGBG5+mINbFoJCi2H6x1ncFhni37xf9r5pdVDbi9nTvX/hphK4Qfl8YEd
         VSVZszikne2kNaIkPCLwcymPRCLUVjJKBVmWbhu+9muEZlWN1RWN2e7BWh7/m78FTzo9
         sVS2X4MifYRpO7nAZkAxb46mhaHiOuEYCplckFFa0b+DuPiEduB2YLU7VgmbJhGVBvuN
         XGTyDw331TcOqKpOTCOxU9tDl+JyqUIrsEHntVCn4+Sx4pE27YTlbG/edZcAEG2Z3mlW
         oxTSWHCfqhDeArq5IIwzyLoSTm2F4SD0tX6peZba5mWoKSPOITp92oTJyOt0i15/2WnQ
         YRTA==
X-Gm-Message-State: APjAAAWsdGqu4KqizqjVDRN2KUrdOxRy54HG+DxzCTJGnpR7Qsmc30Gt
        O2DO0hLSggfv4rxErteSDZ8=
X-Google-Smtp-Source: APXvYqyB22ltjLwXZhUAF1XgfU4XTTVgV+WCMMScFdQwuLZytLRNkdkV2VSXf05gmVpyx73Q/Vyr0Q==
X-Received: by 2002:a0c:80cc:: with SMTP id 70mr17379443qvb.203.1565706040951;
        Tue, 13 Aug 2019 07:20:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y194sm50334031qkb.111.2019.08.13.07.20.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:20:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B67FD40340; Tue, 13 Aug 2019 11:20:37 -0300 (-03)
Date:   Tue, 13 Aug 2019 11:20:37 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Simon Que <sque@chromium.org>
Subject: Re: [patch] perf.data documentation clarify HEADER_SAMPLE_TOPOLOGY
 format
Message-ID: <20190813142037.GD12299@kernel.org>
References: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
 <20190802131440.GC27223@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802131440.GC27223@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 02, 2019 at 03:14:40PM +0200, Jiri Olsa escreveu:
> On Thu, Aug 01, 2019 at 02:30:43PM -0400, Vince Weaver wrote:
> > +        }
> > +}[count];
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks for doing this,

Thanks, applied.

- Arnaldo
