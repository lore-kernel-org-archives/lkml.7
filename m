Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8097C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5062053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCmXAjQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfEOLqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:46:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43163 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfEOLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:46:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so1912214oth.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=si9T0jm5a9bwRXYNfp4qceYIc28/OVStfp0p3dtPwMA=;
        b=PCmXAjQhHr3A63jiQSop3yS3YJB6kaWbry29nGX94c+nkxolsRh48hfccy80WEKcye
         n5AgawCAjmyVijuj3clzqnIxsgjiL0Cr+Tkfr2H1VVeU9HZh7lAk8Z7RJzcMcN/Bvf/X
         GG1GaVinsifouo2JcEV2AWZEBLYWCmgAVSgrQlEG2uIPEOCs1+zlS5EriWeJLVeBFifM
         7EtVyXYC7QfKl77XLnvK3Hlv6AcNj4kXqKC6esyT//WPZFdi4G2I+Pr/CrB+boCpjVkq
         TuW7fo96PuAXH906Pzf7GXj6QANb3C2ioiBwsgUEE7eOM+PK47qZVzNiy4NtGRboYCgT
         bepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=si9T0jm5a9bwRXYNfp4qceYIc28/OVStfp0p3dtPwMA=;
        b=RyJUX/dc4//ha8H4QYoiuOIrC8qli6fRxW32Y/X3clMHuWpLadXv4610dkAid9veqN
         J5AGbJ3fVcjw0Mx/ml/43yLDlGqzx1FmglUprR5xkAhvmO41aQOtKkm1E25IfpDLQMqv
         OxOZt0vpYKAXSIfQ1QQGRgL7BhGGtEodBASTgM8MZAEZISTi/EvaqEmsXHCsuDsUX6mw
         Rzc/hQdKhG3LVpjk+gQs/EfzEezM9iePZksAiKZ7tq3pCzkDL+6K9PcqweH0QUqtb+0F
         aNI3dJ9oqqDcnOO1DkWfTqdLoILaBzCI6D8dyKbC0ORPcwJtnXKbKdsuYh2wSPc8jX6X
         3F4Q==
X-Gm-Message-State: APjAAAXF5XYwmQnJ5CqMUMJKNzuzJRXx46p5JYDUSINZ0DoblzM0QHsA
        a4NJI+3xekHcEh3M4DgOZ+ikX4HU5hjXIKrJOqXUm4EH
X-Google-Smtp-Source: APXvYqzJT4hw93CXYPJ/Jz+wFHBYUSgePQfPs96t26dah/FfVeoXrBMXEcGZD7xRpcHz/VyaedudF9Bw+1Pd7mNLjYI=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr64043otf.332.1557920811912;
 Wed, 15 May 2019 04:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190509234357.24025f65@tamaverik>
In-Reply-To: <20190509234357.24025f65@tamaverik>
From:   Alibek Amaev <alibek.a@gmail.com>
Date:   Wed, 15 May 2019 14:46:41 +0300
Message-ID: <CA+TYKz2KtEq4MjaW7sx21AuQ9sMc6Tx8ibdpmgMNdBvY=c+uTQ@mail.gmail.com>
Subject: Re: Block device naming
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there really no comment or suggestions how to avoid server failure
when changing the LUN number?


On Thu, May 9, 2019 at 11:43 PM Alibek A. <alibek.a@gmail.com> wrote:
>
> Hi!
>
> I want to address the following problem:
> On the system with hot-attached new storage volume, such as FC-switch upd=
ate configuration for connected FC-HBA on servers, linux kernel reorder blo=
ck devices and change names of block devices. Becouse scsi-id, wwn-id and o=
ther is a symbol links to block device names than on change block device na=
me change path to device.
> This causes the server to stop working.
>
> For example, on server present ZFS pool with attached device by scsi-id
> # zpool status
>   pool: pool
>  state: ONLINE
>   scan: scrub repaired 0 in 1h39m with 0 errors on Sun Oct  8 02:03:34 20=
17
> config:
>
>     NAME                                      STATE     READ WRITE CKSUM
>     pool                                      ONLINE       0     0     0
>       scsi-3600144f0c7a5bc61000058d3b96d001d  ONLINE       0     0     0
>
> Before export new block device from storage to hba, scsi-id have next pat=
h to device:
> /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdd
>
> When added new block device by FC-switch, FC-HBA kernel change block devi=
ce names:
> /dev/disk/by-id/scsi-3600144f0c7a5bc61000058d3b96d001d -> ../../sdf
>
> and ZFS can't access to device until reboot (partprobe, zpool online -e p=
ool scsi-3600144f0c7a5bc61000058d3b96d001d - may help or may not help)
>
> Is there any way to fix or change this behavior of the kernel?
>
> It may be more reasonable to immediately assign an unique persistent iden=
tifier of device and linking other identifiers with it?
>
>
> With regards, Alibek!
>
