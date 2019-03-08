Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA62064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCHXPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:15:16 -0500
Received: from trent.utfs.org ([94.185.90.103]:41336 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfCHXPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:15:16 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 0F87D602A3;
        Sat,  9 Mar 2019 00:15:14 +0100 (CET)
Date:   Fri, 8 Mar 2019 15:15:14 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <17155.1552056554@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.999.1903081506320.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk> <17155.1552056554@warthog.procyon.org.uk>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, David Howells wrote:
> See the attached for a patch that helps with certain kinds of collision,
> though I can't see that it should help with what you're seeing since the
> RELINQUISHED flag isn't set on the old cookie (fl=222, but 0x10 isn't in
> there).  You can monitor the number of waits by looking in
> /proc/fs/fscache/stats for the:
> 
> 	Acquire: n=289166 nul=0 noc=0 ok=286331 nbf=2 oom=0 wrq=23748

Running Linux v5.0 with this patch applied does indeed still produce the 
"Duplicate cookie detected" messages, but I only ever see wrq=0 when 
running nfstest_cache: 

   https://paste.fedoraproject.org/paste/dkav0FQzYZxE9-V7GphjAQ

(Scroll down until the messages start to appear again)

Only the n= field seems to change during that test:


fedora0# grep wrq n2.log  | sort | uniq -c | sort -n
     28 Acquire: n=8 nul=0 noc=0 ok=1 nbf=0 oom=0 wrq=0
     29 Acquire: n=7 nul=0 noc=0 ok=1 nbf=0 oom=0 wrq=0
     34 Acquire: n=6 nul=0 noc=0 ok=1 nbf=0 oom=0 wrq=0
     82 Acquire: n=9 nul=0 noc=0 ok=1 nbf=0 oom=0 wrq=0
     93 Acquire: n=5 nul=0 noc=0 ok=1 nbf=0 oom=0 wrq=0

HTH,
Christian.
-- 
BOFH excuse #5:

static from plastic slide rules
