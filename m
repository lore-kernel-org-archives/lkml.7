Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B82CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5403E21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dpZNxdHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406476AbfJWPFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:05:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34320 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390530AbfJWPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:05:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18so19455917qkm.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLjhfsX3TyBTxi+fadpIVv6MU4Vj9o2A3I+zpLB2nks=;
        b=dpZNxdHOy4bVG236Wqmg3LjjIOL2Pb9HsX5jejGqUUraI6L7k/lsMZBeRntTpSU5Zr
         2mubf6q7jQDqSpXmaO/S2FbhM+f3yB+wYQ6jQ6ip80Aq/icFyQ6jJOIr2NmmAeMEQCEe
         D2gmG1kN+UrdPCg4s+WBcPnkZ+W6uxER0eOfSKinvsCmgJCdRAPxvaUMNxdRVBlcoTKW
         RUJvGibJhkDLc+eIv6fhxBdEZzRuMWmhunkFVKX5RyYb2djcEou9Se3RJAzmn1s9LqEG
         Cr/I82a6yc29yyiX9frfgfKomvb7oNbcSG45U8PBW5Ggg81miqNowwQ1jWN5KoDfhPra
         HL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLjhfsX3TyBTxi+fadpIVv6MU4Vj9o2A3I+zpLB2nks=;
        b=X11TV6QkcAURBTJger3h3ULAlhyXj6lCYBThdbcH/XsjKouC/rzutP97YjoWptfPBB
         UynGyTgo0hXBBlNsj0AcROnD7/BDmuFO9F67h59QIdGUf6Q6WQDmaDPtJkk5QF16hEHy
         ia73uUFlMy46sZp/ZaELOBN0P27Quzc5S8meFV6vw6HG7SEXg34sub2Ywws2JBtACnKj
         DO3ax0/GkSgBdj5xKGP4O31l6iEFHUE8681v+H5oNTZM2IeDw8uWzTld5SNMmSrKWMvR
         FfY48OUEjT0GRbQrcL73Nm6M1ttx30VqMe2UVfoKXtu8jjIQ1iVCB79YRdcv6s9ISPxy
         oLgA==
X-Gm-Message-State: APjAAAVTUcBXtWa65F9EkF5sAJ+C5IAvesvuPirIR+JXEiIQ2cbYn7NV
        BDo3RiDja++16UqCLuemtjdxmQ==
X-Google-Smtp-Source: APXvYqz/FhzYp8GGto8Tw5/JjylZYPd63dPTZ0r6aLPjuXrJ8f52Q9xo89ZFsXl2ek0p5+cCXZ5Ieg==
X-Received: by 2002:a37:8dc6:: with SMTP id p189mr8546331qkd.421.1571843151739;
        Wed, 23 Oct 2019 08:05:51 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 18sm8420462qky.109.2019.10.23.08.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 08:05:51 -0700 (PDT)
Message-ID: <1571843149.5937.86.camel@lca.pw>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
From:   Qian Cai <cai@lca.pw>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Date:   Wed, 23 Oct 2019 11:05:49 -0400
In-Reply-To: <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
References: <20191022162156.17316-1-longman@redhat.com>
         <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
         <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
         <1571842093.5937.84.camel@lca.pw>
         <a4398f60-c07e-8fa9-c26d-3b8f688e65a1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 11:01 -0400, Waiman Long wrote:
> On 10/23/19 10:48 AM, Qian Cai wrote:
> > > > this still isn't a bulletproof fix.  Maybe just terminate the list
> > > > walk if freecount reaches 1024.  Would anyone really care?
> > > > 
> > > > Sigh.  I wonder if anyone really uses this thing for anything
> > > > important.  Can we just remove it all?
> > > > 
> > > 
> > > Removing it will be a breakage of kernel API.
> > 
> > Who cares about breaking this part of the API that essentially nobody will use
> > this file?
> > 
> 
> There are certainly tools that use /proc/pagetypeinfo and this is how
> the problem is found. I am not against removing it, but we have to be
> careful and deprecate it in way that minimize user impact.

What are those tools?
