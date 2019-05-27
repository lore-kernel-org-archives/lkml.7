Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5385C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A1D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 08:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE0IZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 04:25:17 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:48070 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfE0IZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 04:25:16 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 5AB11B8B49
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 09:25:15 +0100 (IST)
Received: (qmail 10339 invoked from network); 27 May 2019 08:25:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2019 08:25:15 -0000
Date:   Mon, 27 May 2019 09:25:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190527082513.GR18914@techsingularity.net>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
 <20190521124310.GM18914@techsingularity.net>
 <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
 <20190524123146.GP18914@techsingularity.net>
 <20190527062301.rk32mhnk2qy2ives@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190527062301.rk32mhnk2qy2ives@butterfly.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 08:23:01AM +0200, Oleksandr Natalenko wrote:
> On Fri, May 24, 2019 at 01:31:46PM +0100, Mel Gorman wrote:
> > On Fri, May 24, 2019 at 01:43:29PM +0200, Oleksandr Natalenko wrote:
> > > > Please use the offset 0xb9
> > > > 
> > > > addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))
> > > > 
> > > > -- 
> > > > Mel Gorman
> > > > SUSE Labs
> > > 
> > > Cc'ing myself since i observe such a behaviour sometimes right after KVM
> > > VM is launched. No luck with reproducing it on demand so far, though.
> > > 
> > 
> > It's worth testing the patch at https://lore.kernel.org/lkml/1558689619-16891-1-git-send-email-suzuki.poulose@arm.com/T/#u
> 
> It is reported [1] that this fixes the issue.
> 
> Thanks.
> 
> [1] https://github.com/NixOS/nixpkgs/issues/61909
> 

Thanks! The patch has been picked up by Andrew and it's marked for
-stable. It should make its way into a stable release eventually.

-- 
Mel Gorman
SUSE Labs
