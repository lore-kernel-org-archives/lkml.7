Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBB92339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfICQxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbfICQxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:53:49 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16F0B89AC6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 16:53:49 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id k13so19578589qtp.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=TIiAFZIjHlLz7PBS/03pE3hbJ7hhmKmUaMbhV6zq5dw=;
        b=b9EbxNw33J7Dwf32zVj2Y5sZt0s1Cu7QEiQ1pHULUOaSdhwbIS09XwHD2zvaOdr/rP
         q8WcZvGzDHvJqaYbCLp3XR39tcIg7DZOEClzz1jAUXyiAhKBJuG/gFtwZupu9g6xf3BL
         apWxgAE8gHzPNTLfKtDzmb8kbs5CYj1dS1WosT2tcNedq20+m43HjEJx2G3J4tO3cQ96
         EGUA3sK0c7Evbop0QwLI44OFz6oKA2VKbWfdCvygrziw62tcM21bHnur7KRqlo8BhX7x
         sxJ9HWtX/6asgbkAeUBBV/04ptNAZAWZBLBE9AKWdoVV3w+ebxe2C3B+UY6GzSIPYWW+
         v1kw==
X-Gm-Message-State: APjAAAV2PxQ0MJJ0F77JWnXIhc1/Zegxd6Ju/Tzumn7xTHmIc7BGqhRc
        fKngYkuUZEhEtRU5ZYxWrv53VKmqL4c3NvBxD2QaHfw9cUCtGAHn0xoIobnYc4vb7fxCXdMmz0s
        5980hjdJ9ahc38lq2zIM5tk3R
X-Received: by 2002:a37:9f46:: with SMTP id i67mr12460259qke.108.1567529628437;
        Tue, 03 Sep 2019 09:53:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2RtxOu0+e/HYiXoLPNfFZTtLwLtQQ5mVN9iBaXKzoZQiTiwfOglHbKL3LXBPDM4/BcEk4ZA==
X-Received: by 2002:a37:9f46:: with SMTP id i67mr12460240qke.108.1567529628217;
        Tue, 03 Sep 2019 09:53:48 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id p77sm6894259qke.6.2019.09.03.09.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:53:47 -0700 (PDT)
Date:   Tue, 3 Sep 2019 09:53:46 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH AUTOSEL 4.19 126/167] tpm: Fix TPM 1.2 Shutdown sequence
 to prevent future TPM operations
Message-ID: <20190903165346.hwqlrin77cmzjiti@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Doug Anderson <dianders@chromium.org>,
        Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-126-sashal@kernel.org>
 <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 03 19, Doug Anderson wrote:
>Hi,
>
>On Tue, Sep 3, 2019 at 9:28 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Vadim Sukhomlinov <sukhomlinov@google.com>
>>
>> [ Upstream commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 ]
>>
>> TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
>> future TPM operations. TPM 1.2 behavior was different, future TPM
>> operations weren't disabled, causing rare issues. This patch ensures
>> that future TPM operations are disabled.
>>
>> Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
>> [dianders: resolved merge conflicts with mainline]
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/char/tpm/tpm-chip.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
>Jarkko: did you deal with the issues that came up in response to my
>post?  Are you happy with this going into 4.19 stable at this point?
>I notice this has your Signed-off-by so maybe?
>

I think that is just the signed-off-by chain coming from the upstream patch.
Jarkko mentioned getting to the backports after Linux Plumbers, which is next week.

>-Doug
