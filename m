Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAF5C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4DF2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+phQLjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDISZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:25:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40905 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:25:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so10207605pfc.7;
        Tue, 09 Apr 2019 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rgxjd6yfkaznKtLOQ+DHwY5+ybgamLHodNbBCQq+vgI=;
        b=g+phQLjdoNa5OIXk0j5RCyMaF5yjTaWux0jZDc39etaLa2BtsipqvcWdU8kCL5fqI1
         ms99VKLJ2MWlxUmAkbKAyygKSs09DTpY0op1gW3Ulta3FpflR0OZcy9luKjkh48R3HN5
         Y7Auj0/BVx+ZuzgPFrVf6bnvGNPYcH/pGYAlD2c8D4bQYJI3awVOY2VzPqfHFgVTbq9k
         gLxb/pfVDO0weK+qEHArNCRMT88Yxxy2sJGIym41bOygbxx699lSmul4KDrVo1mDraVg
         PGZBVcqNeHPrZDcRggbOgp2Wai4GZP+u44s7jYKlngVSBWozY6lpNtLNSGH09o92kUhf
         Px4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rgxjd6yfkaznKtLOQ+DHwY5+ybgamLHodNbBCQq+vgI=;
        b=WU8v2d7bzZ9zNxPXzpwXiT/9bPdKBAYUdlD+6JfOwQfKEHq39jZIidxmfqwPc7VylF
         B8C9F+rW3o0Tc6nvaB0b8TULyCrKy8OsxqvkPdpG3UNK9uIMKV3U+BiJR6SWMBP1fTKr
         52nXrGMhm2ed8V9kTfSyFrJ1azSlToz7NQVFDnEsq1geKKK7GCDbq0nMOIkPQGAz01cv
         9Gy7ZTk1VaNjtJehyN4f0zDUxs5dMsGOtUtmszP8LtzWFJ0Nt3UwFS+bqDxHk3FFSxZI
         Ggza9ZXUOckUA8vtm9gyp5QgB2cgMe/W6JP3dZiwYf2+VXZkaBEDchP7NGmdh25ttDGK
         69YA==
X-Gm-Message-State: APjAAAXT+ky45w1Cm1/Cf5JrDfrVZ1HmIhway30QWzdeL9VYK4MpT5yT
        cvZiabeGOqUTY7uMp+Qh+gU=
X-Google-Smtp-Source: APXvYqzcRUJgIUZ5EBgr08LZBZU4sAei5vrd6iktbW3iloKoT/4IzU1+o4arzZIuIWATS7Tq1uPQoA==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr36308226pgl.369.1554834327019;
        Tue, 09 Apr 2019 11:25:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k186sm27539061pfc.137.2019.04.09.11.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:25:25 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:25:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: linux-next: Tree for Apr 9
Message-ID: <20190409182524.GA18518@roeck-us.net>
References: <20190409180042.15bb90b6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409180042.15bb90b6@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 06:00:42PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190408:
> 
> The mac80211-next tree gained a conflict against the mac80211 tree.
> 
> The drm tree still had its build failure for which I disabled a driver.
> 
> The drm-misc tree gained conflicts against the drm tree and also a build
> failure for which I marked a driver as BROKEN.
> 
> The scsi-mkp tree gained a build failure for which I reverted a commit.
> 
> The rtc tree gained a conflict against the omap tree.
> 
> Non-merge commits (relative to Linus' tree): 5587
>  5386 files changed, 176906 insertions(+), 87493 deletions(-)
> 

This one deserves a reply.

Build results:
	total: 159 pass: 144 fail: 15
Failed builds: 
	<many>
Qemu test results:
	total: 345 pass: 227 fail: 118
Failed tests: 
	<many>

Build failure is:

s/nfsd/nfssvc.c: In function 'nfsd_support_acl_version':
fs/nfsd/nfssvc.c:145:14: error: 'NFSD_ACL_MINVERS' undeclared

and similar. Build failures and (many ? most ? all ?) of the qemu failures
are due to commit 55d4c716ea ("nfsd: Add custom rpcbind callbacks for
knfsd").

Guenter
