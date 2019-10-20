Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB32CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50751218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ20TaMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfJTVrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 17:47:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45279 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfJTVrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 17:47:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so6637392wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 14:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nEa2nCLVl/CaMx9prf1lrKZwy7roZPUD/Ml2yn5od4E=;
        b=PQ20TaMwJw0MJgI3eTBNxZzpIGkEApoS44W9J39kJyfMiQJOqSuECuaTRZYsz5Kngv
         F1SucEn8ltoeOktI1hFuCi35SsaY+6OBU7PiygDJhvtx+xmGRHci8bz+lm/8akpoAwu1
         pOmm2tSiDzuKFYEWoc6At9zcsRHJcBj4heeuTh2wyyqfremfg3fgm9/w32cgJo5e4AQ8
         Ac1tTlSxYL+cqjTESg70KDBTqXpaNcH71ZBHmLPpGggsxtZjT8fos/p3O8/570ZFNTY0
         8JqiQbJwrhJ8+bZDTS13w9Apw6SlZPeaUs1H1Kehdq0Gxd3OZb4vp+6sNBndhNL3sjsH
         Q0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nEa2nCLVl/CaMx9prf1lrKZwy7roZPUD/Ml2yn5od4E=;
        b=RvTrB0y/cH2acfRde+IF0gZSffoaPdsceLGA0SzU0KzHk2g4SLjq5hdnDRZmKDmJV8
         2MH9O9MIHxgzRynOB1aBUvxJ1TiwmWM+5Gtu1pqf6wc7dLNNlphHhe0Sc9iL+z598Lod
         n/wq0oX2pU23dDC9IoobIjgYsxrLy3do2ZL5FvMTd0G7xeltMiPeG3VOwRxQyM2D6XgH
         fXNUkkpbKqfDAJIcOJs2eqPnJbZufh6Jb9u0k/szpfUDa67X8+4Avrz5SnPwNIDKfMiI
         IWOf0Bezf9hEQ1ef/o9qCJ8CykgakIEZ+u7b9/0HHhCNtVbL4r6ztGqztQzTA0djKZwv
         fm3w==
X-Gm-Message-State: APjAAAV3gXGyWYSc5jNsaLV7nMWFwkSD+Iagk6fwv4b+JO7qDsPVk67J
        01mIbOzRM79B5SBk0x4+2so=
X-Google-Smtp-Source: APXvYqyClbvQwzSKous9HNBfGcsRcFKBAklGfnLnPbxdFoLXwJ9Ngy/ZfpoFh7Lp3zlTGFkSxiwWbw==
X-Received: by 2002:adf:c448:: with SMTP id a8mr5850387wrg.233.1571608028815;
        Sun, 20 Oct 2019 14:47:08 -0700 (PDT)
Received: from [192.168.1.221] ([62.68.24.148])
        by smtp.gmail.com with ESMTPSA id x7sm12307771wrg.63.2019.10.20.14.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2019 14:47:08 -0700 (PDT)
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
References: <20191018163047.1284736-1-arnd@arndb.de>
 <20191018163047.1284736-2-arnd@arndb.de>
 <20191019184234.4cdb37a735fe632528880d76@gmail.com>
 <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
 <20191019222413.52f7b79369d085c4ce29bc23@gmail.com>
 <CAK8P3a3UztT5aqDTiBNDssHWcdYQNqbhiY_hxJ+AHuM54hgCWQ@mail.gmail.com>
 <20191019231418.c17b05f73276539536b4732c@gmail.com>
 <CAK8P3a0FfTjNAvJG1yUi==bLBjeVaJ0oseaqs-ZouZKHrFdBHQ@mail.gmail.com>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <31d57d94-9701-1c46-6ce2-c43eaa16f444@gmail.com>
Date:   Sun, 20 Oct 2019 23:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0FfTjNAvJG1yUi==bLBjeVaJ0oseaqs-ZouZKHrFdBHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 20/10/2019 13:49, Arnd Bergmann wrote:
>>> Ah, that makes sense. so all interrupt numbers need to
>>> be shifted by a fixed number (e.g. 1) like we did for
>>> other platforms (see attachment).
>> Yes, the below patch resolved both GPIO and DMA issues.
        ^^^^^^^^^^^^^^^
>> Previous patch (selecting IRQ_DOMAIN_HIERARCHY) is not
>> required.
>>
>> If you re-spin all 3 ep93xx-relevant patches together, you can put my
>> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>> on them.
> Awesome, thanks for testing.
> 
> I only remember sending two patches  for ep93xx:
>  ARM: ep93xx: make mach/ep93xx-regs.h local
>  ARM: ep93xx: enable SPARSE_IRQ
> 
> and have added the Tested-by tag to them now. Is there a third one
> I missed?

The patch shifting the IRQ-numbering by one is a prerequisite for the two
above patches, right?

--
Alex.
