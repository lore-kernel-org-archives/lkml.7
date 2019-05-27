Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D424EC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768E2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfE0GXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:23:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51511 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfE0GXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:23:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id f10so7413527wmb.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 23:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2EwAn8/owM0ZpqAm1O3Pr+v/VNdJwGPW1zcKtSbo++g=;
        b=EN35T/dVwzVXzxIYmK5dIHX69jOP/XzAE652qVv12jBXhcg7Mjw3f8Qq82pozMU55d
         Qve0LQ/cUopUmbrPY5MteXLe4HZWA4OGv/rWRB4xRQielhiW1m3STbflWJORWlOhFwAp
         NyXXhOILs4aaIIEMZwkyOlPbRS8co8yL8CiVozsFUC3VEZWRhB4VDVMluXTVbBalN3aW
         DHJqV62VU8Otf0FQ3SI3q4KycfGK1dEmsGG/CmGFNWLKB0BfWvr5mhrpqmgwJ3nziqzI
         NH3Fc4jTQZWvkc/UJVeBkDYY50NqGvA+vMKrnsiqTwDG0nU8L3/71Dlc2nkZlfxFC4hw
         hj1w==
X-Gm-Message-State: APjAAAVVeZA2HR3t/urGcbvjApKwiha1ECLMKl/RYjuGnjzfeZfYJT7p
        h2XTcpZ28BL+2mL+67cii8S+aKwXKyg=
X-Google-Smtp-Source: APXvYqz7gk3SDkHxJ/F20M/kqu5igSHw1TtFY0GExTPcnsN/PG/SpiaxSaw9crWuaaFmjl8FHfUATw==
X-Received: by 2002:a1c:e183:: with SMTP id y125mr328512wmg.152.1558938183765;
        Sun, 26 May 2019 23:23:03 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g16sm9541735wrm.96.2019.05.26.23.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 23:23:02 -0700 (PDT)
Date:   Mon, 27 May 2019 08:23:01 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Justin Piszcz <jpiszcz@lucidpixels.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190527062301.rk32mhnk2qy2ives@butterfly.localdomain>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <20190520115608.GK18914@techsingularity.net>
 <CAO9zADzz9QJ9Rp_Acy5GRggfYZzDwYYNWhCvPc9XHd+G=gS5zw@mail.gmail.com>
 <20190521124310.GM18914@techsingularity.net>
 <20190524114329.hujd3qvtusz6uyfk@butterfly.localdomain>
 <20190524123146.GP18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524123146.GP18914@techsingularity.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:31:46PM +0100, Mel Gorman wrote:
> On Fri, May 24, 2019 at 01:43:29PM +0200, Oleksandr Natalenko wrote:
> > > Please use the offset 0xb9
> > > 
> > > addr2line -i -e /usr/src/linux/vmlinux `printf "0x%lX" $((0x$ADDR+0xb9))
> > > 
> > > -- 
> > > Mel Gorman
> > > SUSE Labs
> > 
> > Cc'ing myself since i observe such a behaviour sometimes right after KVM
> > VM is launched. No luck with reproducing it on demand so far, though.
> > 
> 
> It's worth testing the patch at https://lore.kernel.org/lkml/1558689619-16891-1-git-send-email-suzuki.poulose@arm.com/T/#u

It is reported [1] that this fixes the issue.

Thanks.

[1] https://github.com/NixOS/nixpkgs/issues/61909

> 
> -- 
> Mel Gorman
> SUSE Labs

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
