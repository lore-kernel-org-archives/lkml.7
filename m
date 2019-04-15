Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28329C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E932420825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555333192;
	bh=Q1E85pHBYkGvodUsK7lCDeidoQfw1FAJySX6nVp1kfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TjIVR4TUjxv4IqzZSHpVik+MvTyqBgEond0jL44DkxWGTkvdT/ko7IAkMC2PpBeXu
	 4lWptgLtq+npo0VuWaB7S9pWEmVKCdcd9nz8IdIz2pXcKHI+RFZTRBtAFwCRwi8pd+
	 wbpXOq27Sym9MHvM3Cn2wGowTZC4krU+ch3D7xEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfDOM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:59:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41383 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbfDOM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:59:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id k8so15542309lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUX0TNiGq/KgiwnRmF3oEw42hvyn4Vb6l5AVU+7itU4=;
        b=kNilKxSdKz8ExW8iXqKrp6QdHeMekO4Nwu63twoadCaNvlw5SwkZ6cfoXEhBhPsT00
         YwHZRzymxZbYL6xXqH4yLlomzkwNN7Zc/I1PdMfLOXV/B8S8eGZ3/vf7goK2GETEj58L
         ih4in7DObmFjqQk1HjDAdRbnsqHfpd55Sag26dNg1LUCFNgqm9spor+wdZRT822/7Kp1
         tRMmyD8KoFJBALYxdkawxjrH3Yv+LgTii+JGLbbIETp/+uHy9ZLYAxcUKJAaaP96mFP4
         YAPAdYWEN82Gf2cR8baaCx/z6rhAo/GpMz2YhQA9Vpc0BITN536WYSC60a3F5SnjMpN9
         LGXg==
X-Gm-Message-State: APjAAAWV+nZui75aLNwYanLpvK0me1QsRtbLFMzIWeS/jMj7iZb3DcYe
        MfJzMPKgEaLEv2PvXwro9Hs=
X-Google-Smtp-Source: APXvYqxMvKwUiR8ETW+5oCVtNQcrrEs4dx3dYt7E+DW26cfadWuRo4ANobz5n/j5BY28ZIA3qW+R0Q==
X-Received: by 2002:a2e:7806:: with SMTP id t6mr11739988ljc.143.1555333185949;
        Mon, 15 Apr 2019 05:59:45 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 73sm10674759ljf.72.2019.04.15.05.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 05:59:44 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hG1DB-0000ek-VA; Mon, 15 Apr 2019 14:59:50 +0200
Date:   Mon, 15 Apr 2019 14:59:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH] Staging: greybus: Fix spinlock_t
 definition without comment
Message-ID: <20190415125949.GB775@localhost>
References: <20190405200046.20600-1-madhumithabiw@gmail.com>
 <20190405205304.GS32590@kadam>
 <fd59f7d5-84a0-35ca-b096-a1d2c7e30336@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd59f7d5-84a0-35ca-b096-a1d2c7e30336@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:50:10PM -0500, Alex Elder wrote:
> On 4/5/19 3:53 PM, Dan Carpenter wrote:
> > On Fri, Apr 05, 2019 at 03:00:46PM -0500, Madhumitha Prabakaran
> > wrote:
> >> Fix spinlock_t definition without comment.
> >> 
> >> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> 
> Madhumitha, the reason one would want a comment associated with
> a lock field in a structure is to get some understanding of why
> it's needed.  Saying "protect structure fields" is not enough,
> because that can pretty much be assumed, so a comment like that
> adds no value.
> 
> Looking at the code, you can see the lock field protects the
> connection's operations list.  It also appears to be needed
> for accessing the state field (reading or updating).
> 
> Given that, a better comment might be:
> 
>         spinlock_t                      lock;	/* operations list and state */
> 
> >> --- drivers/staging/greybus/connection.h | 2 +- 1 file changed, 1
> >> insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/staging/greybus/connection.h
> >> b/drivers/staging/greybus/connection.h index
> >> 5ca3befc0636..0aedd246e94a 100644 ---
> >> a/drivers/staging/greybus/connection.h +++
> >> b/drivers/staging/greybus/connection.h @@ -47,7 +47,7 @@ struct
> >> gb_connection { unsigned long			flags;
> >> 
> >> struct mutex			mutex; -	spinlock_t			lock; +	spinlock_t			lock; /*
> >> Protect structure fields */ enum gb_connection_state	state;
> > 
> > What does the mutex do then?  Why can't we just use the spinlock for 
> > everything?
> 
> The mutex needs to be held during enable and disable of a connection.
> Johan might be able to give you a more complete answer but these
> operations (or at least the enable) need to block, so can't hold a
> spinlock.

Yeah, I should have documented this at the time.

You're right that the connection spinlock protects the operation list,
and the mutex the connection state, but there are some other
dependencies here and I don't have time to look at this at the moment.

Better to leave as is, I'd say.

Johan
