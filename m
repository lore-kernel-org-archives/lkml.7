Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C2C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EF0206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AFDD/k2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfFFPhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:37:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41045 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfFFPha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:37:30 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so530169ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=7FsPigjoq8C26eFiFz4PbLbviE4sOu/NaNL8Wv/dWZY=;
        b=AFDD/k2/le52Hdd/TKthmiFLkpxwsE8wgwm+ToBDcTp5nk5LpKOXg2c5jC8eyqSr8U
         PbQa5dsh5SDeL6j0empaIJIbULAJcPWpVBbqfwPg+RIvS/9Z4t7qTgc+J2TnzpXamk2f
         Jk2clgGQMDirG2oKq3gaszEI2ZXgq2nzh2D7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=7FsPigjoq8C26eFiFz4PbLbviE4sOu/NaNL8Wv/dWZY=;
        b=TbtncAjVFYrMzBFoH6Aro2yrhA9baHmYyyIs7Gwov7/ol6Nmh4EHCXdclUPpDkXbdd
         hRx9hemEy49k6ONC52g7SuOME80ur7CTy7TLvqVUWe/4PhhibD67OdBWlk/0Z4AtANmb
         ByhBGd+f65iKHpa157JVtN6voxAOrz84xDBT6ylZjnnX4+ZcIoLKx2BtSoTmdp2sNI8n
         tLBODGSKpV1xr2E2tIhrPvuEyQiJs7cx6hoaAiodILr02RUSqWnlA2rL4kJRf6RSNIN+
         s5JDk2FaDhI/67LswaES9fEWc4Lt7LCkoInuxjZJO13YF1S7oFZg3ZsgHPcAoFCWq8lt
         ziAg==
X-Gm-Message-State: APjAAAXRhGMk90OSvHNQHqwIO1SAY3qhPhWpIQst8fyzo7oU+x7NPfv4
        ULTPgz8fqJYMBWllemnQc1aCP/7at1hnRht/ZQmoWA==
X-Google-Smtp-Source: APXvYqxuIiFVwwy3SZOPoMV5d6L9mjSBqLBwyeJYTl2PURpa5yAIPkIYD/4gZiMQyRghGYi7pdemfpa8qFQTyevPY6Q=
X-Received: by 2002:a5d:9502:: with SMTP id d2mr14353761iom.2.1559835449946;
 Thu, 06 Jun 2019 08:37:29 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de>
In-Reply-To: <20190605190836.32354-11-hch@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQNLjZIO2zMn7N+9xPobnDbFSu4o5gI2RJdJo5AtPRA=
Date:   Thu, 6 Jun 2019 21:07:27 +0530
Message-ID: <cd713506efb9579d1f69a719d831c28d@mail.gmail.com>
Subject: RE: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        PDL-MPT-FUSIONLINUX <mpt-fusionlinux.pdl@broadcom.com>,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This ensures all proper DMA layer handling is taken care of by the SCSI
> midlayer.  Note that the effect is global, as the IOMMU merging is based
> off a
> paramters in struct device.  We could still turn if off if no PCIe devices
> are
> present, but I don't know how to find that out.
>
> Also remove the bogus nomerges flag, merges do take the virt_boundary into
> account.

Hi Christoph, Changes for <megaraid_sas> and <mpt3sas> looks good. We want
to confirm few sanity before ACK. BTW, what benefit we will see moving
virt_boundry setting to SCSI mid layer ? Is it just modular approach OR any
functional fix ?

Kashyap
