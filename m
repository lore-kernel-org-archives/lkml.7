Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E44BC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1869A2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574787271;
	bh=LrdXgBpIGmBm6VAtSBexvelo9GbjQWOHUdqZz8tzBQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MHnAa57EwSsVpFqQ/oWkXnSbb8HixOougEaRlcl1xHUSQ4IIn1cmOVkeZZeEt0Sj/
	 o7bD0JyNXm9HH/RI9+kNq4PsvhzuY98xFrsJj5lsAnsexNa0vJEoPr/UJGpzuMG7J8
	 Vnn7MoqKAJYqv2PIXWhX52u1C79X9hkwLle3KDxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfKZQya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:54:30 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39270 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbfKZQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:54:30 -0500
Received: by mail-wm1-f41.google.com with SMTP id t26so4158000wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 08:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTx9XvAoitX5ElOHyXfUJ5O+w+mtZmpTIHTRwny9Xek=;
        b=hpyqvE9VeMaWI/eZXjmt+RGFOApuV/H9pWeb7ytb3XEgK/upMTknPdqtDJZ+QrruaF
         oj4dl5xb8mUb0PGQ3pn4NehC2HtcZjtAvX+ZGXe7qiNpN5Y+gtlPjFdrTXn0A3Nl0GLv
         nXwHN7hd+fje3Jw2Tiia2BkL+u6ddqshMPNpyJ+1h7JfwFlPXEEAT1TUu7l/x+zYB8Wz
         zYxw9m5dgtKDGXk8QFqcW4SuZT3dyD8F5rlbFJXqqnoc/TUiwksCnQJuST0she6qq7Jg
         QoPZVpw/xzIeWDx5bJZp1DcMfMtO75WeS9I3fHWVUwupzxXDbfU32QhYqNiE+kNztg4S
         h3XQ==
X-Gm-Message-State: APjAAAWJNIigUJfLuSCdYSFiW3fJ0h5YdU0cpdBbR/LxbmlTjK0KEp+/
        XbatrEq2s0kx4gik2AC1NFwBmAZB
X-Google-Smtp-Source: APXvYqyNQMXlfZcrpPbACcE9XEaIY+zXE74QnRlwETHHnA9AoeY9wlB4/0H5Mi4sPRDNtH7ng3/Gtw==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr5400635wme.125.1574787267780;
        Tue, 26 Nov 2019 08:54:27 -0800 (PST)
Received: from localhost (ip-37-188-250-171.eurotel.cz. [37.188.250.171])
        by smtp.gmail.com with ESMTPSA id b14sm3679664wmj.18.2019.11.26.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 08:54:26 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:54:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20191126165420.GL20912@dhcp22.suse.cz>
References: <20191126121901.GE20912@dhcp22.suse.cz>
 <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911261632030.9857@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-11-19 16:32:56, Cristopher Lameter wrote:
> On Tue, 26 Nov 2019, Michal Hocko wrote:
> 
> > Hi,
> > I have just learnt about KOBJ_{ADD,REMOVE} sysfs events triggered on
> > kmem cache creation/removal when SLUB is configured. This functionality
> > goes all the way down to initial SLUB merge. I do not see any references
> > in the Documentation explaining what those events are used for and
> > whether there are any real users.
> >
> > Could you shed some more light into this?
> 
> I have no idea about what this is.

It seems to be there since the initial merge. I suspect this is just
following a generic sysfs rule that each file has to provide those
events?

> There have been many people who
> reworked the sysfs support and this has been the cause for a lot of
> breakage over the years.

Remember any specifics?

I am mostly interested in potential users. In other words I am thinking
to suppress those events. There is already ke knob to control existence
of memcg caches but I do not see anything like this for root caches.
-- 
Michal Hocko
SUSE Labs
