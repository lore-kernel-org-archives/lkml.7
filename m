Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9C3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C521C206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Jpnq/qFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfIQQPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:15:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44629 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfIQQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:15:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id i18so3774227wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PLwjr40Ug6+Q9ptsgelaO6EU1nTou4YKGGmLnihVjZY=;
        b=Jpnq/qFPbfltku6owmoDFb1YyN/pQZ7gUOQsjPW92gHuzN1JaoQYqm0n8vupIE6Ur+
         ulujgVsjAiit902VrHA0Zkma/JpC93i3Eeal+A1mbRmm+HJDtPtzOWDOFRYte6UkwWnU
         HnUjJXC0YRNqUNwABJrnRRwNrNRZv7Rcc+FKzcEF5FqrtXQVOSNbvHk7LbG+mdXv5WtI
         BMTZTpGnCnNJu3J/cW++bVbsELlHEja27fd3ykzxovWPXZ53+fe2EEqZt6B8YRZqs8CH
         fwQ+bv4HqM6lKtQIJoIkhNesYfIJ28vgWGOCM6S+8Hy4zvQxCcJHyVb1nP8j3egle2QJ
         vkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PLwjr40Ug6+Q9ptsgelaO6EU1nTou4YKGGmLnihVjZY=;
        b=OKPgTOnyuVAv8AjDCXDMEN6V9S81Ef/QygHLD/23sf+grJOULinX44QLddNufgYJ/n
         5+cTToCsormHYbsjQy955JBiltCd4JwcG7Mz7JAMiN9Gc8KtJuzJCA7hTqpck2LhSr2e
         5CTM0aofTFGEvqMJmUlNbsltNG/MHFKGOU7FTFDNvQXDcI3Jc5K4u3rGGVyuh9DZUkTU
         rAf0k14bc9XQh9xi7Gh4UTCuw2Okprvwl2xyLO7i1ARWi2T9H4jmOk+KBULItbLQ7Akj
         T4g3a/y0QWfhle+BEwuedX+M4Ehl1zTX2INvg9ZEJbH0437dqtX9domk22SGuyYaOhfH
         GmrA==
X-Gm-Message-State: APjAAAWVpWqGyDlu4hEBcBJGK0xm8VkFM5TeTazTeTho8fYOPw/mxvpU
        NdIaao1pRSmNh+Mge9GJh2ZZ6Kk5MqxCxg==
X-Google-Smtp-Source: APXvYqx/havAU2MdlHSqoI3ec086h5yJEaf+5U58Holx0dhZvWDtwOj5F/DqS5AlQNu42QHSFId1rg==
X-Received: by 2002:a5d:6b49:: with SMTP id x9mr3484630wrw.80.1568736943880;
        Tue, 17 Sep 2019 09:15:43 -0700 (PDT)
Received: from [10.1.3.173] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m18sm4454308wrg.97.2019.09.17.09.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 09:15:43 -0700 (PDT)
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <20190909134241.23297-1-ayan.halder@arm.com>
 <20190917125301.GQ3958@phenom.ffwll.local>
 <20190917160730.hutzlbuqtpmmtdz3@e110455-lin.cambridge.arm.com>
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
Message-ID: <11689dc3-6c3e-084b-b66d-e6ccf75cb8fb@baylibre.com>
Date:   Tue, 17 Sep 2019 18:15:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917160730.hutzlbuqtpmmtdz3@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/09/2019 18:07, Liviu Dudau wrote:
> On Tue, Sep 17, 2019 at 02:53:01PM +0200, Daniel Vetter wrote:
>> On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
>>> Add a modifier 'DRM_FORMAT_MOD_ARM_PROTECTED' which denotes that the framebuffer
>>> is allocated in a protected system memory.
>>> Essentially, we want to support EGL_EXT_protected_content in our komeda driver.
>>>
>>> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
>>>
>>> /-- Note to reviewer
>>> Komeda driver is capable of rendering DRM (Digital Rights Management) protected
>>> content. The DRM content is stored in a framebuffer allocated in system memory
>>> (which needs some special hardware signals for access).
>>>
>>> Let us ignore how the protected system memory is allocated and for the scope of
>>> this discussion, we want to figure out the best way possible for the userspace
>>> to communicate to the drm driver to turn the protected mode on (for accessing the
>>> framebuffer with the DRM content) or off.
>>>
>>> The possible ways by which the userspace could achieve this is via:-
>>>
>>> 1. Modifiers :- This looks to me the best way by which the userspace can
>>> communicate to the kernel to turn the protected mode on for the komeda driver
>>> as it is going to access one of the protected framebuffers. The only problem is
>>> that the current modifiers describe the tiling/compression format. However, it
>>> does not hurt to extend the meaning of modifiers to denote other attributes of
>>> the framebuffer as well.
>>>
>>> The other reason is that on Android, we get an info from Gralloc
>>> (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This can
>>> be used to set up the modifier/s (AddFB2) during framebuffer creation.
>>
>> How does this mesh with other modifiers, like AFBC? That's where I see the
>> issue here.
> 
> AFBC modifiers are currently under Arm's namespace, the thought behind the DRM
> modifiers would be to have it as a "generic" modifier.
> 
>>>
>>> 2. Framebuffer flags :- As of today, this can be one of the two values
>>> ie (DRM_MODE_FB_INTERLACED/DRM_MODE_FB_MODIFIERS). Unlike modifiers, the drm
>>> framebuffer flags are generic to the drm subsystem and ideally we should not
>>> introduce any driver specific constraint/feature.
>>>
>>> 3. Connector property:- I could see the following properties used for DRM
>>> protected content:-
>>> DRM_MODE_CONTENT_PROTECTION_DESIRED / ENABLED :- "This property is used by
>>> userspace to request the kernel protect future content communicated over
>>> the link". Clearly, we are not concerned with the protection attributes of the
>>> transmitter. So, we cannot use this property for our case.
>>>
>>> 4. DRM plane property:- Again, we want to communicate that the framebuffer(which
>>> can be attached to any plane) is protected. So introducing a new plane property
>>> does not help.
>>>
>>> 5. DRM crtc property:- For the same reason as above, introducing a new crtc
>>> property does not help.
>>
>> 6. Just track this as part of buffer allocation, i.e. I think it does
>> matter how you allocate these protected buffers. We could add a "is
>> protected buffer" flag at the dma_buf level for this.
>>
>> So yeah for this stuff here I think we do want the full userspace side,
>> from allocator to rendering something into this protected buffers (no need
>> to also have the entire "decode a protected bitstream part" imo, since
>> that will freak people out). Unfortunately, in my experience, that kills
>> it for upstream :-/ But also in my experience of looking into this for
>> other gpu's, we really need to have the full picture here to make sure
>> we're not screwing this up.
> 
> Maybe Ayan could've been a bit clearer in his message, but the ask here is for ideas
> on how userspace "communicates" (stores?) the fact that the buffers are protected to
> the kernel driver. In our display processor we need to the the hardware that the
> buffers are protected before it tries to fetch them so that it can 1) enable the
> additional hardware signaling that sets the protection around the stream; and 2) read
> the protected buffers in a special mode where there the magic happens.
> 
> So yeah, we know we do want full userspace support, we're prodding the community on
> answers on how to best let the kernel side know what userspace has done.

Actually this is interesting for other multimedia SoCs implementing secure video decode
paths where video buffers are allocated and managed by a trusted app.

Neil

> 
> Best regards,
> Liviu
> 
> 
>> -Daniel
>>
>>>
>>> --/
>>>
>>> ---
>>>  include/uapi/drm/drm_fourcc.h | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>>> index 3feeaa3f987a..38e5e81d11fe 100644
>>> --- a/include/uapi/drm/drm_fourcc.h
>>> +++ b/include/uapi/drm/drm_fourcc.h
>>> @@ -742,6 +742,15 @@ extern "C" {
>>>   */
>>>  #define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
>>>  
>>> +/*
>>> + * Protected framebuffer
>>> + *
>>> + * The framebuffer is allocated in a protected system memory which can be accessed
>>> + * via some special hardware signals from the dpu. This is used to support
>>> + * 'GRALLOC_USAGE_PROTECTED' in our framebuffer for EGL_EXT_protected_content.
>>> + */
>>> +#define DRM_FORMAT_MOD_ARM_PROTECTED	fourcc_mod_code(ARM, (1ULL << 55))
>>> +
>>>  /*
>>>   * Allwinner tiled modifier
>>>   *
>>> -- 
>>> 2.23.0
>>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> http://blog.ffwll.ch
> 

