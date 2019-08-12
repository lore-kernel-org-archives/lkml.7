Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A70DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED85C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcYFmOnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfHLHhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:37:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfHLHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:37:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so11211209wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R1Be8onIeze9fs+7n3+/PpSy9/BtgjJpnC6Vyn42sUg=;
        b=GcYFmOnFusv3pzYSHDeHRfSifYRIiQ5M0sh9Q379q5WLzcuPw+CyFod55Tb1tJYSfH
         jrEDJxlOKgJc3ii8u4Mi8XyHKcHtQ7Sb8xykhjznT2KgkxCNZTbJkbsWrfe/FzbtTzMK
         D2sAEHhjedRpH0Nd41ejwL8sGGYzu+QU3dfvyNIss+NMyyTLLs7rt5CIKZFYdVQlcOey
         rKyG1SBQLz1cUGEGxGmKDgeiCQIoBhLp2eTxIkKVjk+8feijP+cHb+Fwh/PFstIOQoZN
         U7yofqZjAt+Htg+5oNpKL94aMO3K8RNgMhDkU2xMZxSOi2cYgB2xlwn4zCL6OAcDOX0a
         YJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R1Be8onIeze9fs+7n3+/PpSy9/BtgjJpnC6Vyn42sUg=;
        b=qb8SVJOITKs8RJ52duBM1uMp2uvbG0aG7w5qtxyOjGEqtvyclC7V2s2+Yo6ikrJ1OL
         wI3Q/ktuFWNeW/eBA8H/cXC6TCZDj3VdvGJGsxIJHaKCaj/OmzRFoPMQDa3mLmLDWCKM
         a3F3tiwavv+lm86Z3YQQUsyXEuKoirtqimYfq79zJldGne7rBGYE3GiXWl28mS50LczM
         hEgZZD69ZpnUFhrvVLcoNj4ak1nDrBFQbG5pWCVUkM2JiWhUKkbl66uQk/HhFERO9TSI
         ElBHVhhkAg5pu/5BRlmjz8iyXgOn5uMphRiod/eZ3z+jm39qS2XI3t2QZgodYRPDOpyw
         8S+g==
X-Gm-Message-State: APjAAAXscSFTaUqBBvjgIu43U/o/ZNQTGmoBFXdfvBUSWHrIl7kNtHjB
        2btKRLpIZTnIfDod52I4Rydwlw==
X-Google-Smtp-Source: APXvYqyzEw8ku2htf6irDObh2g/4qIFq1aLn5f8fIpvd4e6FGw4qI9x7R+jtgWQvPv3rN1ZGlGlvAw==
X-Received: by 2002:a7b:c952:: with SMTP id i18mr11322397wml.44.1565595461020;
        Mon, 12 Aug 2019 00:37:41 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id a142sm10839483wme.2.2019.08.12.00.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:37:40 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:37:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: tps80031: convert to devm_i2c_new_dummy_device
Message-ID: <20190812073738.GP4594@dell>
References: <20190722172636.4589-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172636.4589-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to devm_i2c_new_dummy_device(). So, we now get
> an ERRPTR which we use in error handling and we can skip removal of the
> created devices.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Only build tested. Part of a tree-wide move to deprecate
> i2c_new_dummy().
> 
>  drivers/mfd/tps80031.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
