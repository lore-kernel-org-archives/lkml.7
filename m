Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26ADC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778B20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qC64sf1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAIIwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:52:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51969 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgAIIwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:52:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so1938873wmd.1;
        Thu, 09 Jan 2020 00:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3UC+FyBaxdvKcy8S6MwxaGbPaUPYnnimn1+HUbTZZ1I=;
        b=qC64sf1xAlDktRkhCL5dnmg8OJ/xcLFfGXFkViGCkzMqD7YerY7tv7Fj/kwuLrA5r0
         LbHPdylWkUO1KBOqeNBpbmBzoKtMxlo8xybIqssvrvLwT/5OFap443Z/U9Q9j3DiSzFo
         9+aWnyTlLXvsgJvQ/jUsQCNfM3UyjqmcYUoiZ56zidYpQuFIF9a/QTUXjMa3C6UAFHXD
         VbhFznLTU7ktnO726IyRe2MFwVr1JZxDTq0Bt5Xpc3HH5/BZMIs9NH4ozwUc3rC99wIo
         4ukUk4X8gt7Ju1nDP1JpAGkWo9Yh+iipjqLJsxuytnRF+OuIm0Q7h/l0j64iRAmST1zW
         Wk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UC+FyBaxdvKcy8S6MwxaGbPaUPYnnimn1+HUbTZZ1I=;
        b=j066cgqNt/jfw54tqABDl9tC4K9a3Nd36YO9nFP47LhxOfxVfvXTdOWXpqXV5ipLey
         BluVBt+xwu1wWIDNHm2sfRtcQF8LND+eltxlwjn5K2qwAWYrjlUsaMSDN6C67x4zN2/4
         je7mmXQ+DBdIS89yHfZHYpTlvdow47Jl73YDahpQy/CzErBLo1HUd1wBJG0fxSW6Ns69
         ZcyiB0yEQAGKICJzV+CmMNeifQaiJm4XvIWKsebvqC5nevPCyCHH9ZXJgZaYoYOn+Z1i
         uhEuCu8vukmnY4UP4sydnUQXHaBmwWpQyLWVL+S86atjzQrDRGl10t4pLWUCJwrnz/w3
         u0Qw==
X-Gm-Message-State: APjAAAUF4oaBm74gKICT2EiQv+ZD3IMhJLb1hXCBtMHF79cifD/Bi9Ab
        I+O79U5l9rgRSb0Bxb42AE4=
X-Google-Smtp-Source: APXvYqzYXWh8VSyjzGZqoZsWgKwcqDzfcvDVzynWCy3+JIXEn4rpC9McK/lf7GDfkBNH1GAubm6PyA==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr3488669wmc.171.1578559955600;
        Thu, 09 Jan 2020 00:52:35 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id i5sm7422343wrv.34.2020.01.09.00.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 00:52:35 -0800 (PST)
Subject: Re: [PATCH] tty/serial: atmel: RS485 & ISO7816: wait for TXRDY before
 sending data
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Codrin.Ciubotariu@microchip.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, jslaby@suse.com
References: <20200107111656.26308-1-codrin.ciubotariu@microchip.com>
 <b11e47c3-8b94-7915-ae5a-d9e8f5b02047@gmail.com>
 <20200109073305.yn5y6sgomjniwwj6@pengutronix.de>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <0ea33918-2845-a750-faa7-fec729976136@gmail.com>
Date:   Thu, 9 Jan 2020 09:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200109073305.yn5y6sgomjniwwj6@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/01/2020 à 08:33, Uwe Kleine-König a écrit :
> Hello,
> 
> On Wed, Jan 08, 2020 at 02:45:05PM +0100, Richard Genoud wrote:
>> NB: MS exchange has added some =3D and =20 here and there, but git am
>> doesn't seems to be bothered by them.
> 
> Unless I missed something I cannot confirm. In mutt I don't see any =3D
> or =20.
It's strange indeed. I double check under thunderbird and directly on my
webmail (posteo.de), there're =3D lying around in the message source.
But not on the other patches from linux-serial.
weird...

> 
> Best regards
> Uwe
> 

