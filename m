Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EBC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB2221D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576595627;
	bh=0KCyjAy/9GjrsG4kczDuTO3NO1JJuxbaNBl7wrY7rgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EGfNnNmO8rpK8MaxYlEq39l0Ys+GGLmlWYoXnTyhgbyBHkuK6maBlmeeqLCgEhN6W
	 zsCYgadi0LmkFQQv0B9UdEGkFoDZXcn6T5KoQ8egvIVlJXp4z2EqSs3PJtFh3inVan
	 4+MP0+m4oP4TJ6YABF22DujEu/8WOW6Qod7b/ELQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfLQPNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:13:47 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39717 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:13:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so11693400wrt.6;
        Tue, 17 Dec 2019 07:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=84OmudL4nhIn2JLQldH7TGRNUYk7SaIOMOPh/ydmyqE=;
        b=N7/q4kXHxNb3rYfWavCVzL7GWMzcpe/lf2TZcsM2U1wclANiPA89u3UKo+4zIJEe3s
         CDWczYcTBYknSNEx/Agm6ClOzAlU/moArhrSFzw+Y4cGav8Ry0CnD5r5lzqzCB97puvv
         iJhW7eUUOGZEI1fNDkQqtZkf4CR+bhfBx6MMdQ/utV5UXrjsjSriUVoAksjy9+6SOM3/
         +thujnVd+IFdNtCLRersTo0HIe9YS4VAyWQgBYJGzwlAejA/MMG7XSZN0wW6s0GGecby
         1f76TkSN5OUmLQJxAlZEDbd4X194kiBUfgebAgjx8ltN4OQyBjQhMFd7M49X7RHzw4JR
         2dRA==
X-Gm-Message-State: APjAAAUFgXYbb82Rs2FepsVp4lWN+UfXiI+7L01qRtYSuwxjrYNl+YHw
        BWABR4RdNbgWAwioiVgiN7g=
X-Google-Smtp-Source: APXvYqzYOMD988kB9mj2RJ66ZpnhbcIyk49ncZyddyoGTYF4n7dVI9PulNh2YOx59yoPntdxj7tJqw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr36952652wrq.37.1576595624656;
        Tue, 17 Dec 2019 07:13:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id g21sm27457018wrb.48.2019.12.17.07.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:13:43 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:13:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Chris Down <chris@chrisdown.name>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217151343.GC7272@dhcp22.suse.cz>
References: <20191217144652.GA7272@dhcp22.suse.cz>
 <43881F9C-90D0-4DE0-BA1E-B74ACF8567BD@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43881F9C-90D0-4DE0-BA1E-B74ACF8567BD@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-12-19 10:04:36, Qian Cai wrote:
> 
> 
> > On Dec 17, 2019, at 9:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > yes, I would just ignore this warning. Btw. it seems that this is
> > enabled by default for -Wall. Is this useful for kernel builds at
> > all? Does it realistically help discovering real issues? If not then
> > can we simply blacklist it?
> 
> -Wunused-function is useful in-general as it caught many dead code
> that some commits left unintentionally with real-world configs.

I do understand the general purpose of the warning. I am simply not sure
the kernel tree is a good candidate with a huge number of different
config combinations that might easily result in warnings which would
tend to result in even more ifdeferry than we have.
-- 
Michal Hocko
SUSE Labs
