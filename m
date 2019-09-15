Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F3BC4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9463E214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfIOQzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:55:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55405 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIOQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:55:25 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 86E1B81325; Sun, 15 Sep 2019 18:55:09 +0200 (CEST)
Date:   Sun, 15 Sep 2019 18:55:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 042/190] KVM: x86: hyperv: keep track of mismatched
 VP indexes
Message-ID: <20190915165516.GA4901@bug>
References: <20190913130559.669563815@linuxfoundation.org>
 <20190913130603.107888371@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913130603.107888371@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-09-13 14:04:57, Greg Kroah-Hartman wrote:
> [ Upstream commit 87ee613d076351950b74383215437f841ebbeb75 ]
> 
> In most common cases VP index of a vcpu matches its vcpu index. Userspace is, however, 
> free to set any mapping it wishes and we need to account for that when we need to find a 
> vCPU with a particular VP index. To keep search algorithms optimal in both cases 
> introduce 'num_mismatched_vp_indexes' counter showing how many vCPUs with mismatching VP 
> index we have. In case the counter is zero we can assume vp_index == vcpu_idx.

I don't see why this is stable material.

>  	u64 hv_reenlightenment_control;
>  	u64 hv_tsc_emulation_control;
>  	u64 hv_tsc_emulation_status;
> +
> +	/* How many vCPUs have VP index != vCPU index */
> +	atomic_t num_mismatched_vp_indexes;
>  };
>  

It adds a write-only variable ...

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
