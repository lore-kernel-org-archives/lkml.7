Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA420C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A773921874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apJXGsYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbfHHNsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:48:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732727AbfHHNsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:48:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so94996421wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GcZ3zbECdiPLNKqqmt56+5zBkRjZxc9TD5pjLBob95w=;
        b=apJXGsYiKecvN9aCUGlleABvwzWhhNUx8AvT93d1B9Z5KX/hgJJ82oq6sg2KSpD0HN
         YqPcBygscdSw1OzzUUentXgHGBy5uA43+V1bcAX4xW2IzYYPEv0ByC5DJQLD2RzCtWXo
         3ICiGlPzerdFCozXtxwSHBayKvVOLwI+pAY33dMaTtb4NqUy8qUiaN9UTxFNUwFow7/6
         hSQex81nJ+byGTscj9e2GwGRcJcyo6pJ+TRhC4LxqV57tFdC94ZomJRhKplMYLaVOCac
         UnQ9gpjvOVuP7hTmfsPBj7QjhO2uZGrN1r2USGPjMyuZ4yFbPbSpOoNUef42Z5YLvtLJ
         KHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GcZ3zbECdiPLNKqqmt56+5zBkRjZxc9TD5pjLBob95w=;
        b=sgRqalLBlDnve7IAhEb7uNAZCaOpxrgMg4AJBO/IxBueKLv/FLuAxxtWvex0c/WOG3
         znt4Hc5/pcmgZPxjYFl8J5CAzSleX/EeA3vTmenlKIgwU1c1tvo70+i3Bum038LQIM5i
         AuCS4nRmv9nVKbkFysHiCaHg6YOp393ZLJ0tpGTHtvPCKee4hYyvvy/RigeIFhFh8SGR
         SyDsByz+a3kCSmEnVZdCzwssO0V1IPCL45AIGyrh8DtPoccr+NGIKSdCUnioJgAsEcwV
         y8dYH8/Y6RalmLx8PHenKYW2ZQl5xVGANcR2xbG5+dLVRBCbO0slW/D+z0kplIkjwMNF
         Y6MQ==
X-Gm-Message-State: APjAAAUeTBOfVedohgPjwSpMwtXX0mrYLraAeLLwnDojrkp7coO+/DhM
        xDoDAiTILN32ECt38/BpF9tTWg==
X-Google-Smtp-Source: APXvYqzZEKSzRsVNoSQVYnVv+D/4c8aED8O3MSMhnUXr1S/gKC93rsWnOKFzP1VrFFrVyOnWbqjP6g==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr16242610wre.226.1565272110713;
        Thu, 08 Aug 2019 06:48:30 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v23sm3153431wmj.32.2019.08.08.06.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:48:29 -0700 (PDT)
Subject: Re: [PATCH] soundwire: fix regmap dependencies and align with other
 serial links
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8529d213-bfbb-780a-092d-3607eeb5e543@linaro.org>
Date:   Thu, 8 Aug 2019 14:48:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/07/2019 00:02, Pierre-Louis Bossart wrote:
> The existing code has a mixed select/depend usage which makes no sense.
> 
> config SOUNDWIRE_BUS
>         tristate
>         select REGMAP_SOUNDWIRE
> 
> config REGMAP_SOUNDWIRE
>          tristate
>          depends on SOUNDWIRE_BUS
> 
> Let's remove one layer of Kconfig definitions and align with the
> solutions used by all other serial links.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/base/regmap/Kconfig | 2 +-
>   drivers/soundwire/Kconfig   | 7 +------
>   drivers/soundwire/Makefile  | 2 +-
>   3 files changed, 3 insertions(+), 8 deletions(-)

I have been using some thing similar in my setup.
I did test this with Qualcomm WSA881x codec.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
