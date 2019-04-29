Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F281C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E0921670
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556574089;
	bh=+09ul6BJ5z6U8oUPWedc6Q3xIY19o0pVeORGAv1luVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PUm1TL3f3xrq6/oSTf3DJegFB5EMsjyWzjnPMSRiplOT4WC/ecnzPCMeLSg5dwVmP
	 HzpL8bFxLLWtMVmKAMpljxyyLf2PwordUGvkSz+82G0OH6jS9N+b8YvAaqTZP9Zr/g
	 6jTI9Zajh5NVb8kzqOB/rZS5N8Sx19f1SKk4vgls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfD2Vl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:41:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:52494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729252AbfD2Vl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:41:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8EB1BABD7;
        Mon, 29 Apr 2019 21:41:26 +0000 (UTC)
Date:   Mon, 29 Apr 2019 17:41:23 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg, fsnotify: no oom-kill for remote memcg
 charging
Message-ID: <20190429214123.GA3715@dhcp22.suse.cz>
References: <20190429171332.152992-1-shakeelb@google.com>
 <20190429171332.152992-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429171332.152992-2-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-04-19 10:13:32, Shakeel Butt wrote:
[...]
>  	/*
>  	 * For queues with unlimited length lost events are not expected and
>  	 * can possibly have security implications. Avoid losing events when
>  	 * memory is short.
> +	 *
> +	 * Note: __GFP_NOFAIL takes precedence over __GFP_RETRY_MAYFAIL.
>  	 */

No, I there is no rule like that. Combining the two is undefined
currently and I do not think we want to legitimize it. What does it even
mean?
-- 
Michal Hocko
SUSE Labs
