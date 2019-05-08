Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDE4C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF4720989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hjj/96MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfEHPyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:54:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44713 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfEHPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:54:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id d3so6107045plj.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UO6VSipa/vxLnsHx2jHyOWY71noSHX2RiG7VVCaq85k=;
        b=Hjj/96MQ0SFne889FlFXkcvcTJkOxSdQVL1Blf4CleWMC2Zv2xNO+eofyYTRunO6k8
         ykHVDgQVKXJV7YYQ0vL0ecq0xDMvDCCZXTLM2/5Oem0Rft51zSEtLTl/QwTfM32af0UD
         xCweiercawjfhsslE1qu4Ib5UtxxuNe7IJoBX6HuEu/bSnx9dczZDv8TIncfl1mE1mQE
         IuZ6Qq9mVTFUrKBCCO7A4iWGjDMdSWQP8RntBGBQsdHLDGJDJBp90bO29OHM6iCPDYlg
         AZEB2tFUVI/NTDHEFNmKzQnJZc7SmABaQPPU6mvXAkaFBZHOYJuUJTju5OeQrz7sSphM
         BVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UO6VSipa/vxLnsHx2jHyOWY71noSHX2RiG7VVCaq85k=;
        b=ZWkWe2FKSU8vn2Aw/49+y5cSz53kTcTf0xnfoiTOgCbN9xEwbkzpNlCz0qPEQiDs9C
         npdsiYp8WUeV1AtGmqLtPNjsLLYUDQLkSFuEeMA0Vs7VU/sl7LeU3RmZx52pWpb9tZu7
         XzxRWlPhYfgsloqxZsiJ+jWQARsO1bTleRlVP7rEkEdVwvYKfVULnj7VH3Xxzqo8dTjo
         B22unrSL5q+Kzwv/N4sgdRopmktvQN3npWFr5Ch2eVhzB+ObFLoJFKZSrvRWygV3stZh
         TykgLqwWuwTadS8BMCxkY0S9KfKDoieGODSt41+wipb0tUwQtpVzql+WtKDA/AAiZH+l
         CVAA==
X-Gm-Message-State: APjAAAUWMh+sUsZRcItWutUvdLauPj65h0h3hSARtD5HppP5FRttsW0r
        u0+WM/XYk2V3eczd1uu3GGnI9sJ/HBZZFwlAKHg=
X-Google-Smtp-Source: APXvYqzDDPjGn5SpAL9Wxd+yu1BRD8IWih0UstZYuhIOzBj2+3kbwyXrH23GiiqkLUklVwk7kOo5YieYktVP9zWP8tU=
X-Received: by 2002:a17:902:7047:: with SMTP id h7mr49072884plt.177.1557330893382;
 Wed, 08 May 2019 08:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com> <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>
In-Reply-To: <67f0d1ab-2edb-24ea-a4b5-62c90c1ef0fb@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 9 May 2019 00:54:42 +0900
Message-ID: <CAC5umyi032svV31SmvcR3+MgQarvhg2x9mNrYH1_2svDBzE51g@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] nvme.h: add telemetry log page definisions
To:     "Heitke, Kenneth" <kenneth.heitke@intel.com>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
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

2019=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:53 Heitke, Kenneth <kenneth.=
heitke@intel.com>:
>
>
>
> On 5/7/2019 10:58 AM, Akinobu Mita wrote:
> > Copy telemetry log page definisions from nvme-cli.
> >
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > * v2
> > - New patch in this version.
> >
> >   include/linux/nvme.h | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index c40720c..5217fe4 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -396,6 +396,28 @@ enum {
> >       NVME_NIDT_UUID          =3D 0x03,
> >   };
> >
> > +/* Derived from 1.3a Figure 101: Get Log Page =E2=80=93 Telemetry Host
> > + * -Initiated Log (Log Identifier 07h)
> > + */
>
> Is this Host Initiated or Controller Initiated? The comment says host
> initiated but everything else seems to indicated controller initiated.

Both telemetry host initiated and controller initiated log headers have
the same structure.  If this comment is confusing, it is also considered
to be removed.

> Is controller initiated even the correct choice because the controller
> would have sent an AER to indicate that the host should pull the
> telemetry data.

It seems useful to retrieve telemetry log continually with the aid of
user space tool reacting an Asynchronous Event.

Similarly, it could be useful to retrieve telemetry log as soon as the
device is successfully recovered from the crash.  (Although I still do
not find the device that has Telemetry Controller-Initiated Data Available
field is set to 1h.)
