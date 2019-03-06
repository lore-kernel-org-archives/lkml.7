Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F223820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCFNhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:37:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCFNhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:37:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so12768270qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 05:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3aSfJJJ8m1fpSiwYywB971Ba62TWMm4dkGWM4MFHBo=;
        b=CBEFgS2PKVALdiZoqIhqKOPnEJUWlILr6PZU2xgTbPupV2pavfBeLM5tCG2KALyw47
         KFOdICbef2X8WjF10o9HNDvvOVWRdXm+nOxEAgoPiJRAakPWPigkosLe690OTaQ5hS8N
         q6hiKkrTbKEiKjex+B8fI1/eKr/dhIoPlUJIGCe5mOQ1Hp0ULb+WoxJiaSfNWZhn04Pb
         QVQzF8UKbHlSI/nFoZfJexNv1FjNWH8c40ZQfV0Lpb8devvW5PbS2cdGxDzoi8Ut4X4t
         wroRHl4MdjeFWWCemUPCqUzKWMUNr6NwAMrZ/XgrJHg/OVHvNo/pwoF6DkqcW0EZzFES
         +97Q==
X-Gm-Message-State: APjAAAWokq5IgvNLc2cs0h98qVuSNjNfyU5/tQmzppLngQtawVQAIzMz
        O8w/375IEXgS6PvoSyD+A4Xaf5+cWfp00uBUlKXPsQ==
X-Google-Smtp-Source: APXvYqysxXLBv4ftKrVSTRMS7Kbp7OpvdLC5Od/GbcP13W6Xn2omOnJ6mlkqrhTqvLq8l1kQYjcW1KO6YRSLduL6R7c=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr6132725qve.180.1551879458196;
 Wed, 06 Mar 2019 05:37:38 -0800 (PST)
MIME-Version: 1.0
References: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com>
 <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com>
 <20190306095442.GM21520@localhost> <alpine.DEB.2.21.1903061327350.1646@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903061327350.1646@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 14:37:21 +0100
Message-ID: <CAK8P3a09XrQWSBJh5-t2WhUtMGvGQRE6coGyxjNDpX2k0bAyUg@mail.gmail.com>
Subject: Re: [RFC PATCH] ntp: Avoid undefined behaviour in second_overflow()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:29 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 6 Mar 2019, Miroslav Lichvar wrote:
> > On Tue, Mar 05, 2019 at 05:42:25PM -0800, John Stultz wrote:

> So once Arnd is done with y2038, we'll ask him to look into y2262 :)

There is also y2070 (many RTCs), y2100 (some other RTCs, especially
those that assume it's a leap year), and y2106.

       Arnd
