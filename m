Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A29C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEFD21537
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpupEWon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfENOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:06:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43530 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:06:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so8329808plp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ks75yII4fjVXJ0Sia2+emZzY1vlPpVSSJvLLV+PDDdw=;
        b=CpupEWonGiNTCMxadJADqpuZsNmcH4qlx1iAzBahjQYoepVY6IB10WeFBmlzfx9gzk
         Ao8eTTo44fTCk1hSnOxivWcNggXZPbn6ncgdftQt/OVgZH6f0RB2QxUk9BZM3ShXz0mt
         78bTc5XiYvg8UVfjnOdoX+kDsmKAt73tJeLWmTZ0xDKMwIf8bGXQBgsrOp601m3/lO51
         shScBhiqorOcJ9fH0CIOoZbi59zdK1pE15PUMZg5KIHKgVsh8JKkiVLjn/i8DdxbxLWY
         qSg9qwcWCZIoEkIaj8NEJ4ZbSGMKshQWbtgtoFJoL3nP5+Jss1lu72tDD6Gsce38j+xi
         VHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ks75yII4fjVXJ0Sia2+emZzY1vlPpVSSJvLLV+PDDdw=;
        b=Ww+zM1oiQ3rITAMdfgZPzoDb25lqcU14iTxwCdiMSefqt9MqLzoIW0TleWi0Vngc2R
         yd4CtDJtmalPlJ8gBt3gEF625auEWTbFdlBxDC2fYGkywfSt8daZh6zp3JowIaRc0wQf
         CmyIupwzyLQa+F9gtPZoDrrvp/3WsTiH9VknmqkJwsTOWAwqgUKXp9W8zRGoyQPBZUzM
         OikGXPT0Wwh8as2z/Va0A25Sk3tsZTYDT3yiqjkZyZognHtZlQZZ2V9RCNOttEKzf6Gk
         1R/3EVVoMBOcpPGHsDnOVfaGf/yPdaERmXcSI5Q6rP2uHho+xSmmKNvu5jgV+0jkjxB2
         3BdA==
X-Gm-Message-State: APjAAAUHeoff1Y1GJnyzmk0zIvISdYiNrhxM4BGNGf1H6LzVoO+OWh1p
        KKDTaefAsSDdgnQaqnK2fYdy0eQ7fXEvqWI78m8=
X-Google-Smtp-Source: APXvYqxtYsQTBSYRBSVFSnKif0UVhYr/vayvs3lz1zFiKvJF56JCc7RUv/5pg3egcezTJpt8cAy7TIxBLah0XzPRAyI=
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr2447988pll.177.1557842792829;
 Tue, 14 May 2019 07:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <1557676457-4195-6-git-send-email-akinobu.mita@gmail.com>
 <1557676457-4195-1-git-send-email-akinobu.mita@gmail.com> <CGME20190512155540epcas4p14c15eb86b08dcd281e9a93a4fc190800@epcms2p1>
 <20190513074601epcms2p12c0a32730a16be3b69b68e3c9d4d0b92@epcms2p1> <SN6PR04MB4527DFC75838C3236F5D05B2860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4527DFC75838C3236F5D05B2860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 14 May 2019 23:06:21 +0900
Message-ID: <CAC5umyh6hdcAnTCDK=7nX8VxFz7LiFY6ttUmcBPXfmXN4r88rw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] nvme-pci: add device coredump infrastructure
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=8814=E6=97=A5(=E7=81=AB) 0:23 Chaitanya Kulkarni <Chai=
tanya.Kulkarni@wdc.com>:
>
> On 05/13/2019 12:46 AM, Minwoo Im wrote:
> >> +static int nvme_get_telemetry_log_blocks(struct nvme_ctrl *ctrl, void=
 *buf,
> >> +                                     size_t bytes, loff_t offset)
> >> +{
> >> +    loff_t pos =3D 0;
> >> +    u32 chunk_size;
> >> +
> >> +    if (check_mul_overflow(ctrl->max_hw_sectors, 512u, &chunk_size))
> >> +            chunk_size =3D UINT_MAX;
> >> +
> >> +    while (pos < bytes) {
> >> +            size_t size =3D min_t(size_t, bytes - pos, chunk_size);
> >> +            int ret;
> >> +
> >> +            ret =3D nvme_get_log(ctrl, NVME_NSID_ALL,
> >> NVME_LOG_TELEMETRY_CTRL,
> >> +                               0, buf + pos, size, offset + pos);
> >> +            if (ret)
> >> +                    return ret;
> >> +
> >> +            pos +=3D size;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int nvme_get_telemetry_log(struct nvme_ctrl *ctrl,
> >> +                              struct sg_table *table, size_t bytes)
> >> +{
> >> +    int n =3D sg_nents(table->sgl);
> >> +    struct scatterlist *sg;
> >> +    size_t offset =3D 0;
> >> +    int i;
> >> +
> A little comment would be nice if you are using sg operations.
> >> +    for_each_sg(table->sgl, sg, n, i) {
> >> +            struct page *page =3D sg_page(sg);
> >> +            size_t size =3D min_t(int, bytes - offset, sg->length);
> >> +            int ret;
> >> +
> >> +            ret =3D nvme_get_telemetry_log_blocks(ctrl,
> >> page_address(page),
> >> +                                                size, offset);
> >> +            if (ret)
> >> +                    return ret;
> >> +
> >> +            offset +=3D size;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >
> > Can we have those two in nvme-core module instead of being in pci modul=
e?
>
> Since they are based on the controller they should be moved next to
> nvme_get_log() in the ${KERN_DIR}/drivers/nvme/host/core.c.

OK.  But these functions will be changed to use bio_vec instead of sg in
the next version.
