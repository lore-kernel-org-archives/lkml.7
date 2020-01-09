Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF32C33CA4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1ED820721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578583949;
	bh=e+8teUutDcTrOf1C5tq1dzQr8Tjsy4MZMpCRFIYHJuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PeJVYrTSMz1McW3GFv+IvDllcTnLzS9n60ZQmgzEAIYO2nOcuCBw4E4Sww+MHA9hP
	 OkTsaaadM3S9DdR+XCgEFNTCJ+PcIxR2DJTaD7kuAZu9acmUGVFfMcP9zAoW7F21O4
	 cMhkmmo/wWzbqaCASCTg1FnBWHdppBCFoKaZxxN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbgAIPc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:32:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgAIPc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:32:28 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFE92072A;
        Thu,  9 Jan 2020 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578583947;
        bh=e+8teUutDcTrOf1C5tq1dzQr8Tjsy4MZMpCRFIYHJuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x0+zT5fu5S2nCgP35Kc9swptcQDkCVh27Z9qnkoMWKBJy5yQ7KwHux13C4WwVsxeU
         kXmNgtSCnHfhTbdZsigqPxu8OO2SYXWmcDvaPxHkFWk+T1D9WIDDjy+IBzf6h0yK1r
         0e/PzjaCU6YFd00U72+HOKb8jUFv5SL+NSoSDeTs=
Date:   Thu, 9 Jan 2020 10:32:26 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Firo Yang <firo.yang@suse.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        rcu@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH AUTOSEL 4.19 46/84] tcp/dccp: fix possible race
 __inet_lookup_established()
Message-ID: <20200109153226.GG1706@sasha-vm>
References: <20191227174352.6264-1-sashal@kernel.org>
 <20191227174352.6264-46-sashal@kernel.org>
 <CA+G9fYv8o4he83kqpxB9asT7eUMAeODyX3MBbmwsCdgqLcXPWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYv8o4he83kqpxB9asT7eUMAeODyX3MBbmwsCdgqLcXPWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 01:31:22PM +0530, Naresh Kamboju wrote:
>On Fri, 27 Dec 2019 at 23:17, Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>>
>> [ Upstream commit 8dbd76e79a16b45b2ccb01d2f2e08dbf64e71e40 ]
>>
>> Michal Kubecek and Firo Yang did a very nice analysis of crashes
>> happening in __inet_lookup_established().
>>
>> Since a TCP socket can go from TCP_ESTABLISH to TCP_LISTEN
>> (via a close()/socket()/listen() cycle) without a RCU grace period,
>> I should not have changed listeners linkage in their hash table.
>>
>> They must use the nulls protocol (Documentation/RCU/rculist_nulls.txt),
>> so that a lookup can detect a socket in a hash list was moved in
>> another one.
>>
>> Since we added code in commit d296ba60d8e2 ("soreuseport: Resolve
>> merge conflict for v4/v6 ordering fix"), we have to add
>> hlist_nulls_add_tail_rcu() helper.
>
>The kernel panic reported on all devices,
>While running LTP syscalls accept* test cases on stable-rc-4.19 branch kernel.
>This report log extracted from qemu_x86_64.
>
>Reverting this patch re-solved kernel crash.

I'll drop it until we can look into what's happening here, thanks!

-- 
Thanks,
Sasha
