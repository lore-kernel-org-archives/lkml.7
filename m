Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8467B27DD5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YfJUZH+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfFCI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:57:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51502 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfFCI5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:57:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so10271267wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 01:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3KM9Q1n5IBx5W/xAod6CQA+4J011QHoahMgLw+wAVWU=;
        b=YfJUZH+eQuq6PIOzpM1g0P7HzEVFK0sP5P7pCwJ5pKtsYquHFWg/Jy+LH9qs9PX5Ka
         6SvDrcZPFlRL0auD58L/wytMUTtGrP0ipWFS2Fh2GG6YR5eL9QJEVstwJG4Y2cMDfH5s
         KOIFz4E5wDbiv+LHPfU/vx1Yb3UnNL4Z6LmDQswNaznkLS3U8R5ir4bKm1pW2n/IBb89
         WBwqmznsI1vkVcTq6iNE+U+s+zBv7ozSuN9W47wBk/kPCBOq9bc+4/Mz3BjgDu95F4CN
         3QrjMHNHhBHjM8vWJsVR7DWC2g8WUqm/nHlEUP6uon8WwNgx9D+NgNTU/x+2FtYv0pCX
         ZFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3KM9Q1n5IBx5W/xAod6CQA+4J011QHoahMgLw+wAVWU=;
        b=qzQ8kxuHHTNa1rRdavQY9yfk2aXnQsE1NKZVfptNbhfESQ583ttg25KdQPVkM24oRt
         BsrpcORcIYGXx/DKw1Y5axMTDaYpK1HMwIHfDtib7DEjpl4q2MchGrs/fYs5MLXUm1CS
         XL8IuID7CJ0JC4mTwhl4Dd8VIlVZ5/8qmUq3pVN1UI2gKQEY6n6TICT8C1Aziz7GEuxJ
         27oU8fPiefYZavJWc108OwOFyv35gnJ2uMR5n6/MqND6/6s7OWq2Gggh+x4+NQKxtN2t
         gG5AuYv6Xy/+ky/X1sAnRr98WpF7qElV/JvBYw/StODWjJ06bWanVGI4+rm8v/Tm5jSI
         Ouxw==
X-Gm-Message-State: APjAAAVpTv5GtFnubXRp89lYglq3tnMHG14RNBJQNcf2olkEy7+naUTX
        67JVgFcfDvFK4eM8fLL9urftCw==
X-Google-Smtp-Source: APXvYqwwWElHtJZbcaKAn2d5m/Gyflr0aRk2DATFNgMRi5ieGeAZwu/gyTWwHcKitBpNG8VRf5NckA==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr14011922wmb.112.1559552225702;
        Mon, 03 Jun 2019 01:57:05 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e17sm1183050wrt.95.2019.06.03.01.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 01:57:05 -0700 (PDT)
Subject: Re: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth
 support
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190527132200.17377-1-narmstrong@baylibre.com>
 <20190527132200.17377-3-narmstrong@baylibre.com>
 <CAFBinCBTK=6OW4kG=i0KZe-+AzGVXyou9g0frnh9yqLsdmB5+w@mail.gmail.com>
 <b54c7899-95b3-1202-d70b-9b8ee2955164@baylibre.com>
 <CAFBinCB9PZ-mjyjCafK24cH3sN5E1r4vt1z=m+uvkHsmRW2PFQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <bbf3c69f-8695-d665-c7ca-587b7e77eb4f@baylibre.com>
Date:   Mon, 3 Jun 2019 10:57:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCB9PZ-mjyjCafK24cH3sN5E1r4vt1z=m+uvkHsmRW2PFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/05/2019 20:08, Martin Blumenstingl wrote:
> On Wed, May 29, 2019 at 12:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 27/05/2019 20:36, Martin Blumenstingl wrote:
>>> On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> From: Christian Hewitt <christianshewitt@gmail.com>
>>>>
>>>> - Remove serial1 alias
>>>> - Add support for uart_A rts/cts
>>>> - Add bluetooth uart_A subnode qith shutdown gpio
>>> I tried this on my own Khadas VIM2:
>>> Bluetooth: hci0: command 0x1001 tx timeout
>>> Bluetooth: hci0: BCM: Reading local version info failed (-110)
>>>
>>> I'm not sure whether this is specific to my board or what causes this.
>>
>> Which kernel version ?
> 5.2-rc2
> 
> it's a Khadas VIM2 Basic (thus it has a AP6356S), board revision v1.2

Can you try with :

clocks = <&wifi32k>;
clock-names = "lpo";

added in the bluetooth node ?

Neil

> 
> 
> Martin
> 

