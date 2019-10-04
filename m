Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25821C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3F720700
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQon2e2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfJDOij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:38:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34386 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388724AbfJDOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:38:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so8885473qta.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KaBcbsZKrfdWjmFP/gRXTF99ALN/AFLTaqqW3Y6Opp8=;
        b=qQon2e2iI77vMjetm1uaf26z5GQ1Ipsrbnq0ZSdT8Vqc+zieAbPnBugAwgG0KTHfD/
         74kzE2xPcLxXHx/PV784cqUiF7YqjYeMTv+/ubsDNPk1UGuW71MPX5iXj4ega+iRTrfX
         PRL/dTJoMvhCRStdbh5BLjwkUe/CfjNRabos2EKhiXv42Ams9mu72qPjNtJPkBuxuImR
         iNJ+uNIVCJmlAUBVN7arj39XW4lLjdJ7wEKDkK3NuJVDiXne0sIo/33JoPVVbaFnMpjy
         Paw6RbNW60GWi3e5QKIrdgG+ki2vbdayHCJOdkWpVnZlx74vCE3OQhMqocPHz9CYZYYC
         H6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KaBcbsZKrfdWjmFP/gRXTF99ALN/AFLTaqqW3Y6Opp8=;
        b=RyQfFwR4Xkw2/P/blMgHNx6zTpMxTe3bFkuSfG/OO7nzf3bNcaMObbgi8MLi2Yl77+
         4+mN8ORYh1vOq3MzrzQN9+DzIf631Rjib2WRrVMbPP1T/MJDpFd+4uUZNT4PYgNrqcWo
         TrUBh+5YzSFSYu7NxELcc6BVlf1YrHVxQJMHUZvWrgK/b1MXMZ05B+PesJQv++QN/jcu
         gO+xGcs0e/gLfLTLchSRTqv7xt5xR3rjGvPrmAt8PEvIgH5ehgQ45MribipOCpbswGSD
         5P5XWACegxfMMRh7BRs7PKeqdMWMfeUvJ4OLmG83jx6rmEswvKwnlKyITIaEW9Yewog4
         +puw==
X-Gm-Message-State: APjAAAUEpXOaRXqj5uroePbW58uLuruZrJAYxDBF5lLcCZgTjh/JHx1X
        syGhvksLZGKq/ninfOvUtnC+5Ztm
X-Google-Smtp-Source: APXvYqzOvWbnCv2ms9URpH+bcwPLvqya/V2pECUq0buh6DpnmOtPGrwnc2vYy0Ua9hPxsjZj18sMGw==
X-Received: by 2002:ad4:5604:: with SMTP id ca4mr2025146qvb.50.1570199917891;
        Fri, 04 Oct 2019 07:38:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id c201sm3151327qke.128.2019.10.04.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 07:38:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7358B40DD3; Fri,  4 Oct 2019 11:38:35 -0300 (-03)
Date:   Fri, 4 Oct 2019 11:38:35 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, will@kernel.org, mark.rutland@arm.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191004143835.GB17687@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
 <20191004143658.GA17687@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004143658.GA17687@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2019 at 11:36:58AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 04, 2019 at 03:30:07PM +0100, John Garry escreveu:
> > On 04/09/2019 16:54, John Garry wrote:
> > > This patchset adds some missing uncore PMU events for the hip08 arm64
> > > platform.
> > > 
> > > The missing events were originally mentioned in
> > > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> > > 
> > > It also includes a fix for a DDRC eventname.
> > 
> > Hi guys,
> > 
> > Could I get these JSON updates picked up please? Maybe they were missed
> > earlier. Let me know if I should re-post.
> 
> Looking at them now.

It would be really good if somehow we managed to have someone from the
ARM community to check and provide a Reviewed-by for those, i.e. someone
else than the poster to look at it and check that its ok, would that be
possible?

- Arnaldo
 
> - Arnaldo
>  
> > Thanks in advance,
> > John
> > 
> > > 
> > > John Garry (4):
> > >   perf jevents: Fix Hisi hip08 DDRC PMU eventname
> > >   perf jevents: Add some missing events for Hisi hip08 DDRC PMU
> > >   perf jevents: Add some missing events for Hisi hip08 L3C PMU
> > >   perf jevents: Add some missing events for Hisi hip08 HHA PMU
> > > 
> > >  .../arm64/hisilicon/hip08/uncore-ddrc.json    | 16 +++++-
> > >  .../arm64/hisilicon/hip08/uncore-hha.json     | 23 +++++++-
> > >  .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
> > >  3 files changed, 93 insertions(+), 2 deletions(-)
> > > 
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
