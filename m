Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6507FC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8292187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhFlS+0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbfKGOPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:15:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41240 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389136AbfKGOPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573136151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQQGeA2GqC4Q8lGdu4U1hGsjXCIjFvgN1cEaPoJfzWs=;
        b=EhFlS+0PPWLUR4oHDvxc50RGj7aBT7VwgaJkgnHJ5MAL0pC8TY6VDroAs71nEYna7x7Ah2
        APUnG9pIu7342iqonwD+6c+diFlIdICg3/a1zkET9O5jnq2MyHP5Uxqmw67v+u3P11R0bf
        Asm2J5gLKO5CEvrFXmoGplEIvdED654=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-fTFAQhzxN1y-SOymwlb9FQ-1; Thu, 07 Nov 2019 09:15:49 -0500
Received: by mail-wr1-f71.google.com with SMTP id e7so1091519wro.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NuQrs5SJVY4jlHa2zxbalzQjTYTxUlDQ8ZHPfqmiNQ8=;
        b=X+GP/O2rBFQCJIKP4OTt61RBIw9gj4c9ABMKmAvAcYYrMSVWyzJBbTmhzd9p4js1Uc
         CKyVlFoB5KYZaHYU6tFgy89U4x8tn1IlQ5TXQ9mlZrLOkc2X4lKBmRPO0UrPoNqVNCdK
         ZmdlaBlI4hbn8iBaRXfQ5/VScwak4w0rCIDCuWEcoeA/dHPAwKFI3PoUATARj1Sifcxh
         8xcM1rbRWVbPcWEN7sQgM5AixUNAxAOdiBLh4RqMWZxArFiILGpWe1Ax85Sn5qKHMFHD
         AB7CCi4iftIT2pWoCvh4EZS5wIcVUoA3aXUVsrsJtyJZ+QDuLMTyxCqhcyhc1IcsgYwJ
         GHMg==
X-Gm-Message-State: APjAAAUX2zDkF5M5tEOUyHDQQfjMsNzK19N98SgGURmgZrt/eucCl+Ap
        TEoFORykRrSnMdir+WVuQZ+nje4AVie4+bin1nWUi6AO4UyF1I6FUKoqFeh8OEbYCzCkCS8uwc9
        pXO4aJHX87I6JUmL8DeR7IwFW
X-Received: by 2002:a5d:4982:: with SMTP id r2mr3134196wrq.254.1573136147571;
        Thu, 07 Nov 2019 06:15:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwgCFT8usXbCPQK392QCEz4oeVoY26l3u2JDtD2xITZhSqFPvEqq5eSP3DgLKVukd6BnLc8A==
X-Received: by 2002:a5d:4982:: with SMTP id r2mr3134177wrq.254.1573136147337;
        Thu, 07 Nov 2019 06:15:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m15sm2185865wrq.97.2019.11.07.06.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:15:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
In-Reply-To: <20191107144850.37587edb.olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de> <874kzfbybk.fsf@vitty.brq.redhat.com> <20191107144850.37587edb.olaf@aepfle.de>
Date:   Thu, 07 Nov 2019 15:15:45 +0100
Message-ID: <87zhh7ai26.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: fTFAQhzxN1y-SOymwlb9FQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Am Thu, 07 Nov 2019 14:39:11 +0100
> schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:
>
>> Olaf Hering <olaf@aepfle.de> writes:
>
>> Is it only EAI_AGAIN or do you see any other return values which justify
>> the retry? I'm afraid that in case of a e.g. non-existing hostname we'll
>> be infinitely looping with EAI_FAIL.
>
> I currently do not have a setup that reproduces the failure.
> I think if this thread loops forever, so be it.
>
> The report I have shows "getaddrinfo failed: 0xfffffffe Name or service n=
ot known" on the host side.
> And that went away within the VM once "networking was fixed", whatever th=
is means.
> But hv_kvp_daemon would report the error string forever.

Looping forever with a permanent error is pretty unusual...

>
>> > +=09pthread_detach(t); =20
>> I think this should be complemented with pthread_cancel/pthread_join
>> before exiting main().
>
> If the thread is detached, it is exactly that: detached. Why do you think=
 the main thread should wait for the detached thread?

Ah, my bad: you actually can't join a detached thread, scratch my
comment.

--=20
Vitaly

