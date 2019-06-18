Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E0C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6692520861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfFRBH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:07:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34586 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:07:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C87BF29544;
        Mon, 17 Jun 2019 21:07:52 -0400 (EDT)
Date:   Tue, 18 Jun 2019 11:08:03 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Douglas Gilbert <dgilbert@interlog.com>
cc:     Bart Van Assche <bvanassche@acm.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] scsi: Don't select SCSI_PROC_FS by default
In-Reply-To: <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
Message-ID: <alpine.LNX.2.21.1906181107240.287@nippy.intranet>
References: <2de15293-b9be-4d41-bc67-a69417f27f7a@free.fr> <621306ee-7ab6-9cd2-e934-94b3d6d731fc@acm.org> <fb2d2e74-6725-4bf2-cf6c-63c0a2a10f4f@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2019, Douglas Gilbert wrote:

> On 2019-06-17 5:11 p.m., Bart Van Assche wrote:
> > On 6/12/19 6:59 AM, Marc Gonzalez wrote:
> > > According to the option's help message, SCSI_PROC_FS has been
> > > superseded for ~15 years. Don't select it by default anymore.
> > > 
> > > Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > ---
> > >   drivers/scsi/Kconfig | 3 ---
> > >   1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > > index 73bce9b6d037..8c95e9ad6470 100644
> > > --- a/drivers/scsi/Kconfig
> > > +++ b/drivers/scsi/Kconfig
> > > @@ -54,14 +54,11 @@ config SCSI_NETLINK
> > >   config SCSI_PROC_FS
> > >       bool "legacy /proc/scsi/ support"
> > >       depends on SCSI && PROC_FS
> > > -    default y
> > >       ---help---
> > >         This option enables support for the various files in
> > >         /proc/scsi.  In Linux 2.6 this has been superseded by
> > >         files in sysfs but many legacy applications rely on this.
> > > -      If unsure say Y.
> > > -
> > >   comment "SCSI support type (disk, tape, CD-ROM)"
> > >       depends on SCSI
> > 
> > Hi Doug,
> > 
> > If I run grep "/proc/scsi" over the sg3_utils source code then grep reports
> > 38 matches for that string. Does sg3_utils break with SCSI_PROC_FS=n?
> 
> First, the sg driver. If placing
> #undef CONFIG_SCSI_PROC_FS
> 
> prior to the includes in sg.c is a valid way to test that then the
> answer is no. Ah, but you are talking about sg3_utils .
> 
> Or are you? For sg3_utils:
> 
> $ find . -name '*.c' -exec grep "/proc/scsi" {} \; -print
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sg_read.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgp_dd.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sgm_dd.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./src/sg_dd.c
>                 "'echo 1 > /proc/scsi/sg/allow_dio'\n", q_len, dirio_count);
> ./testing/sg_tst_bidi.c
> static const char * proc_allow_dio = "/proc/scsi/sg/allow_dio";
> ./examples/sgq_dd.c
> 
> 
> That is 6 (not 38) by my count. Those 6 are all for direct IO
> (see below) which is off by default. I suspect old scanning
> utilities like sg_scan and sg_map might also use /proc/scsi/* .
> That is one reason why I wrote lsscsi. However I can't force folks
> to use lsscsi. As a related example, I still get bug reports for
> sginfo which I inherited from Eric Youngdale.
> 
> If I was asked to debug a problem with the sg driver in a
> system without CONFIG_SCSI_PROC_FS defined, I would decline.
> 
> The absence of /proc/scsi/sg/debug would be my issue. Can this
> be set up to do the same thing:
>     cat /sys/class/scsi_generic/debug
>   Is that breaking any sysfs rules?
> 
> 
> Also folks who rely on this to work:
>    cat /proc/scsi/sg/devices
> 0	0	0	0	0	1	255	0	1
> 0	0	0	1	0	1	255	0	1
> 0	0	0	2	0	1	255	0	1
> 
> would be disappointed. Further I note that setting allow_dio via
> /proc/scsi/sg/allow_dio can also be done via /sys/module/sg/allow_dio .
> So that would be an interface breakage, but with an alternative.
> 
> Doug Gilbert
> 

You can grep for /proc/scsi/ across all Debian packages:
https://codesearch.debian.net/

This reveals that /proc/scsi/sg/ appears in smartmontools and other 
packages, for example.

-- 
