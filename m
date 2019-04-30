Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D75C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B6A21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxHjCkoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfD3KpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:45:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37810 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3KpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:45:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id b12so11123022lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 03:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D0Zsz5cuLJP69SdJwEsKGX6QwExtlT9EFiLTZhEUga8=;
        b=bxHjCkoavoWP0hn9Y3zvg9uBa6/OyLqHI5jEpHTFTvFUZkg/G0SnClzHnlOncwQfd/
         8AJpSAjDKpJaytE5xuwaK8gHuPdq3EOYGTfkU0JbE7sC8Ept3JJ15+MYRxb0x6PzHfl2
         AhWWFagFddh06QfYTxLFTEHlZJkd4lu28BlpyDa+VOERo0+dvzK56HWlS3dT7dUGD1DB
         9lv1ZMGobUYNU9iAUHymErxAMtS8tuhcTNTsWxyb517TlnsEZ+yHZCXFmOMhDfwxEiNa
         rLFDeagMOuR1rkkIJHALJXo0SvmLP3t9/Vcc5XhzVX6i+qNdghV+L0LRvWzGPB3Jma5t
         +fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0Zsz5cuLJP69SdJwEsKGX6QwExtlT9EFiLTZhEUga8=;
        b=oV7jeVIp58qYyABlFOIiRB3IQJHRXjrG5lkUZyHyYs8PDkPH9y0hePkz1BXSEBXuth
         Z9MAvf7eKLHmqlHhYQsszJJ3QA69lbMxNsFwCemLKh5/yaIWqWO+oyUaBPLm72r6LS9S
         pOLkd1pWf/8BAD+Lf2l6N++wPO6kYxQdNLgrjtO6fEk7owXZc2BPUN+LaKbaVKMsCAHH
         59Mio1qW76O0/RmXra4FQDeA0bGZkjY6ARjbzHcyQKr7wcX36Kf9sfonbSrFPDidKFB4
         bLT2uFwCQ0kDv5PmmVUbxaZ3faeKTi9+XA2L/hhyUT5E48viJRRERHkGxBFkL1pq5xQY
         a3Eg==
X-Gm-Message-State: APjAAAWDyobAUnCARMuiYTkf8pbD8S4GCkrw8kpmtUrIIqMMxpnWnPyS
        QvO0zP4RxI9aNAe37/qhWus=
X-Google-Smtp-Source: APXvYqzDf7wlVV/tS0AVM5oO9IvgsP46PdHqrHNLvAfCdN4WQJCHqmCHp4cUQ7a3+BNNLwzEOz0lLA==
X-Received: by 2002:a2e:3e0e:: with SMTP id l14mr35352423lja.125.1556621118804;
        Tue, 30 Apr 2019 03:45:18 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id f1sm7277893ljc.73.2019.04.30.03.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 03:45:18 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 68F874603CA; Tue, 30 Apr 2019 13:45:17 +0300 (MSK)
Date:   Tue, 30 Apr 2019 13:45:17 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        akpm@linux-foundation.org, arunks@codeaurora.org, brgl@bgdev.pl,
        geert+renesas@glider.be, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, mhocko@kernel.org, rppt@linux.ibm.com,
        vbabka@suse.cz
Subject: Re: [PATCH 1/3] mm: get_cmdline use arg_lock instead of mmap_sem
Message-ID: <20190430104517.GF2673@uranus.lan>
References: <20190418182321.GJ3040@uranus.lan>
 <20190430081844.22597-1-mkoutny@suse.com>
 <20190430081844.22597-2-mkoutny@suse.com>
 <4c79fb09-c310-4426-68f7-8b268100359a@virtuozzo.com>
 <20190430093808.GD2673@uranus.lan>
 <1a7265fa-610b-1f2a-e55f-b3a307a39bf2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7265fa-610b-1f2a-e55f-b3a307a39bf2@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:53:51PM +0300, Kirill Tkhai wrote:
> > 
> > Well, strictly speaking we probably should but you know setup of
> > the @arg_start by kernel's elf loader doesn't cause any side
> > effects as far as I can tell (its been working this lockless
> > way for years, mmap_sem is taken later in the loader code).
> > Though for consistency sake we probably should set it up
> > under the spinlock.
> 
> Ok, so elf loader doesn't change these parameters.
> Thanks for the explanation.

It setups these parameters unconditionally. I need to revisit
this moment. Technically (if only I'm not missing something
obvious) we might have a race here with prctl setting up new
params, but this should be harmless since most of them (except
stack setup) are purely informative data.
