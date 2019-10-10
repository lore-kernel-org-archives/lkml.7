Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CD0ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2899206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp+8he4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfJJO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:56:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36941 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJJO4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:56:54 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so7124127wmc.2;
        Thu, 10 Oct 2019 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTfHJ7yUGYRYqVVh4x2cICyXwZILXfSRCuaBZOgCdJc=;
        b=Rp+8he4eprVcCaammm3Fo286/DVneMspe9y/b+zADwf3la3OoYVE/WO2rePexxpgIS
         O923Rsjah2MbLaBDaY5rb1o7IJjSVZvIxsNKwwkmVoOGS7thk4ALI3hDaE6cYt/s/gcW
         eJkD1nXBAA65mhgctIrQPZF/PPEiQAZl/JOzKFdsf84XAmiq6mrvIEnvlrsoycQrsS2O
         aMmQNRBkPTkBgwp15MrGCKhROpfgxnC99oexvwJkCtjcQ60dnKA4tuEtMd/oLccsFJxZ
         JjrGGn65DkhbkDvtw4zOsYfjHH481fZ4R8fBqFZssChCft0bVLm2pFkZAzj3qETPoNTW
         TqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTfHJ7yUGYRYqVVh4x2cICyXwZILXfSRCuaBZOgCdJc=;
        b=q8nyUfc/l1B+P2fh08UBio0sJosnf15u/daLdRnZzt0iATUC6Ch2U06Bx/Chak7qZd
         luk0f0e1oRcBg366f9Hx2sbtK5EJ41ohg86Clcha2mLhhEmvDry1poOqohr3tqDDnWXf
         4w2dlF57iuK/cN24vmW2KdmyS0PylBgcb/CcnBQpM9CfLgMsHN8B/sX1icVgveQJuR0v
         4b4n37hcYn6wybsZwUfrAZMsOCpVveyc/sRmAuZGFc0J92Zn0Y/oIaXgFZJ2++O9UlVv
         4fyIRHRF5sZY2SM8+Pdp0xPQa8Rn9sKOls+NrgeJXB2T4v2D7Mq+OKjCOhU/XolsEBaI
         DNCQ==
X-Gm-Message-State: APjAAAUIb0rm3127Sw4oXNFk4On9wbP23rNS8OHCh5SBHCqqjq7lOvpi
        Y5lqxzUWuhAamcArIzaX/a7JtgaaHcoSAWDcLK2+3fXk
X-Google-Smtp-Source: APXvYqwfu52iVlB3wyrUfhJzMP8NRttLWty7tQ4fsmlTIkxoKw0CUktp6JbWKQQJDYB9AesoMR3oHUYAoISfXJg776c=
X-Received: by 2002:a05:600c:2185:: with SMTP id e5mr8246288wme.78.1570719411937;
 Thu, 10 Oct 2019 07:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191010143232.GA13560@harukaze> <CAOCk7Nrs5W-saDLAovHP_cZbFf8sp7zA=V0iz3VkFjttv=BEmA@mail.gmail.com>
In-Reply-To: <CAOCk7Nrs5W-saDLAovHP_cZbFf8sp7zA=V0iz3VkFjttv=BEmA@mail.gmail.com>
From:   Paolo Pisati <p.pisati@gmail.com>
Date:   Thu, 10 Oct 2019 16:56:40 +0200
Message-ID: <CAMmgNdYS51ZxPDic9fvpTZkEPDP=oAVrkwTvrDsUz2_5ga4dyA@mail.gmail.com>
Subject: Re: msm8996: sdhci-msm: apq8096-db820c sdhci fails to init - "Timeout
 waiting for hardware interrupt."
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 4:36 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
>
> I'm using sdhci-msm on msm8998, so its not completely broken upstream.
>
> What speed card are you trying to use?

Sandisk SDHC 4 - i forgot to mention that the sd slot / card works
fine when using the qcomlt-4.14 branch[1], so it's definitely not an
hardware issue.

1: http://git.linaro.org/landing-teams/working/qualcomm/kernel.git
