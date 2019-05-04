Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30195C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9743206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWcuTvn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:27:07 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:41469 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDO1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:27:07 -0400
Received: by mail-pg1-f170.google.com with SMTP id z3so466277pgp.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YwuBHfxUv+FsNTRE8OYRjXR2YtGLoZqY0npSTmEsbfw=;
        b=EWcuTvn96WfVDGvWWPSnvmbcRd2uBXRiUVok0LeVOv7Lm/ZVRvPqql8jQsig+RYPPQ
         mhwXmmocTPWWAxZLtYPx/t3nu5shKRqPOz5UipgEP58g9vhEbQ0izwN0UiADH6ZOtu8T
         4My7UHNsA+VrGyEZa9uDAlrUIwJOxQNokLn8Gbyt8I5JuSmExn8lvfjkKxinWl+dp9J1
         7J66tmcWqCevyrh2wmgMzpEpIe2X3Ayl4U38x5jILrI90w5cjt8jfyL+Uy766tDzhO7A
         HrSBrSFWpdywz82D1vCb8dc3GjBQd4QyCx3yDodcvbNcHWJwTzl0geXdmRI+Exw5gQXq
         WM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YwuBHfxUv+FsNTRE8OYRjXR2YtGLoZqY0npSTmEsbfw=;
        b=L0bngEidmzkqH1XqcTzcWoXHJ1qrmuCYCvwU6qRJ7x9w2jMdm2UkqROuSjlL7UZj0P
         v7wAbXFq+bzipDN3yPL0JnopEtKPqCttAED2fQvXNI5l+2HqsPO3k3DCP2908FsR3fu3
         wIohCzXXz2sFDswD6MT6cUWD3sMSctPMwWS4IF8Ql6/DjZygbjjErSMxtrYrtx7ib8jJ
         3ZLC6V79hoydRx0sdrwUv2vOzv+fDIl4+f+4hAfCS6gXMAj/zGRtOPtguJ0x5Sp6f9f9
         Wd34K2FOp9RrdrkTptJRWOXL/bqePsVYf/KYbge4K7MOrNGr3cHAIGiLM5WSRlexZmfX
         8NMw==
X-Gm-Message-State: APjAAAWjPNzstMPYWIOk5AadJ84Swvp8ExgrMDL5DDr/F2TKFkVtVsyf
        i2dI3Lp6ebMDlTB2lVKBklZk0V4Qh8BSCj8IngA=
X-Google-Smtp-Source: APXvYqyjzRNY6LxBhCOHZqPyasesLIaHD+lDP6hp0I048CH4/ILXVyk1V0RMtV+/tBP8AIOUIn6Xf2Pz8gc9/tNqQ8o=
X-Received: by 2002:a63:6988:: with SMTP id e130mr19062126pgc.150.1556980026387;
 Sat, 04 May 2019 07:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
 <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com> <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
In-Reply-To: <66a5d068-47b1-341f-988f-c890d7f01720@gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 4 May 2019 23:26:55 +0900
Message-ID: <CAC5umyjsAh7aZ8JEh8=QMXpNwRdnxxfdPBDwmuVKfafG+rT-PA@mail.gmail.com>
Subject: Re: [PATCH 3/4] nvme-pci: add device coredump support
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B45=E6=9C=884=E6=97=A5(=E5=9C=9F) 19:04 Minwoo Im <minwoo.im.dev=
@gmail.com>:
>
> Hi, Akinobu,
>
> Regardless to reply of the cover, few nits here.
>
> On 5/2/19 5:59 PM, Akinobu Mita wrote:
> > +
> > +static const struct nvme_reg nvme_regs[] =3D {
> > +     { NVME_REG_CAP,         "cap",          64 },
> > +     { NVME_REG_VS,          "version",      32 },
>
> Why don't we just go with "vs" instead of full name of it just like
> the others.

I tried to imitate the output of 'nvme show-regs'.

> > +     { NVME_REG_INTMS,       "intms",        32 },
> > +     { NVME_REG_INTMC,       "intmc",        32 },
> > +     { NVME_REG_CC,          "cc",           32 },
> > +     { NVME_REG_CSTS,        "csts",         32 },
> > +     { NVME_REG_NSSR,        "nssr",         32 },
> > +     { NVME_REG_AQA,         "aqa",          32 },
> > +     { NVME_REG_ASQ,         "asq",          64 },
> > +     { NVME_REG_ACQ,         "acq",          64 },
> > +     { NVME_REG_CMBLOC,      "cmbloc",       32 },
> > +     { NVME_REG_CMBSZ,       "cmbsz",        32 },
>
> If it's going to support optional registers also, then we can have
> BP-related things (BPINFO, BPRSEL, BPMBL) here also.

I'm going to change the register dump in binary format just like
'nvme show-regs -o binary' does.  So we'll have registers from 00h to 4Fh.
