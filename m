Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67475C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD5B2166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pydUdVtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfENOEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:04:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38903 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfENOEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:04:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so8697055pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A8jWje4NgcT6MshH45a0i40xgDC1LZofezqqjj0Ab5Y=;
        b=pydUdVtcvkl4WjYE6VFJSrN4kDpWkRSTw1NBe7MssMeEHZ6ZsggZmJbmNuOqLrSp40
         3rOwaurGQyLmgvoQi2+q1hK24SVNEuQJjnSgLXMnxpaGI1zPFia+UFP/j0MaoWshxF6C
         mbjWq2fHWa7nsTW/U74hhlcsRwAeixNS6Tw+RSInNmelyLnZ39Vf7nnmH1vgpmD0jKK/
         LLxDvoVhnkCq6o/EWDkCa1ho8NGMXI4vrbzEfFqIWjygYOYELmZrH+z4Ff3Bd8WQakjh
         hqRQY/UI97N9lBoOIGHk6r/fqIrDb6KzWBzRXIUlJxOF65cNXSQB99tETWcqdcXEWP4j
         A72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A8jWje4NgcT6MshH45a0i40xgDC1LZofezqqjj0Ab5Y=;
        b=LDWWWvJG2q6h2XSDNcxWx9H3c5DjFENFbcP7OgovNf/J2ZRclqgJ3Ca8nIUzizVvnz
         Tozpa2A+gMwD2TsZkq7SkJiZr684P39oozyAqIJ9jOtxxgc9H/dCxO1BZKrLbd28wcNT
         1CzSrljGAGEoevMgK+VBt6fSWrA1dAlpkOz96muFs8wcMqXHa5tIr2d9tTvWWDPmJzcm
         aBD8LEVJXXEG+vO5SNjWiyOp/yhAWL8QhxTl18FSalwYFCQCidRMkMIDQz28fkPYUZJl
         Sb8CaUujYM7/gEbxTJjpSTgjziuwBjvDBdSnLQvmiYgAv4WxrPufcVhdez5dPh5iwUgi
         T+sg==
X-Gm-Message-State: APjAAAWG/qodnTacxIsIzmDjboRWO9kdwpf3r7E9Lkfg9mGDr6ObO+mI
        kFWzNK+ELsGCeGU9VLwb05VbRPBt3Zsv6y0rlV0=
X-Google-Smtp-Source: APXvYqwGzU9z2y3Okwp6KevtAW9y0Jsw9Hlcm2aHeEkxnsnDUrKXTdXrJXdF3qw0vek9g67Nd71rQyIhnL05ez6NnqA=
X-Received: by 2002:a65:480c:: with SMTP id h12mr37371134pgs.266.1557842684846;
 Tue, 14 May 2019 07:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-5-git-send-email-akinobu.mita@gmail.com> <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4527A2B52661330D519FD618860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 14 May 2019 23:04:33 +0900
Message-ID: <CAC5umyjjjuj04mkBd3O23Stjs9s56r+F_XTSimrJbnasy5PBcQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] nvme: add basic facility to get telemetry log page
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
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

2019=E5=B9=B45=E6=9C=8814=E6=97=A5(=E7=81=AB) 0:34 Chaitanya Kulkarni <Chai=
tanya.Kulkarni@wdc.com>:
>
> On 05/12/2019 08:55 AM, Akinobu Mita wrote:
> > This adds the required definisions to get telemetry log page.
> s/definisions/definitions/

OK.

> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> > index c40720c..8c0b29d 100644
> > --- a/include/linux/nvme.h
> > +++ b/include/linux/nvme.h
> > @@ -294,6 +294,8 @@ enum {
> >       NVME_CTRL_OACS_DIRECTIVES               =3D 1 << 5,
> >       NVME_CTRL_OACS_DBBUF_SUPP               =3D 1 << 8,
> >       NVME_CTRL_LPA_CMD_EFFECTS_LOG           =3D 1 << 1,
> > +     NVME_CTRL_LPA_EXTENDED_DATA             =3D 1 << 2,
> > +     NVME_CTRL_LPA_TELEMETRY_LOG             =3D 1 << 3,
> >   };
> >
> >   struct nvme_lbaf {
> > @@ -396,6 +398,20 @@ enum {
> >       NVME_NIDT_UUID          =3D 0x03,
> >   };
> >
> > +struct nvme_telemetry_log_page_hdr {
> > +     __u8    lpi; /* Log page identifier */
> > +     __u8    rsvd[4];
> > +     __u8    iee_oui[3];
> > +     __le16  dalb1; /* Data area 1 last block */
> > +     __le16  dalb2; /* Data area 2 last block */
> > +     __le16  dalb3; /* Data area 3 last block */
> > +     __u8    rsvd1[368];
> > +     __u8    ctrlavail; /* Controller initiated data avail?*/
> > +     __u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
> > +     __u8    rsnident[128];
> > +     __u8    telemetry_dataarea[0];
> > +};
> > +
>
> nit:- Thanks for adding the comments, can you please align all the above
> comments like :-

OK.  I'll send a patch for nvme-cli at first.

> +struct nvme_telemetry_log_page_hdr {
> +       __u8    lpi;            /* Log page identifier */
> +       __u8    rsvd[4];
> +       __u8    iee_oui[3];
> +       __le16  dalb1;          /* Data area 1 last block */
> +       __le16  dalb2;          /* Data area 2 last block */
> +       __le16  dalb3;          /* Data area 3 last block */
> +       __u8    rsvd1[368];
> +       __u8    ctrlavail;      /* Controller initiated data avail?*/
> +       __u8    ctrldgn;        /* Controller initiated telemetry Data
> Gen # */
> +       __u8    rsnident[128];
> +       __u8    telemetry_dataarea[0];
> +};
> +
