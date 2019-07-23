Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA0C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257022513
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsa3wQwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfGWJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:48:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45178 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGWJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:48:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so40343730lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qGX6IuhNcRSi9X6/a2qMSk1y8inVeGuBF+eTHUQ+bWY=;
        b=tsa3wQwWVkiJ7WVoTIb0mGXxzhr+rtgVeVb1p2POWR3Nye0ykLEq0Jqwb5nl+qKYcW
         gNtymOO5HvFleCtrRdTNTgbibysHwuhIIDazUdcgtZ3Hc3yAsrwgvEJaeqf7fHvMqLV5
         TzhsVBYeKj8hdamyObhwyRrdzG1d5yAdwwRgpZvQKXoIA+F0bD7ERjXigIIHjMQ6WFse
         kIW1aoYtQArsgYJ9PHGHHag79EY3mHtN0B5MQfcfMyi+qCQMgHck9ObeJ9cjVF0Mju77
         mgENJnXZ09oupkvGkgGUNuIt1uLUG5tpeeUkb/hPcStDHrpsA9GbSy7BZNhYjZ75kZrn
         TTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qGX6IuhNcRSi9X6/a2qMSk1y8inVeGuBF+eTHUQ+bWY=;
        b=ORHQ4LZi7ZOtWOY1xKqiCOgf0GirYY1GIOdR1HlzLDIkfq8yx5QYcZpttqk5zWy0Da
         JYAmq41dRkn6Z8yQMgr2pLC2OmSObQ1YM8CJ+Xd01uD0Z4YtecK5nlzN1RhqRWQ6lcYm
         qrwE9S062rajmSljplNoer0bViZrFNzewrQ9kCtgpHblgYXajEMD3Q5N17eTdhStOVjn
         +bXZZ7MjJX9ws6VSunpUb7xrcC7o5rfjapRyNXX1FUFMz+ybIjGVXPaTzskkA85Ikx4/
         OVrpMUydiysqdtoD13irSTrZGGuEEJ62Mu3berkMrRL9qDLznIXho922+qbUe3jFNZou
         4NLA==
X-Gm-Message-State: APjAAAUnWKoVng0Ir08GIQnK6QudW0ip5myVXzVfKW8EtUu02nKXWhyN
        bomA9eHGFyM0ZktUE0D5TO0=
X-Google-Smtp-Source: APXvYqx2KdFZ2X7fHRLTwQtjNLDqLUc5b3VWLVVUUpHBi/CuGq6RIWEyl1H6gKJWRqt9VAJ4OphOnQ==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr38066017ljg.96.1563875290418;
        Tue, 23 Jul 2019 02:48:10 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id y29sm7920315ljd.43.2019.07.23.02.48.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:48:09 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 2B1244606E8; Tue, 23 Jul 2019 12:48:09 +0300 (MSK)
Date:   Tue, 23 Jul 2019 12:48:09 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_prctl(): simplify arg2 judgment when calling
 PR_SET_TIMERSLACK
Message-ID: <20190723094809.GE4832@uranus.lan>
References: <1563852653-2382-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190723072338.GD4832@uranus.lan>
 <5D36C11D.1070804@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D36C11D.1070804@cn.fujitsu.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:11:09PM +0800, Yang Xu wrote:
> > 2) according to man page passing negative value should be acceptable,
> >     though it never worked as expected. I've been grepping "git log"
> >     for this file and the former API is coming from
> > 
> > commit 6976675d94042fbd446231d1bd8b7de71a980ada
> > Author: Arjan van de Ven<arjan@linux.intel.com>
> > Date:   Mon Sep 1 15:52:40 2008 -0700
> > 
> >      hrtimer: create a "timer_slack" field in the task struct
> > 
> > which is 11 years old by now. Nobody complained so far even when man
> > page is saying pretty obviously
> > 
> >         PR_SET_TIMERSLACK (since Linux 2.6.28)
> >                Each thread has two associated timer slack values:  a  "default"
> >                value, and a "current" value.  This operation sets the "current"
> >                timer slack value for the calling  thread.   If  the  nanosecond
> >                value  supplied in arg2 is greater than zero, then the "current"
> >                value is set to this value.  If arg2 is less than  or  equal  to
> >                zero,  the  "current"  timer  slack  is  reset  to  the thread's
> >                "default" timer slack value.
> > 
> > So i think to match the man page (and assuming that accepting negative value
> > has been supposed) we should rather do
> > 
> > 	if ((long)arg2<  0)
> Looks correct. But if we set a ULONG_MAX(PR_GET_TIMERSLACK also limits ULONG_MAX)
> value(about 4s) on 32bit machine, this code will think this value is a negative value and use default value.
> 
> I guess man page was written as "less than or equal to zero" because of this confusing code(arg2<=0, but arg2
> is an unsinged long value).
> I think we can change this man page and also add bounds value description.

OK, seems reasonable. I think we should use comparision with zero
and simply update a man page.
