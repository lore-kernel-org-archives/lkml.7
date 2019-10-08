Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E77C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754A6217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570542515;
	bh=VKc7Xxn5RL2X3cXGk70B3QLiIVOG5siFsmbVAIQfhbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwbwfXxqCdEsDIvrn3tQH1dfgZkjArnBX7z56beYgjsrvhSPGqQ1qeDbiE2TsamG6
	 P97DCqYeCizV5Bn2i3iiks5Sd5YovlHpkleFUB8oLrR3LWJQqV34YfjZSTsyyET+Ia
	 MIiHsMbTxD9oc9bmXy5EXNtxrYhcQQBH165Bncuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfJHNse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:48:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbfJHNse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:48:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13FFBB1AC;
        Tue,  8 Oct 2019 13:48:32 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:48:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Qian Cai <cai@lca.pw>, Steven Rostedt <rostedt@goodmis.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008134831.GL6681@dhcp22.suse.cz>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
 <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
 <1570460350.5576.290.camel@lca.pw>
 <20191007151237.GP2381@dhcp22.suse.cz>
 <1570462407.5576.292.camel@lca.pw>
 <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
 <20191008091349.6195830d@gandalf.local.home>
 <1570541032.5576.297.camel@lca.pw>
 <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008134256.5ti6rjkvadn5b5q4@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-10-19 15:42:56, Petr Mladek wrote:
[...]
> I am not -mm maintainer so I could not guarantee that a patch
> using printk_deferred() will get accepted. But it will have much
> bigger chance than the original patch.

I am not going to ack any such patch until it is clear what is the
actual problem. The disucssion in this thread boils down to point to
lockdep splats which are most likely false possitives and there is no
clear evidence that the is any actual deadlock as those would be clearly
identifiable if the zone->lock or any other spinlock spinlock were
participating.
-- 
Michal Hocko
SUSE Labs
