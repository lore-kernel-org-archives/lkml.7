Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB220C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP3SIkcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfHTKQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:16:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45453 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHTKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:16:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id o13so2957328pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iKtnRnRXyBjoovTvJIaq2YQ2tJPH/EOQqzClVloanFg=;
        b=DP3SIkcqOUk5qRV022QgDnIYhMRLclsJbQ+iMuhdQeFA6Vy8y4pu0GdWeJS1iSphsx
         CeoRwgvdNmy74M1YMktAnP+rDB5p8+z0DyOXL+7bgRlbaa0a2dDeCksAHwX41p3+tZz9
         27L/xSef5k2wR9z7Wx8BP60dtIyYTV6klemVidrjmXK0naEftG6wNr6TmbjhkjmHzx9J
         /lRhkqxKpuGN0YLZkExZB0TH/hCMF06Z0cPlO+huQc54Riipp5frvylqrLy4I1ICvyaY
         d6Dy+3Jc4lBSSUVSu+Rk9pWIwtcxzybEywnLMU7/lEVscGrc8tPufM1b7JT9yR4SeG/Y
         IMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKtnRnRXyBjoovTvJIaq2YQ2tJPH/EOQqzClVloanFg=;
        b=tQyYkAAxxGEWH3JZufqjIj80gSkk7lLGf9cucwaCNxFVXR+iETPmyZHGVv53RfRkGL
         YwIKILgepsN+KvNFjBKRPGuzclj6V5sdLIqNO+Cgmz6qO3WT86emHwWRtkSQKY6U6l6d
         gjOeIccerFJBOcsKCfQ4FUUXnfhk04vODghjx/fG1qqxj4T7CFmvq5JzzR+f1sZt/umC
         3lff6JNudKdI6SfUwpigx0rIGPsdXz+E05bGhsAvCZ6TPTYIcwOQcQJlSf/+yImf4gGT
         PQ1hPX3yDKJnWs3cKgS27i/gwPobUtsZ6p6bTBfUTFo6+MVSISqWx825agO7sJuLqhRF
         UOfQ==
X-Gm-Message-State: APjAAAVkYW1vEFwTKYznGrH4c2EKhUsx5OgYdm37Wd4jfZem4GhrelYp
        bRa8YOzQavFQNU+375sXseruJj8p
X-Google-Smtp-Source: APXvYqwgzcLdn0MCog+xQ170OVRC9VgAYrG0bYTJ3m1jyJ55KFyl9rQ0V/CAuip+wgMOjEC0ZAswxw==
X-Received: by 2002:a17:90a:b014:: with SMTP id x20mr6255093pjq.60.1566296214062;
        Tue, 20 Aug 2019 03:16:54 -0700 (PDT)
Received: from localhost ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id k3sm12387515pjo.3.2019.08.20.03.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 03:16:53 -0700 (PDT)
Date:   Tue, 20 Aug 2019 19:16:49 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v4 4/9] printk-rb: initialize new descriptors as
 invalid
Message-ID: <20190820101649.GC14137@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-5-john.ogness@linutronix.de>
 <20190820092337.cudkfdfhsu44vlhh@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820092337.cudkfdfhsu44vlhh@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/20/19 11:23), Petr Mladek wrote:
> > is no risk of the descriptor unexpectedly being determined as
> > valid due to dataring head overflowing/wrapping.
> 
> Please, provide more details about the solved race. Is it because
> some reader could have reference to an invalid (reused) descriptor?
> Can be these invalid descriptors be member of the list?

As far as I understand, such descriptors can be on the list:

	prb_reserve()
		assign_desc()
			// pick a new never used descr
			i = atomic_fetch_inc(&rb->desc_next_unused);
			d = &rb->descs[i]
			dataring_desc_init(&d->desc);
			return d
		buf = dataring_push()
			// the oldest data is reserved, but not commited
			ret = get_new_lpos()
			if (ret)
				dataring_desc_init()
				return NULL
		if (!buf)
			numlist_push()

_datablock_valid() has a "desc->begin_lpos == desc->next_lpos" check.

	-ss
