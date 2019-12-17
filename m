Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B27C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF74D206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsj7ZKlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfLQNKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:10:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35671 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfLQNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:10:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id 15so6945909lfr.2;
        Tue, 17 Dec 2019 05:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jk39L8RgpYiTrld7dSlOIM7xyFzKKS6lSCI/KcHWZk=;
        b=Gsj7ZKltUMuYF0Ggx/KiJ1fsaIQaYjAxnQgADAj5o13RV0RaBOUb5mOBd6isWfIGEq
         oHKz5YCSfrd7GIDR/8B8bGv4Gb6Qu1U8BqLG7zhh723dz9A94DSNakk/TfT2mO7wFBoX
         kDe/afzHPqFNsYpGdfcEM2Aj2zsygDnUo6UjomhX58VDd9/Nabb7cr9NJ7cMNVSp4Cl/
         veUa5Lxf/UTw8d49VAWnS18pfOyXh2QbTCwU79NywB30U2m0AkZV/h4S+wZPIxAYEqmU
         ofzoIsSx74pG5d3Fxot++GzF1gDArbVNTVl3hledBXRoWw0R1YXIFdp5cvP9n/04qFCs
         dydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jk39L8RgpYiTrld7dSlOIM7xyFzKKS6lSCI/KcHWZk=;
        b=OC1aOKFApnoQ63jNUZMkNrss8PuoRgzg0qb3vzSSSOLe4V8H9WCithXMoZPZzTtRBA
         SVndPlsNt9gihcOah4pJlGgh1EGnFr+yN3ifaZmL99BHIewZpAdwanmaZQaGuv3Rl9aq
         mv6QdK7sdCkqaQ7IzYrkLKtFQyQzkAP1W7UYqFDgN2vF1hWO+U9hpxPgnmPXXXHViuhW
         N3jSlzD9Uk/sHj6V3en3YXlKEmN4YTKArZpVOYvHa3GdywSj5+vRj/N8JhAzjDi4A5rx
         XAMGauyDV/4rVtRruPluEAZohGeUqzU2t4yzDO7AbSTnIdvDEk5qvdyTW1mZfHioZZ1X
         oH3g==
X-Gm-Message-State: APjAAAW2XJqWx7nYTu7D2Q8PxDHp/iYdjt9lEEaFoQzrpmUXZYXUft+a
        EE7MJsvvRiSmiAlRx8UZ/zbZ2Akm
X-Google-Smtp-Source: APXvYqx0SUti1aF3Yq6Y7m+qSFkDDVrvqKoaKj+P6rWZ8vzlLHdRnKn5vmD5Wa9Ke3xg8KQ5QC53mQ==
X-Received: by 2002:ac2:455c:: with SMTP id j28mr2806295lfm.184.1576588230944;
        Tue, 17 Dec 2019 05:10:30 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q14sm12539756ljm.68.2019.12.17.05.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 05:10:30 -0800 (PST)
Subject: Re: [PATCH v1 2/2] dt-bindings: net: broadcom-bluetooth: Document
 BCM4329 support
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191215185253.14024-1-digetx@gmail.com>
 <20191215185253.14024-2-digetx@gmail.com>
 <E971B7A3-B5F2-4F21-B0F4-B7D289080D9A@holtmann.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e59a6d98-eef0-3473-add3-ac6b2fae02a8@gmail.com>
Date:   Tue, 17 Dec 2019 16:10:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <E971B7A3-B5F2-4F21-B0F4-B7D289080D9A@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 10:40, Marcel Holtmann пишет:
> Hi Dmitry,
> 
>> The BCM4329 is a 802.11 a/b/g/n WiFi + Bluetooth 2.1 chip which is found
>> in Azurewave AW-NH611 WiFi+BT module.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>> Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
>> 1 file changed, 1 insertion(+)
> 
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

Thank you very much!
