Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0536EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFB220843
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLZf25bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfHMJC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42157 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfHMJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so13555466lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zbadPFLbmftsI8N+IuNnBjaQB4827jD6fnEJgLKNTZs=;
        b=hLZf25bqcvbX25xNuMZbR5PzvxV6GImnoNKHQjbf8sETv7Ar9mx/GVJVNlFBiUoI+x
         OaBu+PCv1W1Alu6XSNHoHrNCp537Atpgj+R9HmRLZFXqzKsJ80D0kddeGkeb1Dqn7Kh4
         2qCin8I2SdptK0jFV8ULLCBJ5lOvpY0rk8B58UyCaS71IqEbPmstIIGYsGLKFiUdRVeg
         4x0pTMXVaKNeZJQeADuHIPNtlLphOYlT0XTQncnLpdJrQPPcNRRt+vf/l9AFxpkaF5yX
         xnhwZBqi6uccNYt04vgFRAZzxWAC+/fwgCCIT+XdyRKjlzxTa9KCw0iUesn6i5pyFpVa
         Nq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zbadPFLbmftsI8N+IuNnBjaQB4827jD6fnEJgLKNTZs=;
        b=TrIdJSoXycizfAhkQjk9ZKBuEd1iQwn80xYX69e6RTlb8vZ4KSj2/clKHF8MiYxWii
         US1JTbv48aW5SkzuDN00sFv0rUtnN1SgQONsq/z67xZ/2Hd0l6P+i89NCwk/ukPLONo2
         8TeR7jWf/mATQBXuB9JTvV4ntzwZGX0XrobTLnpGH4rAMpNef5uJZOj+LY8I04laicM3
         3Uwlt8kEoCuIYkMjMD5dofqh9aQwjocvoeSxsCu8okKKcRoBqR8eoRZNLgUAqNYwrIT6
         rdXgLXVw984mnWAr+L1s+78rguV9eYq6zyQcbhL8HvBptURp7bdhg5Nx9cS08sykGyts
         +RZw==
X-Gm-Message-State: APjAAAXeFu5QcTbRkK2GR8yI/xr2aVx+Jhb6uSOebqKFvLymRzhHojro
        g/vFjY98HBuu5dDe/mYjq/E=
X-Google-Smtp-Source: APXvYqy8fBTXU8joNbGcSdpzVSvcOsS+2SxvVrN6+XsBFW7jGeYY3vigBmz3AZfzQPtQkVS+Jua7Zg==
X-Received: by 2002:ac2:4948:: with SMTP id o8mr1126632lfi.13.1565686944834;
        Tue, 13 Aug 2019 02:02:24 -0700 (PDT)
Received: from pc636 ([37.212.214.187])
        by smtp.gmail.com with ESMTPSA id o3sm19538418lfb.40.2019.08.13.02.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 02:02:24 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 13 Aug 2019 11:02:14 +0200
To:     Michel Lespinasse <walken@google.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] mm/vmalloc: use generated callback to populate
 subtree_max_size
Message-ID: <20190813090214.xy6tgvar6kiartkb@pc636>
References: <20190811184613.20463-1-urezki@gmail.com>
 <20190811184613.20463-3-urezki@gmail.com>
 <CANN689Hh-Pr-3r9HD7w=FcNGfj_E7-9HVsHu3J9gZts_DYug8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689Hh-Pr-3r9HD7w=FcNGfj_E7-9HVsHu3J9gZts_DYug8A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 05:39:23PM -0700, Michel Lespinasse wrote:
> On Sun, Aug 11, 2019 at 11:46 AM Uladzislau Rezki (Sony)
> <urezki@gmail.com> wrote:
> > RB_DECLARE_CALLBACKS_MAX defines its own callback to update the
> > augmented subtree information after a node is modified. It makes
> > sense to use it instead of our own propagate implementation.
> >
> > Apart of that, in case of using generated callback we can eliminate
> > compute_subtree_max_size() function and get rid of duplication.
> >
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Reviewed-by: Michel Lespinasse <walken@google.com>
> 
> Love it. Thanks a lot for the cleanup!
Thank you for review!

--
Vlad Rezki
