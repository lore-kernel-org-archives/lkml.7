Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE1DC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320FB21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 00:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG9uHqY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbfICAhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 20:37:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33224 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfICAhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 20:37:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id n190so8144624pgn.0;
        Mon, 02 Sep 2019 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HYKhqZZp7jnIMlp6HX/xKA8CzksLvNCX8Kw12YKrVSI=;
        b=GG9uHqY6EzKTp+NmNFXol0x0Yo8b//eg5hirJUjGZbF8Ewi6n3Aqv7g5Qrs0WqwQzn
         sYwtAwbs8OtQOgUAVDuGRTUtGcLmQMWv4Ut+WcNtxSx4RwlMr+vCoe9uD0ie205jaN8F
         PfebOKtzphUwJgdQ382wOh2cZLBWxdCmOIP2WpEXo8+gsu09D1A6XomasjFchYmx1nOI
         XegTHmoC3NxSSC86A053v0JJS56nqb055YMqKnvesE4JSl8QbDQ8Wp1YMn7OM3UVs1IG
         XUQ/9dOwqVpsSPRIfP77FZdjdz4Yy+YHRU3taDM1pNNGowqahRwQCqlNw3zObX2COMrO
         E21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HYKhqZZp7jnIMlp6HX/xKA8CzksLvNCX8Kw12YKrVSI=;
        b=DBtBTIBzT7Tgl8gWDmNQWYQah3QZwKf+NgdC5IkOlk4YKLq3km33CIhk7oB+oLzLoJ
         HMyyHMNLRVreXWlgxumd8r42gUvASivdtfWhbtebhLY8dM3aoN6F4yXs9SUQUzDib1ci
         T698Qx2ORrDdH4TPbEnvCeEWrz9KWuI2Mf4T/uFOGliAzeg+/xorNuhEM4zBPqGhKBJ3
         agxEWvym/Dxosb+f1EtuwXjGPh+tHsbZK09XcxaZFIZ58tLrq1iSrZ/oZ9AMZptmZQS1
         /8rET0pf7CuBH6EkHbygs1pRq9+sac6RPWo4sEWGkRC+FKZthNSDUKs6qTKF/aQ2H6pq
         QfcA==
X-Gm-Message-State: APjAAAWiV0OP00WgCHuSK2OJVUlCRxYuWLNW92Ans5C2f2U6iNaEhaGJ
        il+Zapi7eMEdTEP55IhF5uUzpMLY
X-Google-Smtp-Source: APXvYqyaxD5JaG3LjjtT0YzYZcEzB/up1o1Kca6y0BH2nffXoIjkDxft6i8APuQY3uZc8Dx2gSgPwg==
X-Received: by 2002:a65:4c4d:: with SMTP id l13mr27017264pgr.156.1567471037707;
        Mon, 02 Sep 2019 17:37:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm15825681pff.35.2019.09.02.17.37.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 17:37:17 -0700 (PDT)
Subject: Re: [PATCH RESEND v2 1/6] dt-bindings: watchdog: Add YAML schemas for
 the generic watchdog bindings
To:     Maxime Ripard <mripard@kernel.org>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20190821143835.7294-1-mripard@kernel.org>
 <20190830164811.GA7911@roeck-us.net> <20190902114650.w65ya7mgfsyu275x@flea>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a7c5892b-4fd5-9b24-fdd6-f3aa1e6c98e7@roeck-us.net>
Date:   Mon, 2 Sep 2019 17:37:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902114650.w65ya7mgfsyu275x@flea>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/19 4:46 AM, Maxime Ripard wrote:
> Hi Guenther,
> 
> On Fri, Aug 30, 2019 at 09:48:11AM -0700, Guenter Roeck wrote:
>> On Wed, Aug 21, 2019 at 04:38:30PM +0200, Maxime Ripard wrote:
>>> From: Maxime Ripard <maxime.ripard@bootlin.com>
>>>
>>> The watchdogs have a bunch of generic properties that are needed in a
>>> device tree. Add a YAML schemas for those.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for reviewing this, which tree should this go through? Yours or Rob's?
> 
I added the watchdog patches to my watchdog-next tree, where Wim
usually pick them up. I would be ok with Rob picking them up too
if he wants to.

Guenter
