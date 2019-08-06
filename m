Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E749FC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EB6216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfHFSvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:51:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51538 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfHFSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:51:13 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1hv4YB-00041L-19
        for linux-kernel@vger.kernel.org; Tue, 06 Aug 2019 18:51:11 +0000
Received: by mail-pl1-f199.google.com with SMTP id t2so48849000plo.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:in-reply-to:from:subject:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=2zdSETPQrksyHBxfstGVcIf+FZddbD5bcxUPXoyzSyw=;
        b=UpWrlq7HXPm2zOcStbl3mrV5xIsCC7B0uV1ABoE7Cy5P7ERJYm1l5TmnEmcN0GpSX7
         l/U5lppIzIpfKOzIzgYE+IJgl413gZ7MMJpfg0Y7uQi0XLbjsuOAvlERwNgpPA4HpjGe
         S94c/8hLqlTHPYCOF/Bj7POyimzNlxMYEENQFjZuRf6j3CjK2YHXTdhVvQblroFZgWYC
         iR2WwFtZrlDASERfEE+OmwilKdF0kiJWD0Y1Eiu8zX4bA2C3sUPtj5GTY1njAveKXZtJ
         5HUWBQiDQ/nIDDO1clHoOmxT8QhKBZNB1A+jK1SOfGnIjAE81NMa7QpXrNqw8i77rusS
         R8Iw==
X-Gm-Message-State: APjAAAWBPHEHAPL/3RKrUXAXCmU5HWov/HzqxNc0Dzvry7DNJd136R2b
        ubtr9emKU0mBLQeeLMhUznPoCE5RJovPdRiJR+6QzGcCDbnrxZkJLf6SQv839AcL1sltmEWkpeL
        flqSd3cpCvoERZjZrpgexEdj51nIQtZ8owJrmL2G5XQ==
X-Received: by 2002:a62:b515:: with SMTP id y21mr5237957pfe.213.1565117469797;
        Tue, 06 Aug 2019 11:51:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxCPT1G7eI1+2Oh1tZekJKUqADBMlTDDGNt0pdOxu47nAXI84gEwYTa99lDvnee6ttk5zTZjw==
X-Received: by 2002:a62:b515:: with SMTP id y21mr5237937pfe.213.1565117469617;
        Tue, 06 Aug 2019 11:51:09 -0700 (PDT)
Received: from [192.168.1.200] ([152.254.169.4])
        by smtp.gmail.com with ESMTPSA id a1sm59604807pgh.61.2019.08.06.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 11:51:08 -0700 (PDT)
To:     dhowells@redhat.com
Cc:     lists@nerdbynature.de, linux-kernel@vger.kernel.org,
        anna.schumaker@netapp.com, steved@redhat.com
In-Reply-To: 
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Subject: Re: [PATCH 1/3] fscache: Fix cookie collision
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <66d23ccb-0d3d-54cc-59b3-2d2bc10d5e9e@canonical.com>
Date:   Tue, 6 Aug 2019 15:50:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, was there any respin for this patch? I couldn't find it upstream.

This message shows a lot in the xfstests against cifs.
Thanks in advance,


Guilherme
