Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0880CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E9121906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujgYMcpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410234AbfJXRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:15:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41227 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405901AbfJXRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:15:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id f5so25881078ljg.8;
        Thu, 24 Oct 2019 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B2u8s7gx7FtUmA2/ewnUbC7NCE9E4zM8QCdEvaltKG0=;
        b=ujgYMcpcefyHEvPBjnG91nrFx1r96PE3NLBm2gv2VhmxVY9I0K6PXG1lTx6pIG6JRg
         /RqVkcWokAR7Bfi4OkJ23KDI94at36+22bTxGko2LGvkyU2FpWiznLBh1KGkqh/AZSOq
         f8qu4lyQTSdlU35N7g5G+qFSQAQfXkggUj4RYC+LsqJURhgS1n41UHU3Gb3yLOAIk3tu
         JbD/QFOYbkDiiB5puMT1MS8+9GhQ5dk8YbaVnQEeGZB+jG69pRFMI1shocDZUkgWYRwX
         cKSUnHhcridXgLQJEqTwOmzaFyYq88uaK2Chnoyx0im+Pkul1qUNjazuo2tvMzhsonBn
         lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B2u8s7gx7FtUmA2/ewnUbC7NCE9E4zM8QCdEvaltKG0=;
        b=Ccq0mG5YaiyBCZHQAST/EIP30+0i9uVpHTH/CRUGahwVQtG0IOn42WGyeYqj1uAyUT
         zgoVev+QzuZYnIJRvV/ZsUchbjygzXhsf+2+K5w3d/1Y8KvFRf4jqyabpygtfkJfX99J
         LidxKwTEBPemvNX+5jPHwMfkaToEnPW7k2JzMkQ3xT9P/F1ekigZOF2O7/QxHoVd3Poa
         Xr4x51qxeJpZhXkwBM50vIZ8HrRgv74w+8OoZzwAY58/6jC7vq8CfAYHWJXSjbxebrFJ
         z6AmUchtSlGXULtyws09tWQo/pPN6MlRBlfvg7YRRtDpizEFWeIkSj7Jz/SKtgfDE3oT
         r/uA==
X-Gm-Message-State: APjAAAVcMcBbTXbm4v9MlbbfZyqAvg4fiCS1mCm04XOzpciPOGtMBXW7
        wOm2WiS09gyAYhaoYqv1AKNyxnAZ
X-Google-Smtp-Source: APXvYqw1RGIy1mL/CQkGrBGWGbJQNaMlq3LWK78yQ79zaSv2ZJhXCfvGJ9O9KDdEymqgGFfuRXFBiA==
X-Received: by 2002:a2e:9799:: with SMTP id y25mr10627721lji.228.1571937309166;
        Thu, 24 Oct 2019 10:15:09 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id p3sm10948363ljn.78.2019.10.24.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 10:15:08 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on
 client's registration
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190623173743.24088-1-digetx@gmail.com>
 <20191024115016.GA2924027@ulmo>
 <55ab29ad-da9b-c178-4480-dc6edb09b3e4@gmail.com>
 <20191024134756.GC2924027@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7d3b1e99-4c57-d6db-36dd-d0a840ead440@gmail.com>
Date:   Thu, 24 Oct 2019 20:15:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024134756.GC2924027@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.10.2019 16:47, Thierry Reding пишет:
> On Thu, Oct 24, 2019 at 04:35:13PM +0300, Dmitry Osipenko wrote:
>> 24.10.2019 14:50, Thierry Reding пишет:
>>> On Sun, Jun 23, 2019 at 08:37:41PM +0300, Dmitry Osipenko wrote:
>>>> On ARM32 we don't want any of the clients device to be backed by the
>>>> implicit domain, simply because we can't afford such a waste on older
>>>> Tegra SoCs that have very few domains available in total. The recent IOMMU
>>>> support addition for the Video Decoder hardware uncovered the problem
>>>> that an unfortunate drivers probe order results in the DRM driver probe
>>>> failure if CONFIG_ARM_DMA_USE_IOMMU=y due to a shortage of IOMMU domains
>>>> caused by the implicit backing. The host1x_client_register() is a common
>>>> function that is invoked by all of the relevant DRM drivers during theirs
>>>> probe and hence it is convenient to remove the implicit backing there,
>>>> resolving the problem.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
>>>>  1 file changed, 19 insertions(+)
>>>
>>> I don't really want to do this in a central place like this. If we
>>> really do need this, why can't we do it in the individual drivers?
>>
>> Why do you want to duplicate the same action for each driver instead of
>> doing it in a single common place?
> 
> I don't mind doing it in a common place in particular, I just don't want
> to do this within the host1x bus infrastructure. This is really a policy
> decision that should be up to drivers. Consider the case where we had a
> different host1x driver (for V4L2 for example) that would actually want
> to use the DMA API. In that case we may want to detach in the DRM driver
> but not the V4L2 driver.

Okay.
