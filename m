Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF40CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D2A2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5NUgS7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfJaPlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:41:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39866 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfJaPlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:41:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so7142795ljj.6;
        Thu, 31 Oct 2019 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hs9AJBC+az+ICiDdHQdwfGOKMqZZjjUvDnX+IerCWm4=;
        b=Y5NUgS7W7OiIJXi6jmIl7T1HH8NU4D7KBflaK5Sq3mwQbHHqxGRNb7XZjwqah9S5S0
         MpKIHCt7H7zLw+88fN6/+vYHFIst8/xwmcLKzP4gvInLJcY+inYL8N2bYOa5iaIrNCZ0
         SZjxKGQzoAdaXaWsipubXD5a9dy8NY0oJmGlECGPd/qDvi0DIpQrPhVrMUOQKZXT0tdp
         C48g5+zj1G4D+/w3Pf1W3Dc0CIWPOj7D5Ypftawfbc4CIhLwh4qJQN49ujycuBFPm7gZ
         QUlSE/fqzwY/mxde1u3HHtcjM6yGrgy3+YMvvD6w/41kb6FVjvOKowlCksfVmP91CpID
         W++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hs9AJBC+az+ICiDdHQdwfGOKMqZZjjUvDnX+IerCWm4=;
        b=eb6/bCQSDDViOxFoxR2u9wlDRKswme/Xp+HHOezLjGoXgBBkeA1hihGJH9Az72jGx/
         NDIkVoqpWHN99EVSa4YdS+L5CGl7N2GoMZ9OcQgIl7xxD+U0zRoiRP76JbLDFYfmkpk7
         G5BF6S1FgTpW6wE3BcWjJBqwOMWJ5fdfdCNLlhnXb/IYkYaYAb8dHJ6rthviaw5uYm88
         9SzDsF8O/+pBVkeSvhk9gs/9HAqw9ezCumPWFcjXDjmhGAUrSU2tun+uNO+ikFGbxgf6
         qy+q7cbkrEiscOP2SQ1mruZgGwj0b4qdkvOVNGxy28CYiOI/WerCDV2WT/4p7aZfZQnB
         8HuA==
X-Gm-Message-State: APjAAAX+hyi44l4lfbHukqSa0+U2mRXKvdWiBkKrYXxl7odO5qbGka6G
        vw4AaV84t3PS6zoB2pea2kHCkpjd
X-Google-Smtp-Source: APXvYqw9ljJRtaYk1C+MaZKATjFuvS0ms3pUzEegvu2xIhkxddGbBZbqsQ+yNUguxpMqrqluvMffdA==
X-Received: by 2002:a05:651c:390:: with SMTP id e16mr4671922ljp.196.1572536512669;
        Thu, 31 Oct 2019 08:41:52 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id v203sm2428879lfa.25.2019.10.31.08.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 08:41:51 -0700 (PDT)
Subject: Re: [PATCH -next] gpu: host1x: Fix compile test failure
To:     Yuehaibing <yuehaibing@huawei.com>, thierry.reding@gmail.com,
        mperttunen@nvidia.com, arnd@arndb.de, seanpaul@chromium.org
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191030135458.27960-1-yuehaibing@huawei.com>
 <283304d6-bf23-8107-29b6-9f3e7dda943c@gmail.com>
 <cb0a976a-0148-d554-15ff-5f4059eccd37@huawei.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fe9c774b-7fec-e423-9cdb-e742fefbd4eb@gmail.com>
Date:   Thu, 31 Oct 2019 18:41:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cb0a976a-0148-d554-15ff-5f4059eccd37@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.10.2019 16:33, Yuehaibing пишет:
> On 2019/10/31 6:26, Dmitry Osipenko wrote:
>> 30.10.2019 16:54, YueHaibing пишет:
>>> If IOMMU_SUPPORT is not set, but IOMMU_IOVA is m and
>>> COMPILE_TEST is y, building fails:
>>>
>>> drivers/gpu/host1x/dev.o: In function `host1x_remove':
>>> dev.c:(.text+0x624): undefined reference to `put_iova_domain'
>>> dev.c:(.text+0x624): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `put_iova_domain'
>>> dev.c:(.text+0x62c): undefined reference to `iova_cache_put'
>>> dev.c:(.text+0x62c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `iova_cache_put'
>>>
>>> Select IOMMU_IOVA while COMPILE_TEST is set to fix this.
>>>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Fixes: 52499a6ad2ae ("gpu: host1x: select IOMMU_IOVA")
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>> ---
>>>  drivers/gpu/host1x/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
>>> index cf987a3..354232d 100644
>>> --- a/drivers/gpu/host1x/Kconfig
>>> +++ b/drivers/gpu/host1x/Kconfig
>>> @@ -2,7 +2,7 @@
>>>  config TEGRA_HOST1X
>>>  	tristate "NVIDIA Tegra host1x driver"
>>>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>>> -	select IOMMU_IOVA if IOMMU_SUPPORT
>>> +	select IOMMU_IOVA if (IOMMU_SUPPORT || COMPILE_TEST)
>>>  	help
>>>  	  Driver for the NVIDIA Tegra host1x hardware.
>>>  
>>>
>>
>> It should be better to unconditionally select IOMMU_IOVA here.
>>
>> The same could be done for drivers/staging/media/tegra-vde/ and
>> drivers/gpu/host1x/, please see [1].
> 
> Yep, I will repost, thanks!

Oh, I missed that you made a patch for host1x and not for drm. Thus
drivers/gpu/drm/tegra/ also needs the same change.

>>
>> [1] https://lore.kernel.org/linux-iommu/20190829154902.GC19842@ulmo/
