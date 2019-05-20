Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED445C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A1520645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1SUvr49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392725AbfETRID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:08:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41005 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390373AbfETRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:08:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id f12so6996853plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ol97WAmP2eVJA2nRz/+2miX8OAofXhZkUB5qRp3k8dg=;
        b=t1SUvr49nCz5spS7UjhK4JQ6Apy9p/w/1qE61fOdmFfmMryUBZ+WjIsoDVYyX0YN+x
         j5og+gJgIsflpdRHMeu4i6xsY2+UzVuGO1IiAwFKq8YNFVdJFLj22bPvRVxM+yAVqLff
         PAW3c3y2TigXGYgpCjxGUxipPCGGvoOz/MvCTNCPZ+zoHoiu1D+HVg1ssM9mD+mVjUiJ
         qFpPpLRxtAxloaRyKdKCYeCSth/6Bh8xtBLIJjeKCHHG8MsLiaqMtwh6HoObu3XCANYy
         hm+mE/IgGQR/lmsIIIq+EWSCEFhG9esI757NdeTwa4gSr1cwKurrdnZp96vRKZn5Hnrh
         XHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ol97WAmP2eVJA2nRz/+2miX8OAofXhZkUB5qRp3k8dg=;
        b=ACVDZNAaUzYLFxYvnKD2kDSy+mbHMv/vcnHfa3x518fJWJisLaG8g9rFgybAwm9+WR
         WdF2s78ERlJZWiPkIBpfezMBT8wE1YcFHlK1cDYZHk18ZLr7qVFmWn1rKkEZucP79Zgu
         5C+K12FWbT0QEm+cRWeoB+eDdNZMardf+wWjXYen1333v+AZrU2W8Yj2WlS4VDPr7beb
         poHwiHcwXCDIg6Haw0xgtUip7O26qLzpnS1yw+6jniELiVgORFBtUbMLUdFtJDG8hjQ3
         9omD8KZgbO33Vnd5a3xvBePVwbMvErd3EAtDWU/dQAuYcFjaIc43tX0Gk8Tabi2tol4S
         TjUw==
X-Gm-Message-State: APjAAAUJ/oLJHoDa9GK5Tvb3F27KBHrie2mNogimJizYBS8gaeM1pk0i
        tM1rgKTpq15LDz9lVi55MFEWIg==
X-Google-Smtp-Source: APXvYqw9vVqYpqbwDVINtSfVyNRGl8P4j/ZT8VpIKlzNUAKaBErtJAKSArZb4J9wWyNkS2M6O6Yhxw==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr75933523plr.245.1558372081719;
        Mon, 20 May 2019 10:08:01 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 125sm26076542pge.45.2019.05.20.10.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 10:08:00 -0700 (PDT)
Date:   Mon, 20 May 2019 10:07:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Akinobu Mita <akinobu.mita@gmail.com>
cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/failslab: By default, do not fail allocations with
 direct reclaim only
In-Reply-To: <CAC5umygGsW3Nju-mA-qE8kNBd9SSXeO=YXMkgFsFaceCytoAww@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1905201007170.96074@chino.kir.corp.google.com>
References: <20190520044951.248096-1-drinkcat@chromium.org> <CAC5umygGsW3Nju-mA-qE8kNBd9SSXeO=YXMkgFsFaceCytoAww@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Akinobu Mita wrote:

> > When failslab was originally written, the intention of the
> > "ignore-gfp-wait" flag default value ("N") was to fail
> > GFP_ATOMIC allocations. Those were defined as (__GFP_HIGH),
> > and the code would test for __GFP_WAIT (0x10u).
> >
> > However, since then, __GFP_WAIT was replaced by __GFP_RECLAIM
> > (___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM), and GFP_ATOMIC is
> > now defined as (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM).
> >
> > This means that when the flag is false, almost no allocation
> > ever fails (as even GFP_ATOMIC allocations contain
> > __GFP_KSWAPD_RECLAIM).
> >
> > Restore the original intent of the code, by ignoring calls
> > that directly reclaim only (___GFP_DIRECT_RECLAIM), and thus,
> > failing GFP_ATOMIC calls again by default.
> >
> > Fixes: 71baba4b92dc1fa1 ("mm, page_alloc: rename __GFP_WAIT to __GFP_RECLAIM")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> Good catch.
> 
> Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>
> 
> > ---
> >  mm/failslab.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/failslab.c b/mm/failslab.c
> > index ec5aad211c5be97..33efcb60e633c0a 100644
> > --- a/mm/failslab.c
> > +++ b/mm/failslab.c
> > @@ -23,7 +23,8 @@ bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags)
> >         if (gfpflags & __GFP_NOFAIL)
> >                 return false;
> >
> > -       if (failslab.ignore_gfp_reclaim && (gfpflags & __GFP_RECLAIM))
> > +       if (failslab.ignore_gfp_reclaim &&
> > +                       (gfpflags & ___GFP_DIRECT_RECLAIM))
> >                 return false;
> 
> Should we use __GFP_DIRECT_RECLAIM instead of ___GFP_DIRECT_RECLAIM?
> Because I found the following comment in gfp.h
> 
> /* Plain integer GFP bitmasks. Do not use this directly. */
> 

Yes, we should use the two underscore version instead of the three.

Nicolas, after that's fixed up, feel free to add Acked-by: David Rientjes 
<rientjes@google.com>.

Thanks!
