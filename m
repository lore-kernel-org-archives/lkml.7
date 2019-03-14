Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE41C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150DA21855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Jcw1JdHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfCNSIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:08:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfCNSIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:08:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id u9so4518037pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=U7BBK7vlWP/t8lFMd6v5xn5vdx3A6D9GtU1E9MvUOTA=;
        b=Jcw1JdHo6y4yboLPPnhZh47MtMHiT4Fqwj+FE9MGFoOdY887/gZsoUJI3jtA1fNT/8
         qK20DTQLIeqbgiOJzICXJ+IdyOH2LcDqEQKGKE8XAqLVaIIUbfLCBJGAyOs5l/nHYfvA
         qS7O4X/OFWIJJNmmcEeBcVdUFultNgaYcUoGWMD3iun3BxrM4/6/zWWLOeNUonJJ9c8K
         NNwotLKLTIHCaAC/2MbnWyhajFq3LH8R9nxvnfu6fkjuZ2HHiwXSxhCI2X0qTjmGK1Fm
         2KJShQEKsuwTdfCs92gc4YdzQ9tF1BmgYukP4LCz+2giV58bchmqPlmPdhmx6Q4BDvP7
         1xKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=U7BBK7vlWP/t8lFMd6v5xn5vdx3A6D9GtU1E9MvUOTA=;
        b=DyAndBCg4fff9JSISn6ECQyspK95mCMTqdnOpFJ3ORB2+uHTmtBXg6qIGrjGBKhL1p
         LOiVj5UrpM6TWxsQm32po5OKwJ0sIVQn7AAur9x5P2vZUQTGTQsxaL2+AxL5NPu2xM2V
         4gcewhxZZgm6bLe7XU+kSXtsir/hKvR826wFNZMqy9KlFcbECvaFpB6D0ZwY51m8OOYa
         jF5tA7CVUGVsrTGa0YpLp2GEpIEwup98CnW4TmSwov4CHkislquV3hZwnWlqV4ZM3Qdz
         0mOr1iz9ghvsa3NYvExedmoqPda4rP6Lp/tabSDojqZ6GSSYGlpe9M7AgStlroZipDuz
         aqKw==
X-Gm-Message-State: APjAAAVN71TrH7kLUUrF1e4AWWAVYM894YV1LKkOyis9h7vFChRRfyiX
        uEHdU9HeLpQDghaoqvMEavKM7A==
X-Google-Smtp-Source: APXvYqybvV6viQ3TJykIomrDJ8ksvexT9T3eKWTz4aia1ppNeY2NwqascFJHl9mQTXcQTRK3yxhfDQ==
X-Received: by 2002:a17:902:681:: with SMTP id 1mr52755468plh.185.1552586931867;
        Thu, 14 Mar 2019 11:08:51 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a567:ae30:4f79:6ce5])
        by smtp.googlemail.com with ESMTPSA id p2sm32348009pfi.95.2019.03.14.11.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 11:08:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Chuanhong Guo <gch981213@gmail.com>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-gxl-s905d-phicomm-n1: add status LED
In-Reply-To: <5c580f1b-1038-2c34-7047-e504eb4ac323@baylibre.com>
References: <20190312083326.18029-1-gch981213@gmail.com> <5c580f1b-1038-2c34-7047-e504eb4ac323@baylibre.com>
Date:   Thu, 14 Mar 2019 11:08:50 -0700
Message-ID: <7hva0lwcp9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Chuanhong,
>
> On 12/03/2019 09:33, Chuanhong Guo wrote:
>> There is a white LED on the front panel behind the logo and the
>> manufacturer uses that LED to indicate network and USB drive status.
>> 
>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>> ---
>>  .../boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts    | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
>> index 9a8a8a7e4b53..b5667f1fb2c8 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
>> @@ -14,6 +14,16 @@
>>  	cvbs-connector {
>>  		status = "disabled";
>>  	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		status {
>> +			label = "n1:white:status";
>> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +	};
>>  };
>>  
>>  &cvbs_vdac_port {
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.2 with Neil's tag (branch: v5.2/dt64)

Kevin
