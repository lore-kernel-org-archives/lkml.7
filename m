Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4896C21905
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjPjuL9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDJB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:57:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39874 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfDJB5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:57:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id k45so531721edb.6;
        Tue, 09 Apr 2019 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/4oSLi7P+fdzuEz8yEm6yC4qCoqNztla3aC5YWV4Rs=;
        b=hjPjuL9AnGKn00Un4/uVYT10ZUjNCpkqUxgnnEMjH5jdT9Aa3IwfF2WWwvevzUMuTK
         zpjYqFtlTBb36qMco+0BqYbX2YQNKJC9dKrUTmNU2Uyho/vIahUOgHmTrszrHMzHp8L0
         oZL/tImdRulKlxIRSZWHZ5keS2YhAKg1JZRLKl/4diqJIW0ZxxppOn/wtXmU8hyCn/+0
         J0LJ/0iB2D3H/tA0KfaydkL3zZDsP0ptksimxrXnOMB5ay6nPihmroKS0yeX3qZqw9aw
         9ms+/8lPWXHQk9LBnyksRlkDvYrni7lO0v0J0R6904KhG5b4lG8lvUuBXT+a7lxHUiJM
         II8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/4oSLi7P+fdzuEz8yEm6yC4qCoqNztla3aC5YWV4Rs=;
        b=o6k2Wtk+eUG53p5ZvJyVXs5JrN6mNVNgD3GUKbe8t5FSu9CmUyria7NnRv2BSfHq8V
         luSFObzSLihdNDHRQ1YTN87Z/JXQMfvlC5QRM/6ipWgN0Uq1OMDoI6tDcSbWIYTwy2yg
         5f6ht3CEwdCPizYvuPDilQqPn9rwRUgdiqCmWkGSh+UUKKTX2uJKJCx0Uf+MggOo/QAi
         1qC1OSnlgWx34cJ1eBnqq5JHlsA0QwLt9aHbLrnwqFfCCm4m9bzZ90jM+KnqSQP1vzAn
         c8vxqNfFaMbiZBDJNFpKM1jM7gbM8cvASOmcAgVNbWl2Bnwu3Ui2TJUDqUBghcPkXtmc
         +D8w==
X-Gm-Message-State: APjAAAWfcCRoxy5pq48QqyUcJuyg58K437MD6goSZETgz52RQ0cLRFfO
        vpXF3mvjXSpKu1WW3UijXuc=
X-Google-Smtp-Source: APXvYqxOVV0illSmRv4b3YRdpcF5hHicWXnmMFxbfRYGw/Lhj88N68zKUK1dquC/0YVFyfL0uXfmCQ==
X-Received: by 2002:a50:897b:: with SMTP id f56mr25936128edf.144.1554861438311;
        Tue, 09 Apr 2019 18:57:18 -0700 (PDT)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id lw14sm6289231ejb.24.2019.04.09.18.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 18:57:17 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 02/22] net: dsa: Fix pharse -> phase typo
To:     Vladimir Oltean <olteanv@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-3-olteanv@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <8031aa8a-5281-95f0-a9df-c829f9a565af@gmail.com>
Date:   Tue, 9 Apr 2019 18:57:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410005700.31582-3-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
