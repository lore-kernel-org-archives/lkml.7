Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60236C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312212084C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaQ6X+y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfGYRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:49:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38739 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfGYRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:49:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so23669513plb.5;
        Thu, 25 Jul 2019 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2BJIslaNIswmvgTol4V5L0Vj/yDrK/SgSYfdATf9ME=;
        b=WaQ6X+y11G7pCD3oqPwkvQ6X30erNd35PMGZv+eSltcVvkE4p5xxNkBCCNDX9y+xiD
         Ox8dZIHZfNtWUODM/hWymYQSdsxoAx3vpD0nS5tIjiamIeI/iCBzQLTs1mllddbLdq/W
         NTTxdkvluSc/v+MZjjGvZ/+GV+GtYddg1XgW3uNV9JD5LS+u/U8aMLsEh7fqQquPRnjW
         foT7Jmjz5XYQ0LUMmZjL/aCfUT6wgSxuvYsNp9NeJrjMJI5kH5Qk49+3oHkitYg9z5wB
         /OZuCXqzwN3f9hLPIVK+5qvMae+9+MIxc5q553V6va1PnSLsFMtpc5p7vS9DUuKjSpBA
         H4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2BJIslaNIswmvgTol4V5L0Vj/yDrK/SgSYfdATf9ME=;
        b=uCFEaZDJ0WiE+Jeo8rT3qIy+fVJEWKP28KQiBqtS0Kyi1anMeOifQgZvOpqTl7bKTe
         36z7GuPcTogRrkVeSzb2vz4YLKH5yWofkuO7Jck5U6psO4/WCP0ck/BloqWi5kb3g7/g
         a9fH7CNdL059G52W6+wOj0OqQcI8VwRw/+HWai8G6K7NBXKGxAyTTzwhrAiMAxG6uKX/
         FKhP9/URdxf3qcooULVomBLgP1JIy7dxVemATlE4ddfL1hGHfgxfmZEKcLBZWTERSHCO
         2k3y3bQ2BVL1+vQYnZjR1vtw4LeN6hnxGtgN3RB4AM+pEyOD5UGnGImJK8EV0t3qJTD4
         feqA==
X-Gm-Message-State: APjAAAVBteaJZCrivriwgXTOF8OZqTXEZOf89rU6BUZl1lM+mJDMBfZs
        AhmgeZKN6u1DFQFV8x190RczwbazK3uAivaUeGc=
X-Google-Smtp-Source: APXvYqwhwEsYNUUkS+BYkZ9yygVXiAwC/5MQXbEH3PLWYh8PkTAUC345hfJWgphH9g+GrE9L3Q35IuTl91AK2NKlgOs=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr91275985plt.255.1564076972831;
 Thu, 25 Jul 2019 10:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190704090205.19400-1-fe@dev.tdt.de> <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <4b43316c-3e05-0ce9-3ada-db22996205b9@metux.net> <cc5bbcd7148ece53a075948f240bc66b@dev.tdt.de>
In-Reply-To: <cc5bbcd7148ece53a075948f240bc66b@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Jul 2019 20:49:21 +0300
Message-ID: <CAHp75Vct4O+P62vUo02e5iJy9JMFBDjijFf-JUxjRrMhf1XTEg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 3:54 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> On 2019-07-08 21:45, Enrico Weigelt, metux IT consult wrote:
> > On 04.07.19 15:39, Andy Shevchenko wrote:
> >> On Thu, Jul 4, 2019 at 12:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
> >>>
> >>> This patchset adds the following changes to this pcengines-apuv2
> >>> platform device.

Guys, I'm lost with this series.
So, for now I dropped them from queue, if needed, please resend a new version.

-- 
With Best Regards,
Andy Shevchenko
