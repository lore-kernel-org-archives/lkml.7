Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A046C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E412F222C0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 21:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4wuP4xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfJEV6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 17:58:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41331 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEV6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 17:58:14 -0400
Received: by mail-io1-f68.google.com with SMTP id n26so20909625ioj.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 14:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G3GiBa1jUTyLkRA1lkNHAhMtxcRwrlIdapCLYa7uKjU=;
        b=r4wuP4xvj41CIb0744foDaOX+cmTo+WKgHTlLTYy+YlLTYIS8wfbTtSgjBfmQhTEzc
         HA+igB0G72DNBpejdeq2ZkSD5D9FHM5uKVXPp6MVInV4fqcSCxHQMjqGmkijai9P8Brm
         m989hcO2OeWQss7TrXXCM5JWIYPV5uQPAGbRsH0koB/wUiUhp+Cs1UChXA6jd7dQUORa
         5C8ZkuCjPLNAJyptUHEbVsJZ75GsJJjZWTeq7xr+W1kF2YELje1JfmqRBgLmV2nfgYTR
         MMElMGLn50uyIFBCihMhGR5t/FInrJhPc07SUuRcz3REtOihSghZ8FdYn1dbWyFWh0vG
         Mqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G3GiBa1jUTyLkRA1lkNHAhMtxcRwrlIdapCLYa7uKjU=;
        b=f35GZ32gacd8zsKlG0wBIvs1Rdcbl2afZ9rb+YIZhzSXCcf0uxr0rohq28BuJFKgma
         1CozDNuxa4eJBEnqn+FaLE/aDVG62aI647woS+pNnWRE2GTts550TPmnJBgMMr+eNson
         8Fn+f3jhcBEb5Zc20IelWkebzbij9lA26/277AwEoDNMLj8eEmfxbtafbnrl89+YyQxz
         VndOl55ZesuOCkH6TH0TjL4G54Lqf4Gw0BXIDdZlJ0MaO+oJiZ4pmLBaSsCLsRS7elLl
         vo2CBI5cFTt0pzbnxo+PXZioNnthpDZnyS6Nsk82ADHNTfYvTmPoPp3IIeYtIBMdiyjK
         cSnQ==
X-Gm-Message-State: APjAAAXc+pL5B7Ltwmvg3U6bK1chbkRG+zkLng1cSVIwgwqljgjS5KdM
        h4D9zHLMUr2DyD1Ir+foYluN87n8uokKPW2hKzQ=
X-Google-Smtp-Source: APXvYqz44vCH9BONx7KQjbv9AZGFNrvMgpEkN/sLzw2EiiujFbKRVZiMg2lpFGS6CB5F6TBc6jSrFM1Nu//i50jwAtg=
X-Received: by 2002:a92:c8d2:: with SMTP id c18mr9251832ilq.4.1570312693821;
 Sat, 05 Oct 2019 14:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191003191354.GA4481@Serenity> <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
 <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
In-Reply-To: <e0edf48eb84fe038c2912328b28e931900684de2.camel@amazon.com>
From:   Tyler Ramer <tyaramer@gmail.com>
Date:   Sat, 5 Oct 2019 17:58:52 -0400
Message-ID: <CAKcoMVBjzM6dq33DaTYBK6U32U3NQaR5mf6ppGr6iTKRuZ2KNg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
To:     "Singh, Balbir" <sblbir@amazon.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the bad CSTS bit? CSTS.RDY?

The reset will be triggered by the result of nvme_should_reset():

1196 static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
1197 {
1198
1199 =E2=87=A5       /* If true, indicates loss of adapter communication, p=
ossibly by a
1200 =E2=87=A5        * NVMe Subsystem reset.
1201 =E2=87=A5        */
1202 =E2=87=A5       bool nssro =3D dev->subsystem && (csts & NVME_CSTS_NSS=
RO);

This csts value is set in nvme_timeout:

1240 static enum blk_eh_timer_return nvme_timeout(struct request *req,
bool reserved)
1241 {
...
1247 =E2=87=A5       u32 csts =3D readl(dev->bar + NVME_REG_CSTS);
...
1256 =E2=87=A5       /*
1257 =E2=87=A5        * Reset immediately if the controller is failed
1258 =E2=87=A5        */
1259 =E2=87=A5       if (nvme_should_reset(dev, csts)) {
1260 =E2=87=A5       =E2=87=A5       nvme_warn_reset(dev, csts);
1261 =E2=87=A5       =E2=87=A5       nvme_dev_disable(dev, false);
1262 =E2=87=A5       =E2=87=A5       nvme_reset_ctrl(&dev->ctrl);


Again, here's the message printed by nvme_warn_reset:

Aug 26 15:01:27 testhost kernel: nvme nvme4: controller is down; will
reset: CSTS=3D0x3, PCI_STATUS=3D0x10

From  include/linux/nvme.h:
 105 =E2=87=A5       NVME_REG_CSTS=E2=87=A5  =3D 0x001c,=E2=87=A5      /* C=
ontroller Status */

- Tyler
