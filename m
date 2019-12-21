Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E4FC2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A1521655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eUhvhP0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLUO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:28:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43010 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLUO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:28:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id x6so5747591pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J9PeLUrwxMgt0ipUNGLGw536cdWaDOecBS6uBw4Swkk=;
        b=eUhvhP0LP8aWfBvziJi6WFkhFOwf8Iaz9YNJ5O4Kxjyf+u2RVXOJ3LzjEa+jSP1hjB
         SxRrN2mMaVejjRTOFTtKw3akl6CN8/D0SDDcg1I9FJmNBbJpnTwq4bIVGGbqZKJTMmN8
         6Ays8s0DB5XAfbeuIS8qkiYb4FfV4IKQHRFGgYexdlbPNvDteCwYjgSi1Ca20rGPhzYf
         dZUfxnNmMnLbpElcZwUu3Rd3EvdcTkrpH+dCLzMwS7ro/ZAZcNM4XGo6FrH7qMfrI0Hz
         29KWhXFCLZo8sfnsZiywJqQseLwryvwC/Y69/aWVl1Bg+ww5nU7Y3IYE0IVwxpySa8fc
         5CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J9PeLUrwxMgt0ipUNGLGw536cdWaDOecBS6uBw4Swkk=;
        b=WIIIMRRcEua9GOwq9zAEjeY6R0o88Pz0uGiR9AG9GGd2wEU5EIbk3KGVI643IcgHVk
         QhtK7/4gLQkQln7/sWzGFPQApdua5FV5Ses4lcajToQi+EzeSRzns5xw2bddz1mFH7jy
         +3aCCUU/hXquNl7PEQJo/dONoY7pl5dY8CMRZJVCkPUUvksDmAkCRZK0r1JLNtDfR6hd
         AyXss5ok/DAMlVyQJkImXh25v0aZUFmiiyUv+0igfZdhe9M7qdqHhEOYSpEg+bVFZ1S7
         P2LSi735pl4r4fu8vUEACmYEJ6Hbs9xkg2lXd8prPPlh5KI9gt8IFbHGGP9kqm4xQPn0
         fBlA==
X-Gm-Message-State: APjAAAWT6aJgbLk7K34jRcsXUCQq0G/7mZwznGkugJkcJtQ54mCR8YYE
        3L0IwuI41CXoVvLcbbiU6z9LCcMkRxsKZQ==
X-Google-Smtp-Source: APXvYqxVZPOmwWrUSweyNzFxkd7STK0kQE5jxgbhnpd9eDZEu791l03SAgHSdXCkcc0VxU+8qfA9FA==
X-Received: by 2002:a63:6d8d:: with SMTP id i135mr20999865pgc.90.1576938491693;
        Sat, 21 Dec 2019 06:28:11 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g67sm13243439pfb.66.2019.12.21.06.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2019 06:28:11 -0800 (PST)
Subject: Re: [PATCH] compat_ioctl: block: add missing include
To:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1576932330-32095-1-git-send-email-arnd@arndb.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <49713de0-12f9-94f1-00bf-d3189ce9f921@kernel.dk>
Date:   Sat, 21 Dec 2019 07:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576932330-32095-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/19 5:45 AM, Arnd Bergmann wrote:
> As the 0day bot pointed out, a header inclusion is missing in
> my earlier bugfixes:
> 
> block/compat_ioctl.c: In function 'compat_blkdev_ioctl':
>  block/compat_ioctl.c:411:7: error: 'IOC_PR_REGISTER' undeclared (first use in this function); did you mean 'TRACE_REG_REGISTER'?

Folded in, here's the update series on top of block-5.5:

https://git.kernel.dk/cgit/linux-block/log/?h=block-5.5-next

-- 
Jens Axboe

