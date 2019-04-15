Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22325C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C0820818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555328033;
	bh=JHQIUt+pJVTvzwRcGMr0Hls+2ghZW5jDIP3wSHGjHwE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=NtIeAo2Ya6GrbbUdblolBEC+btgw7bObEHQVC2Fp7u4G6CPxihYZD52S5Vk56Ychk
	 Tsqk61wlVAIzcf2s40wdf9iCxY2N54sRE/4wYkfJZOvv5/TsP7XtS0qhvw6p9RMMna
	 lD/KcjfJIv09I7vla8PvhMS9bji2Psuc33EuP4PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDOLdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:33:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfDOLdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:33:52 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D551420818;
        Mon, 15 Apr 2019 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555328031;
        bh=JHQIUt+pJVTvzwRcGMr0Hls+2ghZW5jDIP3wSHGjHwE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zalJlVgIPDjxzyTOy3N33/n8rjzaVE6LIUnF70smuV3E7dfHcQYR8uzYohptNIPWQ
         laIv+MTCgpyQ70drsgm71GnOFL1571ptcDWP1+Xcl6iEBsG0wkZ/mzOoYYK1W9NNFp
         JTnKvgwYFqdZrrqj405XNeYvEHADC/rrBKRd+pRY=
Date:   Mon, 15 Apr 2019 13:33:47 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5.1-rc] iwlwifi: make locking in iwl_mvm_tx_mpdu()
 BH-safe
In-Reply-To: <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>
Message-ID: <nycvar.YFH.7.76.1904151328270.9803@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1904151300160.9803@cbobk.fhfr.pm> <24e05607b902e811d1142e3bd345af021fd3d077.camel@sipsolutions.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Johannes Berg wrote:

> (FWIW, would be good to cc linux-wireless, but no need for linux-kernel
> I guess :-) )

Hm, no idea where I lost that ML from the get_maintainer output, sorry for 
that.

> > iwl_mvm_sta->lock can be taken from BH, and therefore BH must be 
> > disabled if taking it from other contexts.
> > 
> > This fixes the lockdep warning below.
> 
> I don't think this is the right fix.
> 
> The only problem is this path:

Agreed, that seems to be the only culprit.

> >      SOFTIRQ-ON-W at:
> >                        _raw_spin_lock+0x35/0x50
> >                        iwl_mvm_tx_mpdu+0xae/0x5f0 [iwlmvm]
> >                        iwl_mvm_tx_skb+0x200/0x470 [iwlmvm]
> >                        iwl_mvm_mac_itxq_xmit+0xd5/0x1f0 [iwlmvm]
> >                        iwl_mvm_add_new_dqa_stream_wk+0x34c/0x910 [iwlmvm]
> >                        process_one_work+0x1f0/0x5b0
> 
> which I believe we just made use local_bh_disable() since there are
> other reasons as well for that, IIRC.
> 
> Yes, here's the fix:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=f5ae2f932e2f8f4f79796f44832ae8fca26f188a
> 
> It's on the way upstream.

If there are other reasons why disable BH for the whole function (are 
there?), then this bigger hammer works as well of course.

	Tested-by: Jiri Kosina <jkosina@suse.cz>

> Thanks for the patch/report though!

Thanks,

-- 
Jiri Kosina
SUSE Labs

