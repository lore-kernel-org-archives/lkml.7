Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F325C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56482207FD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576347101;
	bh=3LrZZJbCclsHdwqWlzoOzNHVItEveOpELF2p47CNLDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fdxjVLv6HRo16i+gR85xUevyPpdXpVT54+g7+BwWSDAz8ktv7g9vOqjx6Ipcw2/pP
	 xGQN7NC432XS4vHnGf4751qWtWNlmvYAuGDG3oFDS0Ir0jBPXlLPqrjRjDK+LfmOtC
	 xyUEHe2XE/XyWIwD9XUZGNZg9Mr69AaXNqy7tKQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLNSLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfLNSLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 13:11:39 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E525214AF;
        Sat, 14 Dec 2019 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576347098;
        bh=3LrZZJbCclsHdwqWlzoOzNHVItEveOpELF2p47CNLDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUBZNjffD7cHvECGCGvUoTVmTCOYNdfesXyt2NzzLaBYXWloTQ+CuDz+9QLmyP4LM
         suCNLerzScfvRJntS5Y9UtOLHvbSox6nNK1nPHelr0bu7RmwASQZtxw/dVdu5ybf+3
         AsCXBFwQYWWTCsxfdIRJobm9UuyABauqUrstqons=
Date:   Sat, 14 Dec 2019 13:11:37 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Schiller <ms@dev.tdt.de>, linux-leds@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 034/134] leds: trigger: netdev: fix handling
 on interface rename
Message-ID: <20191214181137.GH12996@sasha-vm>
References: <20191211151150.19073-1-sashal@kernel.org>
 <20191211151150.19073-34-sashal@kernel.org>
 <20191214084331.GD16834@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191214084331.GD16834@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 09:43:31AM +0100, Pavel Machek wrote:
>On Wed 2019-12-11 10:10:10, Sasha Levin wrote:
>> From: Martin Schiller <ms@dev.tdt.de>
>>
>> [ Upstream commit 5f820ed52371b4f5d8c43c93f03408d0dbc01e5b ]
>>
>> The NETDEV_CHANGENAME code is not "unneeded" like it is stated in commit
>> 4cb6560514fa ("leds: trigger: netdev: fix refcnt leak on interface
>> rename").
>>
>> The event was accidentally misinterpreted equivalent to
>> NETDEV_UNREGISTER, but should be equivalent to NETDEV_REGISTER.
>>
>> This was the case in the original code from the openwrt project.
>>
>> Otherwise, you are unable to set netdev led triggers for (non-existent)
>> netdevices, which has to be renamed. This is the case, for example, for
>> ppp interfaces in openwrt.
>
>Please drop.

Here's a bug report from a user (fixed by this patch):

        https://forum.openwrt.org/t/18-06-4-serious-led-problems-td-w8970-v1/40417

He has titled the report "18.06.4:Serious ‘LED’ Problems!", and in the
bug report itself he has mentioned:

        The LED's are really important to me. please let me know how to
        fix this by my self! I cannot report it and wait for next few
        months for patch, again!

There are two other similar bug reports:

        https://bugs.openwrt.org/index.php?do=details&task_id=2193
        https://bugs.openwrt.org/index.php?do=details&task_id=2239

So this is obviously an issue that affects users and needs to be fixed.

Beyond the above, the patch is upstream, it fixes a single issue, and is
shorter than 100 lines.

I'm going to go ahead and ignore your input for this and the rest of the
led patches in the series for similar reasons.

-- 
Thanks,
Sasha
