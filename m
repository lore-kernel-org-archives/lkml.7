Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B6BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E8206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="j9s31Q+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfDVTAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:00:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34299 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfDVTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:00:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id h5so9755015lfm.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M8B7nO5+82cIhwrIOBzOOhKx5CNzmCk0siHc0MkP3/I=;
        b=j9s31Q+PoCxgIcmhIGPSwBcVbfRk6dRKf6lDfYwe3+Af9rDP+zj03xPT0tMPxx10sh
         U3UhfhEotzA/PEvaBz+nBkifxWFYmIQvVrVuprqZ1KBCRKrrKqAraDo0gSx07DtXI0QE
         vb81Dl4xvUXK8u4bqzJCno/Bb2zXVtU1u15n+VhZh1G5X/fPtod4q18twdZNp1fh3XHZ
         +Ha0Wi/+/ZZZyfHmINmT6dTRmIs7cxuZrdnCKRHQNRmYQy4cIB50Mz4okq29fwRg5VE4
         lOL2+Vy/FPq/f17CPr4P6U72J6cMBe7S9rCeZzQ9+HqwYk+EGGjaAvDbPjdQbcuOemAv
         TKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M8B7nO5+82cIhwrIOBzOOhKx5CNzmCk0siHc0MkP3/I=;
        b=iRC4b06JWEain2WslCSybAU+oxpcs/0laLsGCmSxikopPA9jObrnCKlrkyUBIX+rQU
         pNVWU1uG28mGRZScjLMnbVlHj4dnYOJZ0ugI6k5FlDe6LJYqUPhmCfrP+anCMWPfEVW1
         zP2jwoVqGe2IAQhShmjLTuDCTm3uc3YzvXLZ4ZbOt5qtOTYUxdG0NHpyfEsZbQt3/DRb
         hVimiwaYtQnmgKs8im9a6IdzhpQTYY5vMcr7DqL7P4Rj6dSYhNefX9v+XIN0kyez3uEc
         Q9qOMlWWWYqK1mdU8P0yl1ELCxZ+TTk07HLhpxO1SkJt2QxAJ4bXckXKdY6enZfaRm/O
         ehGQ==
X-Gm-Message-State: APjAAAWGXGODsa2QaVh6wY/ZNCFtjaF77Kziauc5QLkyTOoNMVnXtnI9
        W206t+HpQO5OufgnfwSi4ckR1A==
X-Google-Smtp-Source: APXvYqxbpUKi/aDL2MZgTIV9szQT6OrC2ScmYQSTmSFdRDAHECEVD3n6qlv7ot2WHPSZWB8UHol0FA==
X-Received: by 2002:a19:9c05:: with SMTP id f5mr12022597lfe.54.1555959616911;
        Mon, 22 Apr 2019 12:00:16 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.98])
        by smtp.gmail.com with ESMTPSA id y65sm66341lje.84.2019.04.22.12.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 12:00:16 -0700 (PDT)
Subject: Re: [PATCH v11 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-3-git-send-email-masonccyang@mxic.com.tw>
 <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <a06cd796-1afc-ecf9-505d-efb615aebf73@cogentembedded.com>
Date:   Mon, 22 Apr 2019 22:00:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <d2a7a471-2847-b774-42b1-9feb8f4c69f3@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/2019 09:32 PM, Sergei Shtylyov wrote:

>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]
> 
>   Do dote that I'm opposed to the driver separation as it's presented in

   Sorry, s/dote/note/.

> this patches, and I have a large patch reworking both MFD and SPI drivers
> in the works.

[...]

MBR, Sergei
