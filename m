Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599A3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2932339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566504724;
	bh=Ku0hzCUMPIz90x9/NXAAV7FD8SLkfZFin2QgzU7FKyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cjn+4z7sxCTfPzbLIJ8ni2FoUxQ5/HvbYpeenvh7qQblfhuzDzcktsH1Zcu41DOCW
	 kGdn7tsDeNvv1pjLtFkAFSwQr1rtibXt9x2lwzZgN5apkB44E328yDmbFrgGrF/iep
	 yxgfaY7vRzi8gbR17ljJKgUMd6dE34972/krF6jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392826AbfHVUMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729746AbfHVUMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC096AE86;
        Thu, 22 Aug 2019 20:12:01 +0000 (UTC)
Date:   Thu, 22 Aug 2019 22:12:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: return value of the function
 mem_cgroup_from_css() is not checked
Message-ID: <20190822201200.GP12785@dhcp22.suse.cz>
References: <20190822062210.18649-1-yzhai003@ucr.edu>
 <20190822070550.GA12785@dhcp22.suse.cz>
 <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-08-19 13:07:17, Yizhuo Zhai wrote:
> This will happen if variable "wb->memcg_css" is NULL. This case is reported
> by our analysis tool.

Does your tool report the particular call path and conditions when that
happen? Or is it just a "it mignt happen" kinda thing?

> Since the function mem_cgroup_wb_domain() is visible to the global, we
> cannot control caller's behavior.

I am sorry but I do not understand what is this supposed to mean.
-- 
Michal Hocko
SUSE Labs
