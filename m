Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B270C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EE12084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568099633;
	bh=xtSAGfJgC7ApXAI0l3Pct75cRPGtlKJcs2C1VRFW9s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sTVasAXyeZJAaV/VObRMHh9hGxofhzxJ/eO1HXuIcWsMxoMjNZFY8syyA8PewPGq4
	 wPj4Dt/D951TZKJ9YZHI5F07moFKAhgsWibLidoSKrdapRNSKG5+XVBSHhqVSmhuW9
	 Jt6Tw2t2Tem5TqeX1GlHKBr7txmKmORs0vo/+hQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404253AbfIJHNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:13:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729707AbfIJHNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:13:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59719AFB6;
        Tue, 10 Sep 2019 07:13:50 +0000 (UTC)
Date:   Tue, 10 Sep 2019 09:13:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] driver core: ensure a device has valid node id in
 device_add()
Message-ID: <20190910071349.GH2063@dhcp22.suse.cz>
References: <1568009063-77714-1-git-send-email-linyunsheng@huawei.com>
 <20190909095347.GB6314@kroah.com>
 <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9598b359-ab96-7d61-687a-917bee7a5cd9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-09-19 14:43:32, Yunsheng Lin wrote:
> On 2019/9/9 17:53, Greg KH wrote:
[...]
> > But as we do not know the node, can we cause more harm by randomly
> > picking one (i.e. putting it all in node 0)?
> If we do not pick node 0 for device with invalid node, then caller need
> to check the node id and pick one, and currently different callers
> does a different checking:

Could you be more specific about who those callers are why do they need
the node id for? Because the page allocator can handle that as already
pointed out in my other email. Who else does really have to know about
the node apart the allocator?
-- 
Michal Hocko
SUSE Labs
