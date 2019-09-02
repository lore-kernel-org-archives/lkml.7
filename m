Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACCBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6716217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y7nVs9IG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfIBL6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:58:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32924 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfIBL6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:58:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so13765504wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cIuJ4ZyO7u1R0DHww9r6ZEUVkA8fHsMxFkdXkyyL4q8=;
        b=Y7nVs9IGvhy5DYUH+6gjjsYgad9lh9VwpVhPeWOsAZGJ1HTWRuSRzGu+gHcEtLXa29
         LcZFLq0VfQ0VdnULsIWZHyDWatuoW6BuJnvA5tm4/kCW6TEnTA8bf61feFsCcjo7Izsr
         guDZ8q5G7Xu4X0JiIoGi/kQEFDeCly9pW2LiwrOlkKLvnKf4Yhn2s2AvtK5djI7LrlS4
         M/WB0KMPf/ugTtCo4xO2OPYzj3yS9UhgGIw8G9FGDqy9g0yu34E37v5CTXO2Byd4+fbx
         szog8YdlBNc/TSDtNur6qEe95Dw58e5/HycYH8fA2e7I6xNlSxPt/d8nFjZMXQafgAND
         MOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cIuJ4ZyO7u1R0DHww9r6ZEUVkA8fHsMxFkdXkyyL4q8=;
        b=P2jXi3ypObsG+SjsEWVqz2znPiU8TfoxsNc2+koMbaxcwtYOOGx7QLd9+nxART97CQ
         EW5Sbp7CKOKhX5Qst4NwKzjQyXy619RzBwAFFuSTbOAnZ6RVcYKINNXf0XcBG0z+tOpE
         fCd4lKSfA06o8wV0G3QI+jh/gQhK/qqxETV0XsZC9ajzLHzfT2oQL5hAd2Z6z4uzgPuA
         u70iX1ouNMg8BRNJ7V1H4N3VMs+v+EKK8aTnv5kij0PhnwZiv0FM/D91gPuvaloAkmTZ
         zWX5f7xcZj8UuWSIKW2jehxQvcg8BP0oV7gXxwew5JmGCkZ/jDchFJgzELOjTKr784Bx
         /eSg==
X-Gm-Message-State: APjAAAXHR5qctIkKwc2DSqa2BDhnnnPgJTTlElu8iQ0hh2NFzRqK5OsU
        mOUiy02vIiP/b+KaIVuybrMRJw==
X-Google-Smtp-Source: APXvYqy7XooxwtcxbzDP3Qx5rs5Gg4qkUsWNe3UALra+Yh0UnaURoY2WV9WFmk1NgQTaEMd0+Q9/EA==
X-Received: by 2002:adf:e485:: with SMTP id i5mr12884281wrm.175.1567425479999;
        Mon, 02 Sep 2019 04:57:59 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m18sm5450088wrg.97.2019.09.02.04.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 04:57:59 -0700 (PDT)
Subject: Re: [PATCH v2] drm: dw-hdmi-i2s: enable audio clock in audio_startup
To:     Jonas Karlman <jonas@kwiboo.se>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "cain.cai@rock-chips.com" <cain.cai@rock-chips.com>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "eddie.cai@rock-chips.com" <eddie.cai@rock-chips.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "dgreid@chromium.org" <dgreid@chromium.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190902035435.44463-1-cychiang@chromium.org>
 <241fd791-3792-34c8-ac35-a81a0a41070c@baylibre.com>
 <HE1PR06MB4011E2F58875F30446D902BFACBE0@HE1PR06MB4011.eurprd06.prod.outlook.com>
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
Message-ID: <9e049910-3f7a-a65c-c329-97865e35c8cc@baylibre.com>
Date:   Mon, 2 Sep 2019 13:57:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR06MB4011E2F58875F30446D902BFACBE0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2019 12:32, Jonas Karlman wrote:
> On 2019-09-02 11:42, Neil Armstrong wrote:
>> Hi,
>>
>> On 02/09/2019 05:54, Cheng-Yi Chiang wrote:
>>> In the designware databook, the sequence of enabling audio clock and
>>> setting format is not clearly specified.
>>> Currently, audio clock is enabled in the end of hw_param ops after
>>> setting format.
>>>
>>> On some monitors, there is a possibility that audio does not come out.
>>> Fix this by enabling audio clock in audio_startup ops
>>> before hw_param ops setting format.
>>>
>>> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>>> Tested-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>  Changes from v1:
>>>  1. Move audio_startup to the front of audio_shutdown.
>>>  2. Fix the indentation of audio_startup equal sign using tab.
>>>  3. Rebase the patch on linux-next/master.
>>>  4. Add Reviewed-by and Tested-by fields from dianders@chromium.org.
>>>  5. Add Reviewed-by field from jonas@kwiboo.se.
>>>
>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>> index 1d15cf9b6821..34d8e837555f 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
>>> @@ -109,6 +109,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
>>>  	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
>>>  	hdmi_write(audio, conf1, HDMI_AUD_CONF1);
>>>  
>>> +	return 0;
>>> +}
>>> +
>>> +static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
>>> +{
>>> +	struct dw_hdmi_i2s_audio_data *audio = data;
>>> +	struct dw_hdmi *hdmi = audio->hdmi;
>>> +
>>>  	dw_hdmi_audio_enable(hdmi);
>>>  
>>>  	return 0;
>>> @@ -153,6 +161,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>>>  
>>>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
>>>  	.hw_params	= dw_hdmi_i2s_hw_params,
>>> +	.audio_startup  = dw_hdmi_i2s_audio_startup,
>>>  	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
>>>  	.get_eld	= dw_hdmi_i2s_get_eld,
>>>  	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
>>>
>> Looks sane, Jonas should I apply it now it's rebased ?
> 
> Sure, looks sane and compiles without warnings on my build host.

Thx, Applied to drm-misc-next

Neil

> 
> Regards,
> Jonas
> 
>>
>> Neil
> 

