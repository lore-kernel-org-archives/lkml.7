Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF2DC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 04:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26617206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 04:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZjC35cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfEDEVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 00:21:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39293 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfEDEVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 00:21:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id e92so3659087plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 21:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2niQZAcO4B3TuA0Jbh10gmhcQ5R1+7CidbDlWs5As80=;
        b=FZjC35cra7t9JQGvg+nlN0g+upkodunL99cIB3S5+l4mYslGpxQzpLFtsrkrG3a6ro
         vo8agCB/Im8sQ7/jbw/cwVF+GZhkDLRRDz93f6fgS7YDz4bTr9c6EW3qE1hkDOdo/DyK
         t/LhOUE0bOx3Ld15nSLQN1CCKFPJOqKKZ4syPxMRajwzWQKMwYFYciItHXCyhgM1tUry
         8LFtKqYte6KyG0K/BBbs0y1ZN4AzgijoOJ8CLdaoUE9of/xdE6Jo3rFJo95nduWoT1u3
         MwralEvoxASdTTm3tcgrgOeEKgRuX5fGEhZFYfRU6geuBWEI2DYeG2PEyys8/mk9mvG3
         xBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2niQZAcO4B3TuA0Jbh10gmhcQ5R1+7CidbDlWs5As80=;
        b=XuTlaq8JeLSz1iURtI6BAx8MC7TZf8cgLuiAX3aucZl8qgRhgM7oz8NpmpFSlCBnWT
         cl/I3iklLonkdgeu8BSUnvLxooVbb3iY9LW5Ndf29kR2vuyksxPgvBcy37XWHgSm/rdl
         mXbQTb5CXnFeOa0GnHkeKr1eOidJaPgmT2y9GC70mr7exBw6mKC97cVSOTghaN6Pup5O
         1YsKwPmOj5N/mCD9EtB7153Edm51I5+Jt2VE7Rd+LCIC1EMpYIIY3/haM49xA+mObklJ
         cGp+Byf64hDdx4/3oeEUMVe16xvogMoQRVntCsWZRKCigR9cv183yUAKpb5azI+Wk/B7
         ZSuQ==
X-Gm-Message-State: APjAAAVyoDdrfeEOdJhZfBuvGRkUEI2ukSQdJaotE5PMuLOCW2BRhpkP
        QcjdwNb8ujBD+gZX5K7DRNwAwTJAKBkvLW3cZjo=
X-Google-Smtp-Source: APXvYqzk08GW18+GoiHSeLiPXxG5WmUXmSoYcOlyzQXVtB3rSOe/11xTKxDCshE4SRkYoGf5dkwKMxrfxUGEACuM7k0=
X-Received: by 2002:a17:902:5995:: with SMTP id p21mr15757134pli.216.1556943661646;
 Fri, 03 May 2019 21:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain> <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain> <20190503122035.GA21501@lst.de>
In-Reply-To: <20190503122035.GA21501@lst.de>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 4 May 2019 13:20:50 +0900
Message-ID: <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=883=E6=97=A5(=E9=87=91) 21:20 Christoph Hellwig <hch@l=
st.de>:
>
> On Fri, May 03, 2019 at 06:12:32AM -0600, Keith Busch wrote:
> > Could you actually explain how the rest is useful? I personally have
> > never encountered an issue where knowing these values would have helped=
:
> > every device timeout always needed device specific internal firmware
> > logs in my experience.

I agree that the device specific internal logs like telemetry are the most
useful.  The memory dump of command queues and completion queues is not
that powerful but helps to know what commands have been submitted before
the controller goes wrong (IOW, it's sometimes not enough to know
which commands are actually failed), and it can be parsed without vendor
specific knowledge.

If the issue is reproducible, the nvme trace is the most powerful for this
kind of information.  The memory dump of the queues is not that powerful,
but it can always be enabled by default.

> Yes.  Also not that NVMe now has the 'device initiated telemetry'
> feauture, which is just a wired name for device coredump.  Wiring that
> up so that we can easily provide that data to the device vendor would
> actually be pretty useful.

This version of nvme coredump captures controller registers and each queue.
So before resetting controller is a suitable time to capture these.
If we'll capture other log pages in this mechanism, the coredump procedure
will be splitted into two phases (before resetting controller and after
resetting as soon as admin queue is available).
