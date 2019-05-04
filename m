Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE034C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D3F206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVTjYVBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfEDOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:36:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39583 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:36:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so2865827pgi.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3/UhKsCGkW4s6b3CKLSpWg03k2UImtt0PnOB2N02e3E=;
        b=rVTjYVBl38TZ1yBXffS6DjJV4YNwnABswrZ+TCLs6fD5UhADPj7DgToHW0h/bXLgqQ
         kfcrY4jK1VlXfRQaGiHJhoMq+5vgoq6yba1hnjV/OfPeVpcxei6RT/lBQvgON/KaYTs2
         hL8KXipjeKNmuLjlacRIvlGCdVABXceYeVfkzdmtxXtQE8cuoTwnChoWX/iIgCGz7xUD
         j1HV9RevkOT+BKVwvqBOh3znIvMThd0uHxVy9+lc04uxvbEHmkW8WbAPluPycVNFkMye
         75XOIbTePGnaDHmO9SPEIOOuyDOWutWnUvuJ4HxRq10qa9mQuYyaNThjRCaM3CdSsSiF
         pXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3/UhKsCGkW4s6b3CKLSpWg03k2UImtt0PnOB2N02e3E=;
        b=CRWJbGm89C20N4sk2wb38nFINbPUyyBzlVpR3nKEhTWOkz+lQ0bi6Zy8rxthemMOQY
         RzXvzTAA1gD/77YMohSgqQF3dVMp1I9Ge0JrEk+3eazz9aNOOQHDqj1Vfbq6KSvEKZ/t
         CdJcoRkeFrbhTMpR8AKihsE4u/KDAnlRMKuGA/BdsM0V+WJR8vgBVFr5V3FLr5BYp5xq
         Y38xi/Pf9ETlqnHP/rF44+S1uGsMbM/gR1dttJOmSinw/ld8jPrTT4yV7oIO7ERoT3/d
         5hk1+1qMszdvyTx9nAqMA37F491KYKl0uTPTRyE4ltXCsPp0ZSNDdTEhuODv7pG9HWtc
         0sDw==
X-Gm-Message-State: APjAAAVT3LQBDo+4RQn4t6s3F5vs8/EdPuFKRN6jYWWkysHmEkJXlGFA
        I0n1SIfBtgKHyhbAdCcML5lySwVRzMLXaREx+N8=
X-Google-Smtp-Source: APXvYqxxlP38m6Yla41WSRx+7y8oQXHn/Bax/14XGYPPPuFOSLTT/RRUqfiOPW6k63m/lqFx4aSGAHuFK0kL3yp9n+A=
X-Received: by 2002:aa7:9214:: with SMTP id 20mr19486575pfo.202.1556980615110;
 Sat, 04 May 2019 07:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <20190502125722.GA28470@localhost.localdomain> <CAC5umygdADGrYeJy=F53Mm4bNPHmo+WY4SD3HFSRqi_cLrz9jw@mail.gmail.com>
 <20190503121232.GB30013@localhost.localdomain> <20190503122035.GA21501@lst.de>
 <CAC5umyiGbDNCtzhJioR_2EV6-6xMuZXOMThCizwJEMHi+KqxAw@mail.gmail.com> <61bf6f0b-4087-cfb3-1ae6-539f18b5b6ea@gmail.com>
In-Reply-To: <61bf6f0b-4087-cfb3-1ae6-539f18b5b6ea@gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 4 May 2019 23:36:44 +0900
Message-ID: <CAC5umygP5cQHQk2ytpNbV5yY-tQ1E-FayMugOfg5gTmnpYtnjQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] nvme-pci: support device coredump
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=884=E6=97=A5(=E5=9C=9F) 18:40 Minwoo Im <minwoo.im.dev=
@gmail.com>:
>
> Hi Akinobu,
>
> On 5/4/19 1:20 PM, Akinobu Mita wrote:
> > 2019=E5=B9=B45=E6=9C=883=E6=97=A5(=E9=87=91) 21:20 Christoph Hellwig <h=
ch@lst.de>:
> >>
> >> On Fri, May 03, 2019 at 06:12:32AM -0600, Keith Busch wrote:
> >>> Could you actually explain how the rest is useful? I personally have
> >>> never encountered an issue where knowing these values would have help=
ed:
> >>> every device timeout always needed device specific internal firmware
> >>> logs in my experience.
> >
> > I agree that the device specific internal logs like telemetry are the m=
ost
> > useful.  The memory dump of command queues and completion queues is not
> > that powerful but helps to know what commands have been submitted befor=
e
> > the controller goes wrong (IOW, it's sometimes not enough to know
> > which commands are actually failed), and it can be parsed without vendo=
r
> > specific knowledge.
>
> I'm not pretty sure I can say that memory dump of queues are useless at a=
ll.
>
> As you mentioned, sometimes it's not enough to know which command has
> actually been failed because we might want to know what happened before a=
nd
> after the actual failure.
>
> But, the information of commands handled from device inside would be much
> more useful to figure out what happened because in case of multiple queue=
s,
> the arbitration among them could not be represented by this memory dump.

Correct.

> > If the issue is reproducible, the nvme trace is the most powerful for t=
his
> > kind of information.  The memory dump of the queues is not that powerfu=
l,
> > but it can always be enabled by default.
>
> If the memory dump is a key to reproduce some issues, then it will be
> powerful
> to hand it to a vendor to solve it.  But I'm afraid of it because the
> dump might
> not be able to give relative submitted times among the commands in queues=
.

I agree that only the memory dump of queues don't help much to reproduce
issues.  However when analyzing the customer-side issues, we would like to
know whether unusual commands have been issued before crash, especially on
admin queue.

> >> Yes.  Also not that NVMe now has the 'device initiated telemetry'
> >> feauture, which is just a wired name for device coredump.  Wiring that
> >> up so that we can easily provide that data to the device vendor would
> >> actually be pretty useful.
> >
> > This version of nvme coredump captures controller registers and each qu=
eue.
> > So before resetting controller is a suitable time to capture these.
> > If we'll capture other log pages in this mechanism, the coredump proced=
ure
> > will be splitted into two phases (before resetting controller and after
> > resetting as soon as admin queue is available).
>
> I agree with that it would be nice if we have a information that might no=
t
> be that powerful rather than nothing.
>
> But, could we request controller-initiated telemetry log page if
> supported by
> the controller to get the internal information at the point of failure
> like reset?
> If the dump is generated with the telemetry log page, I think it would
> be great
> to be a clue to solve the issue.

OK.  Let me try it in the next version.
