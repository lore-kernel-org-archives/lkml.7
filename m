Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E53C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B1920835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUfr4toC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCTAtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:49:24 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51505 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfCTAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:49:24 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so29071001itl.1;
        Tue, 19 Mar 2019 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6ZmU8RH3kZEJ7cTWiZiVzlEIo9tb9b5FAkkpXmhF+M=;
        b=hUfr4toCN2xzTgVy6w6QSckL2xcIfyJP/j8iVR+WDbxTMHrygNbZQ+WfxazwC8hVVa
         jQqyBtLUkhpH+D4cdsiFGsF4Bi7+2WsvF78T0dj7PUeTfm1F3voTcq40gZSOHRefGYJk
         rwRy/qc+212PQcfwmqsyqu187dNdVBgCNBtO0m+q79IwC7wZTXO5YGPX4YfrR6SusSs6
         b92InqktY9WtHrYsQ8ldYrjJ8u2n16Zi6Kyn2+RQTM9URxekXZBd+DfWEVQjo6M04lL4
         0Zukc8vA3oE+wQCW58HXP5aM6eHeKzqAsq06NI0J5wIZyNf3MIq4RcHdogZd7kjBzjw9
         5XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6ZmU8RH3kZEJ7cTWiZiVzlEIo9tb9b5FAkkpXmhF+M=;
        b=Kb8Tre+39Josw1WFJgzr/UnFafh5RNRwgq8MOe2DXihLSfJqy1aidVPk5Dqk2zzYLO
         2p73tb18U7k0FWyD9u0lYutXYhEboJSc7hnqlNzJkDIUWpFYEexgoHNJn+oFQork+UBh
         6/sP5kP24MxPNgU6Y3hVYzEZ9G328gFn6G9AH8X0Ugf4yIlHIbnYjRm0PaGekBnOgRVH
         b0jLsUhDPoaSGP8Eu53nXaj6qILBQj4h/GvSQMFV5cvXzxWOYvNcOSJsQdyO9qiY0h3f
         Qd1ExbW8UrBRyJRmaTypsSWVMJ8QXc1IRWsq0PLo0JqUma/r2gxfblgXdsNi6tXjIN26
         PqWA==
X-Gm-Message-State: APjAAAVrJCesqDISWDaptLlaFewTnUoKRN76GKlfCfqQPm7kCVH621e+
        hRFZ/FQyUQLOKqpwqOH9ExFISmAULPVmI6fMoulEVRsCgmTTug==
X-Google-Smtp-Source: APXvYqzkIOBojYOqTyr2csUkhcuWohViHjyeQiv2HsY+4ZOce855nijwOYlJLrWHRRSIrbqykAALE0tEp1JZaNkWEEY=
X-Received: by 2002:a24:7294:: with SMTP id x142mr2994668itc.26.1553042963541;
 Tue, 19 Mar 2019 17:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <1553013397-29263-1-git-send-email-chongguiguzi@gmail.com> <20190319192242.GA3773@ziepe.ca>
In-Reply-To: <20190319192242.GA3773@ziepe.ca>
From:   =?UTF-8?B?6LCi5qyi?= <chongguiguzi@gmail.com>
Date:   Wed, 20 Mar 2019 08:49:12 +0800
Message-ID: <CAJ3e5OamBadQ7e1-hmS=rjCwTAa9LiUVJH3+nc1kRCymV5OPcQ@mail.gmail.com>
Subject: Re: [PATCH] infiniband:qplib_fp:move spin_lock_bh to spin_lock in tasklet
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        dledford@redhat.com, nux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was only called in the tasklet context.

root@jeff:~/git/linux-next# git grep -in  bnxt_qplib_service_nq
drivers/infiniband/hw/bnxt_re/qplib_fp.c:236:static void
bnxt_qplib_service_nq(unsigned long data)
drivers/infiniband/hw/bnxt_re/qplib_fp.c:390:
tasklet_init(&nq->worker, bnxt_qplib_service_nq,


  thanks.

Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2019=E5=B9=B43=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=883:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 20, 2019 at 12:36:37AM +0800, Jeff Xie wrote:
> > It is unnecessary to call spin_lock_bh in a tasklet.
> >
> > Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> I'm curious, how did you prove this was always in a tasklet?
>
> Jason



--=20
jeff
