Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCE8C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA252173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="KBD05kY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEILYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:24:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45664 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfEILYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:24:21 -0400
Received: by mail-qk1-f193.google.com with SMTP id j1so1154221qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCnlS/Os4iGWNFisP3kaeJDg2CdWLlxOhgRwG4awIx4=;
        b=KBD05kY1U/p8AkeRQqKt9DacXyP8UQYpamDfplN6tJcVhL/BskcqjpJI9Nopif++ln
         bp1FlfXIu8sfMMqXBcXLve4fnRhSRUjJw/wPFLvYitGGT1+TRgYKozqzpubNShKAbV5P
         9zIQes4kTP21dtL/wRF0nXGdfu5gTNqTuJKJs2UAz9QDlakBRfufoA1CAGd3JuwOpsiq
         s2kn+hhcPuBieVnK+qRtC+5klBsrzieeJ+fqVhPKTL16hVVMQ2b6oIEDnALx0rwClPPz
         J3TO+t9Jswjux3vYA0ITXSMbulWyT2Ba8FLklcVDli1sSV6a9Y8IyoRGs6AYClviOoo2
         ffTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCnlS/Os4iGWNFisP3kaeJDg2CdWLlxOhgRwG4awIx4=;
        b=eOKFk7xQZ8dqLsclOlgpqp4+QOOt2z2+LM/QmVfDARnHwqZ2880FFwwDFoput+Z/Wz
         mFWcIZj8UxKm9qBnQJmt7lkP6leAg2NXlZEWTaqeFiAbYVAvcArj48jvHS6ahoMT90hC
         kWp2BAMieaO23di6YaN6cd8QFZdoXppLpJq86dsandMX+ouK9VOyUGe00nR2wXVRcBfc
         f2Qb0rMF5mOw9AIgtXgzactAL32VTWi40boVfywcnrTxJ6B5GSpCM5cyXq4plg7bJAhI
         xR8Ylym/xtz56o/ggAhDrV8RmuDVqtdO3gkGWR/XjN5o7xfZQyYSie/L2iT2KdjwEDky
         v7Wg==
X-Gm-Message-State: APjAAAVO7DKxGe3o67mIb7/gxSiMk+7toTkAlQZlmH7i3llvxbH0GVsu
        ZkmnoSIqfIvypgwyymq/jB6UVPBjRgZym68IIBz4Ug==
X-Google-Smtp-Source: APXvYqzwIaznoFAT/zWqbH4CeaZXP5SqI/lPwmVbnP/H/Hxa5P/Zsau6AOS0KHx/uOaaP009y/M2WPeFkeEbu4pxRZo=
X-Received: by 2002:a37:f50c:: with SMTP id l12mr2768120qkk.175.1557401060787;
 Thu, 09 May 2019 04:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com> <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
In-Reply-To: <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 9 May 2019 19:24:09 +0800
Message-ID: <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] rtl8xxxu: Add watchdog to update rate mask by
 signal strength
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 5:17 PM Chris Chiu <chiu@endlessm.com> wrote:
> I need the vif because there's seems no easy way to get RSSI. Please
> suggest if there's any better idea for this. I believe multiple vifs is for AP
> mode (with more than 1 virtual AP/SSIDs) and the Station+AP coexist
> mode. But the rtl8xxxu driver basically supports only Station mode.

Yes, the driver only lets you create station interfaces, but it lets
you create several of them.
I'm not sure if that is intentional (and meaningful), or if its a bug.
Maybe you can experiment with multiple station interfaces and see if
it works in a meaningful way?

Daniel
