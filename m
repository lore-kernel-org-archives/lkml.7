Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D634C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07DA20679
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2DGp7sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE1OfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:35:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38134 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfE1OfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:35:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id s19so17963961otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkzNKIRiEzcSbm+tX81QK9PaQwoVmPZvfI0mhyqI/yw=;
        b=t2DGp7sN8sVDLXOxZJFvCBGPvVLq+HnkhgcsmhYupokEyvzfHN2p1xvO5klVLV9DL9
         Viv+m96xmESsM7MPNQnbS+9iC/UHCZLiTEOkngSjrgPweccvgM23B/zy1tNUZpsJYc9r
         envjIOeTJ1R9mVIgi2Sr20aaSjHzJ9/sV8XpZEe7hYnChRynDtDOkfEsF/Up3KCs50Qa
         KbfoLY20J70fNihtXZuZuFX3NtakuPvefpWPfc/g+K9/FLgrWLLEuEOEBZkQzhK1PnjU
         8w8de8yvie0p11C1a0wzRJti9yuDp+/vLcFoX+bwitObdmIp8MS5I21AtARZ3z5EJv2I
         nC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkzNKIRiEzcSbm+tX81QK9PaQwoVmPZvfI0mhyqI/yw=;
        b=qgFTf8EoqXHRlrLvhDgkJwevMpHnKBUtiWsKDUQ65TyWhgNnZ9FdebOi0tqgDMk3H2
         C9JkQo+23OuJnmY+cUtXhuUvp1nyfKOKu8zBI+bL8Qloz3+wwTTEVftNObyfEouJOpEe
         v04b2qgXz2xVMAhAN8mmdzlppHf90o2p7KcD8Ye4HnDqP4L3Ob40SYkBemL6s31z9o/b
         7TTmsoszJTmf95NOJ1VEL1ahRM9bQbvYvIV9/FywXBwTydvadujFeDxWDSeEFGFoobg7
         8zx+VwLejkaHFFWE30LmH+00IyDmZ/xUc1tD6yqyV+/ISNHMnhddGRnugaUPMc1wTzdb
         /uPA==
X-Gm-Message-State: APjAAAU2jcmA05/iGHpiupj02NtFeo3DG2gbkxk76fxZRAGnBFznbLrG
        rHhelweQUz0q81nPydDQTAo7shswX0ijis2wx80=
X-Google-Smtp-Source: APXvYqwmqSAV2f2zETkGMF8GguAlSVn6CSaem6SwBvSoEhh6XVyZPxvKm7nnj3Z03zi/JU1waoGInRTQTVetVLY7cNQ=
X-Received: by 2002:a9d:6e0f:: with SMTP id e15mr67099046otr.0.1559054120960;
 Tue, 28 May 2019 07:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiU=uFjJFEoiHFUr+ab73sJksaTBkfxvQwL1X6WJnhchqw@mail.gmail.com>
 <20190528142912.13224-1-yuehaibing@huawei.com>
In-Reply-To: <20190528142912.13224-1-yuehaibing@huawei.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 28 May 2019 10:35:10 -0400
Message-ID: <CAGngYiW_hCDPRWao+389BfUH_2sP4S6pL+gteim=kDrnb9UDzQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next] staging: fieldbus: Fix build error without CONFIG_REGMAP_MMIO
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:31 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix gcc build error while CONFIG_REGMAP_MMIO is not set
>

checkpatch.pl errors remain:

$ ./scripts/checkpatch.pl < ~/Downloads/YueHaibing.eml
ERROR: DOS line endings
#92: FILE: drivers/staging/fieldbus/anybuss/Kconfig:17:
+^Iselect REGMAP_MMIO^M$

total: 1 errors, 0 warnings, 0 checks, 7 lines checked
