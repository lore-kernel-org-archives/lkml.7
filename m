Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0AFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9ED207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F5PvjxHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfDBJoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:44:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12249 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfDBJoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:44:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca32f040000>; Tue, 02 Apr 2019 02:44:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 02:44:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 02:44:38 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 09:44:36 +0000
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@google.com>,
        <linux-tegra@vger.kernel.org>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
 <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
 <20190402043509.GQ2059@sirena.org.uk>
 <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
 <20190402091955.GE2059@sirena.org.uk>
 <10d454a4-e1e1-3a4b-8400-acd680d75a3d@nvidia.com>
 <20190402093159.GF2059@sirena.org.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3053ef10-ba36-ee88-4ca0-d1e39c0ea25c@nvidia.com>
Date:   Tue, 2 Apr 2019 10:44:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402093159.GF2059@sirena.org.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554198276; bh=+2DYTN7EyCd6kOq9oi33zFgwVRW1icHCg6m+5MlveZ4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F5PvjxHGvXPJh751t+uiTIlhuD3z3oahfYpktIlzP5o0/qFiHrcrImoEOGI1veHcv
         iWKbhOpoaWQ9n2NB54B2EJZ03w0QZuTJi1UyzaY/Q2Jh/TjrfTnBR5wyeCNZpxAGHb
         BJjItDmrUCsZFq/+4+9SfeHl6MNiV+XHG1zagSkD4fytCo62fvTnxA0aptCy8iwLa/
         IGbe9fIqKHe3W8P9KfeBulE97/QUJIGr36xFKzuTrWNQl2b/aH75zGes4n0nUrrbX0
         nfI5FlxZDsTRx0PILBwKzIP/ikastvtsTiLM9LzfqOy1Lu6B+9/7Ft+P67b35UnQnQ
         mKVcjQR3YuXgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/04/2019 10:31, Mark Brown wrote:
> On Tue, Apr 02, 2019 at 10:30:34AM +0100, Jon Hunter wrote:
>> On 02/04/2019 10:19, Mark Brown wrote:
> 
>>> Oh, if I've applied that's why I don't have it any more.  Indeed it's
>>> applied in my 5.1 branch so I don't know what you're expecting here?
> 
>> Well I still don't see it in the mainline branch and some boards are
>> still failing to register soundcards with v5.1-rc3 because this is
>> missing. So I am wondering what has happened to the change. It seems it
>> has been dropped.
> 
> You can check to see what's in my tree by looking at it directly or at
> -next.

Right I see it in -next. Sorry but what I am asking is if you are
planning to send as a fix for v5.1? Maybe you have not sent out the
fixes yet for v5.1 and so wanted to check.

Cheers
Jon

-- 
nvpublic
