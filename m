Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED933CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C7D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="iGUsSBTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfKDP6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:58:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34112 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDP6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:58:14 -0500
Received: by mail-qt1-f193.google.com with SMTP id h2so11386947qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4TV8XP9ZZ97Wbi4gj4llnMeNx475KkWsZHdhSFWxIE=;
        b=iGUsSBTpGvkivt9PDVojmkWewQz7Pu/J1a4QhzT9FChTaJd3swuJL+Sf5RpDO1DDZn
         eoNucuj06i6aDncmCzBLRCMj+0rJ4fEC7wcb/EVBakWup+3XeiWCqgRfv9S5wMwddmmX
         Gga5SZle9j6s8VYxFzB/NvdBft4GTKwg4VByJyHOw8BPl7c+Myd4WslCT37apB/NMza+
         UbEgLuZDXZIrkO+9x6ZGkkFmRIAjsUTP/myOzvz5A71XH2OLFk6fhjxOkUDzDUL+mQaI
         BdHL5Z1CEpdNjo3X8G7kIIrfJcFP2Lnq3CNxFV2hMOtXPIi5Q2GEuzTerCiXWZGYCGaS
         86JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4TV8XP9ZZ97Wbi4gj4llnMeNx475KkWsZHdhSFWxIE=;
        b=fcbm6HMxhb67RP65K7cjrHEOtqH9L/m+MjnmmbJdjX/QYgEFusyLfj98aTEjHbOEwD
         NZKa0ETmrZsnicyx4N9+TRenGff2eiXXUGo2ORwGvk/qGBfEbihoUeLCFOMetAPvw/Gs
         EZuKF/acvWyS+dMJvLChucE1mCwEAK8PTp2NyXckrO8d69jz+dVS3eP5Pj9FEn2WsvqW
         WZTYTEjnNJedWg7Al/e+dh1ULKi0ItpOWAdPIe07rhWzGMEL7FaXYIpS6kypHt1fiaOW
         y/RQBBzHq/IRhqjzluJLg/xzpWNXuZVpL03xFxuBIkGEWWoGl53nDFAcOZ4cs+YouPfO
         RFWA==
X-Gm-Message-State: APjAAAXnBgeTctFlCDg9lplZK6WIe7p6pBGIW+7oZViq4tTkf2CDhOeX
        1UCulRFSs9Z/7KMEJuJrPjH7Fg==
X-Google-Smtp-Source: APXvYqzARc/wvDZ4K3G01oo+xpGMtDzlU8QV6cdh/5YfhniLyh+6ycbMhKVOkhys4ocq0wipTbqpQw==
X-Received: by 2002:aed:2392:: with SMTP id j18mr13011818qtc.296.1572883088283;
        Mon, 04 Nov 2019 07:58:08 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:2362])
        by smtp.gmail.com with ESMTPSA id w23sm1477775qtw.87.2019.11.04.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:58:06 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:58:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Message-ID: <20191104155805.GB24011@cmpxchg.org>
References: <20191030202217.3498133-1-songliubraving@fb.com>
 <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
 <20191104154721.GA24011@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104154721.GA24011@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:47:23AM -0500, Johannes Weiner wrote:
> On Mon, Nov 04, 2019 at 03:53:18PM +0100, Vlastimil Babka wrote:
> > Also right now it seems there's just mainline master stuck at
> > 5.4-rc5 and nothing else?
> 
> Re: master branch, it looks like git quiltimport broke :( I'll
> investigate.

git quiltimport was choking up on \r\n newlines in the series
file. Not sure if something changed on my end or on Andrew's.

Anyway, I fixed it with dos2unix. The tree is uptodate again.

Thanks for pointing it out, Vlastimil.
