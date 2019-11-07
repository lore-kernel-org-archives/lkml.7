Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D5CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919632187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbfKGN05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388681AbfKGN05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:26:57 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7C587C0A7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 13:26:56 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v6so996789wrm.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sY5GQZQRR37FgRTpgS+peb+lk0hBcwjkBJyRvYYH6Hw=;
        b=onqwaL+jR5OVIsV423haibvIO3XmHTSjqK/138T4+agQM/ssvmmXP25TtobiZaGSrY
         9KY/GjSYPdTxQBBQgGuFDyVjCq4CsQJScZq3c7So020UQdDG/QjBBSCnAs5IeCRoOgC1
         lmxPLScCvCwFxxged7KEphQUJzbkQ2EuJzinP9b7CQJQ2FuhbswINj77HASaxN3Y/4t8
         htcJ7Rf1n1LCk6hoQRCxcAZi7U/5ZiLAgZKi3WcsuAvKvh6ipBcuZfJxttqorCDBqZSf
         dpHHPj0kT9Qrngz7cf94W4sjGDXBlLL+6+FnZBUK52vsuMzKD8VhOPFVfBwn+00T/4wK
         c1iw==
X-Gm-Message-State: APjAAAV18cPCoMff14CANI1DFAUcVj6wqHxkbZ7E0Ew2wuBS7lbds1h9
        tsJTXUAbK8Ri7QJOX1Jk0wm2dGM4BZCUOcboh+Xsx9EpquaIfhTyjCKV5BbuMTkgw5Yv5JOQUt7
        SuKAqG3A3ZZ4n+g1SzxzMSsXm
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr2855697wma.56.1573133215360;
        Thu, 07 Nov 2019 05:26:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqxTxNfiovI0w9kYuknzKXffvwCptiTG92icmrRUIsqrAdos08hnvVnr3eQTmeYuQjClpj2+4A==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr2855658wma.56.1573133215051;
        Thu, 07 Nov 2019 05:26:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w13sm2269778wrm.8.2019.11.07.05.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:26:54 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] x86/hyper-v: micro-optimize send_ipi_one case
In-Reply-To: <20191027151938.7296-1-vkuznets@redhat.com>
References: <20191027151938.7296-1-vkuznets@redhat.com>
Date:   Thu, 07 Nov 2019 14:26:53 +0100
Message-ID: <877e4bbyw2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> When sending an IPI to a single CPU there is no need to deal with cpumasks.
> With 2 CPU guest on WS2019 I'm seeing a minor (like 3%, 8043 -> 7761 CPU
> cycles) improvement with smp_call_function_single() loop benchmark. The
> optimization, however, is tiny and straitforward. Also, send_ipi_one() is
> important for PV spinlock kick.
>
> I was also wondering if it would make sense to switch to using regular
> APIC IPI send for CPU > 64 case but no, it is twice as expesive (12650 CPU
> cycles for __send_ipi_mask_ex() call, 26000 for orig_apic.send_IPI(cpu,
> vector)).
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v2:
>  - Check VP number instead of CPU number against >= 64 [Michael]
>  - Check for VP_INVAL

Hi Sasha,

do you have plans to pick this up for hyperv-next or should we ask x86
folks to?

Thanks!

-- 
Vitaly
