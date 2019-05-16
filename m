Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77987C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4170A20833
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hM1AiciC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfEPQjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:39:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40204 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfEPQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:39:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so4138468wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=+cXLOi+8ABA7BGrxU3vUXmn2m+alrWUU3E1Q8nvV1CE=;
        b=hM1AiciCPdeN92B0g/CQZQHRvJ35jT0diBinaBf8JPtnfPYksAWCu/5RKgq7PgfmZx
         A0lK3rieYyiPaXsN1hr5ouS1CTaR9lZfj/KIL2cwmfK+njxSHpH2jajyfqYIP71nPDnK
         7eNGxMWSXkMN85MQ0jrSHZVha2VbIObLJCZbTlxM2lGUOepAzu7LXIEKiESQyl37FEvQ
         +r7kbeVg9CaaRy6hM+ct3rpZAVCCXa/3F1+tWmjadHXkB2JizI9J6hIS8e9+t9eR/Bpc
         urW6QyTR8W0uHdIC0ZDcDQQb+tLK28zrJ2EdtkUYB8r67V/MZEhdNj2zYTjOF539aUL4
         BgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+cXLOi+8ABA7BGrxU3vUXmn2m+alrWUU3E1Q8nvV1CE=;
        b=lEX9XkmPhZ/ZLCc9BqDgCF6C1RXfl60SQfx9thK0JzIREc3hEyWkjZfsSkMYZqlswZ
         FalIswpllw0EwWhjXS3zVuR0Sm5JHOBIULBNZvtgPMK/AKHxobEe3kQOcIbYwhirVHjL
         YLf0jCKOj8dhNFqq8pD51WsYZE3XauEtdyZ/mLc++An20Yw/0m5PhMRia3w3GIyEuc+t
         vpUwSIZoV7qE0ww17cGrIkpKki33BCT9HXJCmOIQfHM6pkXgg3M7cLV2ivI794hXVRlq
         TYkj4GsRlYTzJSG1b9j6SMGlao9/mb6n/xJWUWNTOEiT2MQ9VT+kw3QlGUuWvL8sSG9p
         xlPg==
X-Gm-Message-State: APjAAAWoxkH0kn6t0I5WhuRQUOpiOHR1HcySFttD0IK+7dVqyyKd3Ab/
        yTBUWnaKqJfCd++GIzYlHJLHJw==
X-Google-Smtp-Source: APXvYqzujauFHDoLc/in9LTN+7HLQ5/SBKHCrzZMBpDZ3qyrEmaS3kuc9igghD1by4HMoa1ZJUNzQA==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr31799601wru.36.1558024771576;
        Thu, 16 May 2019 09:39:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:e504])
        by smtp.gmail.com with ESMTPSA id z14sm3818382wrq.22.2019.05.16.09.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:39:30 -0700 (PDT)
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] gnss: get serial speed from subdrivers
In-Reply-To: <20190508155341.GA1605@Red>
References: <1557322788-10403-1-git-send-email-lollivier@baylibre.com> <20190508155341.GA1605@Red>
Date:   Thu, 16 May 2019 18:39:24 +0200
Message-ID: <86y336l5fn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 May 2019 at 17:53, Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
>> -/*
>> - * FIXME: need to provide subdriver defaults or separate dt parsing from
>> - * allocation.
>> - */
>>  static int gnss_serial_parse_dt(struct serdev_device *serdev)
>>  {
>>  	struct gnss_serial *gserial = serdev_device_get_drvdata(serdev);
>>  	struct device_node *node = serdev->dev.of_node;
>> -	u32 speed = 4800;
>> +	uint speed;
>>  
>> -	of_property_read_u32(node, "current-speed", &speed);
>> +	of_property_read_u32(node, "default-speed", &speed);
>
> Hello
>
> of_property_read_u32 use u32, so no reason to use uint instead.
>
> Regards

Hello Corentin,

Thank you for your review. A v2 has been sent:
https://lore.kernel.org/lkml/1558024626-19395-1-git-send-email-lollivier@baylibre.com/

Cheers,
Loys
