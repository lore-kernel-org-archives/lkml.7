Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DA0C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC4F217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xa+Fjufb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfEUL0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 07:26:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 07:26:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so18114424wrq.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGys3Iol5dLtdbxkyfPp6BlafjDFlyvcTnF3At5Y2mY=;
        b=xa+Fjufbb1lWW90PQCIg5/2U9zdLS45WWo284k/724/94OQArbEEdhI/a5ceLz5BqQ
         HDJxwMdbf9ZqeaCxJr4pSLAdMLyyGogqX9KXyrPMQcznwEaOzNvZ5HGhNMgRoCPUgCr3
         Di9zgN6DxWACkL3qM55JjMKXdPnxBjt0hHo3iFfupTGIC84YrZNvrorSSol8pCumbxfm
         Ix8Ry0dJi87fXjYcZWVfk397WxTeISlVtOirazL2iLflcXfQ4gMDA4TRw+EizoNnwIS2
         JdGGoDXwcpPOxIgiefi0BgUhoI+jQVf6XANV3wPxfj96YHNXPmGb5DfQIiwtQ2gHOxCP
         YxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGys3Iol5dLtdbxkyfPp6BlafjDFlyvcTnF3At5Y2mY=;
        b=MNdUg66/TCzBFwVqMvnX1aOh82fZDCm1MlZegDT5sgvwAQfIuYNFzfbzCwhmqoW6/n
         xBVTqBTPJXQKRASo1CfjmJaPfGsWvsnk5luW/Cv2Bv7ZWS+k1GQlNuFic1POmQwlPomE
         v/sv/dkCzsmTU8adjgSg6T80HYE9ZCmVv/3oHZ/P4sVfd22uWFOYnyqDbuLORzcGbBcs
         9fD14qHOAsuSIbr7xSWAHWzCjdfl8MB1LTru+VSUiCdfKaqAAD+bUGrsLM4fRV2JTuCy
         mrZEC2CCVDsLoIQ3yEX+DjhWzGrzvWjIOOZ6oftbAgM99ZzsAlBtnSg7cokXszVN6JLP
         lJrA==
X-Gm-Message-State: APjAAAWyGDB9IjLC0QcFevJ3z5LUPsezkABlAaKTB2p0dLNwRxQVIF85
        +OUgHbzGBNjxUe6gm2kICTmDlg==
X-Google-Smtp-Source: APXvYqy2jCv/tcKI8+hfC11XMcNd1yvILVIneSyvMJ+o/81tlqCa0r3Pmi7nB08kvuSCuvJysQ6YWA==
X-Received: by 2002:adf:f34e:: with SMTP id e14mr30178782wrp.215.1558438010594;
        Tue, 21 May 2019 04:26:50 -0700 (PDT)
Received: from [192.168.0.31] (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id b10sm49421373wrh.59.2019.05.21.04.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 04:26:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] dt-bindings: soc: amlogic: canvas: document
 support for Meson8/8b/8m2
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190520194353.24445-1-martin.blumenstingl@googlemail.com>
 <20190520194353.24445-2-martin.blumenstingl@googlemail.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Message-ID: <5b2d9cf4-aaaf-706e-3a0a-96cd3c003e52@baylibre.com>
Date:   Tue, 21 May 2019 13:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520194353.24445-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/05/2019 21:43, Martin Blumenstingl wrote:
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Maxime Jourdan <mjourdan@baylibre.com>
