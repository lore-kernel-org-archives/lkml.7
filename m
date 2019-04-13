Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B3C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383A620848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555162721;
	bh=bMMZA8D0Ap9nVSIP2LqpZyl625yUlCqEL1+ZaI5on28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZwXVYBKvsidM4m6KSxq3x9DknaZeM4fZPjIBTBXqh/ouJOtHPSfv3o2KE0MBaiMq
	 p03e2gqXoFK3QBhjqXH4N+g1gp4KLKIpZc1m0u1gHzeNy0n1lEgKZT7BNJnXmg/meG
	 GV2dPO803zl67CloiFW7JmyYQ2vYjj3v7HSWEgPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfDMNik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 09:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfDMNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 09:38:39 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCEA7206B7;
        Sat, 13 Apr 2019 13:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555162719;
        bh=bMMZA8D0Ap9nVSIP2LqpZyl625yUlCqEL1+ZaI5on28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBZaExaeKui+MjU/DwAmSlyGeVSe3Yi20jVVroX78j8H3xalkIfx6nh4TrhXMt+dI
         6Rmwj3g8zACNAByCW9tbhbhuwsrUgt150SUp06ND74kLVFPYTPb2rQdPK4pAXQKQD5
         DwfiNKjHGQW0Nyvb9kdr0nZpegPz/dC/KWkQ7QG8=
Date:   Sat, 13 Apr 2019 09:38:37 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] vmbus: Remove the undesired put_cpu_ptr() in
 hv_synic_cleanup()
Message-ID: <20190413133837.GU11568@sasha-vm>
References: <20190412233429.29146-1-decui@microsoft.com>
 <DM5PR2101MB09185C3019B33BB0866007B9D7290@DM5PR2101MB0918.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB09185C3019B33BB0866007B9D7290@DM5PR2101MB0918.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 02:19:52AM +0000, Michael Kelley wrote:
>From: Dexuan Cui <decui@microsoft.com>  Sent: Friday, April 12, 2019 4:35 PM
>>
>> With CONFIG_DEBUG_PREEMPT=y, the put_cpu_ptr() triggiers an underflow
>> warning in preempt_count_sub().
>>
>> Fixes: 37cdd991fac8 ("vmbus: put related per-cpu variable together")
>> Cc: stable@vger.kernel.org
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>
>Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Queued for hyperv-fixes, thanks all.

--
Thanks,
Sasha
