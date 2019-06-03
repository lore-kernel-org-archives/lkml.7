Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFB3C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EBA26025
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l1rcmfDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfFCWM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:12:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42825 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfFCWM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:12:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so7803044pgd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=79eSeDNe0QggiFOBK9zOhkSkQmpm6VlHBwv5gxt7/p4=;
        b=l1rcmfDPB8xZh5ExX5/oeDXna+HD9CgZmCMVmFB+VvD6eo1htrqyiBs/GZ2Yfyausb
         7UVbLj/TE/avZbpLI9r93eUtQgS6YbumWYhxeushwaJj2PIlRBfC4hNhJHGM9kFkd4dW
         /R3J9reECWGS2OKGZw8sgtQ2BRut6q7/R9cIpnaH1AHx2dye3s/W2eYBpvfO0DGL5/WW
         JwYQxnz9NnbpNZcn8bWtLsSsG+0LxdDexu9oaW6sQthC9v47ZYMuFRSh01BqhHMvPpQU
         Q7H1N+qDDJ8EJyFmo++BJsWng0iPSKfXQjjZr2AqAJMQabqIklXrGc94TowDzc40eflv
         JHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=79eSeDNe0QggiFOBK9zOhkSkQmpm6VlHBwv5gxt7/p4=;
        b=shL6cRMyqB16pQrlA3AJYv1yUBT9KLU4Nfx6Zo+++C4anKap1Ty2FeE0MH+d5a4ido
         q7eHEetZqC3zIepyQprEdAFLzPOei+sHHi95pBkaujrkRjeecFY0DjKu3kn3UTiiBQuq
         rxLJoqtczGHj2B/2mkGB6BdBrR7+Xotz/hnkSHYSJO4AKPD1T8sGLcsXRDIBmDoGQy5u
         h40uxAgzIC5uUXCkOolP5laStzFWbWHbs9K/lkKxa9/+BaJV3BmFFUo2JkCdpC1eMlmF
         TvrLmWa74hSwOhxKiAnah9PLNvEd3SdyS2Mo80OAQe7uLHksBfFViUuV7FhKnfD9aKEs
         ZfAA==
X-Gm-Message-State: APjAAAUewf2DGRNQtfSeRVo60iEd7XD3x/CEkLiTgGgv37MA0jtxa0T+
        3wJEfReQEpD9ReB0F64MioXjeqqyPv8=
X-Google-Smtp-Source: APXvYqxkGMxpvLdkckFS/GH60j+jfBPnCXI7MzEX2EcX4S0nl6IWm9JFRgyJVj/6Qy9k7P3zcGg6OQ==
X-Received: by 2002:a62:e511:: with SMTP id n17mr28496063pff.181.1559599977626;
        Mon, 03 Jun 2019 15:12:57 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id i22sm15769445pfa.127.2019.06.03.15.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 15:12:57 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: meson: g12a: Add hwrng node
In-Reply-To: <CAFBinCBJO3J1wG1wa6X26VT6yGT_c_1XHOPiPpMRZGW8KKxopg@mail.gmail.com>
References: <20190527125059.32010-1-narmstrong@baylibre.com> <CAFBinCBJO3J1wG1wa6X26VT6yGT_c_1XHOPiPpMRZGW8KKxopg@mail.gmail.com>
Date:   Mon, 03 Jun 2019 15:12:56 -0700
Message-ID: <7hsgsqiahj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Mon, May 27, 2019 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic G12A has the hwrng module at the end of an unknown
>> "EFUSE" bus.
>>
>> The hwrng is not enabled on the vendor G12A DTs, but is enabled on
>> next generation SM1 SoC family sharing the exact same memory mapping.
>>
>> Let's add the "EFUSE" bus and the hwrng node.
>>
>> This hwrng has been checked with the rng-tools rngtest FIPS tool :
>> rngtest: starting FIPS tests...
>> rngtest: bits received from input: 1630240032
>> rngtest: FIPS 140-2 successes: 81436
>> rngtest: FIPS 140-2 failures: 76
>> rngtest: FIPS 140-2(2001-10-10) Monobit: 10
>> rngtest: FIPS 140-2(2001-10-10) Poker: 6
>> rngtest: FIPS 140-2(2001-10-10) Runs: 26
>> rngtest: FIPS 140-2(2001-10-10) Long run: 34
>> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
>> rngtest: input channel speed: (min=3.784; avg=5687.521; max=19073.486)Mibits/s
>> rngtest: FIPS tests speed: (min=47.684; avg=52.348; max=52.835)Mibits/s
>> rngtest: Program run time: 30000987 microseconds
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Thanks,

Kevin
