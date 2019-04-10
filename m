Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC219C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939872133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW2TH3WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfDJLDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:03:05 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51240 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfDJLDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:03:04 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so2687286itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=aCTjXqB9zw6uB6ClKE07eXlztgtEwIs0DWH7msH/NJE=;
        b=hW2TH3WOPBoM4YPTnqmTZalMW+m9nWuGWBOkLvELdGytVUk/wekIT6UeG59zc0l9co
         3pT9UK2wtQ0KqqYCme+QqnB9O6yxpXL8lxiqigeS8MNYXJhDnbm2W7yku7ttTQok3bN3
         NLZf/6bvtPwFbxBpJIRCUJNBal6K09yp5QfGZruejvdrzDnaqAqEYSStqTNGdJAtplma
         8RkHM646Y509MiZ3ggaBJAJ+xL6VtyNXEiFozWpmUiTO4TlcEx9qvJ1MoQCih6i1tv2+
         oL9vv6cj5CJCK6G6wnLoMEVnjMR6v7jw0An+26JFCm7KQC/VE+/SrNFgkHtDlNDYVlSq
         8KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=aCTjXqB9zw6uB6ClKE07eXlztgtEwIs0DWH7msH/NJE=;
        b=MFd+eMt8lv2nC0P+B6Xr1OxxPmA3YpRI8u/sYsP7M2bswYZMZvGMcjVrICQPp5BFEC
         RHnaX/wZ0ktwkHXE5+bweVuZ/HP0LPeP5F8l6cYHWOMEFv9suiRroxwS/XGlabJREavm
         36PNngglF2DOM99bvhzUW7MD47IZQ712TRkyaHemKlA2zDapGy32L1cdIzDVax0+0naJ
         yT2B3pxolGo39bOxnXrdrpCcZUXw/Ny/onbBuUYEC9NTEaBw72NtHMIEXgCvbTVmI/d1
         xgH4F9KIg1gmiw29fK+BkH3PngBIM8Uwqa5MpAym4njQ7g+ExwWfLmzzsOi5wRPedlfS
         YepA==
X-Gm-Message-State: APjAAAXX2ixrJmI176aZ7jbhTrydNJtIJENuVTwxnRWuZAfaMu863Ogk
        +cO2Kar0AWpqf4rmKdLYXlwdWR8MR4kFPoOSd8M=
X-Received: by 2002:a02:c955:: with SMTP id u21mt27888361jao.105.1554894182638;
 Wed, 10 Apr 2019 04:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190321094928.4198-1-e.velu@criteo.com>
In-Reply-To: <20190321094928.4198-1-e.velu@criteo.com>
From:   Erwan Velu <erwanaliasr1@gmail.com>
Date:   Wed, 10 Apr 2019 13:02:51 +0200
Message-ID: <CAL2JzuyHb_gfu5Suf3yaMF1883JN1667yhEwpdmoiqYrUTO2YA@mail.gmail.com>
Subject: Re: [PATCH] scsi: smartpqi: Reporting unhandled SCSI errors
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <esc.storagedev@microsemi.com>,
        "open list:MICROSEMI SMART ARRAY SMARTPQI DRIVER (smartpqi)" 
        <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there !
Any reactions to this one ? I didn't got a single comment.
Cheers,
Erwan,

Le jeu. 21 mars 2019 =C3=A0 10:49, Erwan Velu <erwanaliasr1@gmail.com> a =
=C3=A9crit :
>
> When a HARDWARE_ERROR is triggered for asc=3D0x3e, the actual code is onl=
y considering the case where ascq=3D0x1.
>
> Following the http://www.t10.org/lists/asc-num.htm#ASC_3E specification, =
other values may occur like a timeout (ascq=3D0x2).
>
> This patch is about printing an error message when a non-handled message =
is received.
> This could help diagnose a possible miss-behavior of the controller and/o=
r a missing implementation in the Linux Kernel.
>
> This patch keeps the exact same error handling but prints a message if an=
 ascq !=3D 1 income.
>
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/scsi/smartpqi/smartpqi_init.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpq=
i/smartpqi_init.c
> index 75ec43aa8df3..baf16c138800 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -2762,16 +2762,25 @@ static void pqi_process_raid_io_error(struct pqi_=
io_request *io_request)
>                         scsi_normalize_sense(error_info->data,
>                                 sense_data_length, &sshdr) &&
>                                 sshdr.sense_key =3D=3D HARDWARE_ERROR &&
> -                               sshdr.asc =3D=3D 0x3e &&
> -                               sshdr.ascq =3D=3D 0x1) {
> +                               sshdr.asc =3D=3D 0x3e) {
>                         struct pqi_ctrl_info *ctrl_info =3D shost_to_hba(=
scmd->device->host);
>                         struct pqi_scsi_dev *device =3D scmd->device->hos=
tdata;
>
> -                       if (printk_ratelimit())
> -                               scmd_printk(KERN_ERR, scmd, "received 'lo=
gical unit failure' from controller for scsi %d:%d:%d:%d\n",
> -                                       ctrl_info->scsi_host->host_no, de=
vice->bus, device->target, device->lun);
> -                       pqi_take_device_offline(scmd->device, "RAID");
> -                       host_byte =3D DID_NO_CONNECT;
> +                       switch (sshdr.ascq) {
> +                       case 0x1: /*LOGICAL UNIT FAILURE */
> +                               if (printk_ratelimit())
> +                                       scmd_printk(KERN_ERR, scmd, "rece=
ived 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
> +                                               ctrl_info->scsi_host->hos=
t_no, device->bus, device->target, device->lun);
> +                               pqi_take_device_offline(scmd->device, "RA=
ID");
> +                               host_byte =3D DID_NO_CONNECT;
> +                               break;
> +
> +                       default: /* See http://www.t10.org/lists/asc-num.=
htm#ASC_3E */
> +                               if (printk_ratelimit())
> +                                       scmd_printk(KERN_ERR, scmd, "rece=
ived unhandled error %d from controller for scsi %d:%d:%d:%d\n",
> +                                               sshdr.ascq, ctrl_info->sc=
si_host->host_no, device->bus, device->target, device->lun);
> +                               break;
> +                       }
>                 }
>
>                 if (sense_data_length > SCSI_SENSE_BUFFERSIZE)
> --
> 2.20.1
>
