Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C8620883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bbUsrk+d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfDBIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:52:20 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11792 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:52:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca322b90000>; Tue, 02 Apr 2019 01:52:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 01:52:19 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 01:52:19 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 08:52:17 +0000
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
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
Date:   Tue, 2 Apr 2019 09:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402043509.GQ2059@sirena.org.uk>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554195129; bh=gJiNKrWVDymlhkssr/cNXnvrB70P9R6U4j/NwK6ka0M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bbUsrk+dI3z5adO66+g/8/2Kr/xZwSIO14dPGPNJS1Jzpx3PnHDSQY+Thtrfin0ZY
         67xz6Uznauu6MgV9Nf/mpTW9gCsbEJVVYat1IJ/pBtetke2DIA9w3erppyk8JOo0Kh
         q2VHpwizWpd1BRxlcRf+Zx6gHyJ1RBFX93tV6HC/A6YpaWzI/21gmZK0iU1Gc0bYdx
         M5u5r9d5HERf6K2f9NK3YS7xBXisLGewXzlGkkfjbhUZtm08x4MDWRKs2d00IwsEU6
         6sY5MqlMTHox6IfhH1pTgePDJnEZ8gtsdjyQ+EXxeARGOJrjdpM01Q8kV/yxbyU77Y
         lrWgTvxOJccLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/04/2019 05:35, Mark Brown wrote:
> On Mon, Apr 01, 2019 at 01:22:09PM +0100, Jon Hunter wrote:
> 
>> FYI, I am seeing that the deferral of soundcards failing with v5.1-rc3
>> because the above has not been merged yet. Just wanted to let you know
>> in case this one was not marked for v5.1.
> 
> I don't have this patch at all AFAICT.

That's odd. It is definitely in -next and I did receive an 'applied'
email from you [0]. So looks like something went wrong here. Can we get
this into v5.1?

Cheers
Jon

[0] https://lkml.org/lkml/2019/3/4/637


-- 
nvpublic
