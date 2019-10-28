Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoLU5m9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfJ1Mpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:45:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37405 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJ1Mpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:45:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so9739564wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EjO3nRtZRcHpq4gF9qTCncUdsLaN7JBougyYjcKY6iQ=;
        b=ZoLU5m9GxdnwffSu0EW6y0pGEJD2St4BW1Or90pLKllhPiB4f1Di9B3e3e2mqGJjsq
         jsFx8WAxwcc9s/0IgrizLkXgBV5lcpT33SA8sFf2vGjv3kjC/qpC305pVj/XYl/YtpcI
         D6nlH9i0hwED/+2q7/04OYEVNE5pBpqM8rAZrlokoBQb1PeN69+gkewQ756V439YAp8r
         u37qbi4DkpziBHivr9HsgQ1VD9bcuK/oBIqFaia7N/bgibq5DGJDdqU/Tai48T7XcTVr
         OG7fyw4BHSSwOa1jfqymyccf2xA1Vq8/e+ECfuMMcK5s9tDdJjwk3JnJqopKM5cFSC4E
         VltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EjO3nRtZRcHpq4gF9qTCncUdsLaN7JBougyYjcKY6iQ=;
        b=psGsTO5wj5DUqGA4O/124SfUHbJVYeyjgZwdo3TXrxJX1Eov6n5RKvKUEh4sjw5XUf
         nM7/+9QIX4MoCVe+2ErnTS8nTSthjrMxBJ9BFP3E4d/nJLbbt/jpdcmeEra1ys7beSaB
         QHWE8hz8yMty5n3IVdFNivaBBAYybKhjFTlXnUYsQ2Ikm8IY5gwEMckIp3dZ2UxYnuzj
         eHJrPMON11BL1oi5QJJz/72XQG2p1uJxN6xCP28vrTevos8XPF+00QptllBBJQ/jHNuO
         rdrDqPStqS1VsGERztm5PHpu/ke/+5eXNdF0YIp6DMDI6vWCgGvU3iiIwYZwmB0vP/Ox
         EA0A==
X-Gm-Message-State: APjAAAXviB2AXzowmRrudwLflYPDb6Yi6VIu5D6qn0GFQ1rCwLTRQzTg
        cP4l6lpUxonKhJtUTZuRleqUNg==
X-Google-Smtp-Source: APXvYqx5GBghFKmvy0FXn9fEAyKJ8U0QQT5f2YmoThu0wU+QHGSds58+7CTsU7u+9MwQhikla46hCQ==
X-Received: by 2002:adf:8011:: with SMTP id 17mr15418613wrk.367.1572266743355;
        Mon, 28 Oct 2019 05:45:43 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d2sm16183996wmd.2.2019.10.28.05.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:45:42 -0700 (PDT)
Subject: Re: [PATCH v2 01/11] ASoC: dt-bindings: add dt bindings for
 WCD9340/WCD9341 audio codec
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     broonie@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-2-srinivas.kandagatla@linaro.org>
 <20191025204338.GA25892@bogus>
 <90b2d83b-f2b2-3a5d-4deb-589f4b48b208@linaro.org>
Message-ID: <371955d9-ad2d-5ddc-31b4-710729feae42@linaro.org>
Date:   Mon, 28 Oct 2019 12:45:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <90b2d83b-f2b2-3a5d-4deb-589f4b48b208@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2019 12:40, Srinivas Kandagatla wrote:
> Its Phandle.
> 
> something like this is okay?
> 
> slim-ifc-dev:
>    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Sorry this should not be an array, so something like this:

   slim-ifc-dev:
     description: SLIMBus Interface device phandle
     $ref: '/schemas/types.yaml#/definitions/phandle'


>    description: SLIMBus Interface device phandle
