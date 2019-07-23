Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388A9C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADE22239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 04:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAaCUH2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbfGWEdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 00:33:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36947 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732028AbfGWEdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 00:33:14 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so78991654iog.4;
        Mon, 22 Jul 2019 21:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qk5U3bA3qzqu+IynLlWRQEOBAZ7N1ou8AjhC6QEx5u0=;
        b=eAaCUH2GDO3sHWHaMhz8jJtzV7jW+BiUeGImVRvQzC/HkO/ePhOmBL6V+3w7RvWvju
         1xXhjNCfMO2w1bVdjSwRyvk970tveUNzXQEtvso3ebs79zQaGzj6zYMhMBs3/x8MGWWR
         qaw7VDW7sDC5eieCOhpn2EBVf6uGWddX8jW+UeD8QOcH4Y0wAUIRqZcQ5SHOW+mupeta
         m3XxXRjDWwBQV6vnriWza+9xiQt3hTAl05kdNPy9AEoeMwvpmuBqvE8rlxUVcMFS/TLw
         9p/w0l84R/dJ0/kn1yOfELe4AwF1LEjk9TiJeGg1ZM37psFZmk4aVaodRogWibVwHPWS
         E8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qk5U3bA3qzqu+IynLlWRQEOBAZ7N1ou8AjhC6QEx5u0=;
        b=OyYDzYrjoH9uR4Ab543UJlrRTFPjaTBiGNdB+WWPoRlRPB6l7qrTMoa4bEknPoLKSf
         2h4U4BmWN2VvkUMz9Bdqor6QXyPPF09bNHQjWh7wKXLVMMRMVKA4tp02I+GHIZCG+8iO
         xKt2NvNE887yoy8rmHOgfTVY3B3sJOcKdRqJ2UJ6aRtM0K/qBtOvkeOg8KdqI23kBS5B
         7GpfMRjtCbP20fISpG2CtHFWWo+0lbmQ/tHp7BhfzhMosrS/nAJb50DRmF2ZGfd+2wSq
         iXWpnNCICDf0GfOYQVcT2+VWoGof99IREW3w2SMsjIVz2eKKteRf/FKYkhN+VtlUvm8U
         4X5A==
X-Gm-Message-State: APjAAAVYdtIV9NTfM+1BPBoYCBN+SgUWDOGLuJIzIhk7qwigqNtOi4PN
        hUJfFGGKbQ01kKZHUjbIgiwNR6iIf6jNdwAjutw=
X-Google-Smtp-Source: APXvYqypWk0MoPSm5Ekj3ag8N4aYiKFddHyRSOhwJTVjabMMbXz/iRZaSJJJvO9mdCygUH+Vv3eCygCT2npGFTLY+Zg=
X-Received: by 2002:a5e:8e4a:: with SMTP id r10mr58528805ioo.100.1563856393341;
 Mon, 22 Jul 2019 21:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <1562317967-16329-1-git-send-email-gkulkarni@marvell.com>
In-Reply-To: <1562317967-16329-1-git-send-email-gkulkarni@marvell.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 23 Jul 2019 10:03:02 +0530
Message-ID: <CAKTKpr5H=QCEx_pL272jCQKdaNwQoRAHVyo93YFa62Z2SZJVCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add CCPI2 PMU support
To:     Ganapatrao Kulkarni <gkulkarni@marvell.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Will.Deacon@arm.com" <Will.Deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
        "rrichter@marvell.coma" <rrichter@marvell.coma>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Any further comments for this patch?

On Fri, Jul 5, 2019 at 2:43 PM Ganapatrao Kulkarni
<gkulkarni@marvell.com> wrote:
>
> Add Cavium Coherent Processor Interconnect (CCPI2) PMU
> support in ThunderX2 Uncore driver.
>
> v2: Updated with review comments [1]
>
> [1] https://lkml.org/lkml/2019/6/14/965
>
> v1: initial patch
>
> Ganapatrao Kulkarni (2):
>   Documentation: perf: Update documentation for ThunderX2 PMU uncore
>     driver
>   drivers/perf: Add CCPI2 PMU support in ThunderX2 UNCORE driver.
>
>  Documentation/perf/thunderx2-pmu.txt |  20 ++-
>  drivers/perf/thunderx2_pmu.c         | 248 +++++++++++++++++++++++----
>  2 files changed, 225 insertions(+), 43 deletions(-)
>
> --
> 2.17.1
>

Thanks,
Ganapat
