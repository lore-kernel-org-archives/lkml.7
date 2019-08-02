Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4022173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sYNMRs1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404545AbfHBJAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:00:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38555 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbfHBJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:00:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so52356066lfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nOfUZboLQBdefaSsqopalDUSAj0Q8TAgOh/2n7vo210=;
        b=sYNMRs1y7jnjOKwG0zRNP1K8YIFbSlBhf6eFQJQoUFdLX2BI5y27Ds6WnWgi0qyGms
         kNrqVNNfZM29KCHMMb7ui89lN5zztea5NUkgkwk6DpOgMxsswbMSDC1iaEmawklpDJRQ
         J5mVq9ranM51uW2C98xjvZfbdslylo/OjsZ1priQHrMvB+ncLViqAIO7yStBmLICDlmt
         4+8B9okpyqTizD66fvPN96bqek/5BSqiGsXfUoWdNcXst0HhQWnmNP/LrdxGupwY+9OX
         pEcIVphYhHDlTvIfYQGWq0FScSduxzYtGFCmP2pR2qSI4MhHwx2JKUnDKmXGVNhZEL4I
         1szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nOfUZboLQBdefaSsqopalDUSAj0Q8TAgOh/2n7vo210=;
        b=H+8YooecogwH03wixyFm05VRX6XBFGlOvqipstyq6hhFxWWDx+sVKLceZLByQUdcTx
         abf9buJG0bxpIiFnH4pVFBr1kwVuyvtZW8nov7Nc63XGPswsBRr9I4vMbCLVMzYsMWss
         8aOoebdvgrPJHajPhJL93vNTyE/05mtM7ti/zwDgLEmr+ZfxSAPvnBGSJyCUj01FEK1o
         NsBYuGandBVamk47E0e4Lkc2CyeWrnWfFb+4ip/ThIByydUet4N1pSSP3cOLaXIZjR9B
         KoABBU4ZVPKApM3ym7XZUd7MKzqZ4h4xxy9HgWT/N+ekKlDrX1bg6YOoZeQh23gelJSx
         iu9A==
X-Gm-Message-State: APjAAAVyyS4kjX9PvZ5TyTZpLzAOoB8KrmwdI1SVN9g/9k+ISQ4M3cS4
        MYi5CBfv1nnMPXLlr+Lf4xcqyQ==
X-Google-Smtp-Source: APXvYqxGZgczC1eaVKSdfN3/+nRFqyz52eooZ0ry/5yt2smPrZMOndzeGHd89ilsrgEB4jlADqC5Dg==
X-Received: by 2002:a19:7006:: with SMTP id h6mr62988032lfc.5.1564736428915;
        Fri, 02 Aug 2019 02:00:28 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:461f:21d7:2c53:9256:aa0a:736? ([2a00:1fa0:461f:21d7:2c53:9256:aa0a:736])
        by smtp.gmail.com with ESMTPSA id p27sm12695592lfo.16.2019.08.02.02.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:00:28 -0700 (PDT)
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
To:     Mao Wenan <maowenan@huawei.com>, socketcan@hartkopp.net,
        davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190802033643.84243-1-maowenan@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <133b3357-e0a4-64c8-40b7-02d386e12cef@cogentembedded.com>
Date:   Fri, 2 Aug 2019 11:59:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802033643.84243-1-maowenan@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 02.08.2019 6:36, Mao Wenan wrote:

> There are two warings in net/can, fix them by setting bcm_sock_no_ioctlcmd

    Warnings. :-)

> and raw_sock_no_ioctlcmd as static.
> 
> net/can/bcm.c:1683:5: warning: symbol 'bcm_sock_no_ioctlcmd' was not declared. Should it be static?
> net/can/raw.c:840:5: warning: symbol 'raw_sock_no_ioctlcmd' was not declared. Should it be static?
> 
> Fixes: 473d924d7d46 ("can: fix ioctl function removal")
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
[...]

MBR, Sergei
