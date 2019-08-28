Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4CEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E1420856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="PIAg8Lbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfH1JOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:14:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45242 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfH1JOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:14:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id o11so1476636lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/FAvQVJWH8hNDqsZxVjsvHGWQ4cwiHioyZRXaiwuH4=;
        b=PIAg8LbvLk6D0489+QlpDRqaNqGp/RCZ4+jhKkMhIiBc2/Dd3RlrzlBuLBC/HxydEC
         QowWxlIXSFCcvN/jGvd5Yg34idYzc6aCxnbN9klxRc2JGYBnbpeUz9ypAbTiLWzJQDRT
         iBK3ZNZNyvZkdpdEu8eEdu99LWq66flJeWzenx7xEGLkUp88abcmEZKA6dk+/iar2gLY
         H1vbyG5EMg0ssZr0n/1cAP/1YrdQoleL/mzP+YJhRVJIZOX1DwxNN4fN/b7cb7tU4B8r
         JOis9BEPUMSlTEBN92wV0/IvRHOioQfaupKTQCtVIOfksaLch4G9E2qhx7HKkD9eQG+S
         G+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/FAvQVJWH8hNDqsZxVjsvHGWQ4cwiHioyZRXaiwuH4=;
        b=EGIIEAww/mTMUBehggzHiX5QTvWas6+sY/KQ8IpdPZT/AXY59FCB4M0bvDrtxtM2lR
         9kp0FE+snFYHXN3nDdldt9ur5areV2Lkdg/7OudAp/5Tf1TZSyAycCFnIqIyf4WRqGR4
         FWBPZQV7hauLtmxHkUcSbz3Z279KZRGNjklixzNl941tQxwy0rxHBhwa3bQvsl1mO6Ho
         hhVGxwV1r/2GeLvDtKybCT/ozjJItbGAcaKGCYkXzPKewA9HSLs0tgghqA2S15vHpCVi
         BL/lsbZVIb14kkPXMnX1LVdGP3BjJ+vbo2TkxSErQP5zLjFMEMo4xxNG854P+XSwC0He
         GlPQ==
X-Gm-Message-State: APjAAAUo+aRXH5bYUgBU/1lT3fFbF99ME7O3kp7UFdj7cz6MLkvecLNO
        KkFXJVQ4iU8y+6e86OBKj48KpB8hQFs=
X-Google-Smtp-Source: APXvYqyxt6ENbz8kd9XK40+sRsJvEZ4lHaMldtpiGWZ4JbUMbRrBUe5f2u6ARgH7OgzyukMvezH8qQ==
X-Received: by 2002:ac2:43ad:: with SMTP id t13mr2097116lfl.66.1566983681773;
        Wed, 28 Aug 2019 02:14:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:43c:79c5:cc63:c37e:a616:212b? ([2a00:1fa0:43c:79c5:cc63:c37e:a616:212b])
        by smtp.gmail.com with ESMTPSA id h15sm498484ljl.64.2019.08.28.02.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 02:14:41 -0700 (PDT)
Subject: Re: [PATCH] arcnet: capmode: remove redundant assignment to pointer
 pkt
To:     Colin King <colin.king@canonical.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190827112954.26677-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <1e784ee7-c049-1155-ab7e-a90f1f20f3dd@cogentembedded.com>
Date:   Wed, 28 Aug 2019 12:14:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827112954.26677-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 27.08.2019 14:29, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer pkt is being initialized with a value that is never read
> and pkg is being re-assigned a little later on. The assignment is
       ^^^ pkt

> redundant and hence can be removed.
> 
> Addresses-Coverity: ("Ununsed value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
[...]

MBR, Sergei
