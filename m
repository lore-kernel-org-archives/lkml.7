Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B3FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D83206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI/Bt9Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKUOcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:32:43 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:40107 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfKUOcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 09:32:43 -0500
Received: by mail-qk1-f174.google.com with SMTP id a137so1362893qkc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/o1KLhpRRNQD04Oy5ohJOhqgUZlklP31qnxO+i915k0=;
        b=iI/Bt9GtvPOEET/JZ3DAqzXaa+90jYZh8n+LZU6vzuR6xZDIqQTwAcG0936T1ptkHs
         PsDwCdl2cXNcSm+Fmo7361hp/IgePRqzfsJY+ThY4CxqpRc6cdEEczcRC50qqXD1nItr
         GCkymirFpDfxHdTLKWg/Pp//8hjUpN1zhNTsHmByh4f7cHR/rHtTD1RyP7TlNvGV33gY
         4cvv9qMWXOBNWU6/FaOSaBFkmmXU/A9TZjt5a4YkMvAuCbF0GpJ+RpjGEGQ4uVvsseRE
         PEfC4R0VRjdYrnU5aOwJLAzQ1JSmi2vtz8YtzoLdGurd0Ew5BqxQ6CDuomjPO9Cbhm/C
         egWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/o1KLhpRRNQD04Oy5ohJOhqgUZlklP31qnxO+i915k0=;
        b=YkFRnIH+vx1QSfIT+y1qKaAHhUYNasQLRAUPqCp5/xLmXHHqhVxOQQr8gIrcAXZqiQ
         +1p/D4wjEwcRO7ROrsp5QfOLbPgbSfcluqFEB5vdOYUpbHNueDRfsasenNK/9ICgsVYe
         C69l81xpFhJdEcLem2C1GzQTvAaQHrPI0b82SsalbIOdIFuBJRue/MHM2CMwO4eSAbfF
         PPi0+NjUEO2f+O64eeQP0Ta6dLJD7rmGSMd8YYGS6oODpL1wXht6xfxU0JQodx79l+nD
         F1sjGI1L6NFFsckwKTov9D04+fK4MVyPQIDi8/jz2mAc3Af4jB6Sufx8ly04d9UVkJOG
         RupA==
X-Gm-Message-State: APjAAAXpQnyBkyi0tZZRCDDDKZdU5cSpGB4aXUGUJxng+X5p1jQiP6Le
        Kxg4bnMiJscIQim3+etPp5EoGw+0r70=
X-Google-Smtp-Source: APXvYqxc8pDa5fVXwzqJPaur4OgLnlpZQgp0Z/xAIl8cDYN1GFF8Zu5PFdB3tKNoanhiLyZ6aKTQXQ==
X-Received: by 2002:a37:c247:: with SMTP id j7mr321603qkm.67.1574346761390;
        Thu, 21 Nov 2019 06:32:41 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h12sm1566293qtj.37.2019.11.21.06.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 06:32:40 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD3F940D3E; Thu, 21 Nov 2019 11:32:38 -0300 (-03)
Date:   Thu, 21 Nov 2019 11:32:38 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
Message-ID: <20191121143238.GE5078@kernel.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
 <878so9flb2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878so9flb2.fsf@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 21, 2019 at 04:47:29AM -0800, Andi Kleen escreveu:
> Andi Kleen <andi@firstfloor.org> writes:
> 
> > [v8: Address review feedback. Only changes one patch.]
> 
> Sorry forgot to add the -v8 to the subject.
> 
> The patches in this thread are version 8.
> 
> I'll not repost with the new Subject unless someone asks me to.

Ok, I'll try to go over it later today.
 
> -Andi

-- 

- Arnaldo
