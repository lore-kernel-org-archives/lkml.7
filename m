Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F8F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs2ieiRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfDDPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:55:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34147 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfDDPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:55:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id y18so2217827lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Npv0VXZcQdU/X/HipfUxY+N46abbB7YFR+DdGXLpF5w=;
        b=fs2ieiRMp6FHLIavsDOlYk7d1gawkSeEhmrFRpx16QzRtiWA08c77oB3xRvTNhxUeO
         0MhZ7ir/3j8/WuGdRBIYtndfunJRrSTSNEWR4FRtEnR+WZLSXwGm/DJ7NWI0J56tZlMQ
         OYEp3syEGzwtNmmc/omkltdwZcfrkzCAj2sGEGFzAQT+7QatR/k1BSNZ8NCKTRArbRds
         GiHKxfHpTchwCL026HEk1A5/y94pxZgnrRANOPJrcWUh5rHV9n0p5j/npxpo6L047Nx0
         Gz2pjHe69Jbpyw7qIkCIWDLwkESnkQJWUkf99nkSnvaDMGxJbNcmwJcgOs/uULSO1z8F
         56RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Npv0VXZcQdU/X/HipfUxY+N46abbB7YFR+DdGXLpF5w=;
        b=ULiyyUKkqpLUDb0Zkj9qMWj6gV/EEI/4mBtuhBBMHtm8I2mRrirYVboeLm6aXLCXku
         RslOlPYODH3Z+TyzHof7jheMzCGoc/CknCIMrXLERQmfdkAA+UCDGfBUJHoUWtN3aUgG
         j4HSW/L+Aj9UUwANuHZW+k+YtzhCjtOVeWN7eCeE2s5Pir3Ie3zLcXw9wGh1j8W0HDUg
         BkalNPHCfY1ZG7PG1zxeT6BgMsNJ7O6zPfS3Owd1YfI/WJIAtYikoPlNl7BamMDZDtha
         IH8ujtEFKBh4ohHnNo+vYNnMfEfgxJpP1i75+dZytcy3+E4aJwCLcxOyKHh5nkmMIxyC
         EQTg==
X-Gm-Message-State: APjAAAWIwf82+JfuCOKInKq+hMVl1aeS99OjL5vZuylAFCGJ5A0KBzHB
        Hf9acU/HDtKmBRPIPAUrfL0=
X-Google-Smtp-Source: APXvYqxAvlvKYlaosAu1yO9CsQdxfVsChzY9Wj1XZ7ORD+Vmb4X2ygOdtX2rRzLEW1Eq3G5bZa7fcg==
X-Received: by 2002:ac2:4421:: with SMTP id w1mr3834095lfl.97.1554393314093;
        Thu, 04 Apr 2019 08:55:14 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id s67sm3998764lja.57.2019.04.04.08.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:55:13 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Avoid potential deadlock on
 regulator_unregister
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     l.stach@pengutronix.de, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20190404153218.4984-1-ckeepax@opensource.cirrus.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <47c351d0-ee9d-abbc-5fba-87cd5f598193@gmail.com>
Date:   Thu, 4 Apr 2019 18:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404153218.4984-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2019 18:32, Charles Keepax пишет:
> Lockdep reports the following issue on my setup:
> 
> Possible unsafe locking scenario:
> 
> CPU0                    CPU1
> ----                    ----
> lock((work_completion)(&(&rdev->disable_work)->work));
>                         lock(regulator_list_mutex);
>                         lock((work_completion)(&(&rdev->disable_work)->work));
> lock(regulator_list_mutex);
> 
> The problem is that regulator_unregister takes the
> regulator_list_mutex and then calls flush_work on disable_work. But
> regulator_disable_work calls regulator_lock_dependent which will
> also take the regulator_list_mutex. Resulting in a deadlock if the
> flush_work call actually needs to flush the work.
> 
> Fix this issue by moving the flush_work outside of the
> regulator_list_mutex. The list mutex is not used to guard the point at
> which the delayed work is queued, so its use adds no additional safety.
> 
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> This patch follows on from my email the other day [1].
> 
> After looking at things in more detail I am fairly confident this is
> a good fix. I do still have a slight nagging doubt that something
> should be protecting this flush_work from additional works being
> queued, and I can't see what that is. But as that is definitely not
> the regulator_list_mutex the patch is not making this any more
> dangerous. In practice I suspect this is fine as nothing should
> really be using a regulator that is about to be unregistered,
> or really this delayed work is probably the least of the systems
> problems.

If anything tries to use regulator after invoking the regulator_unregister(), then indeed it's already in trouble. The patch looks good to me, thanks.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
