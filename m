Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0FEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CE5206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBwkT+GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391185AbfITObc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:31:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44084 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388361AbfITOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:31:29 -0400
Received: by mail-lj1-f195.google.com with SMTP id m13so7246027ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UmKmcVdfGL0BM9xGNj29OG99mu12S2rRbnsThHYS5s=;
        b=VBwkT+GOvE6WhewRzb8gEAcfycr3A0ewtfXEzwupM26LaUIU5UgbDTBdRydyd1uZLe
         alI4qn+V5JBIcLczrxIEmPo4F/tvBUhjDP/hsqh5P+nZj0lkruGMN8Fr230gWgXhuzIS
         C4tsv/YvLTFXH6IIm0F5QNcY5S1OPbOwaOjHoM6AfhlxFCaLM5BCMoyT7CglKgZjMdC5
         xpUJ08c7BDB4Y4pejdwwZmrAK9HI7p1aFtu+oNXaCwocp5Th4bERX+teYDoXSiKIvhEy
         gc9wXY1egizDGxO1gfaL+VRaX8q01t02lyQvVMy+piZwkpurWiX6YY7VRcx40+A1ttcq
         TqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UmKmcVdfGL0BM9xGNj29OG99mu12S2rRbnsThHYS5s=;
        b=CWxCNg/1212cPxxiNvFi8FzbAY++186ac3qsE8pfsVkyHQrj2LcfRiLr8BEAD/98Mo
         /aXCm0ENmeDLvYxo8rgze5UXCKHYoeJPlHn+SmiNR1zxROhg1VOPIqJ+wmQcy33MRlAM
         VPfOGO+AlotMbJ9S4AOHF6Z6kEqX1qu016tjk3BcQotl+W0Tn9hDqpvBwrlUFzBg8FK7
         cVMgvMuTQ3afAYNC5lu3xu3p+865Kjlw4rpZbkUbJTr0sgfIUWOKwdPKcDH8cqR0F13W
         56K+x+T52+gI7kGEmOKgoby/eMku8Pd9saJCDYrShCneTcsNbMqZF0MvYILZ+yci9aoT
         qltg==
X-Gm-Message-State: APjAAAVMP0TE1+3SaCzwl0uSRzpPkQJ2EAhEAdz8XN3xjv7Ab3MH/9r5
        wcgVdf/8I5FnDJ64xeL+XVA=
X-Google-Smtp-Source: APXvYqyLzlsjpVbQcNQ6ef6GTDOk1e4X5tDUNzj8rguwYrEjgY6qCI+c0KT+yKYy2gDBoOlPkP0jHA==
X-Received: by 2002:a2e:1409:: with SMTP id u9mr9522774ljd.162.1568989887598;
        Fri, 20 Sep 2019 07:31:27 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id k28sm527415lfj.33.2019.09.20.07.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 07:31:26 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8A2FE460473; Fri, 20 Sep 2019 17:31:23 +0300 (MSK)
Date:   Fri, 20 Sep 2019 17:31:23 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm, memcg: assign shrinker_map before kvfree
Message-ID: <20190920143123.GI2507@uranus.lan>
References: <20190920122907.GG2507@uranus.lan>
 <8a4b5293-6f79-2a5d-4ac8-f8fc17f13b6e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4b5293-6f79-2a5d-4ac8-f8fc17f13b6e@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:11:00PM +0300, Kirill Tkhai wrote:
> 
> The current scheme is following. We allocate shrinker_map in css_online,
> while normal freeing happens in css_free. The NULLifying of pointer is needed
> in case of "abnormal freeing", when memcg_free_shrinker_maps() is called
> from memcg_alloc_shrinker_maps(). The NULLifying guarantees, we won't free
> pn->shrinker_map twice.
> 
> There are no races or problems with kvfree() and rcu_assign_pointer() order,
> because of nobody can reference shrinker_map before memcg is online.
> 
> In case of this rcu_assign_pointer() confuses, we may just remove is from
> the function, and call it only on css_free. Something like the below:

Kirill, I know that there is no problem now (as I pointed in changelog),
simply a regular pattern of free after assign is being reversed, which
made me nervious. Anyway dropping assigns doesn't help much from my pov
so lets leave it as is. The good point is that we've this conversation
and if someone get a bit confused in future the google will reveal this
text. Which is enough I think.
