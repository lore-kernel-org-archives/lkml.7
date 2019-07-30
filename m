Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C8FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0032087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfG3DmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:42:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45413 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfG3DmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:42:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so29068066pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 20:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KzQ2d5or7VQXiah+3vlOrWNhkXWwOjknOlmw+s8awSE=;
        b=nCyruRTj1PFWpzf044lV64Z7JigmgUGWjzJu0l1jF+7Oz4I9TJds7eHUjrVQsAnRBC
         LVeevmR2esgeRkAu4tScsDl2RfAWsBs5ajT+6FCr73WkYKoF7rZFUWW+UTogFKDyYma7
         yLnXuBQznAwBqnqjcbpGHylOGyCo0PGeUfKKv7+jrVLW89sQSAOOIJWayVedWbz4Q3Pf
         oUi3ngoekRX6WQw1OVy7sQ0EgxOT1TAyyhqp/wUbf0Z7URQddEo5GHy51jLYYw3mPPyZ
         NXg2QGVNNF+byAry08R4hU/A7pcnmBpX/Mwf37ZLm68W1ZrgMyq2zQA9pqvAvCvSzPJI
         pzXw==
X-Gm-Message-State: APjAAAXUykHfYdfXAzAoIriACaHsw1hXRhTwE9k5io6xZFWFVLlr4kRt
        6n78Wa6fq4H6b4rL8yA+1Lk=
X-Google-Smtp-Source: APXvYqwKj0qOQ8BC7cbBgbpIj+BoeQaVMscqGRy6D2jtBXUOCNRZ23A9EbKFb2h/fUeGkeVkieBEAg==
X-Received: by 2002:aa7:82da:: with SMTP id f26mr40058645pfn.82.1564458143949;
        Mon, 29 Jul 2019 20:42:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o35sm54590057pgm.29.2019.07.29.20.42.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 20:42:22 -0700 (PDT)
Date:   Mon, 29 Jul 2019 20:42:22 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 18:25:40 PDT (-0700)
Subject:     Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string parsing.
In-Reply-To: <a8a6be2c-2dcb-fe58-2c32-e3baa357819c@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, alankao@andestech.com,
        aou@eecs.berkeley.edu, allison@lohutok.net,
        Anup Patel <Anup.Patel@wdc.com>, daniel.lezcano@linaro.org,
        Greg KH <gregkh@linuxfoundation.org>, johan@kernel.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-540ae5bd-8e5f-4054-9192-4e4e73cbce21@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 15:20:47 PDT (-0700), Atish Patra wrote:
> On 7/26/19 1:47 PM, Paul Walmsley wrote:
>> On Fri, 26 Jul 2019, Atish Patra wrote:
>>
>>> As per riscv specification, ISA naming strings are
>>> case insensitive. However, currently only lower case
>>> strings are parsed during cpu procfs.
>>>
>>> Support parsing of upper case letters as well.
>>>
>>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>>
>> Is there a use case that's driving this, or
>
> Currently, we use all lower case isa string in kvmtool. But somebody can
> have uppercase letters in future as spec allows it.
>
>
> can we just say, "use
>> lowercase letters" and leave it at that?
>>
>
> In that case, it will not comply with RISC-V spec. Is that okay ?

We could make the platform spec say "use lowercase letters" and wipe our hands
of it -- IIRC we still only support the lower case letters in GCC due to
multilib headaches, so it's kind of the de-facto standard already.

>
>>
>> - Paul
>>
