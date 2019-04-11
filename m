Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616ACC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA02217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="mZVlWLhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDKKqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:46:46 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:34089 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKKqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:46:45 -0400
X-Greylist: delayed 2412 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2019 06:46:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6KQUjfncdrsA3T/gypZ6l17eb8a3qRti+BhvKSXNdXY=; b=mZVlWLhb07aa7ksCnolUZx/KZP
        P2sM6MGNBKIx+x3ivo/T5kfwRdKcndI8xA3pn2wuGnSl8suFvQTomU6Y9eeXffi2+FB57Dqvom0rX
        PqMrC5ilXQ+7HlucyFkeBh4YrjM55C7KBQ3wuUobixC4F3faLZUAxtoF9IoUZqv3Clx1bHf7EtFNO
        YYEyST9kshknN3psuK5Ms6zFX5hhDUjSQWMeMzgmQPmJx7NamQNOFBxkkolLbVEgomxN+SlA8zDB2
        TcXApbAl3mf9gtQ7nPn29o8Czxxoy65nSWAClgy/GK7k+p3COnbFDP6Axj48boYzQ4VW8D5yDwn0v
        YsUSgCwg==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1hEWbF-0002t6-0W; Thu, 11 Apr 2019 13:06:29 +0300
Subject: Re: [PATCH] gpu: host1x: fix compile error when IOMMU API is not
 available
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, digetx@gmail.com,
        linux-tegra-owner@vger.kernel.org
References: <4c3d021c73c001f633803e364cfbc6ace3381205.1554936354.git.stefan@agner.ch>
 <7371b1573ddd0b127713724ef5051a6f@codethink.co.uk>
 <20190411083017.GB4633@ulmo>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <c73bb650-7175-150b-a678-c707e5f0e7e7@kapsi.fi>
Date:   Thu, 11 Apr 2019 13:06:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190411083017.GB4633@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.4.2019 11.30, Thierry Reding wrote:
> On Thu, Apr 11, 2019 at 09:23:13AM +0100, Ben Dooks wrote:
>>
>>
>> On 2019-04-10 23:47, Stefan Agner wrote:
>>> In case the IOMMU API is not available compiling host1x fails with
>>> the following error:
>>>    In file included from drivers/gpu/host1x/hw/host1x06.c:27:
>>>    drivers/gpu/host1x/hw/channel_hw.c: In function
>>> ‘host1x_channel_set_streamid’:
>>>    drivers/gpu/host1x/hw/channel_hw.c:118:30: error: implicit
>>> declaration of function
>>>      ‘dev_iommu_fwspec_get’; did you mean ‘iommu_fwspec_free’?
>>> [-Werror=implicit-function-declaration]
>>>    struct iommu_fwspec *spec =
>>> dev_iommu_fwspec_get(channel->dev->parent);
>>>                                ^~~~~~~~~~~~~~~~~~~~
>>>                                iommu_fwspec_free
>>>
>>> Fixes: de5469c21ff9 ("gpu: host1x: Program the channel stream ID")
>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>> would it be better to provide something like this i nthe header that
>> defines dev_iommu_fwspec_get() to be:
>>
>> static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>> { return NULL; }
>>
>> although returning an PTR_ERR would have been better.
> 
> I don't think there's really a large number of failures here. Either
> your device has an IOMMU fwspec or it doesn't.
> 
> But yes, I think it'd be better to have the above static inline dummy in
> iommu.h, but I'll apply this for now in the hopes of getting it in
> before v5.1 final.

A similar patch was already sent before by someone. That one also 
programs the bypass stream ID (0x7f) even if IOMMU is disabled. We 
should pick that patch instead.

Thanks,
Mikko

> 
> Thierry >
>>
>>> ---
>>>   drivers/gpu/host1x/hw/channel_hw.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/host1x/hw/channel_hw.c
>>> b/drivers/gpu/host1x/hw/channel_hw.c
>>> index 27101c04a827..4030d64916f0 100644
>>> --- a/drivers/gpu/host1x/hw/channel_hw.c
>>> +++ b/drivers/gpu/host1x/hw/channel_hw.c
>>> @@ -114,7 +114,7 @@ static inline void synchronize_syncpt_base(struct
>>> host1x_job *job)
>>>
>>>   static void host1x_channel_set_streamid(struct host1x_channel *channel)
>>>   {
>>> -#if HOST1X_HW >= 6
>>> +#if IS_ENABLED(CONFIG_IOMMU_API) &&  HOST1X_HW >= 6
>>>   	struct iommu_fwspec *spec =
>>> dev_iommu_fwspec_get(channel->dev->parent);
>>>   	u32 sid = spec ? spec->ids[0] & 0xffff : 0x7f;
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
