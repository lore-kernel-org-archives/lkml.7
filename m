Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508EAC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B012183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="p9NpB8BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfC2GuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:50:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35811 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbfC2GuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:50:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so1192768wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rk9Tjh9bmBsApmUPV+4Ng0H24HMGN/q1wBY66W9cA0E=;
        b=p9NpB8BW/snbMT9Z9LvxO17RKtk/8U3XFViiFz3CMJFqaFoNNL/QgAsxqhaogZEqJh
         bDdogWjHLqd2YlMw5o15c2DWxE1ttH6mfMbkJMWxWF6yws9fIsxRNx720RCbMyAHmkWH
         vEJsI7cYA3t4H0nEgBO6m+4/c3C+1xzDERsRyviDhlW4b62Zn5syw9IEuYPdzxA6fR4j
         bPxWUfcII161QwVI3aGqI+ISLsItsiFOLZoU9rIrTjIh7bAbVAGnVWm21hBJ45FxcS64
         aTqfmxRR77m1hulzM6PZWsrPbkN+s716QZNni/f2Lle6eVJ87T06FiWSlhIsRLasxbPk
         D3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rk9Tjh9bmBsApmUPV+4Ng0H24HMGN/q1wBY66W9cA0E=;
        b=l7ZsMP+Rf5jfTWUbBrveyOSjnaEZaoER/pEXjn+e50L8Za7HIXPYNKjT0Py53e81Qo
         tYq76uyFn49/v67GnxZPOTGXq/hMIBLMISU9GzEWibc8KlAIjpiwENL0u6hQPh/JmRgq
         syTo36ITfl+HWhMKgJ03Iuxfwe2Rs+sxdRBFRR1Apq/SixKgXQO/2h3ohJF2qbGoXXLj
         FFCTIyfVDy3d4EkWaph3gu5LiY1OtVgvECUWTvkh/L8Z7LdMqsKGZ05daV73kWgXycbe
         kK9+GfoyXjmdGeE2IRj6Kxwk5PmtBsGf/kfZAXRs1cVEAFf/RXp+y0SkCWhLAcNwwtlE
         tOtQ==
X-Gm-Message-State: APjAAAUZsIbijRJSMh5xpTmOs61K1zBP85m8sa7Ll60SV9TlwTzhB/kn
        KvNGVRN3uI67rKBMMwHRZ2DF12LKeb7yDnlfQiNmww==
X-Google-Smtp-Source: APXvYqwCj5geTzE+H/keNYztYw/5CSD4uWVM3FMR2KtG/Sk32SMr1m7buPmPFfvCSnKyPwPrlNwz1rbLAq5dya26RMU=
X-Received: by 2002:adf:9427:: with SMTP id 36mr31439937wrq.128.1553842221523;
 Thu, 28 Mar 2019 23:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190322132509.GA19263@infradead.org> <mhng-05d2bbbf-c808-408e-8fc3-14c00ac167b6@palmer-si-x1c4>
In-Reply-To: <mhng-05d2bbbf-c808-408e-8fc3-14c00ac167b6@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 Mar 2019 12:20:09 +0530
Message-ID: <CAAhSdy2pqVS7LPfiaQzw90=kvaJDL63KbMXEiqHg_Raa_LiNxw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix FIXMAP_TOP to avoid overlap with VMALLOC area
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Fri, Mar 29, 2019 at 11:48 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 22 Mar 2019 06:25:09 PDT (-0700), Christoph Hellwig wrote:
> > Looks good,
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Thanks.  I've added this to my fixes list for the next RC.

I have another RC fix as well:

"[PATCH v4] RISC-V: Always compile mm/init.c with cmodel=medany and notrace "

https://patchwork.kernel.org/patch/10870605/

Regards,
Anup
