Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95596C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CD21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 02:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmNW4xBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfDJCJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 22:09:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33890 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJCJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 22:09:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so543877pgq.1;
        Tue, 09 Apr 2019 19:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0UccuvA1Euxec4cc09BWLLE5hZIV1qg3gm753hmhrhk=;
        b=fmNW4xBRClJmOpbnMy4T5vjfvmp/MLoc5te+0CDYgWkRzMtLZBDeQmqnQj00UljJz6
         uMq5PRE42R+TSk8/5658T0zot+FRUcX6zFbrOFZ8X8tOz970nQsIOYbzxalNUcZ/7tQg
         dd+EAZ4yUMk8r1529r44sK1Mp81YCAA0jaFYPjk2OU1JatVkA/TtjetdI0pWL7mXgHbo
         ZF6jza67hYkMqe2WmHX3oEZ2IGQpm1eCgEX4QpSuoWC0KSuDLIjq2lOGEbpmXfvNgrKm
         /ReqDChTmKqhl/STsMXGsTSCDHgoNBMGJkl9AmHVtbZVdyKmCjeBO+AyViFumU0rKzt5
         edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0UccuvA1Euxec4cc09BWLLE5hZIV1qg3gm753hmhrhk=;
        b=DQrFdDF6sEoAw0XiNoGJRkvzbPikIJV3KgKKRTE8aQhvEulvs+TnJnwegJ8hp/0eVI
         O21kyytY+mYBWJSm6QeMjSRPtCOk1C5x98pG9ozxEmKaNlqdRITtDa9AHGkl4CnCcFNE
         bZ2BsYo2FC/3nGN2AMDPG6bEnSQ0dS8Dg2nq01WRj91D5SXkzE8VQYaCMFuMMkAzk7fA
         I3Fh4lNRJq1B8FwElQUITLD4jYAPY5v0vgYhB4AELn+7GsXGVCsRbOv455c2FiRrUw3s
         JXMJxDAyydWCm5xKEwQn2qiJPCY7Zmyl3ohQQhak0SiuD59VPO+LIVh2MCgMVttVl3Vj
         xVTQ==
X-Gm-Message-State: APjAAAWVgCzn6i/MLXf1XygpAf9IyeUpsBv9k+8YKHnGejFtC2/WPp3F
        43mrt95CQ2sOFRz4gYj1iocgKW38
X-Google-Smtp-Source: APXvYqzO7kyhsFmEYrpFGeKZiYZQkvMxNzqnpaSrfvlKjvGg3WJZSYOgtK/6zEck2SSWlCZSBR3J3w==
X-Received: by 2002:a62:e816:: with SMTP id c22mr40669187pfi.54.1554862170956;
        Tue, 09 Apr 2019 19:09:30 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id b2sm41466674pfo.150.2019.04.09.19.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 19:09:30 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 20/22] net: dsa: sja1105: Reject unsupported
 link modes for AN
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-21-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <cb0245b2-38c7-b00c-91f0-0d159b0bc46d@gmail.com>
Date:   Tue, 9 Apr 2019 19:09:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-21-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> Ethernet flow control:
> 
> The switch MAC does not consume, nor does it emit pause frames. It
> simply forwards them as any other Ethernet frame (and since the DMAC is,
> per IEEE spec, 01-80-C2-00-00-01, it means they are filtered as
> link-local traffic and forwarded to the CPU, which can't do anything
> useful with them).
> 
> Duplex:
> 
> There is no duplex setting in the SJA1105 MAC. It is known to forward
> traffic at line rate on the same port in both directions. Therefore it
> must be that it only supports full duplex.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
