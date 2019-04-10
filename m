Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC66AC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9A21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgrS8y7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDJB57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:57:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46027 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJB56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:57:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id o26so502145edv.12;
        Tue, 09 Apr 2019 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1/6UAD0SSi15aPgBdvgJXUF/zbQSF6IzziyK/+Kj15I=;
        b=EgrS8y7+ZXzdnhDYpQK5tY0h4kFlvwCkPa7myzvZFf4/iZGjFXqEZPrlGyUWLmjDd8
         FDWm1hXtKmYELJgpcDzsTB04TPTc9ailDnA9MgU8xmvq4CnI2LPMDviJYGZbI6Nq9sLf
         RY0wB0FyiIPWCsBhzlMAr7qKmFXh7mbgoxiKFzMGUvhZFhUJkOIpiP/+94cZLJW3TA3I
         EEf2zmkoAKRiZemJ9/fnmq9+pP1V+UMS2BPODVF4a27hi7pGqMw8a2z0yPwIrJCtKgU8
         5vj/0hNLiox6DnIqseO3VUfloi21VfUtm8mRyDP1UOP9QczuzsyeI0dlbWbAuS/O7cL8
         oARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1/6UAD0SSi15aPgBdvgJXUF/zbQSF6IzziyK/+Kj15I=;
        b=fgvO+yltDsYzVR70nm0lVJSRGFCV0CelzuDkzD1vzA41C6T42r3gJgqAsd20/Ymeuu
         rkfHBpZ4kb9HCz65yae1zc7nBgo+r/+pslyWbMjMkVufG0DPaaQSLFpnTqztWyhqmTze
         ZqWw034Za8ky2/wOp3A+PIHXIzdNgEdf3G77W/xiiZEknmxgsKWRrCewJ2WnzwQC4Ll9
         UOiVfcnBTFXVzIndDJq6RImpvfQi1sa4wxtneICQWm8KhJQBdKy+Yfom23qYKAORd7E/
         8lZu2SLoQ92xAO7zG+viPmx4sy2V/ViTLgZHcPd9j+02OVgQQsyJNRs/RB7+Sa/Oa9iT
         hDCw==
X-Gm-Message-State: APjAAAX8ZuGlck08862107oKVYaK3VtDu9X/4wI86fsd/NB+itlTezVf
        qvtCjTA1f6Euj8AnzSUFJ3Ir3NYW
X-Google-Smtp-Source: APXvYqyPIZNbjD71DasGx178YMuEd+QxWNVMeNrSuSHadRhDGcrpgh4xHx0v6JZKM/Sm01zYluH4/Q==
X-Received: by 2002:a05:6402:607:: with SMTP id n7mr14512422edv.161.1554861476642;
        Tue, 09 Apr 2019 18:57:56 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id r16sm1627662edy.11.2019.04.09.18.57.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:57:56 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 04/22] net: dsa: mt7530: Use vlan_filtering
 property from dsa_port
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-5-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <c80bd309-ecf7-3be6-e8f8-06223b41a552@gmail.com>
Date:   Tue, 9 Apr 2019 18:57:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-5-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> This field was recently introduced, so keeping state inside the driver
> is no longer necessary.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
