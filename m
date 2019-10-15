Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AAAECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1712C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="tV6fx4WF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfJOObs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:31:48 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38977 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732851AbfJOObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:31:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id 4so19344382qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLVD7vPJBGWYE3BC+T54ofrBrkXdHmXQZojv0W6wPTA=;
        b=tV6fx4WFPct3lTQ345Oq5xdMJixBxbdzJ7TXEOs2AxCPbU6ggBQHmQqmttRkGbTrth
         fKUwwLGnsTfYmRceiI3Xgg90DWKq4uc8M2uCUC0gW7Kszq8+XiEcQm6DORDmpne3DNc3
         sP3uuZEW9h1B9OlrpZxPAEvnvNcADrsXQlBARcp4sThPwcJuBQcxX7qj870CDr30s0wy
         Y/Bru1q+VVfeGEiZXBd0NtokPdennXJiRa6MUbNmTAiBGLUzZbv2mtF4OVrL4AeU9/4O
         7yXtd3u+UCcgUo7ynZF+2L510IN+ovY2Y/IJq7wZ2XYC/oEL5iAmc75a89W/b9z4mPS1
         UZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLVD7vPJBGWYE3BC+T54ofrBrkXdHmXQZojv0W6wPTA=;
        b=ZBwzy7Ui4yPFIn1BepLaQDDlaDQwbxCVARIoLqjrhrTEaFfk/pJ7mn/3VOaMwGImTP
         hshzE4psZjZ4buukfRFj3Ro71sqWaws65DAalIgWWlnr/tjdkJ5cuiUxTczPXG6ds/uK
         tsReGndN/w3hUW4n5bmpoh0Rax5+ZCrv8t0VZYQFcuHc1IZBrsDIciPlwYzHJb5iMI5i
         yBP/dARa99DcatnjCRCaQnJcUz4MLldgAnehpm5tUcpcKxBm9q7INpRXD/hBNHM70Btd
         pkv90Gzr6piXQhfhipcYHMiL2gzQU5nB+WYiMA9Z5EYyAjDZm3C/OKoyF/ubr4DgbjQr
         9wtA==
X-Gm-Message-State: APjAAAWXdRloR66iWQ6V+EUP91CmUeQiOdj3+GvA/sQohkuPAt9Pwswv
        dRHJUDkdvoQ+ZiWKsxeJRzj4Ng==
X-Google-Smtp-Source: APXvYqzunM/QzD2RkF8PdGCuo6II98hv68LXdo5zbgABkad6Kr+uQdefq49as/+MZ8iDH7JqufNQwQ==
X-Received: by 2002:ae9:ee06:: with SMTP id i6mr34408845qkg.362.1571149905707;
        Tue, 15 Oct 2019 07:31:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d056])
        by smtp.gmail.com with ESMTPSA id o52sm14093380qtf.56.2019.10.15.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:31:44 -0700 (PDT)
Date:   Tue, 15 Oct 2019 10:31:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015143142.GB139269@cmpxchg.org>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015082048.GU317@dhcp22.suse.cz>
 <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
 <20191015103623.GX317@dhcp22.suse.cz>
 <31cab57d-6e79-33cb-1a58-99065c6e7b82@yandex-team.ru>
 <20191015110401.GZ317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015110401.GZ317@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:04:01PM +0200, Michal Hocko wrote:
> On Tue 15-10-19 13:49:14, Konstantin Khlebnikov wrote:
> > On 15/10/2019 13.36, Michal Hocko wrote:
> > > On Tue 15-10-19 11:44:22, Konstantin Khlebnikov wrote:
> > > > On 15/10/2019 11.20, Michal Hocko wrote:
> > > > > On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
> > > > > > Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> > > > > > These counters needs update when page is moved between cgroups.
> > > > > 
> > > > > Please describe the user visible effect.
> > > > 
> > > > Surprisingly I don't see any users at this moment.
> > > > So, there is no effect in mainline kernel.
> > > 
> > > Those counters are exported right? Or do we exclude them for v1?
> > 
> > It seems per-lruvec statistics is not exposed anywhere.
> > And per-lruvec NR_FILE_MAPPED, NR_FILE_DIRTY, NR_WRITEBACK never had users.
> 
> So why do we have it in the first place? I have to say that counters
> as we have them now are really clear as mud. This is really begging for
> a clean up.

IMO This is going in the right direction. The goal is to have all
vmstat items accounted per lruvec - the intersection of the node and
the memcg - to further integrate memcg into the traditional VM code
and eliminate differences between them. We use the lruvec counters
quite extensively in reclaim already, since the lruvec is the primary
context for page reclaim. More consumers will follow in pending
patches. This patch cleans up some stragglers.

The only counters we can't have in the lruvec are the legacy memcg
ones that are accounted to the memcg without a node context:
MEMCG_RSS, MEMCG_CACHE etc. We should eventually replace them with
per-lruvec accounted NR_ANON_PAGES, NR_FILE_PAGES etc - tracked by
generic VM code, not inside memcg, further reducing the size of the
memory controller. But it'll require some work in the page creation
path, as that accounting happens before the memcg commit right now.

Then we can get rid of memcg_stat_item and the_memcg_page_state
API. And we should be able to do for_each_node() summing of the lruvec
counters to produce memory.stat output, and drop memcg->vmstats_local,
memcg->vmstats_percpu, memcg->vmstats and memcg->vmevents altogether.
