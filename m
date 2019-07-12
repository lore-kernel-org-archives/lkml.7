Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D0CC742B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1292084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 11:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfGLLAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 07:00:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35383 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 07:00:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so7614931qto.2;
        Fri, 12 Jul 2019 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pal+pi/d4Dk93PuDYZ//Pw+9a15iKT4iShxvJ3znLK4=;
        b=sUuHJ1y/Q2iHbFVF1NiijGbCwORzEO1Zs/ZqeHwp98oPVrOqsXUvcT5HFGZ8VzT1Il
         k8IyQfIRZSTFlmPBXsIR51t9CiFySX8aiCu3c3lJcUZtP3TMALKqbOKLyYwAkpcLX/Ix
         dsDcZZZ1vIXKovPLntqBCR7sIZNV/SD5ub3STvv5tu02SfsrZKnlNla0GNXgOtWSq27J
         jMT2Z8q9c8Df4bXE3eKsy88BR4JSN2ecvznwJlDandFtN+XkEAtUb3VoBe+KTnZq1GKK
         x+n0+D5klB/+rSGzMnmMxZ8S48+o1i8oxBcp9O/Lmx/1SWxj7w5u6wo7vKfijOq9T7x+
         KIYw==
X-Gm-Message-State: APjAAAUQZZDmjkes8+e5ebVsIKmcErfvTgXLyvg2u4ehimhjlsfrCfEH
        UPNI3o0WaA4E4xu0RgU0BBLbMGmhbDtfdysKVNh8LHv4gLk=
X-Google-Smtp-Source: APXvYqxCZome0dJAMTWtGsenbmYtkd8gnE0cPWNBLmFkrCEENjBEhDXjXabVqz9NG5LZenPSw3uVfa5Y6HOAvISZvTc=
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr5825888qtf.204.1562929201614;
 Fri, 12 Jul 2019 04:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190709211559.6ffd2f4e@canb.auug.org.au> <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
 <20190710070509.GB29695@dhcp22.suse.cz> <20190710173434.8081fa5410ccf0ccd72719b9@linux-foundation.org>
In-Reply-To: <20190710173434.8081fa5410ccf0ccd72719b9@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 12:59:45 +0200
Message-ID: <CAK8P3a3Eb1+imK+daiK=ctN6DhwSuTfnAnUUG9xK5rQo=pZ_uQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 2:41 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
> Subject: mm: shrinker: make shrinker not depend on memcg kmem
>
> Currently shrinker is just allocated and can work when memcg kmem is
> enabled.  But, THP deferred split shrinker is not slab shrinker, it
> doesn't make too much sense to have such shrinker depend on memcg kmem.
> It should be able to reclaim THP even though memcg kmem is disabled.
>
> Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker.
> When memcg kmem is disabled, just such shrinkers can be called in
> shrinking memcg slab.
>

Today's linux-next again fails without CONFIG_MEMCG_KMEM:

mm/vmscan.c:220:7: error: implicit declaration of function
'memcg_expand_shrinker_maps' [-Werror,-Wimplicit-function-declaration]
                if (memcg_expand_shrinker_maps(id)) {
                    ^
mm/vmscan.c:608:56: error: no member named 'shrinker_map' in 'struct
mem_cgroup_per_node'
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                        ~~~~~~~~~~~~~~~~~~~~  ^

     Arnd
