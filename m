Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BA9C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7822E21D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 06:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogaMPrR+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogaMPrR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442290AbfIYGYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 02:24:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404570AbfIYGYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 02:24:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA4E861197; Wed, 25 Sep 2019 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569392651;
        bh=efyvQV7q7fIN6ZkOeoxT6VazF4LiJT3OJPSTTXRZbJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogaMPrR+nmcQbEvlzytpjir1Xy/qKVqEGmn5ROTxTq8C81BvoSE7POnTLXwIKgBgj
         tx2zGwFW0ps/spY586xrdcflVRQUGMzPTX2cpk44BPmodH+EHNAYbeknxeheXjecJd
         8sVlaO1xL6gSyL71OJWFVeW4BymdvSCHhuuWwUg0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3292560128;
        Wed, 25 Sep 2019 06:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569392651;
        bh=efyvQV7q7fIN6ZkOeoxT6VazF4LiJT3OJPSTTXRZbJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogaMPrR+nmcQbEvlzytpjir1Xy/qKVqEGmn5ROTxTq8C81BvoSE7POnTLXwIKgBgj
         tx2zGwFW0ps/spY586xrdcflVRQUGMzPTX2cpk44BPmodH+EHNAYbeknxeheXjecJd
         8sVlaO1xL6gSyL71OJWFVeW4BymdvSCHhuuWwUg0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Sep 2019 11:54:11 +0530
From:   ppvk@codeaurora.org
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        vbadigan@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-mmc-owner@vger.kernel.org
Subject: Re: [RFC 1/2] mmc: sdhci-msm: Add support for bus bandwidth voting
In-Reply-To: <616c7a8c-a1cf-2043-4ea4-f452ee90f083@linaro.org>
References: <1567774037-2344-1-git-send-email-ppvk@codeaurora.org>
 <1567774037-2344-2-git-send-email-ppvk@codeaurora.org>
 <616c7a8c-a1cf-2043-4ea4-f452ee90f083@linaro.org>
Message-ID: <d10c21360d4830c864374a57c491c21c@codeaurora.org>
X-Sender: ppvk@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-12 18:26, Georgi Djakov wrote:
> Hi Pradeep,
> 
> Thanks for the patch!
> 
> On 9/6/19 15:47, Pradeep P V K wrote:
>> Vote for the MSM bus bandwidth required by SDHC driver
>> based on the clock frequency and bus width of the card.
>> Otherwise,the system clocks may run at minimum clock speed
>> and thus affecting the performance.
>> 
>> This change is based on Georgi Djakov [RFC]
>> (https://lkml.org/lkml/2018/10/11/499)
> 
> I am just wondering whether do we really need to predefine the 
> bandwidth values
> in DT? Can't we use the computations from the above patch or is there 
> any
> problem with that approach?
> 
> Thanks,
> Georgi

Hi Georgi,

By using the direct required bandwidth(bw / 1000) values, it will not 
guarantee
that all the NOC clocks are running in the same voltage corner as 
required,
which is very crucial for power concern devices like Mobiles etc.
Also, it will not guarantee that the value passed is in proper Clock 
Plans domain
there by effecting the requested Bandwidth.
I think, you already aware of these consequences on using direct 
bandwidth values for
RPMh based devices.

The value the we passed in DT will make sure that all the NOC clocks 
between the end points
are running in the same voltage corners as required and also it will 
guarantee that
the requested BW's for the clients are obtained.

Hence the reason for passing the predefined bandwidth values in DT.

Thanks and Regards,
Pradeep
