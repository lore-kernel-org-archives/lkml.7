Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE52C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528C32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYStpXRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfHEFYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:24:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41765 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfHEFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:24:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so35861391pls.8;
        Sun, 04 Aug 2019 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kwMEz+087NG71UJ43Y4PF8iaz73tFFj8XFrCYqheyzM=;
        b=RYStpXRdJ6l1TB5wKrJU7HiL/1JFuert86TTPAt7bqfUAgmkKErLM2V7eOfh80Dt2X
         z7zdYP5OzQEjRfg6GxLfMGJx5i8X3s+g//iYCtV2yZNKceD6Ya66xqmj8jEJZ0x4z3OQ
         43TQ1PL+flTx9iYukVvXCXiibP5xo1OjP9SbWR1oZbkY1uY6zZGLDoEN0/r6wsIRVgzU
         3Noiq/QHVUllGwiToLVLy27y4uG1aCixTU4rLvpGd8YxUaPuwP/ba/CLQxcjYW586fb6
         1W/dT88fozfMlEJD/QgB/3tin2mbI5vBE/RSIhH9/hQtob0Oxs1EXz4vbgjetDZz0uCm
         Yf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kwMEz+087NG71UJ43Y4PF8iaz73tFFj8XFrCYqheyzM=;
        b=a3e0P6queC2BxB2HatvRW+Tl2BSUftyauGl3en0d9ygPijfEb4nyPRZBvDXHztzaFR
         qW7ru7yIa27Aabyc8yy1KW6m4xU6mgczXNluP6QEeFUCHzZ/pLcjml3K3i1c1mYNFuzo
         ofIWi91zFaV7yx2PRWR1Idafs/Dw8Q6Owp0KKwCHVo2IBO4jt6HRjYWhB1Cj4vSlzrWE
         DGl639uXL9HWipk4XNb0DHoioyuIkEvA40gWmoUrdaQcYnMY8vuGAEgENes3Vu0M79pL
         TXSFdp5gPGiZmCmJCc1p4Jxd3qkaQDp+qI1y6YP0BjFFTDAKyrby6CRzhaL0qWMgvFhu
         A+Vw==
X-Gm-Message-State: APjAAAW33hCF+FQq01ulgLEGErk1RFNU7hfMRsr9PBnXynN2UNbCtA5W
        rJ96SZrOX648uSKa/ITlh1Q=
X-Google-Smtp-Source: APXvYqwJG9ftnbw1vWkXErhnQDqqhwN5wPt0f+1hEmXWYKjYXk1pH+W1bk1sCUeNvKF1PgCaKoiyQg==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr146166694pls.44.1564982644123;
        Sun, 04 Aug 2019 22:24:04 -0700 (PDT)
Received: from localhost.localdomain ([163.152.162.125])
        by smtp.gmail.com with ESMTPSA id o12sm12798313pjr.22.2019.08.04.22.24.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 22:24:03 -0700 (PDT)
Date:   Mon, 5 Aug 2019 14:23:58 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
Message-ID: <20190805052358.GA8904@localhost.localdomain>
References: <20190802173651.22247-1-suwan.kim027@gmail.com>
 <20190802173651.22247-2-suwan.kim027@gmail.com>
 <c23b3ac1-68d9-bc1e-610b-955988e11055@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c23b3ac1-68d9-bc1e-610b-955988e11055@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 04:22:27PM -0600, shuah wrote:
> On 8/2/19 11:36 AM, Suwan Kim wrote:
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
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 000ab7225717..c62f7fa8118c 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
> >   	return 0;
> >   }
> > +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +		gfp_t mem_flags)
> > +{
> > +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
> > +		WARN_ON(1);
> 
> Don't add WARN_ON. I cleaned them all up recently and don't want new
> ones added.

Ok. I will remove it and resend v4.

Regards
Suwan Kim
