Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE864C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53C7218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjU2r6QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCVB4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:56:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:56:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so599886wrx.9;
        Thu, 21 Mar 2019 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GjMj2peYypvLpdXn1BdiiW/yZpQFLYROv+hnZxnQLHM=;
        b=NjU2r6QMuiyaHTo/TcxCQxAeWgebLqFaZCTbj0SJe8SUFMp39hcJKz5DwkHjEFy4hg
         ilJSH8O6sHgu5nbQbb2sRZlNEtDdZqrJdCpN35YBmp8vtYyVfmhbxw/ajQRPbb6x3Ouk
         obXrMOYWGkdVxQPM1dvmFuZH0VtIvf+cgT5Wg9meinWHqVIwNR/rENGKgQsrHNPK0Wlz
         +lnsuLhv6eTew9x+t2VKQ71gCi0+KdpqwM5MRc9Lb+nIOOpOnwGh/aA+z0GaHyb3qx0N
         V5lY1jOpeJDMYWnTGY9GQjCnD59L0v/wuAE1QPPI50YfSjDSKPbwDdxuto9/qnIPmBuU
         FkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GjMj2peYypvLpdXn1BdiiW/yZpQFLYROv+hnZxnQLHM=;
        b=pDZSP+FSaDu+Lg4yX8JFkYrS+Coe1sNzoFBfjPKsdigi4u2NE4YYtByFZoJuwbVNEH
         PCp/LnrL1Bh5pi1rleOV2ieS6FUc1SE/ugzrd2p8+T/thQMRvnle6FgByxNexTPg/N/G
         /fRrbA21ztClll7cCi8fuWTwB5X0NGdxMhHSCxtSrTh8BvQYw5h25+gERl6CtzduD6hQ
         zxFrd4Pxn9Fik/9nk7kJIma1r+pgMD+2Q7uwaqv7QSvP4nxGTvyjx0ZOQYxKMpvkkBLb
         qJqg5BiyuRFqCtlLuXUNjNB8TPnB9ehfVeFpGJZNOOU+6i94v19edRzIzMFMGMJ+nEnL
         KHGg==
X-Gm-Message-State: APjAAAULoT/AFehVIMDZhQOkmVaLODB/Qe2sVF2QE4yXshM4Jc0mS/Fw
        TMYDThWqRi+OdjaSFRTCPRsIxlrNgwGUF4htvDk=
X-Google-Smtp-Source: APXvYqwcxrmU708hbNZf7Pm25A7NliWKPTJSwRbnRFkgtcPgnnJ37GzF+Ay5x2A6DzboEl7a/1/4VkuHGSUxTdSrt6Q=
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr4393006wrr.275.1553219769245;
 Thu, 21 Mar 2019 18:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190316020905.14962-1-yanaijie@huawei.com> <1553193542.65329.119.camel@acm.org>
 <CACVXFVOeh_H9R8G0W=WHT9aaOm2K60HhEPbg9Okd58dhQ4Pm8Q@mail.gmail.com>
In-Reply-To: <CACVXFVOeh_H9R8G0W=WHT9aaOm2K60HhEPbg9Okd58dhQ4Pm8Q@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 22 Mar 2019 09:55:57 +0800
Message-ID: <CACVXFVPatx7RV9OzfX2yTEb68t57o6UbsOpzq6igEgU7k4-W4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] scsi: fix oops in scsi_uninit_cmd()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Yan <yanaijie@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:36 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Fri, Mar 22, 2019 at 2:39 AM Bart Van Assche <bvanassche@acm.org> wrot=
e:
> >
> > On Sat, 2019-03-16 at 10:09 +0800, Jason Yan wrote:
> > > If we remove the scsi disk when running io with fio, oops occured wit=
h
> > > the following condition.
> > >
> > > [scsi_eh_0]                              [fio]
> > > scsi_end_request
> > >   ->blk_update_request
> > >     ->end_bio(io returned to userspace)
> > >                                          close
> > >                                            ->sd_release
> > >                                               ->scsi_disk_put
> > >                                                  ->scsi_disk_release
> > >                                                      ->disk->private_=
data =3D NULL;
> > >
> > >   ->scsi_mq_uninit_cmd
> > >     ->scsi_uninit_cmd
> > >       ->scsi_cmd_to_driver
> > >     ->drv is NULL, Oops
> > >
> > > There is a small window between blk_update_request() and
> > > scsi_mq_uninit_cmd() that scsi disk may have been released. This will
> > > cause a oops like below:
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000000
> > > s/sync.c:67, func=3Dxfer, error=3DIn[11347.116050] Mem abort info:
> > > put/output error
> > > [11347.121598]   ESR =3D 0x96000006
> > > [11347.126200]   Exception class =3D DABT (current EL), IL =3D 32 bit=
s
> > > [11347.132117]   SET =3D 0, FnV =3D 0
> > > [11347.135170]   EA =3D 0, S1PTW =3D 0
> > > [11347.138308] Data abort info:
> > > [11347.141186]   ISV =3D 0, ISS =3D 0x00000006
> > > [11347.145019]   CM =3D 0, WnR =3D 0
> > > [11347.147977] user pgtable: 4k pages, 48-bit VAs, pgdp =3D
> > > 00000000a67aece2
> > > [11347.154591] [0000000000000000] pgd=3D0000002f90774003,
> > > pud=3D0000002fab098003, pmd=3D0000000000000000
> > > [11347.163304] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> > > [11347.168870] Modules linked in: hisi_sas_v3_hw hisi_sas_main libsas
> > > [11347.175044] CPU: 56 PID: 4294 Comm: scsi_eh_2 Not tainted
> > > 4.19.0-g8052059-dirty #2
> > > [11347.182600] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI
> > > RC0 - B601 (V6.01) 11/08/2018
> > > [11347.191370] pstate: a0c00009 (NzCv daif =E3=B0=83=E7=B9=90=CE=B5=
=ED=9D=BE=E3=AF=97
> >
> > Please verify whether the following patch is a valid alternative for yo=
ur patch:
> >
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index ed34bfbc3844..745ffdda1bc1 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -1408,6 +1408,7 @@ static void sd_release(struct gendisk *disk, fmod=
e_t mode)
> >  {
> >         struct scsi_disk *sdkp =3D scsi_disk(disk);
> >         struct scsi_device *sdev =3D sdkp->device;
> > +       struct request_queue *q =3D sdkp->disk->queue;
> >
> >         SCSI_LOG_HLQUEUE(3, sd_printk(KERN_INFO, sdkp, "sd_release\n"))=
;
> >
> > @@ -1417,9 +1418,12 @@ static void sd_release(struct gendisk *disk, fmo=
de_t mode)
> >         }
> >
> >         /*
> > -        * XXX and what if there are packets in flight and this close()
> > -        * XXX is followed by a "rmmod sd_mod"?
> > +        * Wait until any requests that are in progress have completed.
> > +        * This is necessary to avoid that e.g. scsi_end_request() cras=
hes
> > +        * due to scsi_disk_relase() clearing the disk->private_data po=
inter.
> >          */
> > +       blk_mq_freeze_queue(q);
> > +       blk_mq_unfreeze_queue(q);
>
> It is over-kill to drain any requests here, what we want is to just
> drain any in-flight
> IO requests.

Not only over-kill, actually it can cause big performance issue, since any
block/scsi utility may trigger the freeze/unfreeze.

Thanks,
Ming Lei
