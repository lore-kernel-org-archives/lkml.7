Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF642C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AB22147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="AZ8i4eI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCLUTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:19:02 -0400
Received: from node.akkea.ca ([192.155.83.177]:51746 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbfCLUTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:19:00 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id C4BC44E204B; Tue, 12 Mar 2019 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552421939; bh=CLsJUgY6072ng4H8Psr/at9acv3E5litlixfC+6CBfI=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=AZ8i4eI9xSR04MN6viCDJ/n7gdOpv03jJg/2+zXsm0rJWBzSi+wxSEsJfSF1nF3MW
         gpIXE/njG7Ly5uTnBT9Ut3HjxnTXlo+g/nT1PC/9G1EHeha54lkEtmgoO4pOegge6Y
         UZNY49i1mLMedGuVK0QlSjrxfx3hTaymEQOhc+ns=
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the thermal management  unit (TMU)
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Mar 2019 13:18:59 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, daniel.baluta@nxp.com,
        agx@sigxcpu.org, dl-linux-imx <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
References: <20190311213124.29325-1-angus@akkea.ca>
 <CAHQ1cqEHr1mB2EH3-fJPrYa+nkcWPPjmCTjSt-XsDnJp-SCf+w@mail.gmail.com>
Message-ID: <9f25fb1a0acb35539dcd802502c49058@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 2019-03-11 19:35, Andrey Smirnov wrote:
> On Mon, Mar 11, 2019 at 2:35 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> 
>> These are the TMU nodes from the NXP vendor kernel
>> 
> 
> Hey Angus,
> 
> TMU block supports multiple thermal zones and vendor kernel doesn't
> really account for that (see below). Latest version of the driver in
> thermal tree now actually supports that feature (mulit-sensor), so I
> think the code in DT should reflect that as well. I recently submitted
> a series adding HWMON integration for TMU
> (https://lore.kernel.org/lkml/20190222200508.26325-1-andrew.smirnov@gmail.com/T/#u)

I tried applying those to linux-next. They don't apply very cleanly 
there so I gave up.

> and this is my take on this patch:
> 
> https://github.com/ndreys/linux/commit/09931e3d60af0a74377307b433db97da1be31570
> 
> All of the code there is up for grabs, if you feel like using it.
> 

I followed that and I have a version that works with linux-next that 
does not include the GPU
and VPU parts.

I also tested a version with the GPU and VPU parts and it "works" but 
creates 2 useless
paths in /sys/class/thermal .

Should I wait for your changes to get into linux-next or resubmit a 
version that works with the current one ?

Thanks
Angus
