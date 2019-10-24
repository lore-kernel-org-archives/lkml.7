Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4818ECA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619921655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWbjhBCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439827AbfJXRJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:09:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45196 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410207AbfJXRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:09:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so25829587ljb.12;
        Thu, 24 Oct 2019 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IrAfe5w1HnK8l8FuW+hQKQUlkFSvckC54yQUeXG//ko=;
        b=mWbjhBCkHaL5glMlAQhj6Agacp7Li+u9if1i1Ymo2qjHZ1lHG0TLeYiSC97M/nRPK1
         Ad0R9qrXYKIE6zV1TcIBK6d9UtUT23ChFMh1uXvkVmiOVh+ukKHzfqd9bdHItfSID9zp
         X044GzJxWSpeVpQ8tT9dk7DRx6V/FBx6lF1HqtlZJe7X7D1saoe/5HFlvLT217poA8ns
         6skq943P1cTy+77942FQ8aBUiWYVacMA24Tn8E+YN7x6pNZABQ0Uwks5AW7Ezwtp+Y3o
         85GpDedISXW8N/FKjQOdMcGN+r4jQaswCPUeV9UUOumjOnhDiy8Zkj2hVDZxE9oLGH6W
         M/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IrAfe5w1HnK8l8FuW+hQKQUlkFSvckC54yQUeXG//ko=;
        b=Zr3PRk6S0lqpC3yZLULkkkiGhNEIJxUjlV0OZ0Kz0QuN54aN1t64l49BC42bKIJgSx
         JJx7H7cyKbgdMBTmlbRP2v4uzcBc+WJtw+fc3fp5j+OkfGDYrgIBMt8n2n/59FsfYKXc
         oqrumyaxkxjXs2cvlp3zfG0s7Or9EgnROGP7K9QzCJCfqK51Kp1z+vtE2iXUwoMsNeZ9
         l1Kd5/uyss/YAuEdDnmHsWdd7zydJHyv/QsIis67Dp7uog3LIclgFFcmZuC7bY+FY1En
         oX+ZGY8qPx8AXDoMLSgwQWi4Ls9BARJI/deBVlYFtop/QoX5YhuC35VYeuTiTy/sxqN3
         Rwuw==
X-Gm-Message-State: APjAAAWskwBJH1YsjWAkb/AvmkZYtle1WuV6zXzL8DP0GyxopBVpA/dQ
        aoJfbhyfAan0JgKr1IEH3npJW8vN
X-Google-Smtp-Source: APXvYqxSkIhVMx2JQ4ozADmzdOXgHT9YOY73BRvR0bq+4cNTs8tWmZwy3WI9LUw0lgPggYogDS0wbg==
X-Received: by 2002:a2e:4e12:: with SMTP id c18mr27544082ljb.51.1571936965362;
        Thu, 24 Oct 2019 10:09:25 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id n25sm10143389ljc.107.2019.10.24.10.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:09:24 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20191024115016.GA2924027@ulmo>
 <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
Message-ID: <b8a9fc65-3d2f-8461-e0de-83cbb45fea49@gmail.com>
Date:   Thu, 24 Oct 2019 20:09:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 16:35, Dmitry Osipenko пишет:
> 24.10.2019 14:50, Thierry Reding пишет:
>> On Sun, Jun 23, 2019 at 08:37:41PM +0300, Dmitry Osipenko wrote:
>>> On ARM32 we don't want any of the clients device to be backed by the
>>> implicit domain, simply because we can't afford such a waste on older
>>> Tegra SoCs that have very few domains available in total. The recent IOMMU
>>> support addition for the Video Decoder hardware uncovered the problem
>>> that an unfortunate drivers probe order results in the DRM driver probe
>>> failure if CONFIG_ARM_DMA_USE_IOMMU=y due to a shortage of IOMMU domains
>>> caused by the implicit backing. The host1x_client_register() is a common
>>> function that is invoked by all of the relevant DRM drivers during theirs
>>> probe and hence it is convenient to remove the implicit backing there,
>>> resolving the problem.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>
>> I don't really want to do this in a central place like this. If we
>> really do need this, why can't we do it in the individual drivers?
> 
> Why do you want to duplicate the same action for each driver instead of
> doing it in a single common place?
> 
>> we already call host1x_client_iommu_attach() from all the drivers and
>> that detaches from the IOMMU as well. So I'm not sure I understand why
>> this is needed.
> 
> Wish you could ask that couple months ago. I'll try to refresh the details.
> 

In kernel's boot order:

1) Host1x is attached to exclusive implicit domain
2) Host1x is detached from the implicit domain and attached to explicit
3) Both DC's fail to attach to implicit domain because DMA-mapping code
doesn't take into account multiple devices in the same group.
4) GR2D is attached to exclusive implicit domain
5) GR3D is attached to exclusive implicit domain
6) VDE is attached to exclusive implicit domain
7) VDE is detached from the implicit domain and attached to explicit
8) DC client is trying to attach to DRM domain in
host1x_client_iommu_attach() and that fails because tegra-smmu code
allocates ASID in tegra_smmu_attach_dev()->tegra_smmu_as_prepare() (i.e.
on IOMMU group's attaching) and all ASIDs are already busy.

Hence if DRM sub-device drivers are detaching from the implicit domain
on probe, then the problem is getting worked around because there are
available ASIDs at the time of host1x clients initialization.
