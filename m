Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E6206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SGgzRutb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDAMWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:22:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14203 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:22:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca202780000>; Mon, 01 Apr 2019 05:22:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 05:22:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Apr 2019 05:22:12 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 12:22:11 +0000
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@google.com>,
        <linux-tegra@vger.kernel.org>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
Date:   Mon, 1 Apr 2019 13:22:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554121336; bh=H4eS+JDIFbGfXBP7CSW58+O8K9HXMfpUpUef8WPXP3c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SGgzRutbeB84hNNGAO3vXqbY4Ggm0hycYsQ6PHBKaMF+/8v54P/qUVb1ZJWxQ1+U3
         TJvweOokwO5KsVLSAeqtRtPfeRbo513mOLqiYe3iuVudo3tDLfiFUH42xkUpL+CWsS
         1ImEnkWqq3sR87Jps+CA73SCDE3lghIgje3HmfCe7rn8uMqowJZ9XxulwHMIkF5M7F
         HGzS301WpBmDhVZt2o9HHYubENOQ5b5DMR6W4mqjG7F5+xKhvLAJczJt4H3zrDL5wN
         Yz8w9hrjE6JNY4CsmonWwfpf5th2XVRTNqPWWK2DHhoSuPlqs2aqpZb36vd2AyApe8
         JcnUQkNUyjkYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 04/03/2019 13:31, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> Commit 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
> re-worked the clean-up of any platform pointers that may have been
> initialised by the function snd_soc_init_platform(). This commit missed
> one error path where if any of the prelinks for a soundcard failed to
> initialise, then these platform pointers would not be cleaned-up. This
> then prevents the soundcard from being initialised following a probe
> deferral when any of the soundcard prelinks cannot be found.
> 
> Fix this by ensuring that soc_cleanup_platform() is called when
> initialising the soundcard prelinks fails.
> 
> Fixes: 78a24e10cd94 ("ASoC: soc-core: clear platform pointers on error")
> 
> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>

FYI, I am seeing that the deferral of soundcards failing with v5.1-rc3
because the above has not been merged yet. Just wanted to let you know
in case this one was not marked for v5.1.

Cheers
Jon

-- 
nvpublic
