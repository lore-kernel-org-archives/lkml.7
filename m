Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC2AC2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674772077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fkV13MPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLKIty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:49:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34953 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfLKItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:49:53 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so23086185wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4R24ntszuyj6kFcy2bkKHmfof1u+l61AIa0Jznn7nN0=;
        b=fkV13MPNrAmIqCyKrhsIiXMxkSEC8PpmYORYYeyoJCfRjwsyyVxCSCzTGOQplQaoCn
         e6EdHOD+fGB5rvO/jVDLPF9wOmcg6CDa2zHBqVmGCs+XtY/nJ5/rO7wy0F8v9xozOiS0
         6O7oFu2s+ejQsgMupCttpv5auLgY7wRIphmBLxq/xzGuR5ebJ37jp2xrISuVZ173bxJ8
         T+IzaEjF+XqSw2mkUxv9ceuv6W6bIcjm0CXpzrmi0FWOHEaU+FkedQh0e5T2/Ago7Oi/
         o2V5kq+QigfXom0dZnufuLTl3gc+VOa+zmkrvqpwwurOV3VnNPRfMwa5JLdFdH8J2Rhq
         zfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4R24ntszuyj6kFcy2bkKHmfof1u+l61AIa0Jznn7nN0=;
        b=QcLjArjfZrtwKYJJD+u0AarGiCuWd18N2T7pxpGRpjffAmBaHet2UKUPtopWIfVOY5
         14euODKPy2hOz0Be/Yxui0een2KdbEh/F7VRKneKp+6Z32h/ZInYCbwO+vM/ZVyRL2em
         E8IdnBeOXY2zT8FqAvk3K4EgOhl6uZSB7A9XYxykEt4AEWv/l2fA/yzFDRqlM1h49evq
         k9ruZayfdyhUPuF6oBGkA7ma0CfeTkEgAHMngbggE+SmxGuyQJqnCbVEFvICGgOc1ehT
         Foh1o3yp/hIlQucY85Tstncu6SoTKtMNzzXr+Q8Xme/K3tDTsoWmEDBwYK1vo87neIb7
         lAUg==
X-Gm-Message-State: APjAAAUehYqM8SROoH8PPG1jOr0oDsb99vXSSrZh+ypRU9IYhyKKWvr8
        5ppMGMM3bvhFh73mxWmH872WSPXIz6jrag==
X-Google-Smtp-Source: APXvYqzO428TcmQ1sH6DcJsA9ow0CcwV7CoG805pSPiBXWV6DZFGTKXNpFdW6luh2XbFPmzNZ8Xfzg==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr2363092wrt.229.1576054190319;
        Wed, 11 Dec 2019 00:49:50 -0800 (PST)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f5sm1462572wmh.12.2019.12.11.00.49.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 00:49:49 -0800 (PST)
Subject: Re: [RFC-next 0/1] Odroid C2: Enable DVFS for cpu
To:     Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20191101143126.2549-1-linux.amoon@gmail.com>
 <7hfthtrvvv.fsf@baylibre.com>
 <c89791de-0a46-3ce2-b3e2-3640c364cd0f@baylibre.com>
 <CANAwSgQx3LjQe60TGgKyk6B5BD5y1caS2tA+O+GFES7=qCFeKg@mail.gmail.com>
 <7hfthsqcap.fsf@baylibre.com>
 <CAFBinCBfgxXhPKpBLdoq9AimrpaneYFgzgJoDyC-2xhbHmihpA@mail.gmail.com>
 <7hpngvontu.fsf@baylibre.com>
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
Message-ID: <4e1339b4-c751-3edc-3a2e-36931ad1c503@baylibre.com>
Date:   Wed, 11 Dec 2019 09:49:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7hpngvontu.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2019 22:47, Kevin Hilman wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> 
>> On Tue, Dec 10, 2019 at 7:13 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>>
>>> Anand Moon <linux.amoon@gmail.com> writes:
>>>
>>>> Hi Neil / Kevin,
>>>>
>>>> On Tue, 10 Dec 2019 at 14:13, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>
>>>>> On 09/12/2019 23:12, Kevin Hilman wrote:
>>>>>> Anand Moon <linux.amoon@gmail.com> writes:
>>>>>>
>>>>>>> Some how this patch got lost, so resend this again.
>>>>>>>
>>>>>>> [0] https://patchwork.kernel.org/patch/11136545/
>>>>>>>
>>>>>>> This patch enable DVFS on GXBB Odroid C2.
>>>>>>>
>>>>>>> DVFS has been tested by running the arm64 cpuburn
>>>>>>> [1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
>>>>>>> PM-QA testing
>>>>>>> [2] https://git.linaro.org/power/pm-qa.git [cpufreq testcase]
>>>>>>>
>>>>>>> Tested on latest U-Boot 2019.07-1 (Aug 01 2019 - 23:58:01 +0000) Arch Linux ARM
>>>>>>
>>>>>> Have you tested with the Harkernel u-boot?
>>>>>>
>>>>>> Last I remember, enabling CPUfreq will cause system hangs with the
>>>>>> Hardkernel u-boot because of improperly enabled frequencies, so I'm not
>>>>>> terribly inclined to merge this patch.
>>>>
>>>> HK u-boot have many issue with loading the kernel, with load address
>>>> *it's really hard to build the kernel for HK u-boot*,
>>>> to get the configuration correctly.
>>>>
>>>> Well I have tested with mainline u-boot with latest ATF .
>>>> I would prefer mainline u-boot for all the Amlogic SBC, since
>>>> they sync with latest driver changes.
>>>
>>> Yes, we would all prefer mainline u-boot, but the mainline kernel needs
>>> to support the vendor u-boot that is shipping with the boards.  So
>>> until Hardkernel (and other vendors) switch to mainline u-boot we do not
>>> want to have upstream kernel defaults that will not boot with the vendor
>>> u-boot.
>>>
>>> We can always support these features, but they just cannot be enabled
>>> by default.
>> (I don't have an Odroid-C2 but I'm curious)
>> should Anand submit a patch to mainline u-boot instead?
> 
> It would be in addition to $SUBJECT patch, not instead, I think.
> 
>> the &scpi_clocks node could be enabled at runtime by mainline u-boot
> 
> That would work, but I don't know about u-boot maintainers opinions on
> this kind of thing, so let's see what Neil thinks.

U-Boot doesn't anything to do with SCPI, SCPI discusses directly with the SCP
processor, and the CPU clock is set to 1,56GHz by the BL2 boot stage before
U-boot starts.

The only viable solution I see now is to find if we could add a DT OPP table
only for Odroid-C2 dts to bypass the SCPI OPP table.

The arm,scpi-clocks driver registers a clk for this CPU clock, using SCPI to set
the rate, right now this is ok.

But, arm,scpi-clocks also registers a "scpi-cpufreq" device, which calls
scpi_ops->add_opps_to_device() which gets the SCPI OPPs and adds them to the CPU.

A way to handle this would be to check if DT has OPPs in drivers/cpufreq/scpi-cpufreq.c
_before/instead_ calling scpi_ops->add_opps_to_device() to use the DT OPPs instead
of the firmware OPPs, like in drivers/cpufreq/cpufreq-dt.c.

calling:

	ret = dev_pm_opp_of_get_sharing_cpus()
	if (ret) {
		scpi_ops->add_opps_to_device()
		scpi_get_sharing_cpus()
	}

would maybe work.

Neil

> 
> Kevin
> 
> 

