Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265E1C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92E3206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fhF2VQBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbfG3Ni1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:38:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52560 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3Ni1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:38:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so57182441wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ySoiYclDSeZwytRrL2JIutyMtXbb3MYUEVXKENpqhnU=;
        b=fhF2VQBaJsGrcgN+Ys0+/XauSUyKgdE6DH1yLJ6S2DbwmATbj1PNLX9A1ZCvjAYXKn
         IWX+X2oNsTojknjD+vSzxjCvxmjlUy01fKd3zrCfpUbAJVGQmGFWXZRwB7H5TNQwucRf
         lOZzvKEC4EUidiQt4NPrH3BPls2JuiC4IYc+2FSe68618fcGe4jil5vxFHiedoWhErB2
         qyvwWL3ikacppoLZhYfkaOZO8KxEUYI2xDJ53x5qa3hddovUUs2rCYARo9FCUxBI/pp4
         RN94LPiF6Yxl93Id/UV7UsyAIEfugDKMxkzxWW+LoZ92H7vmoc1WseUdjvYnSE6wgYow
         JogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ySoiYclDSeZwytRrL2JIutyMtXbb3MYUEVXKENpqhnU=;
        b=D49Fm/UKNCVMoVAQYE/x7R3N1gUa7kYikmJTVYwm6CjpTD0Z2+USyjJG7QGBylAXIA
         WSDDHRKcAB8A2rg3aNadB4xwIE4VJ7xO9EtoeJbOdK7xnzsQdt3NxZXm4RZ1xt3ly5rZ
         F68Jt6wdzayuZtPn8uDL9SnHK8m8dzKY5tHzVC/fCV5DCM+EkD5goTpRUJbeo9K4doJG
         CrUSOVMlJH7Ly5ETvth58l8RUWrrMxmYUrZo/UQquP+8u4eadset80XLUf0ZY753UZGy
         S1pXkWkq1MQNfriK/MaUFyy0OAVdxOESbKCFAadfhOyhgu1CtTVOTLuZmLoQ2LrU11aG
         1CEw==
X-Gm-Message-State: APjAAAWDTJQLdoKoQ6rNSgEIBqJ+EsIZAMk12v/o7fUpVWUcOsbdPKB8
        s2w+s//OtdpiwTq3ahRglZFelQ==
X-Google-Smtp-Source: APXvYqzlkOHFuDDXRvtAu9G8KWlcDGrLqm93CxayT4rZvt2Crs1lpG0nDwqCsHCl0mO5f5ncVF6fNA==
X-Received: by 2002:a05:600c:224d:: with SMTP id a13mr61076680wmm.62.1564493904725;
        Tue, 30 Jul 2019 06:38:24 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n12sm67726828wmc.24.2019.07.30.06.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 06:38:23 -0700 (PDT)
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: Refuse DDC/CI transfers on the
 internal I2C controller
To:     Sean Paul <sean@poorly.run>, Matthias Kaehlcke <mka@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Adam Jackson <ajax@redhat.com>
References: <20190722181945.244395-1-mka@chromium.org>
 <20190722202426.GL104440@art_vandelay> <20190722210207.GZ250418@google.com>
 <20190725174927.GN104440@art_vandelay>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ea3219fd-b8eb-279b-aa08-c77705a31249@baylibre.com>
Date:   Tue, 30 Jul 2019 15:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725174927.GN104440@art_vandelay>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 25/07/2019 19:49, Sean Paul wrote:
> On Mon, Jul 22, 2019 at 02:02:07PM -0700, Matthias Kaehlcke wrote:
>> On Mon, Jul 22, 2019 at 04:24:26PM -0400, Sean Paul wrote:
>>> On Mon, Jul 22, 2019 at 11:19:45AM -0700, Matthias Kaehlcke wrote:
>>>> The DDC/CI protocol involves sending a multi-byte request to the
>>>> display via I2C, which is typically followed by a multi-byte
>>>> response. The internal I2C controller only allows single byte
>>>> reads/writes or reads of 8 sequential bytes, hence DDC/CI is not
>>>> supported when the internal I2C controller is used. The I2C
>>>
>>> This is very likely a stupid question, but I didn't see an answer for it, so
>>> I'll just ask :)
>>>
>>> If the controller supports xfers of 8 bytes and 1 bytes, could you just split
>>> up any of these transactions into len/8+len%8 transactions?
>>
>> The controller interprets all transfers to be register accesses. It is
>> not possible to just send the sequence '0x0a 0x0b 0x0c' as three byte
>> transfers, the controller expects an address for each byte and
>> (supposedly) sends it over the wire, which typically isn't what you
>> want.
>>
>> Also the 8-byte reads only seem to be supported in certain
>> configurations ("when the DWC_HDMI_TX_20 parameter is enabled").
> 
> Thanks for the detailed answers (both you and Doug)!
> 
> This change looks good to me, but I'll leave it to a dw-hdmi expert to apply. So
> fwiw,

I'm not qualified as a dw-hdmi expert but until the internal i2c controller
is exposed as a "standard" i2c adapter (which is a valuable feature),
blacklisting a fixed address is wrong, and we should detect invalid/malformed
transactions instead that doesn't fit in the HW model OR really stop emulating
an i2c adapter.

Moving to drm_do_get_edid() would need to entirely rewrite or refactor communication
code to handle the SCDC transactions, since they use an i2c adapter...

Neil

> 
> Reviewed-by: Sean Paul <sean@poorly.run>
> 
> 
>>
>>>> transfers complete without errors, however the data in the response
>>>> is garbage. Abort transfers to/from slave address 0x37 (DDC) with
>>>> -EOPNOTSUPP, to make it evident that the communication is failing.
>>>>
>>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>>> ---
>>>> Changes in v2:
>>>> - changed DDC_I2C_ADDR to DDC_CI_ADDR
>>>> ---
>>>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> index 045b1b13fd0e..28933629f3c7 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -35,6 +35,7 @@
>>>>  
>>>>  #include <media/cec-notifier.h>
>>>>  
>>>> +#define DDC_CI_ADDR		0x37
>>>>  #define DDC_SEGMENT_ADDR	0x30
>>>>  
>>>>  #define HDMI_EDID_LEN		512
>>>> @@ -322,6 +323,13 @@ static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
>>>>  	u8 addr = msgs[0].addr;
>>>>  	int i, ret = 0;
>>>>  
>>>> +	if (addr == DDC_CI_ADDR)
>>>> +		/*
>>>> +		 * The internal I2C controller does not support the multi-byte
>>>> +		 * read and write operations needed for DDC/CI.
>>>> +		 */
>>>> +		return -EOPNOTSUPP;
>>>> +
>>>>  	dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
>>>>  
>>>>  	for (i = 0; i < num; i++) {
>>>
> 

