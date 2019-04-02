Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC921C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34320882
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSCq4RCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfDBMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:43:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36441 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbfDBMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:43:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id e15so4297762uam.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyqWNVXvqwDdZsWajTQiUYqOuW/qC+0qbexYAa6djEo=;
        b=rSCq4RCXnDYcTqVBaV6t1vjTAMNKZMcmHxHznzS4J9nC83FNC1hGowC++Y0nHeAI4g
         XRbCD5vvPnFkWN0Dx9wyGn3/P5oZZ1zheq7h/hkZEJJ+PoTyDvBJbsLav4lTaP1Lv1dv
         CJV6yk1j5cxY3iCYiwhLnXI8dgXUCB0XxcWZKQi/plxH9XS7lz8zZ5aXWAvCK1qWee0D
         ZAd9nrjzqQ8WlKO8aXu8Sv1hEcRf4Kq+7fKTufuIxvJ3ZcE2qQdQSjKM3ISEQy7tqm3u
         V/4Tt1kTs1o+4NQc9C2pOPiAcI4+JDFHPxQFzfEpW1VSS87FNPPGMyzWesY+C2nEZm9W
         4muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyqWNVXvqwDdZsWajTQiUYqOuW/qC+0qbexYAa6djEo=;
        b=IWmaonUVBPXGvIstFyogh3MBh2SIUgpb5vjPHq1FQibU6voJvb6jjF7kF8rzN195vr
         VR5v6OBTkDv5jzWFU5CQlCht5V6ON3wfGsPxbg9NEW1sWXJO0Kc8+ulbCs0oNxw5tAzx
         oBy1oCHXu9M4zszLOj53hPkHc+9qJ/aoAxYy2/abBEHs2gfPV51q5vB+X2O8XZmk7emR
         Z907QtP/I1/MCAd+r75qxOmUW4h5D6nbi7VzOzhzAeOgTxDrEmp6XFYA3t856rM676pv
         KE1TsEJGuK1vReq4SVmddvDyoBq2+R8arPjkHY6hVsswVbNSqGsvMI/mdwV+x5C5tB4q
         xjYg==
X-Gm-Message-State: APjAAAVBGuZ6P1KeEAI1tli4UOOqqEAe2KcqKjRndAFoh6vC+7FAs6nC
        +ySzRQk6gpQiY3sXjdEMKVn5zReGTe31JyEOPTg=
X-Google-Smtp-Source: APXvYqw/4sZn2zDnEvMJhJzD5ScQ3Axd0HPBzb9Dgd6vsH7LuiiTqpPt/9YPssvzpj7bioAIZ2rP9G+b+X2MUbfOmbc=
X-Received: by 2002:ab0:2f8:: with SMTP id 111mr1452458uah.123.1554209015736;
 Tue, 02 Apr 2019 05:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190402113539.23838-1-oded.gabbay@gmail.com> <20190402120140.GB24119@kroah.com>
In-Reply-To: <20190402120140.GB24119@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 2 Apr 2019 15:43:10 +0300
Message-ID: <CAFCwf10PFS8gxjquPw0Lcc1QofH0Dk0QtaXudt-1BMdU4mofrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: add new IOCTL for debug, tracing and profiling
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 3:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 02, 2019 at 02:35:38PM +0300, Oded Gabbay wrote:
> > From: Omer Shpigelman <oshpigelman@habana.ai>
> >
> > Habanalabs ASICs use the ARM coresight infrastructure to support debug,
> > tracing and profiling of neural networks topologies.
> >
> > Because the coresight is configured using register writes and reads, and
> > some of the registers hold sensitive information (e.g. the address in
> > the device's DRAM where the trace data is written to), the user must go
> > through the kernel driver to configure this mechanism.
> >
> > This patch implements the common code of the IOCTL and calls the
> > ASIC-specific function for the actual H/W configuration.
> >
> > The IOCTL supports configuration of seven coresight components:
> > ETR, ETF, STM, FUNNEL, BMON, SPMU and TIMESTAMP
> >
> > The user specifies which component he wishes to configure and provides a
> > pointer to a structure (located in its process space) that contains the
> > relevant configuration.
> >
> > The common code copies the relevant data from the user-space to kernel
> > space and then calls the ASIC-specific function to do the H/W
> > configuration.
> >
> > After the configuration is done, which is usually composed
> > of several IOCTL calls depending on what the user wanted to trace, the
> > user can start executing the topology. The trace data will be written to
> > the user's area in the device's DRAM.
> >
> > After the tracing operation is complete, and user will call the IOCTL
> > again to disable the tracing operation. The user also need to read
> > values from registers for some of the components (e.g. the size of the
> > trace data in the device's DRAM). In that case, the user will provide a
> > pointer to an "output" structure in user-space, which the IOCTL code will
> > fill according the to selected component.
> >
> > Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/device.c              |   2 +-
> >  drivers/misc/habanalabs/goya/Makefile         |   3 +-
> >  drivers/misc/habanalabs/goya/goya.c           |   1 +
> >  drivers/misc/habanalabs/goya/goyaP.h          |   1 +
> >  drivers/misc/habanalabs/goya/goya_coresight.c |  13 ++
> >  drivers/misc/habanalabs/habanalabs.h          |  25 ++++
> >  drivers/misc/habanalabs/habanalabs_ioctl.c    | 123 +++++++++++++++++-
> >  include/uapi/misc/habanalabs.h                | 116 ++++++++++++++++-
> >  8 files changed, 280 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/misc/habanalabs/goya/goya_coresight.c
> >
> > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > index e3797f582436..6cbfd560721e 100644
> > --- a/drivers/misc/habanalabs/device.c
> > +++ b/drivers/misc/habanalabs/device.c
> > @@ -1044,7 +1044,7 @@ void hl_device_fini(struct hl_device *hdev)
> >                       WARN(1, "Failed to remove device because reset function did not finish\n");
> >                       return;
> >               }
> > -     };
> > +     }
> >
> >       /* Mark device as disabled */
> >       hdev->disabled = true;
>
> This change isn't part of this new feature :(
>
I'll split it up
Oded
