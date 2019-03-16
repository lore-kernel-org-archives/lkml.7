Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E4021904
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QXZxU8pZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCPOhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:37:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38183 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfCPOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:37:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so8572569wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=EuF9ruvnrcAnzkL0pWYAzpDOU230eEZTjJbK/BXtXUk=;
        b=QXZxU8pZYTR4NWsf7RG2jW/n4SgIY84wlGcMM1NvqMkq3rPEAXXfKg1+xgK+M0CeLy
         k044m1yxWHLgbVV+0Lh/ZlJ5xmxde3MoZf7oyu/rPvza2FHIlv8uGTSpnddWgCvb69St
         0PHXiumshSJV9kOLS1zp6+oAwUbwLXK2vjCbmduclzSrukwc4r9rkHr1TDBsgl65Lxnf
         0CY9jcl0Nq7/CaXugdngDaUR5Wx2WnWLl1Uj/0wtnIrhYssUlpiFNSbVBM0m/tpEoPqY
         P4z0YASKIY6pt+m9rPWr5ra+JqAfk0U39wX7AsvpEg6nVDYQ80vw6FMEfIYVHTKu6BLV
         hkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=EuF9ruvnrcAnzkL0pWYAzpDOU230eEZTjJbK/BXtXUk=;
        b=KPGoQ03g938VbeMqWa+NeyLzzMM5ux6LCg/1pjd9unt067fvNW0HKwD5hkWhYQ0XFr
         X6EWQeFhFPYtr7DorrsfYf7S5qmqORhXQ8zteNmIX0B7n1bQ3fRCYx1Y7quoQPvBKj06
         86Jg1qDrJa/xxlCbBkMB04w0q8fPzREG5ml7/uUTOCen5BIIP1fUZd/0dx5YBqhCS/TO
         INaf8lxOPm39oflZhViGos6Qliw9JV2/ttLtTTKDXhSjFPFaEFAjSOJQtKYYA7HE9FjE
         sdh47frIgNbMlqommRmUGHg39IZhO8N7MWGAyiDHgQzvrc0t9XRjC8gy95A6Pi4v1kri
         EYMw==
X-Gm-Message-State: APjAAAUciI2Ri+4Ywl7D0Ek4Oj2/BXvGul+sSE7+2rfdH6dzue9KLXJu
        jdTrVMDhsteAXgbA8KzkvWvy4w==
X-Google-Smtp-Source: APXvYqx4QkRPRKkZURePfIsE9R9jSRgX7yl45mRAhYOgYdfA2LDG1rjh6NZxbXDKxKHprMbWDyZcAg==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr5529884wmd.26.1552747022144;
        Sat, 16 Mar 2019 07:37:02 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o1sm7974757wrj.20.2019.03.16.07.37.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Mar 2019 07:37:01 -0700 (PDT)
Message-ID: <5C8D0A0C.4040807@baylibre.com>
Date:   Sat, 16 Mar 2019 15:37:00 +0100
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/9] arm64: dts: meson: g12a: Add G12A USB nodes
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-9-narmstrong@baylibre.com> <CAFBinCBC8OcGRSdNTcqPzH6jbWiO1J_9+BcmZmpSJ+uVTjrHUw@mail.gmail.com>
In-Reply-To: <CAFBinCBC8OcGRSdNTcqPzH6jbWiO1J_9+BcmZmpSJ+uVTjrHUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/03/2019 22:40, Martin Blumenstingl a écrit :
> On Thu, Mar 7, 2019 at 4:15 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> This patch adds the nodes for the USB Complex found in the Amlogic
>> G12A SoC.
>>
>> It includes the :
>> - 2 USB2 PHYs
>> - 1 USB3 + PCIE Combo PHY
>> - the USB Glue with it's DWC2 and DWC3 sub-nodes
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>> +                               g-tx-fifo-size = <128 128 16 16 16>;
> I'm not sure about these values but it seems you have already successfully them.
> buildroot_openlinux_kernel_4.9_fbdev_20180706 uses the following
> values (which are identical to the ones on GXL/GXM, but using the
> values below I couldn't get dwc2 to work on GXL when I tried it last):
>   dev_tx_fifo_size[0] = 128;
>   dev_tx_fifo_size[1] = 128;
>   dev_tx_fifo_size[2] = 128;
>   dev_tx_fifo_size[3] = 16;
>   dev_tx_fifo_size[4] = 16;


Same for me, only <128 128 16 16 16> worked for me.

> 
> Thus I'm still giving my Reviewed-by based on the assumption that the
> g-tx-fifo-size values you have are working (at least for you)

Indeed, I tried the amlogic values without success, I suspect the driver they use
(the Sysnopsys out-of-tree driver) uses these values differently.

Thanks,
Neil

> 
> 
> Regards
> Martin
> 
