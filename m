Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF5C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD9B222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIBa6S8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfIZKxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:53:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41498 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIZKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:53:21 -0400
Received: by mail-io1-f65.google.com with SMTP id r26so5259548ioh.8;
        Thu, 26 Sep 2019 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=07TZjLhLzFQD/d/peiuV+KiApqHJ0vC82cYd9ZCGW3I=;
        b=lIBa6S8No25wVSZ5OCudotLs3QnSkUDyAEFTtWdhBSUVnDRrlkXvLDgFtxtXdNmehK
         dAzU29e+4ePHpmLtLt0IwEaGXkMIyzPU7A698T3pNHzZAWSSYgjwoFL6rsjhY2DJIKDM
         PRVDHjGrpJNvmdprSqaC12xs6qQvoWFnLKRKXm9vdPWLiS9Q4Cx7yWE5EOpecBzXzi+n
         CpkVfEMgEu3JFob6ios7fRsgDRzLhMDxBPgs6Vf+/vqD5gh9mmpetrt0ZXZNKv4Mo9b0
         SvPrUE3Eowl0FKu+rabY1pbjGQ/uGk4fU+zZLVjV4/c+fCaLpzeXzXbliXzUp+7Bh5h3
         eLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=07TZjLhLzFQD/d/peiuV+KiApqHJ0vC82cYd9ZCGW3I=;
        b=NfqwXiUJZUAoAUq4wvXNGqMd0VC/PTViJHh2M86D7wPMnSun/YO9it3IA826BemMpQ
         TNPeKcrg7FiTfcWH4KdVSgtXK+J0XAPivc9W/S7mBulo+V29mw4yq7+QE5u3p+amoIGC
         aEwAaYUlH+BLoSi56nq8Y8vZ6Fe8QRx67L4Qdll4vUtIOGXbjoJIiBXSzSCa3UMvspNx
         IcM/l+anfyhqhlf2WCrf7wZs83BtiUMAUCBRwG2Mu6c06eMrziq7EKYByQ1l9dvw4ERK
         QXYa6+Tf4mhiTYeB5ppYE8lT1+/R76q1duRT4fLvAsSs5L37bx96Lil6Srznj7mI843L
         7nmw==
X-Gm-Message-State: APjAAAVKHQB+f0FPT7qO1MdHb22qRtTaTlfHo1fk7/2b/Oios26n41Wh
        HgMFFPsKfkRBrGHgMKw/2wz37zF5o43N7S87bVzjNw==
X-Google-Smtp-Source: APXvYqxN48IwDqdlkhPJvWfp5fy13UB08I+go8HDZg/Y1UhOHe3uy98kP5lBC01mtdXruP+pH7sTAHjdETKxcLhv7is=
X-Received: by 2002:a6b:fe11:: with SMTP id x17mr2916340ioh.6.1569495200143;
 Thu, 26 Sep 2019 03:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190902054935.4899-1-linux.amoon@gmail.com> <7ha7asuj6q.fsf@baylibre.com>
In-Reply-To: <7ha7asuj6q.fsf@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 26 Sep 2019 16:23:08 +0530
Message-ID: <CANAwSgSvPmtzCzbaLC6LOfov9e32V9koUhF=5VAaKO87EHKw8A@mail.gmail.com>
Subject: Re: [PATCHv4-next 0/3] Odroid c2 usb fixs rebase on linux-next
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, 26 Sep 2019 at 03:34, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Some time ago I had tired to enable usb bus 1 for Odroid C2/C1
> > but it's look like some more work is needed to u-boot and
> > usb_phy driver to initialize this port.
> >
> > Below patches tries to address the issue regarding usb bus 2 (4 port)
> > while disable the usb bus 1 on this board.
> >
> > Previous patch
> > [0] https://lkml.org/lkml/2019/1/29/325
> >
> > Re send below series based re based on linux-next-20190830.
> > For review and testing.
> >
> > [1] https://patchwork.kernel.org/cover/11113091/
> >
> > Small changes from previous series.
> > Fix the commit message for patch 1
>
> Queued for v5.5.
>
> I fixed up the typo in patch 2/3 when applying as suggested by Martin.
>
> Kevin

Thanks,

Best Regards
-Anand
