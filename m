Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A607C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F02084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ixlTkYu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfDBEmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:42:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37079 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDBEmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:42:42 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so1526733pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 21:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=vNybugLJ1syLLEj5KhGmwpf3GcnIHGr8LT9ikdK8UC0=;
        b=ixlTkYu54L05CWEPJNPWVwpVfX7wS1IYidw9SqN5NQccYgrrO4r98yG1D14bN5q4cX
         z+t6da4DXEG/V2wR/kSTdz4va6MuvJ+vd5E1DJN8VQqY8iDxIOwUhZir5kwCB91Xzbch
         KgyMQz2+w6FXNS32pCoefOgh81g1ZpBtmMBpXkqJOEPxbURAsFnROGuAXLdjbvxpsPpY
         rLQjPnjL40UZ22c7QgAha37L4dB6DY5CtL4hSmleQgmI0Gj+SG49GZDb6xteh8HzFd39
         V1/RrYN1555u72yFOtEALYfeHsjfAnq5a/Do7gtFWulQbPlQw9cqXutVYRQwYqOACu4y
         h/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vNybugLJ1syLLEj5KhGmwpf3GcnIHGr8LT9ikdK8UC0=;
        b=ZDwOlssxYrr2WEjKk2TDCKW0nzZYMjoXkJCY81WKzxGiA7DhF8/Y0BKuCHCVWPXzMj
         hRLYT3cyubEnM6DH5hyeAOeaJlceLIkZm0R53at3spX0xEgqM2fhhzApTqmNljiXjBuz
         INqpM9dEO7vt1l6keumBBxjF+5QfajNBNGAQdN22HRvg+QbXI0rOKh3NOZA53ti2tHNA
         kVEc2mPMJZeN+KFBFns1pcDdqzJ16ercb36yx5GlrEQ7Ry3ZdoptpgthouxsdOp7lLXS
         OlWULvTNddeH5S8RJF3Mp6/6L3FQQ/bKPuDTo3RbzKCwaAbTmpcN5mio3lUFtNl3vuQD
         c3ng==
X-Gm-Message-State: APjAAAXh8LmzgZu/nh+ndDLRIFS4GtnUknsPCkoIgy9kkVoAhUkQ8lRD
        +9FgA72AbP/wS4eBxOMR+6ibIg==
X-Google-Smtp-Source: APXvYqxVGbCb4xTICQnSMT55PM/u1hnp31xgbW5A6zIe070KJMy64ELVGGQ5yJOeYz+xw0rDsRH/QA==
X-Received: by 2002:aa7:8019:: with SMTP id j25mr67250575pfi.77.1554180161589;
        Mon, 01 Apr 2019 21:42:41 -0700 (PDT)
Received: from localhost (c-67-161-37-193.hsd1.ca.comcast.net. [67.161.37.193])
        by smtp.googlemail.com with ESMTPSA id u62sm21665696pfa.124.2019.04.01.21.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:42:40 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm64: meson-gxm: Add support for the Mali T820 GPU
In-Reply-To: <ed3ca736-0d2d-0a69-2e14-a9ed29f0cd13@baylibre.com>
References: <20190315135655.28359-1-narmstrong@baylibre.com> <ed3ca736-0d2d-0a69-2e14-a9ed29f0cd13@baylibre.com>
Date:   Mon, 01 Apr 2019 21:42:40 -0700
Message-ID: <7hbm1puif3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 15/03/2019 14:56, Neil Armstrong wrote:
>> This patchset adds :
>> - Optional reset properties in the midgard bindings
>> - Mali T820 Node in Amlogic Meson GXM DTSI
>> 
>> Changes since v1:
>> - Updated midgard DT wording following the recently submitted 
>>   bifrost bindings
>> 
>> Christian Hewitt (1):
>>   arm64: dts: meson-gxm: Add Mali-T820 node
>> 
>> Neil Armstrong (1):
>>   dt-bindings: gpu: mali-midgard: Add resets property
>> 
>>  .../bindings/gpu/arm,mali-midgard.txt         | 14 ++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 27 +++++++++++++++++++
>>  2 files changed, 41 insertions(+)
>> 
>
> Kevin, can you take both in your tree now the bindings are reviewed ?

Yes.

Queud for v5.2 (branch: v5.2/dt64)

Thanks,

Kevin



