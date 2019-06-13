Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A69C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C962C208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n6tXgtU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfFMPxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:53:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37646 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731599AbfFMI7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:59:55 -0400
Received: by mail-yw1-f66.google.com with SMTP id 186so8033922ywo.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2+9AWuuxtYq5kDObExhhjKauucpmi9PpKTbQpENwdxw=;
        b=n6tXgtU9jyCYIoEnopcXb3kvdH3pJPnNaZUgr1h0kYuBqfuVkDfZdhDI0C+M0DShsJ
         mtpEej7Q7tu2iYouCZdzXTxI9G/6f7S/D8RS8ub9Y5Fyp2eQGzED8xB15X7TvNMjjUTW
         2WGPWrOH5drqi1Z2nq9jnoeSfhd24IPTN8FDU+Uf4oEDF8jDbTxUAr6k2/pklQYA/cgJ
         Wo718mB+1Nr1bhMm4baOFs4Ehv107XvmCkzvWQjVfsUwC0xLmmNsTroDwDjM11k8XWe0
         orlt9dkGJM1m0c/rfBdcQ4mRYIWRKdFar+ydaHnVVN+wHBJVJj+UaZCVtw109orLDmEP
         MYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2+9AWuuxtYq5kDObExhhjKauucpmi9PpKTbQpENwdxw=;
        b=QYuVacUMCsYmpg8zzBx4U1R+IJCBN277ju0hweVi7jmXuyoj7ouHR8d8GYyH7njmDv
         LDwNHzk6Byhy+Q3vadEipylS/whRHRkritO+8sXr74+JMQSDVgbiMWwKBB7U9ZDiKHNg
         o/Ty7X53t+Jdn4guxkSzMK5AdeeAIt2bQzxjnxm2q8PIdCqO5jEEl39b2TbAV91rLbQ9
         SUWzOciQKF8SqbigJLXSrTiL2xfoLIaJ25OV1IPw1VwCY4x1Na2NBQ1eMJPh8gLDiJS+
         0momDEewcBslAU7qMxu6hG8Z6y3sfVehZm33Ee58xjRnbqU5zFuHv79vc+5pCUye5IyP
         JInQ==
X-Gm-Message-State: APjAAAX0+XshHRlFVdK4/LnRWsxn8oUcJLp9qLMZ73GyIL0JVpC5WLO2
        zWPYtyQ45CapzcZosjcGerQs7A==
X-Google-Smtp-Source: APXvYqxCEx653iUhqyan6kGQNPIR/w4+osLNDQGaSLrv8KI2gz87AEfJHMcrWUO3XewvyXWR1KK79g==
X-Received: by 2002:a81:3494:: with SMTP id b142mr19026909ywa.79.1560416394346;
        Thu, 13 Jun 2019 01:59:54 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id l5sm574202ywf.11.2019.06.13.01.59.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 01:59:53 -0700 (PDT)
Subject: Re: [PATCH] block/switching-sched.txt: Update to blk-mq schedulers
To:     Andreas Herrmann <aherrmann@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20190612065009.GA11361@suselix>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a781a669-85ec-6df1-a18d-6d329b2f5ff6@kernel.dk>
Date:   Thu, 13 Jun 2019 02:59:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612065009.GA11361@suselix>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/19 12:50 AM, Andreas Herrmann wrote:
> 
> Remove references to CFQ and legacy block layer which are gone.
> Update example with what's available under blk-mq.

Applied, thanks.

-- 
Jens Axboe

