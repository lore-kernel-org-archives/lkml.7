Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E1CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3BE20714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574410807;
	bh=gK6oJApQdfap1GRmd4jnfOse8hyJ8UGnatmDKIcDr68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hgTrqFcVmNajBljUWP/babjS0DQdt7hLxA2pVstnj3q9W0CNCm5c9XdDdJLb4KkY4
	 JSxpkd2LjGp+AMDq/ugMlavqyC0WRMbDHrVKcyURtEkterFPQWLwhOdxHt6yzbSvMm
	 R64YyDwbtUIMj6WQ/cRzS2b7s9/L+i5epAwqhgQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVIUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:20:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36618 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:20:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so7519615wru.3;
        Fri, 22 Nov 2019 00:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPT3v6LUVVcOVXi+g802WzoqdgMO1VqYXbBWJl6TUYI=;
        b=l8PfjEiBknhJLccXhUb9oQ5ay4+RKcqgUFyDqcQXRpOXr7TajTIEw5PDmUWDTOkuO/
         CCYYk0/CFR9C4uNsypVTyYjKmwcJxnC8+WDVV8APMfp7vS2jATvYs2kknrJjy+atxlnx
         2QtkYPLn+ttq6pkwqBFpwHMSIYJwF9thDjGGGCC1gdJln0x1iUTqipf0c3E5Lq0eggOY
         dU6wXYwZ9n6pispuF/A43AXqCQGXUtqaFFO79Hr5lks9JDT+uLE7JgtiJi3nMM2zwfFW
         sFubgXykJIjS3V/BNnq53knhVienGSi1JbkONV8/YyjpiKu38aI1LG910lT14G1S4AxR
         +WMQ==
X-Gm-Message-State: APjAAAUAsJ1+NkopRFU52eQzSHKuDbhfg9i5fMdT/oQFdcq/r31u8/mn
        DDyR6xgH6RS8rBcMrRQB0Z8=
X-Google-Smtp-Source: APXvYqxCiNaVvdFuGx1EHIvyZ/qVW3RIpS2NmxW8P6HtapWUa9SJQAxcL2KD6HkTcQmn22Ao0CafaA==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr29505wrs.46.1574410803823;
        Fri, 22 Nov 2019 00:20:03 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o189sm2740666wmo.23.2019.11.22.00.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 00:20:03 -0800 (PST)
Date:   Fri, 22 Nov 2019 09:20:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] mm: memcg: switch to css_tryget() in
 get_mem_cgroup_from_mm()
Message-ID: <20191122082002.GP23213@dhcp22.suse.cz>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191113162934.GF19372@blackbody.suse.cz>
 <20191113170823.GA12464@castle.DHCP.thefacebook.com>
 <20191121152847.GA14375@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121152847.GA14375@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-11-19 16:28:47, Michal Koutny wrote:
> On Wed, Nov 13, 2019 at 05:08:29PM +0000, Roman Gushchin <guro@fb.com> wrote:
> > The thing here is that css_tryget_online() cannot pin the online state,
> > so even if returned true, the cgroup can be offline at the return from
> > the function.
> Adding this for the record.
> 
> The actual offlining happens only from css_killed_ref_fn, which is
> percpu_ref_kill_and_confirm confirmation callback. That is only called
> after RCU grace period. So, css_tryget_online will pin the online state
> _inside_ rcu_read_{,un}lock section.

Thanks for the confirmation. Maybe we should start with a trivial patch
and document this first. We can go and cleanup bogus users on top.
-- 
Michal Hocko
SUSE Labs
