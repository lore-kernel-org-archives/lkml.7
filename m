Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B4C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750EC25634
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Aljnxgrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfE3JMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:12:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34503 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfE3JMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:12:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so4439985lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=voAp2WtjCrorqQ5ljFVovFNN+W4jtil5Y8wsKYlsKkY=;
        b=AljnxgrcoViOjePLPkPD/RTOG6RAXos1o39z1MBQxUJXhCIvWU2t+ZVa8IUEWmSojD
         J7PdDiDHIaJT0U5E9J6N1bWJPMWoBHMHvxTGmK/s/+/qTiGjAMiVg7HgX6YdtenYpSeT
         TqfBLc2tsAHrhgq5uZHORqxAB4XQPHVUD+9j556B6kymMdNLVUqe9B76zgGqMqN/bCLv
         T27ZgOA5hKVXKudSC1VVCtYLuf5W5U1zD20ts5kTaAmZRFqubrCyf4JQqHaNcma+TETC
         v4dIfV3XTVN3pnw1IlDpaZduN+QmY1RzkCRPSbKBtAqFRQEOv6wOtwO4OMAEKokE8tzJ
         jK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=voAp2WtjCrorqQ5ljFVovFNN+W4jtil5Y8wsKYlsKkY=;
        b=rXzLm4iydXILbwhLFH7VFO0tKliSpvpi0+Ndx1h8I1SSZp0+C2MW/ApvxBrUbedxhY
         YT/heuE7p0tIyz7UueFW5kn8Abrjxrzz2X5sHaw3dUMFKblG/7x1ykbHtZ2kgAzGGhk0
         fTWJcBwV6TZ1Kb7T8zyoCUtDijtBy74lR53BGIANAj2E+Uo4cO/BJcs4kf+APoXuWtO/
         8e5gxOwMcLF6GhW6BzBD7+NFpws6XclV2vZvZ69K9NkwTrnoKq7P+34nQIcWCJkFRuVG
         pTR0y9wGqwUwyLOlFSBvrTDFuJmW52TN10B7IxwfwFi7cRfZ35/rBQKyPLFpJ27NXakd
         IseQ==
X-Gm-Message-State: APjAAAXA0/ykGld7km4+Hd0X6M6EmcZdgqyWf29AlroBlQNRXBEJDIAU
        wbP8yPae4Riztx4OnrFzxjWYBw==
X-Google-Smtp-Source: APXvYqzERZfjp5gyfdJ4vSHm7vKm0QHcmqOfCD42yB/j3rJj12bVGfN/kYvcSIKAQCASMC6KDMuRpQ==
X-Received: by 2002:ac2:514b:: with SMTP id q11mr1533656lfd.33.1559207518496;
        Thu, 30 May 2019 02:11:58 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.85.229])
        by smtp.gmail.com with ESMTPSA id t13sm352381lji.47.2019.05.30.02.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:11:57 -0700 (PDT)
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_add_mnt_opt()
To:     Gen Zhang <blackgod016574@gmail.com>, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, ccross@android.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190530080602.GA3600@zhanggen-UX430UQ>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <e92b727a-bf5f-669a-18d8-7518a248c04c@cogentembedded.com>
Date:   Thu, 30 May 2019 12:11:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530080602.GA3600@zhanggen-UX430UQ>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 30.05.2019 11:06, Gen Zhang wrote:

> In selinux_add_mnt_opt(), 'val' is allcoted by kmemdup_nul(). It returns

    Allocated?

> NULL when fails. So 'val' should be checked.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
[...]

MBR, Sergei
