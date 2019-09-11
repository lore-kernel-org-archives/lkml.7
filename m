Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD5C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098DE2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aXAgJOu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfIKQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:55:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfIKQzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:55:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so14044591pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QVzc7x0XOPlA1RrL6UcO+fm5NotNlH7iMncjCJBJnes=;
        b=aXAgJOu/93uoPfF7SbtKK/0ZWJ4poSZHbD00znLc5Os1xU5tX0K0Wu34dE7ri3SRTw
         eomrvo6N+T94gFjQIEXN3wz4vuN63LPFp9mxf5vnM6IRLArMhRmW3Iinut4buyqnQheg
         ZrEcYg+asrwu3ArbguAanYRECh4Zl0hbHt7A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QVzc7x0XOPlA1RrL6UcO+fm5NotNlH7iMncjCJBJnes=;
        b=Kdkb7QOqZM5pA3HUg0zQG7AlJxBL/PwA4ggyWJuE4tR4cWFPRn1UsHh+/QcDN422T8
         ffG8VcBfJfeO7r4Vx/NKHBPd8GT+l0RGnV4RMDkAqm3VZdz4jPRCGUzSjdgwyChXy/8a
         jmvIN5V8Ud/mG4IUfE3kQPx1RtH7eWLdWqHWPtFP4hGlpW7U4LAja+gqQifFiDy1vVbE
         GCKCNpHeTC4w5xcxR1+OSqJjqEVKgPygnxpacPiSKQlei+j3FAt+JllNVq0F5TYJ5wJl
         yZXoKzQbC5Jv5gMoWDv/uh0AD94CU7ywiEnOhtDWX/tswzSgJSEGgFZMQwjhSBeRGzaB
         mNtQ==
X-Gm-Message-State: APjAAAWU5rZmnFzthNcHlC4Ebm1ak5EXfTXwzXTwmnTkuQNX9tvurK3E
        viAz3/VJgBZeIYRenQbmkkxtAQ==
X-Google-Smtp-Source: APXvYqzOqZkMd0NdJa6DTPoVNOt6bO8UiPegUVSWBZC/GbY5p2H/PayFVRYRDsdxzmCTcwjU+N3WRA==
X-Received: by 2002:aa7:8b09:: with SMTP id f9mr38864255pfd.23.1568220946793;
        Wed, 11 Sep 2019 09:55:46 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z29sm35092888pff.23.2019.09.11.09.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:55:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] gpio: iproc-gpio: Fix incorrect pinconf
 configurations
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Jin <li.jin@broadcom.com>
References: <1567054348-19685-1-git-send-email-srinath.mannam@broadcom.com>
 <1567054348-19685-2-git-send-email-srinath.mannam@broadcom.com>
 <CACRpkdZe2btC-vjRq1rPaHA9pXUi8N_cZT-RQ5m=PxjmkASieA@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <535f7569-70d0-1a7c-e15d-b77301867629@broadcom.com>
Date:   Wed, 11 Sep 2019 09:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZe2btC-vjRq1rPaHA9pXUi8N_cZT-RQ5m=PxjmkASieA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/19 2:34 AM, Linus Walleij wrote:
> On Thu, Aug 29, 2019 at 5:52 AM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> 
>> From: Li Jin <li.jin@broadcom.com>
>>
>> Fix drive strength for AON/CRMU controller; fix pull-up/down setting
>> for CCM/CDRU controller.
>>
>> Fixes: 616043d58a89 ("pinctrl: Rename gpio driver from cygnus to iproc")
>> Signed-off-by: Li Jin <li.jin@broadcom.com>
> 
> No response from maintainers for two weeks, so patch applied.
> 

These patches were actually all internally reviewed by Broadcom 
maintainers before sending out to the mailing list.

Obviously you wouldn't know about that, :)

One of us should have explicitly given our ACK, sorry...

Thanks,

Ray

> Yours,
> Linus Walleij
> 
