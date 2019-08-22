Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B9923400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbfHVQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:25:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389875AbfHVQZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:25:18 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 07645A707
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:25:18 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id e22so7078993qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BobyCGhcbReGb3WBS4gHw8mqIof48hpNCYG3u+entU0=;
        b=prYC7S/f8GC+5Bv1sL4vdsU8QohWSnp/rlRt4Tvy+Iul8rVrB5JdFz91XDdTbQOcT5
         lA1qJYwljgkA8G3YageioDu+XiocrOhZGZIlBihK4P9tzxfNPwGeLICWvOA57/Np76x+
         hQ2jCBj6AtYCafJciKywj+bhfWOdHoKJ/dNg4E3FrZSKFmM+YgMpiZzLIKtu6aejfxQj
         avDgfKlf+wuagJFiNgMoUs6e/tkbubj79qs2P+HdAOjq+2cVTn4XZ68QevBqEJtHtxw1
         gIZ6cFqwKEHu6R0riX7d7JVQE0vo1uwUqa/bIctYfPUSzytreA1gs1EzSudN7oZJdJQZ
         FFcw==
X-Gm-Message-State: APjAAAVoe2Ip6B1M2UChofvJdVUPHbN+ENeUVoEUiC+Q5nxHN/YzFofi
        44aGTterprjHeyJqRjhzULQa5ELN3o+T/1B/t1YRQks9MuWYUZumDDRTP7WhDo6JqRwiuTp/rXG
        0AVRYML9T/IqjaP5skG4dziMrmSHvxe0L5TkPVewd
X-Received: by 2002:a37:9bce:: with SMTP id d197mr37776552qke.230.1566491117397;
        Thu, 22 Aug 2019 09:25:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCzxx9GIlrS4XEeCbX2mQfjnH5qofbbfKKPHcUlTryzHxO5TNoQ52Nj0sQTldgDLnPN/3HYP791B71A1K3g2k=
X-Received: by 2002:a37:9bce:: with SMTP id d197mr37776528qke.230.1566491117241;
 Thu, 22 Aug 2019 09:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 22 Aug 2019 18:25:05 +0200
Message-ID: <CAO-hwJ+kujRCBw-A8HV7ppLbnD-nkOsqFd3_KgCD9UBR23oq2w@mail.gmail.com>
Subject: Re: [PATCH 0/2] HID multitouch: small fixes
To:     Matthias Fend <Matthias.Fend@wolfvision.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 6:23 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> First one should prevent us to add more quirks for Win8 devices
> that have a trackstick.
> Second one is a weird device that doesnt work properly in recent
> kernels.

Looks like there is not much traction for this series.

The test suite is still passing, so I applied the series in for-5.4/multitouch

Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (2):
>   HID: multitouch: do not filter mice nodes
>   HID: multitouch: add support for the Smart Tech panel
>
>  drivers/hid/hid-multitouch.c | 37 +++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> --
> 2.19.2
>
