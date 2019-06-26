Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C37C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02AA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="szJWlS72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:16:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37610 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:16:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so1824910wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0lexb+9ELj8cXRsSAP5xJ5XziclRZjFkNRGtPNltonQ=;
        b=szJWlS724CXUSSyr2+6CkRRey8twYt7DwTW+OQ98PFf41ZTJHJN0FmWnrSZK+d2wmc
         FYfaOA9QnFpb9us7YNMOW1rXqkIwQ//zM3mbP9GKwjO6bHMvv7uoVI665w0EjWWt+sh2
         pe+iwacmiHmu6j4y+hlB7i2ewUDTDRtcoinvy2twRiPDLVbHfl55eAfoPxZZl+iepbj/
         4BFiBhtRSBv/SJKIlLIGk6xflbkrWD9+dpV3EgFsQuDpVLP4phJHVwpTVptEMFxV/K/N
         2OCDwg4m5qepbHnnOtFsZO7j0/s2iFiGM/6LozIVMWQ72PIMZ6PSUSGuEaRIBEOcD8OL
         IruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0lexb+9ELj8cXRsSAP5xJ5XziclRZjFkNRGtPNltonQ=;
        b=WG4AsPNbZcmQ0P+2PF4Lhlq5bKaWqANzD3MLHr3XzOvbxAqeCrncoiH6MRsJglwRf+
         mPHRpgnLEtOpF24HZAwLq8AzaVkpM0aEb28dTJg1HMJek7Pzsy2jYiZ3El35ke2YNHI8
         MEsOqIVgDXCOEJLBJAUPMRJwU7llIUv8NBwqY4InYEPepIsTf9oXUSFF7g61dLS1vdIJ
         /4QGK1Cbp+wwcmgz0HmpEnOVFPCpz51ruG9rKldOgfILqUyMJu/NKdrisJV0BqSXJbdV
         DwI/TjnJ4OXtHGEMrB5pbinJioUKUSf43Bi3OsU7oZUv8eF5agJbUID3MmFbxCmfssAY
         LoGQ==
X-Gm-Message-State: APjAAAXvBAd+BUUWKnLp13O2vJwMRJNndsPB5hNQw0o5WHxMRGGqCvvR
        S6wyMBkZoEQxRlxzh5nWRWbF6lI+wyk=
X-Google-Smtp-Source: APXvYqwDRdft9Y5lQZvIG49DbvknV0O6Gwx+IjCJkF9bawSOCK3wELB7PDXKCzH9aAfhNRPnfUVmig==
X-Received: by 2002:adf:ec49:: with SMTP id w9mr2548979wrn.303.1561540597500;
        Wed, 26 Jun 2019 02:16:37 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j189sm1726715wmb.48.2019.06.26.02.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 02:16:36 -0700 (PDT)
Subject: Re: [PATCH 3/4] drm/meson: Enable DRM InfoFrame support on GXL, GXM
 and G12A
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>
Cc:     "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <CGME20190526212026epcas3p3ef1bafa97e5da9dac02b26fa0a375c80@epcas3p3.samsung.com>
 <VI1PR03MB4206A326130A81DCBAA62CE8AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <bdc1746a-5829-9991-6f1c-d66f03c95d77@samsung.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <43cc7bec-e624-f690-8869-a00d26abd7c4@baylibre.com>
Date:   Wed, 26 Jun 2019 11:16:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <bdc1746a-5829-9991-6f1c-d66f03c95d77@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/2019 16:59, Andrzej Hajda wrote:
> On 26.05.2019 23:20, Jonas Karlman wrote:
>> This patch enables Dynamic Range and Mastering InfoFrame on GXL, GXM and G12A.
>>
>> Cc: Neil Armstrong <narmstrong@baylibre.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> index df3f9ddd2234..f7761e698c03 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> @@ -966,6 +966,11 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
>>  	dw_plat_data->input_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
>>  	dw_plat_data->input_bus_encoding = V4L2_YCBCR_ENC_709;
>>  
>> +	if (dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxl-dw-hdmi") ||
>> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-gxm-dw-hdmi") ||
>> +	    dw_hdmi_is_compatible(meson_dw_hdmi, "amlogic,meson-g12a-dw-hdmi"))
>> +		dw_plat_data->drm_infoframe = true;
>> +
> 
> 
> I see it follows meson_dw_hdmi.c practices, but maybe it is time to drop
> it and just add flag to meson_dw_hdmi_data, IMO the whole
> dw_hdmi_is_compatible function should be removed
> 
> and replaced with fields/flags in meson_dw_hdmi_data - this is what
> of_device_id.data field was created for.

It's in our cleanup process, this will pushed shortly, but in the meantime it
can be left as-is until cleanup is pushed, I'll sort it manually if both
happens in the same time.

Neil

> 
> 
> Regards
> 
> Andrzej
> 
> 
>>  	platform_set_drvdata(pdev, meson_dw_hdmi);
>>  
>>  	meson_dw_hdmi->hdmi = dw_hdmi_bind(pdev, encoder,
> 
> 

