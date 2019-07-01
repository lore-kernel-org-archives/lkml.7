Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50682C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DB4206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smmR1WDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGAJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:29:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37682 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGAJ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:29:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so6290442pfa.4;
        Mon, 01 Jul 2019 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KrfXpIQxr/cn2+9rwoAEVrRZR4QKKQe4lr3NtCXDl9w=;
        b=smmR1WDj9hEEUk0Fi/hV9Yntct1psX33m2A/KLnuExax/YWgDzvlGKgOxwdePAWmXA
         h4aI9Ej6GQpkipSZDJG1obdyHVrOm7BMcih7ah3c36xxIj6FbIwqaoRi5ZYT4WYmRdL3
         gD2zvsMTEPggGtdn72k+qQ+McyXFDD4i1AqQxCyrgg5VwbrHe4UWh4uKeowRlMTjDG1k
         170+kns5ylrfzHdM4170qVNcyVe61muK5///zIMjo4MZfAa+wiP0b4yHQVXR0oNhExgQ
         v9m5TPBfx0flrzxVf2S06zMK8D+XnTm23Tt6Njj9QjfbI5XUkI0dhIsHkJ/udYPKemY+
         Tp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KrfXpIQxr/cn2+9rwoAEVrRZR4QKKQe4lr3NtCXDl9w=;
        b=nZRZB/XQ5ZpZOcTQ2Pxg/ErfBY2SNK/R86kutWFT7iBrjCEiFSBq1Vy3p//gNZ8rUT
         5Y4st9yShiZ+QZ+odr2KH0dVTBu7OOmSR9Y38SI188coVtKGxotHRDAYPVYroU99dwC1
         /8eRddVBRTDSxD2p+KzHrcuvKrBO14bwv1pyYnlOdLy+vPugAVd5BoewPVYaexiT1q9q
         I9cjluH2H2PTazmJEBITV052uJG/S54lR7f/FBgh9jGrM13TlYiLNAbfrJUJFQ7rEUM/
         wHZsahIka+D2uXkN303k2V0fPxVVmvPCH2bX6xFXLTs8Cghfhs5EKtXB3klmhxGLsRFk
         Bhfw==
X-Gm-Message-State: APjAAAX9XhjWp2LGETFvcqMOtkg0Mc4e1Zfksy5ZvOrbfVNvejc9mL/Z
        5NYrnUdvJkI8y+VCNuelwnEK52gB
X-Google-Smtp-Source: APXvYqwUTe5RkYuin8LohkLDd/WteibKN2lDHhZAR6zoj23sp8Osx8FE8Zi29HB0PC/d+AlBfwtMsA==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr30227096pjc.10.1561973379791;
        Mon, 01 Jul 2019 02:29:39 -0700 (PDT)
Received: from localhost.localdomain ([163.152.3.133])
        by smtp.gmail.com with ESMTPSA id u65sm23209068pjb.1.2019.07.01.02.29.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 02:29:39 -0700 (PDT)
Date:   Mon, 1 Jul 2019 18:29:34 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     stern@rowland.harvard.edu, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usbip: Skip DMA mapping and unmapping for urb at vhci
Message-ID: <20190701092932.GA3939@localhost.localdomain>
References: <20190621174553.28862-1-suwan.kim027@gmail.com>
 <20190621174553.28862-2-suwan.kim027@gmail.com>
 <10a4f10a-d271-9331-b847-bdc06f9fc9cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10a4f10a-d271-9331-b847-bdc06f9fc9cf@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 06:11:54PM -0600, shuah wrote:
> Hi Suwan,
> 
> On 6/21/19 11:45 AM, Suwan Kim wrote:
> > vhci doesn’t do dma for remote device. Actually, the real dma
> > operation is done by network card driver. So, vhci doesn’t use and
> > need dma address of transfer buffer of urb.
> > 
> > When vhci supports SG, it is useful to use native SG list instead
> > of mapped SG list because dma mapping fnuction can adjust the
> > number of SG list that is urb->num_mapped_sgs.
> > 
> > But hcd provides dma mapping and unmapping function by defualt.
> 
> Typo "defualt"
> 
> > Moreover, it causes unnecessary dma mapping and unmapping which
> > will be done again at the NIC driver and it wastes CPU cycles.
> > So, implement map_urb_for_dma and unmap_urb_for_dma function for
> > vhci in order to skip the dma mapping and unmapping procedure.
> > 
> 
> How did you verify that unnecessary dma map/unmap are happening?
> How many CPU cycles did you manage to reduce with this change?

Dma mapping/unmapping is not required for vhci because vhci passes
the virtual address of the buffer to the network stack without
passing the dma address of the buffer. Network stack receive the
virtual address of the buffer from vhci and later, network card
driver performs dma mapping for the buffer. So, as far as I know,
dma address of the buffer is not used for vhci and virtual address
is only used by vhci.

I used ftrace to measure a duration of usb_hcd_map_urb_for_dma().
As a result, usb_hcd_map_urb_for_dma() took a duration of about
0.14us out of about 10us which is the duration of usb_hcd_submit_urb().
However, this figure is the dma mapping measurement value for
physically contiguous buffers when vhci does not support SG, and
if vhci supports SG, more CPU cycles will be consumed for SG dma
mapping.

I think that the important point is dma mapping/unmapping is
unnecessary at vhci. So we can skip dma mapping/unmapping and save
the CPU cycles (even if it is small). This is an opportunity to
reduce the end-to-end latency of usbip and improve the performance.

Regards

Suwan Kim
