Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23193C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C0214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568740065;
	bh=Cx46LOGv4BNjTSei9LWwlF4X6Up/WnaZBoHwti+KXHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t8HB5c1QbioIH6Pn+zAB+NJ1m81zMnkN2AKDmc+Xm59MbkbjU91IkOoAkyPuRHIoI
	 Rsh9ceuEvTeQULcIAV9KXkoJOROm1joGog8VVEZ73+ADLWuShq0Msegk1kXRH4V2QQ
	 oOsWGs6+rQnhsiRTwInBPQ/IrhjEY61+JE5VUscQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfIQRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:07:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfIQRHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:07:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539862067B;
        Tue, 17 Sep 2019 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740063;
        bh=Cx46LOGv4BNjTSei9LWwlF4X6Up/WnaZBoHwti+KXHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EHXpHfISM0cj8rSRrHKB9Ji1mZQyNgSpSoRF3W/iJc8AKBXvEAi9fg+vhWIqc101g
         KmEe0D0zX4/kwUr2ppTKtYRksZTNnNJ7nnQJA1s2nPV5DGOyuoE8ov2JC93TUCrmr4
         KsIKiK4o/MwvTJJmVVwhKmOm+brcwDK/nQOv+u5o=
Date:   Tue, 17 Sep 2019 18:07:38 +0100
From:   Will Deacon <will@kernel.org>
To:     KeMeng Shi <shikemeng@huawei.com>
Cc:     akpm@linux-foundation.org, james.morris@microsoft.com,
        gregkh@linuxfoundation.org, mortonm@chromium.org,
        will.deacon@arm.com, kristina.martsenko@arm.com,
        yuehaibing@huawei.com, malat@debian.org, j.neuschaefer@gmx.net,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] connector: report comm change event when modifying
 /proc/pid/task/tid/comm
Message-ID: <20190917170737.dpchgliux4qi2qef@willie-the-truck>
References: <20190916211008.ipqe3j7s22aannta@willie-the-truck>
 <20190917135628.3054-1-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917135628.3054-1-shikemeng@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 09:56:28AM -0400, KeMeng Shi wrote:
> on 2019/9/17 at 5:10, Will Deacon wrote:
> >The rough idea looks ok to me but I have two concerns:
> >
> >  (1) This looks like it will be visible to userspace, and this changes
> >      the behaviour after ~8 years of not reporting this event.
> This do bother for users who only care the comm change via prctl, but it
> also benefits users who want all comm changes. Maybe the best way is add
> something like config or switch to meet the both conditions above. In my
> opinion, users cares comm change event rather than how it change.

I was really just looking for some intuition as to how this event is
currently used and why extending it like this is unlikely to break those
existing users.

> >(2) What prevents proc_comm_connector(p) running concurrently with itself
> > via the prctl()? The locking seems to be confined to set_task_comm().
> To be honest, I did not consider the concurrence problem at beginning. And
> some comm change events may lost or are reported repeatly as follows:
> set name via procfs	set name via prctl
> set_task_comm
> 			set_task_comm
> proc_comm_connector
> 			proc_comm_connector
> Comm change event belong to procfs losts and the fresh comm change belong
> to prctl is reported twice. Actually, there is also concurrence problem
> without this update as follows:
> set name via procfs	set name via prctl
> 			set_task_comm
> set_task_comm
> 			proc_comm_connector
> Comm change event from procfs is reported instead of prctl, this may
> bothers user who only care the comm change via prctl.

Perhaps, although given that proc_comm_connector() is currently only called
on the prctl() path, then it does at least provide the comm from the most
recent prctl() invocation. With your path, the calls can go out of order,
so I think that probably needs fixing.

Will
