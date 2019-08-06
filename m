Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8A220818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q9Vdg1/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfHFKFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:05:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbfHFKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:05:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so87277161wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 03:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tD7GBCktkRgBqSQK/rnS2OSCtvZ6JKSYqsfzwb/RV0U=;
        b=Q9Vdg1/Jnn+2hpisJUNHKj55kXITbJizFqEZLvdMMifAbvLijjhKdZQzcOk6rg6biF
         vj2QpQFdH18o+gwKuevO6r0gIsS+yxD62YTeaRc/3nHak9+XXS1CA5ALumdCYdxy22EK
         UnvoqcHTjoGd7ZXmggbXcwgHvjuQ9V8xkXxudLD4ziqrVEedqBF4Z+i3JAFIiCfOiUkn
         RKpt80kpVNZmecHICto/0TMEM2PcMWsI0x8kBIqoNwwbuDDBceiVzQfzbqpGuiDPnCwr
         18MmYTojJ43cey8QcAc66hgdhGIwx0wa0onmlR8fQDlAtTWosIOiwAhVfisoIEgm/FMk
         dgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tD7GBCktkRgBqSQK/rnS2OSCtvZ6JKSYqsfzwb/RV0U=;
        b=rI9rlE1gtlCzLoEzUPB9E/qxuDhodKHvkXAUR7xZt+dZny8ENk1miM2ba7uE0JRNdi
         APnNFKba2ikVTEi6RyLgP9pI6AbFXtZpmGjEEvsY2k9+o2LGzc+sMl6lkS3tWz8JEJpK
         Mh98xUotjdT82C5SFZeu2wfKrdwFStHu00oaxjkyMytQQkagWlBTTOEGcskJf0ONUlH4
         O12pkQizuHj6yPb4tgHGj0COh5jzk1p2lRvp55oZQtj7YS6RqgSo8SG2+VZaOQmk2S+T
         2DClt3JJ/A5zyncHucQKyk/QXyhszc6RLRx08vRN/M2NFuN/kuT3bGsSe2O8czKsxsMp
         ckRQ==
X-Gm-Message-State: APjAAAUsSvWS9SSiMXN4Bi61sevLf93NsXGLTYw81BOb8WnwP0rRUeYm
        pmyaJJT6GtcxKj3Um8ar/Z6amLRFz8w=
X-Google-Smtp-Source: APXvYqzpWHfNm5EbCjNGJ6Vw8NSHmw5758vwwbCj5bXSgXTRGDeyMkz1GMDHlz7qeloNb+yN0JqX6Q==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr3611414wrw.73.1565085947506;
        Tue, 06 Aug 2019 03:05:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id i24sm3303100wrc.45.2019.08.06.03.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:05:47 -0700 (PDT)
Subject: Re: [PATCH 0/2] nvmem: imx-ocotp: allow reads with arbitrary size and
 offset
To:     Jose Diaz de Grenu <Jose.DiazdeGrenu@digi.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <771a6f0a-3cc2-da20-2439-9a91dd2bf9d2@linaro.org>
Date:   Tue, 6 Aug 2019 11:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/2019 16:32, Jose Diaz de Grenu wrote:
> Currently the imx-ocotp driver does only allow reading complete OTP words
> correcty aligned.
> 
> Usually OTP memory is limited, so the fields are stored using as few bits as
> possible. This means that a given value rarely uses 32 bits and happens to be
> aligned.
> 
> Even though the NVMEM API offers a way to define offset and size of each cell
> (at bit level) this is not currently usable iwth the imx-ocotp driver, which
> forces consumers to read complete words and then hardcode the necessary
> shifting and masking in the driver code.
> 
> As an example take the nvmem consumer imx_thermal.c, which reads nvmem cells
> as uint32_t words:
> 
> 	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
> 	if (ret)
> 		return ret;
> 
> 	ret = imx_init_calib(pdev, val);
> 	if (ret)
> 		return ret;
> 
> 	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
> 	if (ret)
> 		return ret;
> 	imx_init_temp_grade(pdev, val);
> 	
> but needs to later adjust the values in code:
> 
> 	// Inside imx_init_calib()
> 	data->c1 = (ocotp_ana1 >> 9) & 0x1ff;
> 
> 	// Inside imx_init_temp_grade()
> 	switch ((ocotp_mem0 >> 6) & 0x3) {
> 	
> This patch adjusts the driver so that reads can be requested using any size
> and offset. Then, for example the nvmem cell "calib" could use the 'bits'
> property to specify size and offset in bits, removing the need to mask and
> shift in the driver code.
> 
> This is specially useful when several drivers use the same nvmem cell and when
> the specific size and offset of a OTP value depends on a hardware version.
> 
> Jose Diaz de Grenu (2):
>    nvmem: imx-ocotp: use constant for write restriction
>    nvmem: imx-ocotp: allow reads with arbitrary size and offset
> 
>   drivers/nvmem/imx-ocotp.c | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)

Anyone form IMX can test this patchset before I push this out?

Thanks,
srini
> 
