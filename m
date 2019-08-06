Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5602C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DD52070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g61zEiji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfHFPcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:32:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFPcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:32:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so41766504pgp.12;
        Tue, 06 Aug 2019 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UZNkW3omqDGb3IOeyV4C6nHOTv5lpWwou2g5aoq2ifw=;
        b=g61zEijiG05NmXYg/SDefh64ACJmE0M0vXiZbTm4mg1sKQ9XqS2q4t551Z093GwWKK
         6f+wLREAVeNG5byPAz3Vef7U3JnKU8zp8cnfjn40g2O8ZbsAicI7HZsw3mMW13Pk/18U
         zm8cypqrKrXfuavOaE2JLRcDowrh1OE/XVsMcSECKWt5I5yabQDjbNUMbRPkEWSS40Y/
         BWwysSuyJl6sbR2ldCzps5lhATVgv8GVHz6zq6YKI/FGrz0P2m7LfJVDOaN4z5AzG8sc
         qEqe0jEf4d2jN0Z6wM0U5EkCW9sIG0NoIgZEqzZ46sfjSnSOEiiGRGrQ0UE/7lZfC9BA
         xN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UZNkW3omqDGb3IOeyV4C6nHOTv5lpWwou2g5aoq2ifw=;
        b=aKvX14m2Iy7zyWsyocEpkK/OUo/HbSBjAJhKTzZMdcUslqTLhj79D5cpgkbtVlQ4Sa
         hRrnAFK5oDu2QYnIUwqUnbCgn/Cvn9HmCC76NO2bVVWKe1eewvTvJM/2bitgVO6rSe61
         4xymj9QDCbJr7eidQJu/wkCQ3VlRH1sVtaRRXV9tfSYSxRe2TlVz+FI0lrUENJ4Uqb6y
         RcyuIkJ4AQdPw2n0EOW+2WzGhxFHDFsxuRLuEJjL9HRsCDQM1WOBDJYJnc9g2idOZBAq
         E3akUI7GXJHluwSK1dQqUKzEUeizFMFeJD+Tn6pkpMejlZPbVmeZ8o1Iwz2U789jDXAX
         H13A==
X-Gm-Message-State: APjAAAWO9zJXvZ7A+w4SPnuk8Xdkij6w3sMVPFanlir8eohfcsWkNSpK
        UVgl5qhXwnzNhK04vnSAM1agBS7ISaU=
X-Google-Smtp-Source: APXvYqwUdwORrySSKs1spneMCsr+cSp04grGupRPtq/NdhD8Z6N9veZXaHkeea+aqf0SvgK20Ag5Pg==
X-Received: by 2002:a63:724f:: with SMTP id c15mr3634930pgn.257.1565105566992;
        Tue, 06 Aug 2019 08:32:46 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id z13sm19377959pjn.32.2019.08.06.08.32.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:32:46 -0700 (PDT)
Date:   Wed, 7 Aug 2019 00:32:41 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
Message-ID: <20190806153241.GA3738@localhost.localdomain>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-2-suwan.kim027@gmail.com>
 <c3485edd-f7e3-95a7-38db-acda371575a2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3485edd-f7e3-95a7-38db-acda371575a2@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:11:30AM -0600, shuah wrote:
> On 8/6/19 6:31 AM, Suwan Kim wrote:
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
> > v3 - v4:
> > - Replace WARN_ON() with pr_err() in the error path.
> > 
> > v2 - v3
> > - Move setting URB_DMA_MAP_SG flag to the patch 2.
> > - Prevent isoc pipe from using SG buffer.
> > 
> > v1 - v2
> > - Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
> > stub driver to use SG buffer.
> > ---
> >   drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > index 000ab7225717..429e4e989f38 100644
> > --- a/drivers/usb/usbip/vhci_hcd.c
> > +++ b/drivers/usb/usbip/vhci_hcd.c
> > @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
> >   	return 0;
> >   }
> > +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > +				gfp_t mem_flags)
> > +{
> > +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
> > +		pr_err("SG is not supported for isochronous transfer\n");
> 
> Any reason to not use dev_err()?

Because some codes in vhci_hcd.c use pr_err().There is no other
reason. However, dev_err() seems more appropriate than pr_err().
I will replace pr_err() with dev_err(urb->dev->dev, "SG is ...")
Is it ok?

Regards
Suwan Kim
