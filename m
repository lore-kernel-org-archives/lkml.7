Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06282C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1332077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eupi1aaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLIRFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:05:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbfLIRFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575911140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIL9P9E+t0Af0cB2lnnGX6O0iOj+o/yCtp56yQPQwkQ=;
        b=eupi1aawXcFXFSlNK5gceL5hqOtrQnxYo71zn1R8MdZWVIg5v0Yrb2aoQ28J1w1ecZEGoU
        FkaXvCXGFE7B/+jqf8p8zx2YZbdahUIHsk2R0wBXuaCBQYgtODeERZ/C9PnBneu4lZspCv
        xrgQQmiKv1hZLcjQn/oEsBJvH42KRoY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-EJZGaGpmMdOik0TAelwHBg-1; Mon, 09 Dec 2019 12:05:38 -0500
Received: by mail-wr1-f70.google.com with SMTP id y7so7011305wrm.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wIL9P9E+t0Af0cB2lnnGX6O0iOj+o/yCtp56yQPQwkQ=;
        b=YuQP0PtVFkIXi/pWEgz3LpjEp4214Icv0FrRWWFLWGCt8dRIcUz7Bej5kXFC4Yg+Y9
         qo+5CJAasCdW1xg9u4PJqOoArlJb1loiqX7W8tNIqpsnvffqB50ogCr7eV2ASYGu09EN
         /IBevXcyb/PDnpCCmv6h7T8eQhHPjIns8+v9sxeyCgFQ42mnIew+wnAi7rdTxg8krVnf
         x4P/Ff3XtzOE1DCVsU4MBomCEu2dat5t0NdXvAgUHegKIV9eOqfBeDzvloFtxLkTDVf/
         WAHsYqtN1t4eB0Hyejf2sOuUDU1aGQBfRyOYbkLc0dsesTVDcs8bukMGECO3PqXmc4Iu
         gAng==
X-Gm-Message-State: APjAAAVStuhre5RM7+1apiroeC7cTvEdWAa9wNaohgFiXIteo5tTxVTV
        dDlSdKag4zCy4ZQWEcLPeFPD5s0TvHMfaIE8v/rLbra8Ncpqk8lQr3ChxKyN+YZn3VQqPyovlOP
        3hipdRTjUQ7QwY2UM30sZBIyr
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr34138wmk.1.1575911137566;
        Mon, 09 Dec 2019 09:05:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKwynLR6vYeRDh6BKaDO4EA5HcVr4+oiiNnycyJhRCVOHGm6bTC7g+DgAPIxwaEfhVjnQv4w==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr34113wmk.1.1575911137320;
        Mon, 09 Dec 2019 09:05:37 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id x18sm72699wrr.75.2019.12.09.09.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:05:36 -0800 (PST)
Subject: Re: [PATCH 0/2] use jump label to handle resource release in
 irq_bypass_register_*
To:     linmiaohe <linmiaohe@huawei.com>, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1575600833-12839-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2900fcd4-f08e-0508-8b6a-4e7d82fbba78@redhat.com>
Date:   Mon, 9 Dec 2019 18:05:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1575600833-12839-1-git-send-email-linmiaohe@huawei.com>
Content-Language: en-US
X-MC-Unique: EJZGaGpmMdOik0TAelwHBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 03:53, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use out_err jump label to help handle resource release.
> It's a good practice to release resource in one place
> and help eliminate some duplicated code.
> 
> Miaohe Lin (2):
>   KVM: lib: use jump label to handle resource release in
>     irq_bypass_register_consumer()
>   KVM: lib: use jump label to handle resource release in
>     irq_bypass_register_producer()
> 
>  virt/lib/irqbypass.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 

Queued, thanks.

Paolo

