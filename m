Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE7C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277502053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfICHvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfICHvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:51:17 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48B282A09A2
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 07:51:16 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id c23so4454879edb.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w8HIPoxJeKQ6uWeXwaqzJnrwZeqZuyXyHwG4+Nh5f8I=;
        b=Od57bel9c+v8Pg26YMGT8OHg8xpxKu7hq/ZypHKKqG7VAVAqpD60FrSnfEg9qhoiok
         YhbE2b2L8AdWlkWD1xlWIYabTvpi7+PV0/hF99xgNpd+SwwS4jzE7tuy6LDhW81fJZEp
         UjrTVd32IdIVrE4puOJZfEFUaBJW4emOMK3GluTuy84nK/KC7CUjZuh3Sy73/U5Of1hh
         OEL6n2eaRE5qeT3CS3uP4XLrOejtG6ybN405r6xJ+5J2ar9hwNLfheuoB5OmYUx7mbFt
         K83olkVhr25PRkUF85WyEHFAa+hwRD3xzDIqg2KMxIXhppmRQhkvJmaw4tL3O/Gi5fZS
         A0Bw==
X-Gm-Message-State: APjAAAX5JibIlBUfGJfKUm/oXrcBK6XZR8/0kYslhU+58XWnK48vTcZG
        M9LUJXoWr9rrHedlsEwHslNYc9ae2OtBmT5q/aHfkd+y0wzxo4NEtBcZf7ZrF5mmZ34Sg4ffMlp
        2yC2/ltc6I6Hb/VHAFUlGYNMf
X-Received: by 2002:a17:906:d7a3:: with SMTP id pk3mr13383195ejb.97.1567497075044;
        Tue, 03 Sep 2019 00:51:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcWpjWCgHm7od0lS3pQcg6L6ajmTNeMv46O7wYLrV4SdnJWrI2Vv4mBF3X9ZIiqJr2V6QZKg==
X-Received: by 2002:a17:906:d7a3:: with SMTP id pk3mr13383184ejb.97.1567497074920;
        Tue, 03 Sep 2019 00:51:14 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id c1sm3244417edr.37.2019.09.03.00.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 00:51:14 -0700 (PDT)
Subject: Re: [PATCH 5/9] crypto: ccree - Rename arrays to avoid conflict with
 crypto/sha256.h
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190901203532.2615-1-hdegoede@redhat.com>
 <20190901203532.2615-6-hdegoede@redhat.com>
 <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d55a6a7-9cca-38cb-97a2-558280fdc122@redhat.com>
Date:   Tue, 3 Sep 2019 09:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOtvUMdd+V5pesw+O-kk9_JB5YpxUM+hU+Uu=kiMvOL9d0AziQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-09-19 09:45, Gilad Ben-Yossef wrote:
> On Sun, Sep 1, 2019 at 11:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Rename the algo_init arrays to cc_algo_init so that they do not conflict
>> with the functions declared in crypto/sha256.h.
>>
>> This is a preparation patch for folding crypto/sha256.h into crypto/sha.h.
> 
> I'm fine with the renaming.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Your Signed-off-by is only used when the patches passes through your hands,
since Herbert will likely apply this directly that is not the case.

You want either Acked-by or Reviewed-by to signal that you are ok with this patch.

Regards,

Hans
