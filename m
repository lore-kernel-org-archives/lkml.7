Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431AEC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C662084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1XzrMZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfGLIrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:47:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41768 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfGLIrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:47:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so4422242pls.8;
        Fri, 12 Jul 2019 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=esRAOOVeCAMfkLBCPpbUJgFGAvMCopvzPUsRT/4VLVI=;
        b=e1XzrMZ3sILfaqqVuSBZxuypjl2P58tzLbSE9QshiDMXsaqrea9IoEO09J6m2todds
         mrMe1bLP4LXoIsTJzCoagdDYE+HVDTRilvoLXaWI/AfOPHrV0fcSfntBcltck2aeFuID
         PHd6AkMohE9FrY/k5NsiuYFrPcydpL/lse9aHKALed0jkHAIG08aWPi7fFlcsj636kvp
         8/J/AD1uv+EO1Q0NljusZriyHp8vOIuH1QYt0U7xYHXXoumTYpCFd4zd4I2A5h10EdJx
         QdiuKffqaBtz8l60wfI5mz6S4uRUm+ntfJ9KX1Z25ngA42UrI8LSgA09NQ39fcNqw7Mc
         50mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=esRAOOVeCAMfkLBCPpbUJgFGAvMCopvzPUsRT/4VLVI=;
        b=TmYHC8VYZLqGjRgIvV/ukL2FSwXIFSiT5UnEMk9GGBcj9uGcBfPZoGyX5aNOExuOsl
         Bloq2G72QED+WD6xfzitrnUOp3i04HDFbCWeRe9tQV2N8nCsWTXzqd97uLA4G6FMX46v
         JUmTrSx+6PY0h4Ghm1Df45eRJ3GSYIA+lPoN3vDimoAufNfDjc/UEx99xUIaInTY7Ob4
         E1lDRI3vPuCOz9pd9HOeJvRwMDIaDpY9DswMQAlHtSn9TfEIjM0wmaRayZjlG0t54Sgg
         x72XKLk2gf31CxChJIn4cAqyA2l9pEWWJV0VIJGzEhmqvabZ5MiccMnJ56QgiBV6lidW
         kzww==
X-Gm-Message-State: APjAAAUS1Ow+JA0ZS7Hzlc407kzXacy+7m6Ro4M1rUdjbBzWmKhVa3Gy
        9xaK5gh26r/OLr6mXM4ToSvgtwP3hCI=
X-Google-Smtp-Source: APXvYqxpeGPfI+CsYePvXY4R+JulVlCm6bs8+qzmmvbZZDT2OqumfflEJP31ZUiqiKIzdVXAdhhPaw==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr10115787pll.27.1562921241186;
        Fri, 12 Jul 2019 01:47:21 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id d2sm9419115pfn.29.2019.07.12.01.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 01:47:20 -0700 (PDT)
Date:   Fri, 12 Jul 2019 17:47:17 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20190712084717.GA31048@minwoo-desktop>
References: <20190712073511.53bd6665@canb.auug.org.au>
 <a04e21e3-3bf7-276d-ccfd-d617e88c80b6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a04e21e3-3bf7-276d-ccfd-d617e88c80b6@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-11 16:03:22, Jens Axboe wrote:
> On 7/11/19 3:35 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >    8f3858763d33 ("nvme: fix NULL deref for fabrics options")
> > 
> > Fixes tag
> > 
> >    Fixes: 958f2a0f8 ("nvme-tcp: set the STABLE_WRITES flag when data digests
> > 
> > has these problem(s):
> > 
> >    - SHA1 should be at least 12 digits long
> >      Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
> >      or later) just making sure it is not set (or set to "auto").
> >    - Subject has leading but no trailing parentheses
> >    - Subject has leading but no trailing quotes
> > 
> > Please do not split Fixes tags over more than one line.  Also do not
> > include blank lines among the tags.

I'm sorry for noises here.  I will keep that in mind.

Thanks Stephen,

> 
> I should have caught that. Since it's top-of-tree and recent, I'll
> amend it.

Jens,  I will do it from the next time.  Thanks for ammend.
