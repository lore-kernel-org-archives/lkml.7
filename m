Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8909C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5BC207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="GdLHRxhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfFFL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:57:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38128 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfFFL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:57:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so2123421wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VvMAoYB96Ne6gNiw7p4GFcBlSUcy3tQ2OsEurFpYOpk=;
        b=GdLHRxhx1Eu+J3NK1DpIviyVH+JsheaELn3+MZJvUpurQ7ZbpnhuXpC98K777RsjtZ
         Ur0j4Bq8CVjlMS01NwZh+H91f9E6zGSmWvoOhDoE6UZ5w/HSwnwM9yKARE9w96fkBwjD
         M7QoOMIYuwT23+B/IzP2d22c2QtofMPh61bSS3AEXKDZJgHwtO/mo5BRHDStfYb5F+8Y
         xxYCNpLUck7plVgsMT0yAVLkh704eDLhMqpNJRxofjGuniSOhR1RspZPAGN5+vD8NAhE
         gajHo5nNnB4NS/LLe5CDX989n5WFdK31oJuJaK4s5mjlJZUzxUR/qIiU7zj07bvp5ufw
         SCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VvMAoYB96Ne6gNiw7p4GFcBlSUcy3tQ2OsEurFpYOpk=;
        b=BJwaOayGAUM7q/OyWt5xUmeyNIPnmT1wOHHJq0uKeRmn5hC23rnFOOL+9dR/FzJ9dz
         Qq4cY4qO5DHIhU3PpiNi0NzCD55uRoHwz3q7puUicyFikCdvg43Y03UkGDfJpDNs5Q1L
         WdHH0yw0wOSzj/bzoxa+hm8R/XaGbBJ4RpLPg8mitdcI/X079uv/2R05fcZb/mDTcbH3
         B+AR/EevCqKaDqWlVJeQobfWcJktf9Xy+sdDC02P0+k/ba/GYfmCS6Pz9jrih7W4ARTz
         fPPosccKVEa+Goi3UE/X9RMeUSWaWYfKR+A0ZpYtlLQvTtbm3ZH5hH+QOMPgiPkIwsui
         5znQ==
X-Gm-Message-State: APjAAAXqZuo6PY4kXOcLY4Q61zAZLtaozxuSqHSXe2kbkJoB5poMTXhT
        GoaXFf9+AgbPVRwUnPpqmrB0/GKMpI4aAdMPyCgkS9+h85w=
X-Google-Smtp-Source: APXvYqyIYIhNq+jLA2tljFH0wmKipdNhIUGNWVtC+4lfUpeq8DUgGzbXumkypig2mMkTG/JN0tYfjKDoyp2nwimAn8c=
X-Received: by 2002:a1c:c915:: with SMTP id f21mr24578674wmb.123.1559822249364;
 Thu, 06 Jun 2019 04:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com> <e8ad370e-6528-2ab1-5001-ab3fa4dc5ae8@huawei.com>
In-Reply-To: <e8ad370e-6528-2ab1-5001-ab3fa4dc5ae8@huawei.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 6 Jun 2019 13:57:18 +0200
Message-ID: <CAMGffEnFWGdAYEr4mvTKfeDR4xRQwQneeDjaDSaj3gmGHY=i3Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
To:     Jason Yan <yanaijie@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        intel-linux-scu@intel.com, artur.paszkiewicz@intel.com,
        Jack Wang <jinpu.wang@profitbricks.com>,
        lindar_liu <lindar_liu@usish.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 3:35 AM Jason Yan <yanaijie@huawei.com> wrote:
>
>
>
> On 2019/6/6 0:12, John Garry wrote:
> > Many times in libsas, and in LLDDs which use libsas, the check for an
> > expander device is re-implemented or open coded.
> >
> > Use dev_is_expander() instead. We rename this from
> > sas_dev_type_is_expander() to not spill so many lines in referencing.
> >
> > Signed-off-by: John Garry<john.garry@huawei.com>
>
> Cannot agree more=EF=BC=8C
>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
>
Looks good, thanks Jason!

Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
