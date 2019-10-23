Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C00C47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F7921906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571853741;
	bh=CprqxoKvaciPcib1UsukQImyA0K5ihbhXL0QqiZh8GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K2+JYx+UC6AX+eOgdewH0rGHU00yrm1R43VGa9ul8jpk8BOFO0nz4PfeS/bx4YXqE
	 3Xwifb58vUDh54LO5IoGlKUH/eoEVYDxYjljLtNlqbfHfGXvFkRto06yB8oQA47FQQ
	 PcKqMa4a0NPZ59FccrJOcNcBMWVFbqzLRpdcvp9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfJWSCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:02:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:52832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387653AbfJWSCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:02:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B587AE6F;
        Wed, 23 Oct 2019 18:02:18 +0000 (UTC)
Date:   Wed, 23 Oct 2019 20:02:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH 2/2] mm, vmstat: List total free blocks for each order in
 /proc/pagetypeinfo
Message-ID: <20191023180217.GO17610@dhcp22.suse.cz>
References: <20191023102737.32274-3-mhocko@kernel.org>
 <20191023173423.12532-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023173423.12532-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 13:34:23, Waiman Long wrote:
[...]
> @@ -1419,6 +1419,17 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
>  		}
>  		seq_putc(m, '\n');
>  	}
> +
> +	/*
> +	 * List total free blocks per order
> +	 */
> +	seq_printf(m, "Node %4d, zone %8s, total             ",
> +		   pgdat->node_id, zone->name);
> +	for (order = 0; order < MAX_ORDER; ++order) {
> +		area = &(zone->free_area[order]);
> +		seq_printf(m, "%6lu ", area->nr_free);
> +	}
> +	seq_putc(m, '\n');

This is essentially duplicating /proc/buddyinfo. Do we really need that?
-- 
Michal Hocko
SUSE Labs
