Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7737AC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E33206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 09:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo0U1egZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfGUJBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 05:01:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42268 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGUJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 05:01:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so17710267plb.9;
        Sun, 21 Jul 2019 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMCT1sRvSpYaoD1Z8FlxTMQ/VpyVpjBJDn9MHa/ZVPo=;
        b=bo0U1egZOrd62N2e2VId7EPbVmrGg8I6+LSmMCOOlbh1JSpDDny0jX6sY6Aj8uQZ0V
         FDwFWUnBN6gqTfizZciyH98orjrfc3S1wNDrSeFt9xfMUwXuEtMPunSq0mmpn/0yBnII
         LbXxrVBLoabcRCyF38hBvo0lu78uBosAsIruwJI7fabIvOmk502+1WzwSFBkr0r4opP5
         AOSCNTjUvXB075IaUcpmXtQ/yzFSo4xaLu4+9HD61M4u1Y2DKy69Eu7BOV8xhhCEn7kD
         rcKWZW93sIpMRRIBniwanhC0t1cWsyyxu/XeFP5EZ1PbxEMTLrTOa6mLnNSmLyW+yWfH
         Qy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMCT1sRvSpYaoD1Z8FlxTMQ/VpyVpjBJDn9MHa/ZVPo=;
        b=tEtSZ+2YxJ9X0igWYXGuVOov7YAGhoGbleh+va98G32s3conZVtdoX26yARQTE+QxD
         6uOpbS2LNL4H9XjJMqNf8ieon10Z6RFLA/GvN9M7SlgRUZERxXBAPKUEoKmbmqAaBX1g
         wR131os/5itDbgq2rhtEplMyfMXBfiM5gWSXJ8Oi0xU0wIfBXgMgJcVUTd32U8AA0Ovu
         75At1Ea3mzDHPsNrHJ1ArXs1IZyzVNUrK3qkyUex3B3oWZD7EiX8cWuAKvLUokQeu+6c
         kCDp0p9EGL9kgTciTM4/08ofZYwg7CBLpuoqQ5gOIcuaSGpTx2QEqPmwQtlc0zIyJez3
         Kzkg==
X-Gm-Message-State: APjAAAWkK+RQ8NPkg4t8nF/0xEGY5G4NmBHp6iTrbXqo/jFttokop71g
        LgemRtCH9334Fk4HSG/IEhI=
X-Google-Smtp-Source: APXvYqyikdxi8c6IvDgbXlRE72AiaNOa+eepRpqSFBRQj/PNMLJamXs6jgijafuJBKPoUp8opfJD2Q==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr69739706pls.9.1563699694660;
        Sun, 21 Jul 2019 02:01:34 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id r1sm34548144pgv.70.2019.07.21.02.01.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 02:01:34 -0700 (PDT)
Date:   Sun, 21 Jul 2019 18:01:29 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] usbip: Implement SG support
Message-ID: <20190721090129.GA13527@localhost.localdomain>
References: <20190705164355.14025-1-suwan.kim027@gmail.com>
 <7eaaf016-8da5-6089-fe19-bf62c3bbe187@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eaaf016-8da5-6089-fe19-bf62c3bbe187@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 04:04:20PM -0600, shuah wrote:
> On 7/5/19 10:43 AM, Suwan Kim wrote:
> > There are bugs on vhci with usb 3.0 storage device. Originally, vhci
> > doesn't supported SG, so USB storage driver on vhci breaks SG list
> > into multiple URBs and it causes error that a transfer got terminated
> > too early because the transfer length for one of the URBs was not
> > divisible by the maxpacket size.
> > 
> > To support SG, vhci doesn't map and unmap URB for DMA to use native
> > SG list (urb->num_sgs). In DMA mapping function of vhci, it sets
> > URB_DMA_MAP_SG flag in urb->transfer_flags if URB has SG list and
> > this flag will tell the stub driver to use SG list.
> > 
> > In this patch, vhci basically support SG and it sends each SG list
> > entry to the stub driver. Then, the stub driver sees the total length
> > of the buffer and allocates SG table and pages according to the total
> > buffer length calling sgl_alloc(). After the stub driver receives
> > completed URB, it again sends each SG list entry to vhci.
> > 
> > If HCD of the server doesn't support SG, the stub driver breaks a
> > single SG reqeust into several URBs and submit them to the server's
> > HCD. When all the split URBs are completed, the stub driver
> > reassembles the URBs into a single return command and sends it to
> > vhci.
> > 
> > Alan fixed vhci bug with the USB 3.0 storage device by modifying
> > USB storage driver.
> > ("usb-storage: Set virt_boundary_mask to avoid SG overflows")
> > But the fundamental solution of it is to add SG support to vhci.
> > 
> > This patch works well with the USB 3.0 storage devices without Alan's
> > patch, and we can revert Alan's patch if it causes some troubles.
> > 
> > Suwan Kim (2):
> >    usbip: Skip DMA mapping and unmapping for urb at vhci
> >    usbip: Implement SG support to vhci
> > 
> >   drivers/usb/usbip/stub.h         |   7 +-
> >   drivers/usb/usbip/stub_main.c    |  52 +++++---
> >   drivers/usb/usbip/stub_rx.c      | 207 ++++++++++++++++++++++---------
> >   drivers/usb/usbip/stub_tx.c      | 108 +++++++++++-----
> >   drivers/usb/usbip/usbip_common.c |  60 +++++++--
> >   drivers/usb/usbip/vhci_hcd.c     |  29 ++++-
> >   drivers/usb/usbip/vhci_tx.c      |  49 ++++++--
> >   7 files changed, 391 insertions(+), 121 deletions(-)
> > 
> 
> Hi Suwan,
> 
> I have been traveling and would like to test this series before I ask
> Greg to pick it up.
> 
> Just a quick note that I will get to this early next week.

Ok. Thank you for reviewing the patch, Shuah.
Please let me know if you have any problems reviewing the patch :)

Regards

Suwan Kim
