Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51106206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAn16Ept"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHSOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:08:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36396 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:08:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id f19so622441plr.3;
        Mon, 19 Aug 2019 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=GSLHXu1mOtlkzdO0Aoy6ALFWdjQmUSGB2auJNt7fmaY=;
        b=hAn16EptkwYbIsimrtCVoLm3Vy2/0maL2p4sTLH/uJOqrzgirMoRwVwobxhbxRutWh
         Hoj/J+0xMDQQ+DRUIjfbV6AyjSf9wPse+GBYiR7P21FBQHEarrOe62Oti+ue+vs+3QIR
         1ExfSZZC/TKj6jUNxFScZ86jbWp98Z2VfasIRWdrhAHCkJdZncoo06ryvn8WpySQw751
         V+fss1tF3DpVSyjKRwkpPZ+fQ9EksfRmL8tqpVyiDVQs4SvyK7q2aLnABiNjdxSvIBHF
         lqsQfmxVD5MU+L+Ey2i1jAJ57tedIzgJ06XZ6WRhOQvaGWqDX8CGZ7vuZ/VIGDJqyHK4
         uxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=GSLHXu1mOtlkzdO0Aoy6ALFWdjQmUSGB2auJNt7fmaY=;
        b=qIoSg++929F4L8HBeWN3qIZH7wHqh9Ef0Dslv+Uic+Mz873KWH/G/nb/UaOseSspuD
         6Z5/cm6hkiCSVZpcrKwz9Jr8kKfwwDbq3nztOuu9BWgcHh3lYD1VkraCzP3hsH3z2Jda
         eUExMZMqrEEmg9IdRtLEoLz07V1vEDuBdIw8kksHsEAt8ZGe7ilzFmh0cM1FqpumefjA
         Qq/yXEAtUF1xniu3sn0U1qI1ngujbGYaKFcpUCCYVVBBxu+c4Aqp15rj/ygDFoK6Sfqy
         mXlCZo2Kxj3V/3xz3UZnRKEiKgJ0go/L+5AJFjVA4JfH7Cjm4zSfpGeU6/3wonJS1G62
         O9Og==
X-Gm-Message-State: APjAAAWNZqcQPbb+JcUZy+I/j02elR1WyK8MSnykkPlTHwjCgTF+gWof
        sZtq0fwONXEe1SWW5XA81I55sgoaih4=
X-Google-Smtp-Source: APXvYqzFRu4lTXAtTaDQiAyQr6JuJk/LzOC6VfLDOvSW4lLPPVsn2jAzVwCGW6lZVtESwmhasPcgDQ==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr23407917pls.259.1566223738387;
        Mon, 19 Aug 2019 07:08:58 -0700 (PDT)
Received: from localhost (193-116-95-121.tpgi.com.au. [193.116.95.121])
        by smtp.gmail.com with ESMTPSA id d6sm14454537pgf.55.2019.08.19.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:08:57 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:08:46 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 1/7] powerpc/mce: Schedule work from irq_work
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Santosh Sivaraj <santosh@fossix.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org
References: <20190815003941.18655-1-santosh@fossix.org>
        <20190815003941.18655-2-santosh@fossix.org>
In-Reply-To: <20190815003941.18655-2-santosh@fossix.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566223307.ypgtanp5uk.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj's on August 15, 2019 10:39 am:
> schedule_work() cannot be called from MCE exception context as MCE can
> interrupt even in interrupt disabled context.

The powernv code doesn't do this in general, rather defers kernel
MCEs. My patch series converts the pseries machine check exception
code over to the same.

However there remain special cases where that's not true for
powernv, e.g., the machine check stack overflow or unrecoverable
MCE paths try to force it through so something gets printed. We
probably shouldn't even try to do memory failure in these cases.

Still, shouldn't hurt to make this change and fixes the existing
"different" pseries code.

Thanks,
Nick

> fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
> Suggested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Cc: stable@vger.kernel.org # v4.15+

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

=
