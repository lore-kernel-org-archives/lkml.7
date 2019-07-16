Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C8C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4820880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZlvU3qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfGPOCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:02:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33394 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGPOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:02:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so13875817lfc.0;
        Tue, 16 Jul 2019 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjAomZEn9d4ngvQHHNNsnYK3PRO2HICWZX2h1mQmSBo=;
        b=QZlvU3qGt/oYhHq/Pi0rqOE/Mz2976fylNe9a8QfRughACHrjbVQWH6p4ZT/JgOCOw
         jAU0nRAE4PqUOxfhRSXw53b5i3lPq/ffqfzBIYbKBE2dRb2bH/4ND4h4TmSIeKerBbhk
         tqgF5vqLC81Ll0MnTDGU95Aow1RvTKWplOr4PcII+Vxv1LtEWVMHbP6wMu+5A2VQyMIw
         LxLF57oJ1nw3nKPnKPeSFIsvuLgEbnabnGdgmqa0Opo55G9qeg3OvXtfFlxTFEb6kOUa
         djGCQ3G1c/FE5362ZJ6OTT0sYnZA234H1uHlFndm/d3cJJfvSaZJjeqgglieteZTST1o
         4Afw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjAomZEn9d4ngvQHHNNsnYK3PRO2HICWZX2h1mQmSBo=;
        b=sHt0BEOx0bLyKFyKRD4qrYKcznavtKkgxD3OGt84E6XElMvk+k3NADtf3QMBwzfZQF
         3mLs+A8tcxmPrztjickWrJ8JN9j3YeYh9xjBJg96fXCitR/ujGOKI6Bc0ReuQt6/JHLW
         QTBbaVJIVsmmJE+6zgEbjxssso1p+us3ButsiOEe9617MWLgQZ78dXpBS0eJ7JiINE0C
         k+0J1H/020GGutIoDOBAM9Xi2NUJgahHxj32KvmEnlK7gg9Z1+YMxKhzvoDC2ZXJxAFa
         WWE9QfX0/kitsxf9jSXzQDXSquaEI0qy9+pCYTdCsZyHjdi0H+OMEmidoerarBoLviwq
         A6xw==
X-Gm-Message-State: APjAAAWmTL/AIGKZHd4ALUY0FZ5bHXLvT6PSOsytCtsP9g/2CT/exIxx
        3mSTmCYo59UPzgBoIZkNSF8dVrtp
X-Google-Smtp-Source: APXvYqz0Xi2nOjffBQJf9WV9lxsDud9i0qdM0Z5ptomkZhqGR/PaxKW9VEyX0ne4qcVHGShXyIzhyA==
X-Received: by 2002:a19:5d53:: with SMTP id p19mr12358331lfj.109.1563285722736;
        Tue, 16 Jul 2019 07:02:02 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id 199sm3774430ljf.44.2019.07.16.07.02.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:02:02 -0700 (PDT)
Subject: Re: [PATCH v1] drm/modes: Don't apply cmdline's rotation if it wasn't
 specified
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190711021313.29445-1-digetx@gmail.com>
 <20190712195429.dlz5ofwoafciedcq@flea>
 <11723cfd-12d2-5810-70df-0e053352d648@gmail.com>
 <20190716084225.6wf5lsdzukyb6cz5@flea>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8e1bf9f3-d16e-537f-36f1-047d16faf5eb@gmail.com>
Date:   Tue, 16 Jul 2019 17:02:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190716084225.6wf5lsdzukyb6cz5@flea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

16.07.2019 11:42, Maxime Ripard пишет:
> On Sat, Jul 13, 2019 at 09:57:32PM +0300, Dmitry Osipenko wrote:
>> 12.07.2019 22:54, Maxime Ripard пишет:
>>> On Thu, Jul 11, 2019 at 05:13:13AM +0300, Dmitry Osipenko wrote:
>>>> The rotation mode from cmdline shouldn't be taken into account if it
>>>> wasn't specified in the cmdline. This fixes ignored default display
>>>> orientation when display mode is given using cmdline without the
>>>> rotation being specified.
>>>>
>>>> Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>
>>> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>>
>>> Thanks!
>>> Maxime
>>
>> Thank you. Please note that I'm not a DRM maintainer, hence either you
>> should pick up and apply the patch by yourself or somebody else who has
>> the commit rights will have do that. I guess Thierry could also pick up
>> the patch into the Tegra's tree, but this patch is more DRM-generic.
> 
> Right, I've applied it now

Thank you very much!
