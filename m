Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9142CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B43820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN8NolD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfDPX7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:59:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45478 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPX7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:59:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id y84so18522803oia.12;
        Tue, 16 Apr 2019 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j7Owsz6CzrQQSmqpVTgbIkhx2o0xLH6/WHgZsWHm3+0=;
        b=IN8NolD7e7ff94UzsL9QfiMBw7MSWUIos5VinYw4YaO0hm62w1DhfFntPRzjUwg+d/
         vlgcqghHbwXhlIAash/lCBEsrUfCM2RZHbW9NcUsw/eFr/bwFzE0kQUTh+gut6LfRsY+
         phEu/X1UPOar+E5HMXXMWJdN5lPvKA6UebSAWodujD7pMXT2uTzVAbZZHPzq5pb82Xma
         iStmsAaQvm3DJDSN7Epbe6+5GKnj7JtnX6Ra69SrieWTJYb9GOZ/3twZeEnyIfVVcfwD
         pcRqHGwFHHf3kEYDoLLyVIxZneplIsjs1pcBAOymCtHRuRg4J+D/zGVguNa5CFRCQSRC
         xszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7Owsz6CzrQQSmqpVTgbIkhx2o0xLH6/WHgZsWHm3+0=;
        b=akjWuJCWYN5467JwaXlyPZuordJbYc1Q+wYyWGUSa3JbPy5ijwuEah8cJvK41t/tHZ
         xrkbTkXzBC/cDXZPxBkoP7Pb30u9jiOT3gqjouK5Lvf+0GAoSf/zZ8tgO59JsWYIZz3U
         V4KHiuT5fjIoV7jDG1ag3FJ1KemNnbFCLMcyHeICLlv6QNRyDq7Hi4yCNd99cb94AjcR
         xOEPi56llbuIYZMeEKSd1gXZtQvS5nk38JBQI1QQW9/KGD9arVq8q4Lz6yKRvdIR9sXo
         A99MgoD7Y99dxAX2NgBnQBiBOSJ91AhtP/w2X83EWMJOz9ro13vNHP0IPSfXsgnXphv9
         ukvA==
X-Gm-Message-State: APjAAAVIroJCnpIPcTJ5ZFHANgjB6UYAi6+A1tqsc8fhe549TGxLx0iW
        ISVVkx0ZIVaZLt2o/AfAv0s=
X-Google-Smtp-Source: APXvYqxGElx3mE9jGLniAA4dAHBxgKViIZpGDyDdfzWUO/TnIOVUxp12YDWRZFHVu5+X7fnpI/3lZw==
X-Received: by 2002:aca:5010:: with SMTP id e16mr25266407oib.27.1555459183067;
        Tue, 16 Apr 2019 16:59:43 -0700 (PDT)
Received: from [192.168.1.2] (ip68-101-123-102.oc.oc.cox.net. [68.101.123.102])
        by smtp.googlemail.com with ESMTPSA id t35sm22640855otb.80.2019.04.16.16.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:59:42 -0700 (PDT)
Subject: Re: [PATCH v3 net-next 11/24] net: dsa: mt7530: Let DSA handle the
 unsetting of vlan_filtering
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190413012822.30931-1-olteanv@gmail.com>
 <20190413012822.30931-12-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3a387160-7bb8-3a43-d397-e3fc41bd57a9@gmail.com>
Date:   Tue, 16 Apr 2019 16:59:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190413012822.30931-12-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2019 18:28, Vladimir Oltean wrote:
> The driver, recognizing that the .port_vlan_filtering callback was never
> coming after the port left its parent bridge, decided to take that duty
> in its own hands. DSA now takes care of this condition, so fix that.
> 
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
