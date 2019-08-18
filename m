Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3610DC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E93206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0q9PVaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHRPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 11:47:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfHRPrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 11:47:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id bj8so4586533plb.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=21hbVFGx+8/jzq/lmcXaeMIKxoYnWYEJ5IhsV1Pi6yY=;
        b=L0q9PVawLVsOvBFxUCXFWKikeyH523goWfKtLidRkTAggugmUrJsK8zyriaLtId/nw
         OPjJ8rPg8N5hN4B881wlhRSRhkD30WeNu55zqirfcjB1xgCQvezNytqzkyrZln/6Y/4h
         q1esOQNtQtL53EtbMgc6Zcrwva8ZvVa2HbY2GoHPR7YQ53lSdLO1yyTfaiKAUecYbxrn
         3xAV0cwZrzxTag6dmsTWnzaI/m99RE46jOq1v9PJVoh9y0rMZOrpAluHVNGCgTIpJ+hE
         CsTlHpAZiXqv7LJuYx1e6VMmfY4zRf/rEF3pJl3G24sJK9M45hoEdQYy1MNW7MXSv9WI
         J5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=21hbVFGx+8/jzq/lmcXaeMIKxoYnWYEJ5IhsV1Pi6yY=;
        b=svqbT3i4T9Yp1tJ+Djv3/yaJr8yvx1scnNGKdbGNBiy2c6uzWIMyUeBwlf2QWpN9BQ
         sFwvusqrVhjo5VvAiM6IRePtv/nUyLidrgAAnJwZu6mAoumsolVNVe/OQFyek9EShiRB
         vCO7ca8z9byWvDDWK5aEb8Edk5HQmXgHaVzOb7XiCmAfAg9TvexXCGCtIe8QZdjo/ZLt
         GOBE8i2Q0xxjyiqJSE7IL9ifcrn6PqERmv2aVobJp93QDWents3WZeklZR1FcE98vykJ
         93UL3wISnzB6KcqmeKEAqqgLbkYp6wMSUpdGjo+ew+y5iF100FKY/VOU6WKMA+Zl41kg
         rhEw==
X-Gm-Message-State: APjAAAVSL+gklDxDQTcRFnHxx/VFOWDABXEAzCCh/Lxx+ruNwRDtQCTQ
        8ZiLnfYpNEgcnUA4h+vZpK4=
X-Google-Smtp-Source: APXvYqxgOdbzTuZqpSIsD/XyuwyyQRunnfBKn90nh/nP/SkQAUAIBCmwLO8lnzsg5zvX/QzvXRi7XQ==
X-Received: by 2002:a17:902:bb81:: with SMTP id m1mr18764674pls.125.1566143271821;
        Sun, 18 Aug 2019 08:47:51 -0700 (PDT)
Received: from raspberrypi ([61.83.141.141])
        by smtp.gmail.com with ESMTPSA id 1sm15190534pfx.56.2019.08.18.08.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 08:47:51 -0700 (PDT)
Date:   Sun, 18 Aug 2019 16:47:44 +0100
From:   Sidong Yang <realwakka@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/arm: drop use of drmP.h
Message-ID: <20190818154744.GA5455@raspberrypi>
References: <20190817074115.19116-1-realwakka@gmail.com>
 <20190817163549.GA15813@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817163549.GA15813@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 06:35:49PM +0200, Sam Ravnborg wrote:
> Hi Sidong
> 
> On Sat, Aug 17, 2019 at 08:41:15AM +0100, Sidong Yang wrote:
> > Drop use of deprecated drmP.h header file.
> > Remove drmP.h includes and add some include headers for function or
> > struct that used in code.
> 
> Thanks for your patch.
> We already have a similiar patch in drm-misc-next, that
> drop the use of drmP.h from arm so this patch is obsoleted.
> 
> But keep up the spirit and send us other good stuff.
> 
> 	Sam

Hi Sam.

Thanks for reply. I found the patch that you said.
I'll keep up and try to find other good one.

Sincerely, 
Sidong.
