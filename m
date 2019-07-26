Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C950C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE12171F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX+qZUfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfGZJ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:58:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZJ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:58:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so47193942wmj.5;
        Fri, 26 Jul 2019 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLJorQvghyl6IcdxX7Lb1tw6yVw/dZusj2KL96pJtao=;
        b=gX+qZUfVV9sP7taGSw8DcFdrYFJqz+Vy9y2Jc6NcxaHwsNgOmxzV/nzxgBAll8eynD
         AfodXp3+aOFMGPl08WFw5zhIYE3jbJ1H3D4XAob//EubTo7ylRjP0zU/sQW0SZg+fy65
         4RBndOvHhKyYI3KwMtZ9XGwZsYY27xRGWSRMuIVKRt25Fd4Aw+Ex1LwqRCXldL+Wg/Tk
         9CraWUBKKBbXY+y3rpuiBMUYULJJqsT6j1i7cG1oVAHN5yYF0mu+g8QTBajplwqwSEEw
         1L7fm8NPCaN5qyrsS/ctehooWvG+krWXA0xJ/P7HY5SJE9ljmwFUS4Q+i4WkPEF8P+He
         pJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLJorQvghyl6IcdxX7Lb1tw6yVw/dZusj2KL96pJtao=;
        b=uDL6kUvnu0p9zskY51YK0UZhU0stXPVAFcb0GtjY8Vbzktmy9bAtuoY80m0X9fvSw3
         C0jww9X2V2kPoxZrwW5KHuimiAMLUCxMG13iZWlsA+2yUnfPFtULuYHUurHRn2/Qrxdm
         YspCy9ejVPLOqlECp/PQ7YgMVA/OWKbejGVe/h2q8oXk3K+zKU8nhzaIe9QByAKmDQGA
         B2Xoyg7MgbluIbiFu6fdsR7CTkUy/FDBO88wdbOG11POSOvhlhmmjZ1qNer4OPfuY4GR
         hBAF+m1itZra2RGl3h8DvkipmuMZTVg9hqGMhzx+ys0RQdLLgajjOkwy7Wh8f1eqr5cV
         RW8A==
X-Gm-Message-State: APjAAAW5XPJZy+v5/Ku5fSuUvBhWtVP13JhY4vEIR/AClFi33qiwAKGE
        9TLtMDf8KRl7WnVlwbZv88c=
X-Google-Smtp-Source: APXvYqxaPlO+u5d814OS6J0FqxMEZJQIMhBDcVQn1suHTGRMGAIHcmKiFfpzhsVTgCFprNcqH5Vu3g==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr78880407wme.123.1564135112469;
        Fri, 26 Jul 2019 02:58:32 -0700 (PDT)
Received: from [192.168.8.147] (216.171.185.81.rev.sfr.net. [81.185.171.216])
        by smtp.gmail.com with ESMTPSA id t6sm58304258wmb.29.2019.07.26.02.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 02:58:31 -0700 (PDT)
Subject: Re: [PATCH] Revert "net: get rid of an signed integer overflow in
 ip_idents_reserve()"
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Guo <guoyang2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
References: <1564132635-57634-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <afa992f6-eb5e-8104-9a03-f992b184a6b6@gmail.com>
Date:   Fri, 26 Jul 2019 11:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1564132635-57634-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 11:17 AM, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
> 
> There is an significant performance regression with the following
> commit-id <adb03115f459>
> ("net: get rid of an signed integer overflow in ip_idents_reserve()").
> 
>

So, you jump around and took ownership of this issue, while some of us
are already working on it ?

Have you first checked that current UBSAN versions will not complain anymore ?

A revert adding back the original issue would be silly, performance of
benchmarks is nice but secondary.

