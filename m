Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F492CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DE12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kovun9oA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393574AbfJXN2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:28:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45808 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbfJXN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:28:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so25018150ljb.12;
        Thu, 24 Oct 2019 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qpRvQzuCmX419tk1RXW8tLuM29gmSdeDEbb3mw63/Z8=;
        b=Kovun9oAV/Qbjri23VchT2LL8J3Rk6T4/3T+ZqBT2hJk2n9yWkfFaFl6JZPn6vma0P
         ULYfNhxTO66dzQt6pb1FdLeilIgUpeh6DCGYRLv71aZS68AW0wailQ3mJ45gOoc5r6Dd
         sA4fTZJ36PimL6hPdLisA/dGmsvO2tiorj9N61qsqNh2fcWmV1uGMF7OLMerRibbDDkU
         fJYiThddg1l+sHOLjDbT8CflmqiNGWE1EzeVhLNdr7KJwAR74GwLwi/8Ag2zSIil8Gx9
         qZeAoyDLdV64+YhMAvXzhKQPHvD9MxmVB2JqMeDZYWII+yAdo0QIPKWMcdb1vCN14N2Y
         /9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qpRvQzuCmX419tk1RXW8tLuM29gmSdeDEbb3mw63/Z8=;
        b=TU31CC3WK0rtfHJ8+7jxxloQgZXiToAnjHxswxGnRpUTAi7fmVpq8UdI3mqFA2ZBD/
         mP/tVO6ZrfNUlzQvTrQrw0FlZrziJEWBzngd2uSfKuUNW7fh7zQfB5CX1RJKFJE/ENSt
         fJ7t44HcmFy7Ol0WuaDF50TExp8rUVmJfDE+0hZmiPxY8ipRoy8nCzRirzC/DYNxSn5m
         /Ouf10zGuptlSAHAam9lwg1tvTdPTfQbAtPBGPB5D1mjckPm0SZvvS0FdvTbzSJb47p8
         oLV3jtwipc8tsZOgiUtSaoFFW1UG9gg5qciw7HkFi+x7rLornk1ZNncZBJ0+T1jom/nm
         ziMw==
X-Gm-Message-State: APjAAAX+8KDiIn8+VU7hZOTS+hyEI70KFARTuVkDDc5WIIt/owDfE06A
        IZLjKvZRxhXkZ6OhzdvF8UBT7UNA
X-Google-Smtp-Source: APXvYqxEyUIn2nPYDdkJADbTEtVDmWGoK1iE92aiqKCeecsa1zc9eSC17TYokztPqlhjJTC+iGPbIg==
X-Received: by 2002:a2e:207:: with SMTP id 7mr25972549ljc.198.1571923724328;
        Thu, 24 Oct 2019 06:28:44 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id p18sm13528791lfh.24.2019.10.24.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 06:28:43 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] drm/tegra: Fix 2d and 3d clients detaching from
 IOMMU domain
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20190623173743.24088-2-digetx@gmail.com> <20191024115804.GB2924027@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45926d95-3e7a-c56b-402a-2b2c6475c5db@gmail.com>
Date:   Thu, 24 Oct 2019 16:28:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024115804.GB2924027@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 14:58, Thierry Reding пишет:
> On Sun, Jun 23, 2019 at 08:37:42PM +0300, Dmitry Osipenko wrote:
>> This should should fire up on the DRM's driver module re-loader because
>> there won't be enough available domains on older Tegra SoCs.
>>
>> Cc: stable <stable@vger.kernel.org>
>> Fixes: 0c407de5ed1a ("drm/tegra: Refactor IOMMU attach/detach")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/dc.c   | 4 ++--
>>  drivers/gpu/drm/tegra/drm.c  | 9 ++++++---
>>  drivers/gpu/drm/tegra/drm.h  | 3 ++-
>>  drivers/gpu/drm/tegra/gr2d.c | 4 ++--
>>  drivers/gpu/drm/tegra/gr3d.c | 4 ++--
>>  5 files changed, 14 insertions(+), 10 deletions(-)
> 
> I think I understand what this is trying to do, but the commit message
> does not help at all. So what's really going on here is that we need to
> detach the device from the group regardless of whether we're sharing the
> group or not, just like we attach groups to the shared domain whether
> they share the same group or not.

Yes, the commit's message could be improved.

> But in that case, I wonder if it's even worth splitting groups the way
> we are right now. Wouldn't it be better to just put all the devices into
> the same group and be done with it?
> 
> The current code gives me headaches every time I read it, so if we can
> just make it so that all the devices under the DRM device share the same
> group, this would become a lot easier to deal with. I'm not really
> convinced that it makes much sense to keep them on separate domains,
> especially given the constraints on the number of domains available on
> earlier Tegra devices.
> 
> Note that sharing a group will also make it much easier for these to use
> the DMA API if it is backed by an IOMMU.

Probably I'm blanking on everything about IOMMU now.. could you please
remind me what "IOMMU group" is?

Isn't it that each IOMMU group relates to the HW ID (SWGROUP)? But then
each display controller has its own SWGROUP.. and thus that sharing just
doesn't make any sense, hm.

> Let me see if I can throw something together to that effect.

