Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A29C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816BF2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjfiDiGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfCLQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:02:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45397 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfCLQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:02:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so2127564pfm.12;
        Tue, 12 Mar 2019 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CHyXDaPIHjibiFy22aPvR2N0EpshdvkVuWtuHAwVOgc=;
        b=AjfiDiGTdHBA1kYKmtDtyV7n+GrVIrDo7AfNwbnUyY7meZeFldtADJ0UYiUeukbkvo
         BuJJvgu64PZLs9EGZErDKQv3sYd49JiZ946rxMQywCNKiNXw1a0LzrQn16ONQcnKB9Nw
         xo5sbns+gYhUi2UJx0QCCbITLA6vkZJDkTwIGrbJHP4ROvGKvgrxy+KdwcHlGnnc62Kd
         bkRH5vUfYpk7PTqFq322yTP/TLN6pYwWSJuvRYZu2Sqt4TNPL7ysIHwBRop/Poko2dBY
         Od7I7aFOJi+XOEQS179mg6661X3+3kFHqT/Cxb4qdCVSFLssCZJWIcpyU/mWXCsnf2pR
         UlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CHyXDaPIHjibiFy22aPvR2N0EpshdvkVuWtuHAwVOgc=;
        b=WK5JQt08gYpZsvl9yw+x1MIBrEqX8HnFF6FpkGsqRfpumBrFRryF7KRPsU3TUouz+C
         PcHzfxo6u4Vth/ru4M8dQ6SKSlNzyyODqzSLV/hHw1gCIKlQlCWMqveTeZB1Jw7pz3F9
         5OFmlARL5lFGW8uXXAcP6gi4JLh/wPt4cEY40bBb/72NIPeFo/drbbTYOMqV7rIP2gQ9
         cfI8PjrY7Bdst8z04pHJ9qf3YGM6tLhOwILzToob48KeKuMrDQmLv1y+aTnbbOwQXIzM
         ZKYBSLt/EpYJWJQezaEWPg5ZXDDYFPjPSqz/7O6cP++30DJSdaGKHgi6HiT+YPaezuxA
         yPIQ==
X-Gm-Message-State: APjAAAUsQqtXy7J4umDF0h7j77+t40sXh/AR/g5bGdQywQD7orshcIwR
        AxIF+5Cv2rq4xASjwXBWRE5pHRCf
X-Google-Smtp-Source: APXvYqwrzFIuAO3c+5/A/XjG/uQiKAAsruMmGozzV/7/3YS8m0FuvXxlQ+aC36DcD4TDHygB9TmZ6w==
X-Received: by 2002:a17:902:8217:: with SMTP id x23mr41184312pln.332.1552406559600;
        Tue, 12 Mar 2019 09:02:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id g188sm20101969pfc.24.2019.03.12.09.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:02:38 -0700 (PDT)
Subject: Re: [PATCH 38/42] drivers: gpio: vr41xx: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, andrew@aj.id.au, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        robert.jarzmik@free.fr, yamada.masahiro@socionext.com,
        jun.nie@linaro.org, shawnguo@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-38-git-send-email-info@metux.net>
 <20190312113732.GG31026@ulmo>
 <e224f52a-a92b-63cd-a9ed-67672a2c7337@metux.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <18445a6d-09b2-f2d1-fd7b-4dfbbaf99981@gmail.com>
Date:   Tue, 12 Mar 2019 09:02:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <e224f52a-a92b-63cd-a9ed-67672a2c7337@metux.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/2019 8:42 AM, Enrico Weigelt, metux IT consult wrote:
> On 12.03.19 12:37, Thierry Reding wrote:
> 
>> The driver currently doesn't request the memory described in the
>> resource, so technically you're changing behaviour here and with your
>> change the driver could now fail if somebody else has already claimed
>> the memory.
> 
> hmm, using w/o requesting/claiming - isn't that a bug ?

Not necessarily, before regmap existed, you could have very well
delegated a subset of a larger resource to a specific driver while a
driver requesting that larger resource would be responsible for doing
the request_mem_region(). As long as both drivers don't stomp on each
other, this is a perfectly valid way to delegate, yet keep things
modular/separate.
-- 
Florian
