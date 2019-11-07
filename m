Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EF8C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AB1214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+7xgzJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKGOof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:44:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727325AbfKGOoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573137873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uokYutLXxZLmrspkhT2MmzUiCDD5/pP/FDqbke/Wsbo=;
        b=d+7xgzJxHiA3f8mbW8jOhNgHGmgb3sSUOxs7I00kRPhCaEYXr3bVz0XDpFZNOZnFjcsHGQ
        fvLADNOnki4E3XGh7Ka4K5qctHJuAAtxhK/scxbefgARdDvReIBPTfZyh0cjfwUmRsyRxE
        7+HTtnemWpQv8wg4dgkn7u0thZqyATQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-6DXwr04MOc6ZXuRE-WzCjA-1; Thu, 07 Nov 2019 09:44:31 -0500
Received: by mail-wr1-f69.google.com with SMTP id 92so1153105wro.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 06:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gVCbv0LzqaX/qvKbIQst3PDmSY4xjmIqqe/yjz+5HCQ=;
        b=PZ/xqI8xxSoH6rWQCr1tni9a1uqqb++Srchvf26ubAhCn7zu8B/Lcsn9Fz5CkI+7mG
         Br33HQ8ZaBObsd5nAZbrdSUpZ6Qc+XpuEcoH1S4C0z8tg80+arWGgR6FsXEmJD6q7K3R
         f4sYGbTCQpQZHUdah9UTyPabRJ7P2MeSFU/CFJr4/WnkraRh5NAwBM+ad8g7aLuruM0a
         1Fwse3r1ZvBKkGDXc/t45IkPSbyqmuPze7v1ZN4vGySiGaEh2Sh090P8j4q2FI8ExVD1
         3xLejldB+C6VWiabO4n1cBJ7lrA6u/vQT61xggVO6LURuYMsfOYdynse3+ePHZUIOusQ
         Da2g==
X-Gm-Message-State: APjAAAXOYM8dcVCk4zEo5yfZkLbrfqUpxVhcSILx3mVt8P5N673YUHyv
        TTTZeLgZSGV8tHShKVMIVCKff3t5zDLjgOZirYmMOf3lCenSkS6XcZ2h79stPHdaM6XOOathhrg
        GLp3q/WB8YGpatW6ZcdUK8vKQ
X-Received: by 2002:adf:f048:: with SMTP id t8mr3418735wro.237.1573137869946;
        Thu, 07 Nov 2019 06:44:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUI1JLHk53Xg60Bfi3+RoW23Um++7OLDP36Ol51PbWYQBdWIxnkrQYImvKgZXpd3GbH1R6MQ==
X-Received: by 2002:adf:f048:: with SMTP id t8mr3418652wro.237.1573137868856;
        Thu, 07 Nov 2019 06:44:28 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z14sm2475247wrl.60.2019.11.07.06.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 06:44:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "open list\:Hyper-V CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] tools/hv: async name resolution in kvp_daemon
In-Reply-To: <20191107152059.6cae8f30.olaf@aepfle.de>
References: <20191024144943.26199-1-olaf@aepfle.de> <874kzfbybk.fsf@vitty.brq.redhat.com> <20191107144850.37587edb.olaf@aepfle.de> <87zhh7ai26.fsf@vitty.brq.redhat.com> <20191107152059.6cae8f30.olaf@aepfle.de>
Date:   Thu, 07 Nov 2019 15:44:27 +0100
Message-ID: <87wocbagqc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: 6DXwr04MOc6ZXuRE-WzCjA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> Am Thu, 07 Nov 2019 15:15:45 +0100
> schrieb Vitaly Kuznetsov <vkuznets@redhat.com>:
>
>> Looping forever with a permanent error is pretty unusual...
>
> That might be true, but how would you detect a permanent error?
> Just because the DNS server is gone for one hour does not mean it will be=
 gone forever.

'man 3 getaddrinfo' lists the following:

       EAI_ADDRFAMILY
       EAI_AGAIN
       EAI_BADFLAGS
       EAI_FAIL
       EAI_FAMILY
       EAI_MEMORY
       EAI_NODATA
       EAI_NONAME
       EAI_SERVICE
       EAI_SOCKTYPE
       EAI_SYSTEM

I *think* what you're aiming at is EAI_AGAIN and EAI_FAIL, the rest
should probably terminate the resolver thread (e.g. AF_INET is
unsupported or something like that).

--=20
Vitaly

