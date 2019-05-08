Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B7CC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D220989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOJDWf8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEHQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:02:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36478 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:02:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so10728764pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=77RyMHazvG2msNzM8pf8/kJ6r9tk7sPVLtMCVG2udcU=;
        b=cOJDWf8ZIA/Ztag3fTZVNI6DZMHUE4a4eeOEZVSOp91ZKk0KrcswOhR0Zo/c/+bof/
         49MqhaXjc9e6ElZm7SZYJct/HYTSN3DoW1IWHeHqNluelE0GsgW6g8v8s2CZzrgOJy4M
         RvdeVrJKq2Z1b3F2NFCDe1h2Y4c7Y8/7S105h6gZq0duJKTwi5Zye+vNqjkh2krT2kL4
         y2lR20qSM5vElIGf+zKpVKiYhQgbgHfzUk2q/WmtbnefHitR5DUDvUHxkbDHkCC+wa/q
         vRgS9c3dliKpalhmN8dXj64Gc133LJn633t9ahWzP9ZsCbWgC8XxXBs8yuRPJO3V+cU1
         L9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=77RyMHazvG2msNzM8pf8/kJ6r9tk7sPVLtMCVG2udcU=;
        b=Dw/JL5Vt/kkZpo0CfAuIsAudWsR/bMuuFOF0bMY1h4EHDEgZEnkepc5qqjAmumqokc
         4pkmwdIJ1mRqUvn6GwmFPc8pmm6YUlYO4p1kjnhsk0CRdV8OoY20j4MZzlhiUypxTYL/
         OaAFqgfo1sSWraUVtXT6Ql6AptUcbnxd1zJEPClTPm4hozMCrcbjexz5PpNyQzaYLMfo
         kPs9CwZ4FG8Kb6aJ4glFtK74dZA20bc4NxGVYmOvZzhIPMj0HFcn6OBB/ccMzFk91rAu
         WIKXH9R89iV2ntyRCkGMwCu6D2G/2qVU+ftoKWgcys+/z9wEXF7sPBWteO+ClNfVdRE3
         u+lA==
X-Gm-Message-State: APjAAAWThTi8VRAyM4hMf7xv2aPKvtCedMnsNXYQ4XD5fxzzIBji8xcf
        bJgDaLjFfgv7NJbRkfeoIiREqlyQUyzwggd7Cxc=
X-Google-Smtp-Source: APXvYqyz/wjMooRJ76q0YSf0rxiwBcHqiAK7CCzsRN1O/AvgVg2wK45uSoc3yGKVWNRBs3YLRFDYF3XbDcDe+HdCSlM=
X-Received: by 2002:a63:5c5b:: with SMTP id n27mr38008342pgm.52.1557331352209;
 Wed, 08 May 2019 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com> <CGME20190507171318epcas5p129bb73b39447d62a7d266ed461687488@epcms2p3>
 <20190507170733.GA6783@localhost.localdomain> <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>
In-Reply-To: <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 9 May 2019 01:02:21 +0900
Message-ID: <CAC5umyjsC_ECC4c_fS5QhVY1JgfSLx6ecEPVua=0j=K+JaiFpQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] nvme-pci: add device coredump support
To:     minwoo.im@samsung.com
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=B0=B4) 9:25 Minwoo Im <minwoo.im@sams=
ung.com>:
>
> > This is a bit of a mine field. The shutdown_lock is held when reclaimin=
g
> > requests that didn't see a response. If you're holding it here and your
> > telemetry log page times out, we're going to deadlock. And since the
> > controller is probably in a buggered state when you try to retrieve one=
,
> > I would guess an unrecoverable timeout is the most likely outcome.
>
> Akinobu,
>
> I actually agree with Keith's one.  In my experience, there was always in=
ternal
> error inside device when timeout occurs in nvme driver which means the
> following command might not be completed due to lack of response from
> device.

The nvme_coredump() is .coredump() callback of device_driver which is
called when anything is written to the /sys/devices/.../coredump.
Providing this callback is optional, but simply removing this manual
device coredump method is a bit inconvenient.

So instead of directly retrieving the snapshot with the shutdown_lock held
in this callback, I'll change this to just scheduling the reset work, and
the actual device coredump will be triggered by the same procedure that is
implemented in the patch 7/7.  Therefore telemetry log is retrieved only
when the controller is successfully recovered from the crash.
