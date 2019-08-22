Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA62CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2620578
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcodsO2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393934AbfHVWTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:19:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36858 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393795AbfHVWTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:19:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id w2so4918671pfi.3;
        Thu, 22 Aug 2019 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hXggJeNk5DyrlR3Ykl3KL8qzqxi9q3v2FlHbbm7gWl4=;
        b=gcodsO2YQzJBlOe/tqRER49vskORqFAXiBa1KeZHCmfBhmQuoSTUgEEDlseqTRrozC
         ZCX4pQ2/HzMS8u7wK/3IhDmPuZLJsA2dA+KxrfgQTxvGgUAhoOvkfxkweoyuFWvazp4l
         +CKppRl9fbh0aQYajG7t1zjmfXkyBacCaxgQj9Cjw6hQkeN7Y3xVLi9AyOlsaTS3hz86
         7faGt5v1x1ksPRwpuVjRI+MqXhFf4ocatQ5RA6dxEVV/CnX4Q8eJaFzp/6gANJIj9DV0
         G4ENe6IJ5xRJVBIV+jGRdXYffP6pNZrzy60LTF4/jChAZ4NSVpmPPJDOJqAq1LPwE9UE
         h1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hXggJeNk5DyrlR3Ykl3KL8qzqxi9q3v2FlHbbm7gWl4=;
        b=BfThCx4Cg8cSzlwiW8lGUqAgKhqtOfiQgHlIaAvVyCnbNv0B3Hd9oq0k7Hg2ihzeUq
         zs6Xhoo412m9/q3XWtrDf6GYWPjzD49KDmZhj0oKYZuG1Mn085qjCneU7+LQzA/ZbOFl
         Ln/NtKFcKt5NIsAYDEw5/Ej0s2/P2oO2DHy0RLbySUIrCoPV3vSzAhsDVGrUlTZZWaRO
         UrUk898cdpDnfo6MBwIu5ug3k2l78+CKOfjnduOefErYiy+/3+u9ocfc2cCnYckIVtbT
         quDKCBmJOmFq+rVpi8Id0SO6F9+lSqxZNnES1fubG6U66Qis8bWbvKGT5c7r014y8DGT
         bo1g==
X-Gm-Message-State: APjAAAVGSiCSW4o39NX1NKhVLxkyfwzzX4zVeQENPgKUH9L8+l1ZD2L+
        YzyXxTglzuZE1PzzlLlcUgI=
X-Google-Smtp-Source: APXvYqwo/P3Ukfyvj1z2aTJyxTAhQuVP60XXCeDNBl2fvSuHQxBq1pZ1a4s8TltSNYeKNuJPWj3qAQ==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr1287128pgi.70.1566512359236;
        Thu, 22 Aug 2019 15:19:19 -0700 (PDT)
Received: from localhost.localdomain ([221.155.202.134])
        by smtp.gmail.com with ESMTPSA id k3sm435624pfg.23.2019.08.22.15.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:19:18 -0700 (PDT)
Date:   Fri, 23 Aug 2019 07:19:14 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     shuah@kernel.org, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
Message-ID: <20190822221912.GA5004@localhost.localdomain>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190808155435.10050-2-suwan.kim027@gmail.com>
 <20190822164011.GA7093@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822164011.GA7093@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 09:40:11AM -0700, Greg KH wrote:
> On Fri, Aug 09, 2019 at 12:54:34AM +0900, Suwan Kim wrote:
> > vhci doesn’t do DMA for remote device. Actually, the real DMA
> > operation is done by network card driver. vhci just passes virtual
> > address of the buffer to the network stack, so vhci doesn’t use and
> > need dma address of the buffer of the URB.
> > 
> > But HCD provides DMA mapping and unmapping function by default.
> > Moreover, it causes unnecessary DMA mapping and unmapping which
> > will be done again at the NIC driver and it wastes CPU cycles.
> > So, implement map_urb_for_dma and unmap_urb_for_dma function for
> > vhci in order to skip the DMA mapping and unmapping procedure.
> > 
> > When it comes to supporting SG for vhci, it is useful to use native
> > SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
> > fnuction can adjust the number of SG list (urb->num_mapped_sgs).
> > And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
> > hcd_map_urb_for_dma() does.
> > 
> > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> 
> Can you please redo this patch based on my usb-next branch that has
> Christoph's DMA changes in it?  It should make your change much simpler
> and smaller.
> 
> Please do that and resend the whole series.

I just sent v6 patch. And I discarded patch1 and patch1 is no longer
needed because vhci doesn't set set HCD_DMA flag that is introduced
by Christoph's patch.
So I sent only patch 2 as v6.

Regards
Suwan Kim
