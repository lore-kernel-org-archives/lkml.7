Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6629AC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AABE24677
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="BE6ht680"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFJIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 04:08:13 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfLFJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 04:08:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so6910830wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 01:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=IC0nFJQovPdziVzgU2aFSV4eEeO6kPT3TlMkyeyMjTY=;
        b=BE6ht680FK89WSCevAr+hDyb8eiiRaSME+dcBCpdAfBPuoSvfGpOOy8GTvuMkQot8K
         qbPX0nc8xReBu8fQo1uAJ01WyJ7Sn+MJ9qlNLfdJe8VJhQmETJmZdvFuzekZk9T7jguD
         1wtEIImojrv6poPBjtrkJo6rqpqlfzJvFsaSLoa1I1SE7pFzYslfnB3cMJOziys4d7el
         P4GqzCVIPomt19lNJy0tt9k1AqiKL1RuJDu1Ls0BqcStkQMOoTl1bGN9sPT+wIEfn0iH
         0Wu7B5mhZZLC913K2lXnVFrcQROMYMdKVoQE0mte0Z2XkYXYPIM+nt/wF8YE/9BR7QC0
         rSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=IC0nFJQovPdziVzgU2aFSV4eEeO6kPT3TlMkyeyMjTY=;
        b=tDqfU3/JJze5JlP3lBgy6YEOM/TmhkGGEeAfTQyD4OdB9Hxtivd4XDflwaoSyrBWaN
         jEM659NHVSPMsgcaTghUa5smovkRTVYWOVRvUlKL/0lqUKlpSpDjNObEjn9M7NmJadDC
         km7JAB51HR03lVInb62unuiUJmJnzKKyT5iSn51cKJ4bSe1s7OAsdMaAJIBX6gna5BDk
         PtgwkGEj1it/D5ncv71wdBM2y4qSvIoKGLpsH7b67V53iMp0vhiKi0xMAt/N7EC3QkS+
         EwpaKken4zUtnUMzfCN1LCkCaEXifk3/nnOAOuBn3PqHdZ6w1OPw/Zw4jwg5Dwdar8h9
         vFXg==
X-Gm-Message-State: APjAAAXUiDuWzpvm2PrGt1VFZCKdCFQ6TUzsTg9TBxcmYVUA1vc/ptyP
        IprLd4F8SPyEFDKfiYIbZSQx9/pmP5dyJQ==
X-Google-Smtp-Source: APXvYqxAwUOIdiopWUwCUwN0Qp3EG6FDEluwivT/IAoznBn8WYyf9gk/0j9zA4KkkFZDgCe44j+tSw==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr14998118wrm.13.1575623290069;
        Fri, 06 Dec 2019 01:08:10 -0800 (PST)
Received: from [10.1.4.98] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g25sm4662913wmh.3.2019.12.06.01.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 01:08:09 -0800 (PST)
Subject: Re: [PATCH v2] bluetooth: hci_bcm: enable IRQ capability from node
To:     Kevin Hilman <khilman@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20191204161239.16653-1-glaroque@baylibre.com>
 <7hv9qu2rt1.fsf@baylibre.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <6f6cbb0d-3265-8e6d-60fb-6df2539d36af@baylibre.com>
Date:   Fri, 6 Dec 2019 10:08:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <7hv9qu2rt1.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kevin,


On 12/6/19 1:58 AM, Kevin Hilman wrote:
> Guillaume La Roque <glaroque@baylibre.com> writes:
>
>> Actually IRQ can be found from GPIO but all platorms don't support
> nit: s/platorms/platforms/
will fix in v3
>> gpiod_to_irq, it's the case on amlogic chip.
>> so to have possibility to use interrupt mode we need to add interrupts
>> field in node and support it in driver.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>> sorry for noise,
>>
>> v2 is for rebasing on master branch
>>
>> guillaume
>>
>>  drivers/bluetooth/hci_bcm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index f8f5c593a05c..9f52d57c56de 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>  {
>>  	struct bcm_device *bcmdev;
>>  	const struct bcm_device_data *data;
>> +	struct platform_device *pdev;
>>  	int err;
>>  
>>  	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
>> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>  #endif
>>  	bcmdev->serdev_hu.serdev = serdev;
>>  	serdev_device_set_drvdata(serdev, bcmdev);
>> +	pdev = to_platform_device(bcmdev->dev);
>> +	bcmdev->irq = platform_get_irq(pdev, 0);
> I don't know this driver well enough to be sure, but don't you need some
> error checking here?
>
> If this fails (on platforms with no IRQ defined), is an error code in
> bcmdev->irq going to affect later code that tries to setup IRQs?

not needed to do something here because  bcm_get_resources function check irq <=0 if yes it check if host-wakeup gpio was defined in node and try a gpiod_to_irq.

at the end in bcm_request_irq function i check if irq <=0 if yes return EOPNOTSUPP


> Kevin
>

Guillaume

