Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4B0C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5858120850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnJ19AKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEHPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:42:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38249 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEHPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:42:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so10107807pla.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TbpLBJwELA4ZhMuiXOVpcVpNwPXzU1eiQLAkmq/LVxI=;
        b=mnJ19AKufOjGk8tvHoM9aQnTMOhsQHnP5jlo0s7U4n00Fk4GRGl0B2r4h+iwwuIY04
         C7rWtS8ncyyTu6X5I7sqqocz9LoyrcjVgLXhIqzaA7JvgSYIy5HYMhCwYdOnQ0s04GUM
         Fm8ni5HP59wCfQTyOMB1QRgHfwd7kMR8CpNWOdQ3vy9XESduTxsJBdR9XqydvnF5oPc/
         S8dxkhy7UhYr8MZ/TfvSKnsYajpNn5M4XuMDbtG6Jjc9fhfjmmsLsEjmwM7Qka6Zf4IP
         aVX/J3e/8m4G8Gr/pxxoHW9uPrsSg6M8kMHqJ2U5ElXhtK3AJyaGlWoCytik03n1GtVK
         8gUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TbpLBJwELA4ZhMuiXOVpcVpNwPXzU1eiQLAkmq/LVxI=;
        b=mHOaUfEdoh6A3DkDqk3KvaTXJJ1rrkMDT/8Jrbw86ETW1Jw/V16h5wUHHpWrKmiXVD
         gziVdzoMBQDxXi+iLIFmHMyHp3Jz5bcrnXlQZOTGzRm3oaGB0SLyYH/wZdVRtVYBaDie
         s64IzNiDA9d1U6nVREVu1T7WHHB6KfB4QtKPQsSq/GSpPrKN2QQ6D2t0l0veC44M66YT
         s4ll+uHwsUyAoFciAw/N4TqAKdvGbrSqpl9hCcTbzky1OLuKb53YULJhKrqa/LHUqjm2
         WavrISecYRzB/Cz+OaM9BQXrZD6mM83wmwh63pxaA/EeSa93l06IGkMOUyA85g8InpFf
         +dMg==
X-Gm-Message-State: APjAAAULm6la1XPji6nN0Lq15yhzuIyerZBXuWumZZjhogBucYRwslAR
        c7b9L7LVsnzZW7um2XNQT5tim6sJDHujW55OJHw=
X-Google-Smtp-Source: APXvYqyxKFSFYNXcsOge68frjTC5/yNeYCovRt6Ak6bdoDpqBQFELMHZxCDw90irFErQVc9z04/EQxw9P36whBeHqS0=
X-Received: by 2002:a17:902:9b98:: with SMTP id y24mr29157309plp.185.1557330151014;
 Wed, 08 May 2019 08:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-5-git-send-email-akinobu.mita@gmail.com> <81c0d1bd-c117-3fcb-959b-4507504021dd@intel.com>
In-Reply-To: <81c0d1bd-c117-3fcb-959b-4507504021dd@intel.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 9 May 2019 00:42:20 +0900
Message-ID: <CAC5umyjDn579iu4V1pXhKJ_PUQdNgY3LBZWgWgqQw_ZoNd88FQ@mail.gmail.com>
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

2019=E5=B9=B45=E6=9C=888=E6=97=A5(=E6=B0=B4) 2:28 Heitke, Kenneth <kenneth.=
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
> > +struct nvme_telemetry_log_page_hdr {
> > +     __u8    lpi; /* Log page identifier */
> > +     __u8    rsvd[4];
> > +     __u8    iee_oui[3];
> > +     __le16  dalb1; /* Data area 1 last block */
> > +     __le16  dalb2; /* Data area 2 last block */
> > +     __le16  dalb3; /* Data area 3 last block */
> > +     __u8    rsvd1[368]; /* TODO verify */
>
> Remove the TODO

OK.

> > +     __u8    ctrlavail; /* Controller initiated data avail?*/
> > +     __u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> > +     __u8    rsnident[128];
> > +     /* We'll have to double fetch so we can get the header,
> > +      * parse dalb1->3 determine how much size we need for the
> > +      * log then alloc below. Or just do a secondary non-struct
> > +      * allocation.
> > +      */
>
> This comment isn't necessary. You usually can't read the entire
> telemetry log at once and the header is a fixed size. You would likely
> just read the header followed by reads of the different data areas.

This comment is derived from nvme-cli.  So firstly, I'll send a patch
for nvme-cli.  If the changes are accepted, I'll update this comment, too.

> > +     __u8    telemetry_dataarea[0];
> > +};
> > +
> >   struct nvme_smart_log {
> >       __u8                    critical_warning;
> >       __u8                    temperature[2];
> > @@ -832,6 +854,7 @@ enum {
> >       NVME_LOG_FW_SLOT        =3D 0x03,
> >       NVME_LOG_CHANGED_NS     =3D 0x04,
> >       NVME_LOG_CMD_EFFECTS    =3D 0x05,
> > +     NVME_LOG_TELEMETRY_CTRL =3D 0x08,
> >       NVME_LOG_ANA            =3D 0x0c,
> >       NVME_LOG_DISC           =3D 0x70,
> >       NVME_LOG_RESERVATION    =3D 0x80,
> >
