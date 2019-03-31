Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90E6C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0BA2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="E+5Lfs5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfCaRoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:44:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39347 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731510AbfCaRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:44:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so8597407wmk.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K88RNWTe7YAd6gktueP90sT+q3Uq4wmmn8gMxnEgk5o=;
        b=E+5Lfs5gQgNKSw+TTCGisudHU2r5kplwvSK8cyCWuMS5hBcW274gIi1O0VxxHsSsIf
         E2bHh8SwWqg3RtetJCJrHfhEkrqsLrq1BhvVvyRkLTcuDPwUElZCsyuLZlTPUpol8xH1
         qnyxj5GQIgKtJOLTWUW93C7UW/dDVVSzB3fQEZUSfsHBuepP3nMw5VLmesZVfmbFWOMP
         mfAGCDtFN8kcPOCm2yqC/SwuSaQOwW4eZ9lPUrGlwtZyf867HmdIqiHvU1Q5gOVD3bdW
         tlUvwaymEg+7mYNwENX1rcaxZQ/6jrpVsjwqQC7U/pvflJCccd49nxnR75N7uIgX79O+
         x9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K88RNWTe7YAd6gktueP90sT+q3Uq4wmmn8gMxnEgk5o=;
        b=FfMfHUDCizak4aHf3U5qVmKcNdS0pfR6njDE/GjYN0t2RtMF4H5qMMdCLbgXM6diK8
         Q3a/0skkD6NrjQ5c4DfwYkkrqWJXPOM+TdgFQWQien01Z395ocCNJlZyM+Pvh/wCbkqd
         t0aDsC+haOp36LSdJPoUDQpPCnxjlfzHPBHi9uVqDHpCo6z8QkQNBFciNmPyEFLNIY3P
         Ny8xOuxMhRSmRG+MOY6hj7Aad7kKEDnZqU3uBAzZte4Qs14EmigpJ0pAoXJzwnNDc6LR
         d1Um77k9/ZleDHZsToddvR/K+k/YLGXMDBmf0MDA8cADSzGwLbD0deV8uGgfoz1rDvAT
         PFTg==
X-Gm-Message-State: APjAAAXDWf+mFZd3PceygfSsODIgBfdzLZbf+xnbM1jaOwmznRfcWdYW
        8hD7j6MwK7elDs1z9mZPAKYcGkpWf+aJK7R2+4pI1g==
X-Google-Smtp-Source: APXvYqx0mJU6CA5Wm3wK/FLnq4aCE7sXDmboZyD9Xajj0T4vcrnNUtY3FFi4gFvjeR/gIAsSD2jZCSeXVt8mjOx/L6Q=
X-Received: by 2002:a1c:c910:: with SMTP id f16mr9534209wmb.47.1554054238928;
 Sun, 31 Mar 2019 10:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190329234423.5611-1-colin.king@canonical.com> <20190329234423.5611-3-colin.king@canonical.com>
In-Reply-To: <20190329234423.5611-3-colin.king@canonical.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Sun, 31 Mar 2019 19:43:49 +0200
Message-ID: <CAMGffEmMjSc-juQcO9eQ6AVc9OTh8POd4Xi0SbVYtt5Fk=NyQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: pm8001: fix spelling mistake, interupt -> interrupt
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>,
        lindar_liu <lindar_liu@usish.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 12:44 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Rename the functions pm8001_chip_is_our_interupt,
> pm80xx_chip_is_our_interupt and function pointer is_our_interrupt
> to fix spelling mistakes.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Thanks, Colin,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>

-- 
Jack Wang
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
Phone: +49 30 57700-8042 | Fax: +49 30 57700-8598
E-mail: jinpu.wang@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
