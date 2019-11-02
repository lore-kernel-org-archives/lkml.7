Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CDBCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727212084D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 16:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="FQGV/w2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKBQ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 12:28:24 -0400
Received: from mail-ot1-f101.google.com ([209.85.210.101]:46326 "EHLO
        mail-ot1-f101.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfKBQ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 12:28:23 -0400
Received: by mail-ot1-f101.google.com with SMTP id n23so735982otr.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOhsT7U/lVZ/UH322QdKvvhT18+Y7E093E16VQv4bmc=;
        b=FQGV/w2NMVmH2cCpUK6iZSzjs3/ZDSx499CKDOmisKZvMfau0WOjwa7xQZHmRcYcKS
         o1AW1A6TgbMbIewZ1YpprbUpNnQRqyKwNvix2Qk7p0pu8yuPJJv4rqPlSG9u7/fnU9b6
         dH17bsx9nKMMCfeiZbG8pGQP9sVIdHBFeFhCE18vIprrmilLQ0OZoPcXDqqMvIuOvYUH
         LpEyAxIjNbUfOcCH5IPyBif+V90waJpLRxBucAxoFJkqaYiuKP+kGAcd52ghW56Kh6N9
         nSzuJaRfrZ2s/Lxa5Ns50fBh7Zy7ERY6UE3JPeKpWrCexBHjpRuTA3GW7OlTs5olyW2h
         iV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KOhsT7U/lVZ/UH322QdKvvhT18+Y7E093E16VQv4bmc=;
        b=CyeUB8SNeqCxbRlTZHIXdsYPCmh4Ku0Mmy3PdoYNLBsP0f87GBZwJ2vJMyYTOsr/1n
         tJFN6AGf+YZVQBmginJBw9lh0uU9eMyrRrSjKklfILREqKnmnIy2tLSasNcEwSB6zbH/
         9Zq1BIoccjyKles6v6OpRttRPJBp7gCG7dvXxSoi30dH3nJrOiPIVnkx3JbaBNX6TYo/
         edjNHSdJ8qp/CSz7foBl/C/m+BAtzaDjk4apols+SdWDjToEsZ5siAOD6wZ6itQ2/SSY
         I2+ZmR4gRCJMl9EpawVnosRnmlhPaY5IzRq7kruNv8nGNVLR9f+AWaYJ+BHGtjOWhpux
         0fCg==
X-Gm-Message-State: APjAAAWD8aBbuYEJElWDHEsH3YwxvEJxjZJ7jJN9xNeEW5b5Vwfs8+0I
        Bq3mxk+Jyjp7YWIFPRXu1YYuj1x7cKsXfD2+qZI0KhFGHLsZZQ==
X-Google-Smtp-Source: APXvYqxBk+2HhBN4Ei5Bda2TRcc19q/GGIRxgsFXtf/QJF16Pv2DI3WLywQO2BbWlnbJCpRTYA4Ok7quLz5a
X-Received: by 2002:a05:6830:148:: with SMTP id j8mr13400179otp.162.1572712102914;
        Sat, 02 Nov 2019 09:28:22 -0700 (PDT)
Received: from familie-tometzki.de (freebsd.familie-tometzki.de. [18.210.29.142])
        by smtp-relay.gmail.com with ESMTPS id i2sm1155195otk.4.2019.11.02.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 09:28:22 -0700 (PDT)
X-Relaying-Domain: familie-tometzki.de
Received: from freebsd.familie-tometzki.de (localhost [127.0.0.1])
        by freebsd.familie-tometzki.de (Postfix) with ESMTP id E4F00278CC;
        Sat,  2 Nov 2019 17:28:21 +0100 (CET)
Date:   Sat, 2 Nov 2019 17:28:21 +0100
From:   Damian Tometzki <damian.tometzki@familie-tometzki.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
Message-ID: <20191102162821.GB19103@freebsd.familie-tometzki.de>
Mail-Followup-To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
 <20191102160252.GA19103@freebsd.familie-tometzki.de>
 <5c85a690-4ed7-91bb-30b5-c40174534a27@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c85a690-4ed7-91bb-30b5-c40174534a27@yandex-team.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02. Nov 19:14, Konstantin Khlebnikov wrote:
> 
> 
> On 02/11/2019 19.02, Damian Tometzki wrote:
> > On Sat, 02. Nov 18:16, Konstantin Khlebnikov wrote:
> >> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
> >> charge path") memcg invokes oom killer not only for user page-faults.
> >> This means 0-order allocation will either succeed or task get killed.
> >>
> >> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
> >> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> >> ---
> >>   Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> >> index 5361ebec3361..eb47815e137b 100644
> >> --- a/Documentation/admin-guide/cgroup-v2.rst
> >> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
> >>   
> >>   		Failed allocation in its turn could be returned into
> >>   		userspace as -ENOMEM or silently ignored in cases like
> >> -		disk readahead.  For now OOM in memory cgroup kills
> >> -		tasks iff shortage has happened inside page fault.
> >> +		disk readahead.
> >> +
> >> +		Before 4.19 OOM in memory cgroup killed tasks iff
> > Hello Konstantin,
> > 
> > iff --> if :-)
> > 
> 
> This "iff" is shortened "if and only if".
> https://en.wikipedia.org/wiki/If_and_only_if

good to know :-)

> 
> > Best regards
> > Damian
> > 
> > 
> >> +		shortage has happened inside page fault, random
> >> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> >> +		failed memory cgroup allocation invokes oom killer and
> >> +		keeps retrying until it succeeds.
> >>   
> >>   		This event is not raised if the OOM killer is not
> >>   		considered as an option, e.g. for failed high-order
> >>
