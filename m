Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39DDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97192070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 20:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ16VgBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFDUdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 16:33:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39638 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 16:33:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so11021812pgc.6;
        Tue, 04 Jun 2019 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hXC/2/MzxNes+DPxbYu8rbPijB+wJo91rnKEeiN64qk=;
        b=jZ16VgBpozscYLlEYideku+hB2+dcvvqT6XGssHSIMyc59YrL5efsBqsG9o/QEkvhX
         mtqzboXa6Z3zBHMrXPZqyemXpN2lvS7+OKt0gXtDZ/c3VlwH4x0CrvjNrdoPPmX9RZqS
         cIH/JTbRmemcxAfKkBAkcr0aC2a2JJQBNuTWi50YT5CrPb49N7ywI5nmxNYXCSw8f1CU
         2jy1EPsM+EiFqGeB/WPnBAbxpfjb7N7jjNfnOQ+WhitHU3kH+S1sycBqD4kggB4GM4rO
         jE/xU32dSVzvJhZHxeP6N+8H1YbP04ADvoagpyeZNf0NqZMO61GgG1iL6c0JDTcDwf/+
         JRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hXC/2/MzxNes+DPxbYu8rbPijB+wJo91rnKEeiN64qk=;
        b=QOdBmPItKLZPRqquw1MCiJAvSqfE6Z/rGIo7a1VKlMM+AJqeMjzGGkmmPOoX8M8T6r
         6rhSSwzrOPp8fq5705ea1lMzWnz/yiVKRacGB67bLlHeVot7RTjNLWDk25W1shFJcERF
         JIzRKHqWRIR/0JVQC60aXDLwmlm0N+WoQ5FWkkmYjrGp7WmWNJZ3nxxalxEq/Wds39bK
         CyicFg1twNPriUWEGCBMjIhHEE2fbJITsSlZ/70oc8vHl/RSOKQD9E47nNgO6k+gVPlH
         rwW4o3JLuWe75V8FTvkXXQAyTYv4n8pP7/Q+rkdi743dAXvLgKhWsRLa1mId/67sFs9u
         ze0g==
X-Gm-Message-State: APjAAAUV1ACKbAg21n/6weGaq5mnAjoNw20wBkQzeGdFk4/0NzoWYe8M
        7MidmUlLMPB79/sxzrWgkjoZwhh1
X-Google-Smtp-Source: APXvYqxaRIpajJebtbtLZuYPKStcI0FB7V8SRd7LI07Zm7jwcSGFPcTThJ8EMI7zM1D+TPoryWNngw==
X-Received: by 2002:a17:90a:9f90:: with SMTP id o16mr40136106pjp.72.1559680431122;
        Tue, 04 Jun 2019 13:33:51 -0700 (PDT)
Received: from [192.168.1.3] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.gmail.com with ESMTPSA id m6sm20717993pgr.18.2019.06.04.13.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 13:33:50 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 05/17] net: dsa: sja1105: Reverse TPID and
 TPID2
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net, richardcochran@gmail.com,
        john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190604170756.14338-1-olteanv@gmail.com>
 <20190604170756.14338-6-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <d063b199-f807-330b-90ff-46240221bf30@gmail.com>
Date:   Tue, 4 Jun 2019 13:33:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604170756.14338-6-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/2019 10:07 AM, Vladimir Oltean wrote:
> From reading the P/Q/R/S user manual, it appears that TPID is used by
> the switch for detecting S-tags and TPID2 for C-tags.  Their meaning is
> not clear from the E/T manual.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>


Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
