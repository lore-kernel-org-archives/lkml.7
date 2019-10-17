Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321C1ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0233021925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcMp4pfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441201AbfJQR5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:57:22 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43558 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbfJQR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:20 -0400
Received: by mail-il1-f195.google.com with SMTP id t5so2904819ilh.10;
        Thu, 17 Oct 2019 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcS5hYdP3pCxm/yZLIGrFm7va/wuB5toN9M7cwBJfq4=;
        b=BcMp4pfGIFOkf4xxZpY2CD5fOpV+6Bj+/idbEiDyJxt8lqnXd3BVwPpM6QI7ja6+aC
         TwG4M7vMynFU9QefpWHLDy9erHpgm4+zTzlX+6+qXJQjIvo1y3AxxKMIChANbvT58y/D
         7Vb908VUCtNaCeGApGvG6TAFpgFPwg2GmOdbx37rhNuZ4K0mD3ULJMNZ3/Sbg0M4ks2F
         5eQsVXgVW1yU/LpdjCGtU/AKeK9aIdyUeVYZCFDh6tPeLMNs1q7HWaz3WrXh2Y3u8cfm
         UoMsLXLym1pooH607OikvQwcu9wFJWEo3nokTGPMVgy8MzgJIPQ/RBc/szzs7bBNEGWq
         mTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcS5hYdP3pCxm/yZLIGrFm7va/wuB5toN9M7cwBJfq4=;
        b=StpBZvcdLrnee8TWJmWaDm9B7mntFCFenfaejkF/dVEcV3z9G+B2ANsrqrkni93+8h
         4dUNqTWMadvk/9fHPpcK7SevEFjBN2vuvFBwdseqHe5TidGx1YiEO4uIucIxaaHIFzb7
         EtH/umQ+YNtAhKXE1sNahmZAsF3pTbCkovobRUBn/G7ZKl1SEdbvFdfH9oSgYP8rGgS8
         2bJxf3FcpX/7SzTdhT3rrmPKg6guf1YFVXstDGNwFJ3t3iUhmsrXUc+zHlr62olt3Vzy
         MprKVD+bWVbp0qmprWLDN1ggNO1SC5MkAJkvEmq7vyiw5qHuUaXv3rYAvmrTPE9y/0ef
         PMsg==
X-Gm-Message-State: APjAAAXUjVviVrFmSHtKaGxZuWJdGPD9hMXQtJdiISupSZGl908xB1Jf
        N4xRfngeGpFaIgZbM8eXSDGNuyYjSpbDFAFjdx4=
X-Google-Smtp-Source: APXvYqykU6l9b4dn91QLAmg0FiFZO3jTjHvdjb5410032UJVHmHeljk5z6DlHlsHPFhD+w3YNWHsIQg0GHMBWHSh/bM=
X-Received: by 2002:a92:d652:: with SMTP id x18mr4948635ilp.58.1571335038402;
 Thu, 17 Oct 2019 10:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191002114626.12407-1-aford173@gmail.com> <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
In-Reply-To: <1550E9D9-43ED-4345-A9AF-6D9F097FC64E@holtmann.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 17 Oct 2019 12:57:06 -0500
Message-ID: <CAHCN7xKA9-K4uYU9oFW+A7ywc8TGixNa-yHJgL7uSTbyXnisTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: hci_ll: set operational frequency earlier"
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <adam.ford@logicpd.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 1:36 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Adam,
>
> > As nice as it would be to update firmware faster, that patch broke
> > at least two different boards, an OMAP4+WL1285 based Motorola Droid
> > 4, as reported by Sebasian Reichel and the Logic PD i.MX6Q +
> > WL1837MOD.
> >
> > This reverts commit a2e02f38eff84f199c8e32359eb213f81f270047.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> patch has been applied to bluetooth-next tree.

Any change this can get pushed upstream to stable?  (including 5.4?)

adam
>
> Regards
>
> Marcel
>
