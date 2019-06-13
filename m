Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B4C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1282133D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Vf0Co9J1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfFMUER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:04:17 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:36105 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfFMUEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:04:16 -0400
Received: by mail-io1-f49.google.com with SMTP id h6so737969ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=DI3nny5EkaaAj92ROhz8+oF1JyVO+F50iFiYFfny5cg=;
        b=Vf0Co9J1FWQf/mNg9X22WqwFrqk1bWNDchM2WOC0coX4mVxqvFdL4M7qSSiticNd+/
         +3h8YyGJXb6Dp9fwIq4WsLEKSNJVZR/j3S/HsXXpkjb7r3yKx1VfkTt2fSEW7Upj2InB
         vpUy4mSkuPaOLlVxWUk8m4jGlNkrR8m+OQY9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=DI3nny5EkaaAj92ROhz8+oF1JyVO+F50iFiYFfny5cg=;
        b=FcEbhC1Sm6PwnlffRrBssNhEsQ8WVY1s6ziDr4RODF11Ftf/rF+6R5yweXFCdsY/ht
         UNs//pUz1q8WGRz1q4Ufo2NK2rAWtVhI34D9CVlbGPgfGdYKRAkaQI48HR9CzFHsbkG7
         0/i3Febo5c0idVHCVPmbU2ONsknflz8pQnRpBVqVqsMTIUBR6oKhZD+AZZE45SoDcoH1
         EvCIYVwJIeHqlfNuLt8y8GWO1ia+plN8eLnSyAvbZoBOyrMcnuLGaCmCjMtiSzvKNyH8
         rHuSfSB744wL/SH0xhLszKh50lG4wkRbhh2CyyoeWW3tgedOtsrF/vVHnDDpfhLVbEfv
         1uYQ==
X-Gm-Message-State: APjAAAVCx3BUUyuXeBWv7Myf0CA8kwQ2DvXXgvd2keD1mgncuO1ULpfc
        EVk4SzHiSJa7bR0yBcZFa17EvgThJjJvH2ZtjKKKlA==
X-Google-Smtp-Source: APXvYqzt6T4yoFnlQQM4Io9z3VVKv9jXWB1wt4QkxYaqK+pkTNNNf6XRH7RjKzaoumZniM5JtnYN2SZhYMEkCQ+APaM=
X-Received: by 2002:a5d:9b1a:: with SMTP id y26mr37376851ion.238.1560456255599;
 Thu, 13 Jun 2019 13:04:15 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190605190836.32354-1-hch@lst.de> <20190605190836.32354-11-hch@lst.de>
 <cd713506efb9579d1f69a719d831c28d@mail.gmail.com> <20190613084458.GB13221@lst.de>
In-Reply-To: <20190613084458.GB13221@lst.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQNLjZIO2zMn7N+9xPobnDbFSu4o5gI2RJdJAgF+bYgCEzcr9aN60eSw
Date:   Fri, 14 Jun 2019 01:34:00 +0530
Message-ID: <d411baa1bdd34f1a1289480d13fe1cef@mail.gmail.com>
Subject: RE: [PATCH 10/13] megaraid_sas: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sebastian Ott <sebott@linux.ibm.com>,
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
> So before I respin this series, can you help with a way to figure out
for
> mpt3sas and megaraid if a given controller supports NVMe devices at all,
so
> that we don't have to set the virt boundary if not?


In MegaRaid we have below enum -        VENTURA_SERIES and AERO_SERIES
supports NVME

enum MR_ADAPTER_TYPE {
        MFI_SERIES = 1,
        THUNDERBOLT_SERIES = 2,
        INVADER_SERIES = 3,
        VENTURA_SERIES = 4,
        AERO_SERIES = 5,
};

In mpt3sas driver we have below method - If IOC FACT reports NVME Device
support in Protocol Flags, we can consider it as HBA with NVME drive
support.

ioc->facts.ProtocolFlags & MPI2_IOCFACTS_PROTOCOL_NVME_DEVICES

Kashyap
