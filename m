Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE39C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EB2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfG3MK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:10:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55763 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfG3MK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:10:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so56921180wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 05:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9L0zBGqIjlWL1IQrDXZZd5jCWfrUHuNyOkNCDrFw/Cs=;
        b=jVxQVwTPQZnLHlWL4q3pDgIMoyv5VPlzO7jjHak8ej2jLDnC0bgxD5mT9GdKH0m9J5
         bGQk6/vGdFJ5+RJpisbjQEjguMpaOP8e0kPrbbM36eoaV9Tv2x2aEQYcXshgB+OT+16q
         ZpZhNvqUqp2zILYr3acC6CTw0rGUYtsK3dlkyaOQ1n9E2rCIe3V45EgUfI9nOWZdLQKF
         Vb85/rtoGNSRrR2oXgVDxjRVBZfYb2V1oAsSX9Wl82lUwTLFstHFZ+lzchPwQjHK5cZx
         B5LuXoljukwFJdJ+3JDjv+PnGhxCnLxXedJbrz3pl7YK5tdpYPHG+ZuAJvAUyV6EG4kt
         me0Q==
X-Gm-Message-State: APjAAAVKBnAOEkG2n7F6b1bXRDBysTPa9Fs2yGK6Xg/1evA9sFZ6gmgG
        xBaVUcXu+vLg5zs0f6D2rm3SnKV5bvQ=
X-Google-Smtp-Source: APXvYqzRKfHoZNVIgIXgBiYl7T8xPjJrXf2ElRHPMC0DZvjUOPtbRAo+bHcxkpSIp0MMlJYsQjsIbQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr105796251wmk.79.1564488656203;
        Tue, 30 Jul 2019 05:10:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04? ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
        by smtp.gmail.com with ESMTPSA id t15sm56691815wrx.84.2019.07.30.05.10.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 05:10:55 -0700 (PDT)
Subject: Re: [RFC PATCH 06/16] RISC-V: KVM: Implement
 KVM_GET_ONE_REG/KVM_SET_ONE_REG ioctls
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Radim K <rkrcmar@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190729115544.17895-1-anup.patel@wdc.com>
 <20190729115544.17895-7-anup.patel@wdc.com>
 <3caa5b31-f5ed-98cd-2bdf-88d8cb837919@redhat.com>
 <536673cd-3b84-4e56-6042-de73a536653f@redhat.com>
 <CAAhSdy2jo6N4c9-_-hj=81mXjHjP8mvZy_8jOdRZELCyU9Y8Aw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9f84c328-c5ad-b3cc-df0f-05f113476341@redhat.com>
Date:   Tue, 30 Jul 2019 14:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy2jo6N4c9-_-hj=81mXjHjP8mvZy_8jOdRZELCyU9Y8Aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/19 14:08, Anup Patel wrote:
>> Still, I would prefer all the VS CSRs to be accessible via the get/set
>> reg ioctls.
> We had implemented VS CSRs access to user-space but then we
> removed it to keep this series simple and easy to review. We thought
> of adding it later when we deal with Guest/VM migration.
> 
> Do you want it to be added as part of this series ?

Yes, please.  It's not enough code to deserve a separate patch, and it
is useful for debugging.

Paolo
