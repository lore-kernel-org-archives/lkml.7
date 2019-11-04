Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CBECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAFC214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Xdl7ya/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfKDPrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:47:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33660 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfKDPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:47:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so24630957qty.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L8x9fkwneHCR6wxkSArxVaQnd8zzbF9wl94xgUfTw0M=;
        b=Xdl7ya/n9X+9F/h7stlvF9B+2GbuX93zP1aJLC7uJ2Ug90K4LHZOPzDf9h5icgO1su
         qA4iYNTafrzK96F0IZGyqMg710hfAaD9qH7nDv9adhOTRS3AnXbTzfj/GZEENRnBcXlQ
         OODsJi1Kec+UrlUmkzETLvU3F7B5bjkUQJxCTbsPo7EOSaHbP/7iGr5j6kQqLvJZFL7g
         h96E7wGEq8fwH8z9lq/IopzW/1QMcR17Ow1HNGBjAvwyApG/hODp7p25rS0xsk4hgS7j
         gVG6mdDoYyRNilO5n92nzF4PEiE0Nm29rlD+FAF2Hme1tmmzaRTaqwmCP+NhAoGfCL7e
         HCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8x9fkwneHCR6wxkSArxVaQnd8zzbF9wl94xgUfTw0M=;
        b=s9KT/EpyIjbHlM2XF7tegLbi8oh/yjowuzoD4LCi+MadJ+qYKmCT30azfJZDgTj8Qv
         ABvHq3bEE8YyK4hsaboglETLkOHG0fVUxmyX0pXYVeNPB8LksZehziNMGV2Iza9Zlm9t
         4fhZnwOZkB4zycWqHy2K/ECaJuPQ+R88zG3zzZygheqO5L4HRnk4PqyrZ5Xp49ribtY6
         /4EJiYRt7WqSkg4+ssTzI1Yrm94Y9h53TQS2/kLqZo+gRDsSooRYNENzcFt2YlgeQbkM
         xIDgsaf/0i1alhhK8ayQdH++EQLW/sxNYzXTGuaY31Z8cwyRy851yM0TT46IhBGQ5K/t
         Jmvw==
X-Gm-Message-State: APjAAAWM6rwZQML3BGzreaEdunLU9mPwYXHNvt1Sp4NdV8eoYNbp/Oxg
        4HRT2yLHSL29WD/inUQKvfYAyBBQYauMVQ==
X-Google-Smtp-Source: APXvYqzwYBayyLWeoeKSZ/10HUhTy7G1ejrmK4EH9o6dmQZoqFWpwpFTRC5MsROwoZO+puEQ9ZDCXA==
X-Received: by 2002:ad4:57d4:: with SMTP id y20mr9997613qvx.63.1572882443391;
        Mon, 04 Nov 2019 07:47:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:2362])
        by smtp.gmail.com with ESMTPSA id 70sm2094778qkl.92.2019.11.04.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:47:22 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:47:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: update information for "MEMORY MANAGEMENT"
Message-ID: <20191104154721.GA24011@cmpxchg.org>
References: <20191030202217.3498133-1-songliubraving@fb.com>
 <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4ff9c9-064c-7515-41ea-9f20b9889e51@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:53:18PM +0100, Vlastimil Babka wrote:
> On 10/30/19 9:22 PM, Song Liu wrote:
> > I was trying to find the mm tree in MAINTAINERS by searching "Morton".
> > Unfortunately, I didn't find one. And I didn't even locate the MEMORY
> > MANAGEMENT section quickly, because Andrew's name was not listed there.
> > 
> > Thanks to Johannes who helped me find the mm tree.
> > 
> > Let save other's time searching around by adding:
> > 
> > M:	Andrew Morton <akpm@linux-foundation.org>
> > T:	git git://github.com/hnaz/linux-mm.git
> 
> Not sure about the git part. It's not a real development tree, but a
> secondary "mirror" of the quilt tree, with unstable commit ID's. Could
> it be somehow indicated? Also right now it seems there's just mainline
> master stuck at 5.4-rc5 and nothing else?

I think at the least we should put the quilt trees before the git
tree, since that's the primary source of truth.

Not sure how to annotate the git tree, though, it looks like people
were trying to keep the format machine-readable:

        T: *SCM* tree type and location.
           Type is one of: git, hg, quilt, stgit, topgit

Re: master branch, it looks like git quiltimport broke :( I'll
investigate.
