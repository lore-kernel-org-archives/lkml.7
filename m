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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F855C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F391520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWspXk3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfHFPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:52:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44857 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfHFPwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:52:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id i18so41815586pgl.11;
        Tue, 06 Aug 2019 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jfzEOZ5rHqiPG3I14G2VFXx2UVCDNmo50hSta/tpyio=;
        b=tWspXk3BfSxgbI2f0ulWibLmdQ02GrosL1PS8zVFzux94T6iZp4QTukfX+bNsCIqrv
         vBBzPN2Xs7DFTTJf9eIqCH2273IsFsU2hOEY8MjXF9OQiA1k0GMCZAIPxTp/SfY7VjeO
         6WV8gQIgf6H6vhbygYPJYa6Ae8Vx6hvH7i3N00cc6U0Sgzdmti+NscIsZYTNa74KudQW
         XuvMjZa+YUaaEQ/9s4Hjq3uhp3DtBsRHjNMK6nXzI+3anazpyrcrGoJsWFsdQryYS4dH
         6b8F71Fjwlmf09TInPIMDhWSmC96Bts6C7SI9OKpm7FmSfM7n/gmbbNCL+T0IMRT9xs6
         v3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jfzEOZ5rHqiPG3I14G2VFXx2UVCDNmo50hSta/tpyio=;
        b=XY2TdqrXiYkNE1GPpZIJ07a1mP/QyCU68Oiv5kQEyMhNaUv03jR2pvkcE34Wa227Vz
         5yBnLl7uVhau1ak8oM2VWazvLrJJZV49CvGpFu9vCAD0e9cnI8YIwf1OR4EyTQwD/pPn
         0pNAnvmgwl1537iKlLX2JU7D9d/5oXu8vpfZK7Yi/2gL1vtPpcI2DX6O3P7uoIjkZIt5
         24y4IKy5+yYNyHDchpX2vUTpqPncenWH+gbJXHBizgcupH66yJbmnEaSbY5BaTqT4dxp
         UJLHF7HkuBeRpxRt3/3roUGv9ahsIEMNFNa0f3SVnq72Ab36IyCTp6sJ/Uddywfq5lED
         0lSg==
X-Gm-Message-State: APjAAAXtrnHoTT/3dwr2dJDfeofv7c1TKLCOM/Y8d268PL+AzY6qG89b
        Vukzx/VGtPxM9mwyGKzx7K0=
X-Google-Smtp-Source: APXvYqwcH83PnARnKz0XS6pVYyW13EFTSuzDICVaH5O3eXt87Eyv9wtDzApVxK224SOGGChtITQjVg==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr4415570pff.224.1565106764377;
        Tue, 06 Aug 2019 08:52:44 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id f7sm85385329pfd.43.2019.08.06.08.52.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:52:43 -0700 (PDT)
Date:   Wed, 7 Aug 2019 00:52:38 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>
Cc:     valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] usbip: Skip DMA mapping and unmapping for urb at
 vhci
Message-ID: <20190806155238.GC3738@localhost.localdomain>
References: <20190806123154.23798-1-suwan.kim027@gmail.com>
 <20190806123154.23798-2-suwan.kim027@gmail.com>
 <c3485edd-f7e3-95a7-38db-acda371575a2@kernel.org>
 <20190806153241.GA3738@localhost.localdomain>
 <b5c6c9e5-0855-c055-6bb5-47dbc497f606@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5c6c9e5-0855-c055-6bb5-47dbc497f606@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 09:38:54AM -0600, shuah wrote:
> On 8/6/19 9:32 AM, Suwan Kim wrote:
> > On Tue, Aug 06, 2019 at 09:11:30AM -0600, shuah wrote:
> > > On 8/6/19 6:31 AM, Suwan Kim wrote:
> > > > vhci doesn’t do DMA for remote device. Actually, the real DMA
> > > > operation is done by network card driver. vhci just passes virtual
> > > > address of the buffer to the network stack, so vhci doesn’t use and
> > > > need dma address of the buffer of the URB.
> > > > 
> > > > But HCD provides DMA mapping and unmapping function by default.
> > > > Moreover, it causes unnecessary DMA mapping and unmapping which
> > > > will be done again at the NIC driver and it wastes CPU cycles.
> > > > So, implement map_urb_for_dma and unmap_urb_for_dma function for
> > > > vhci in order to skip the DMA mapping and unmapping procedure.
> > > > 
> > > > When it comes to supporting SG for vhci, it is useful to use native
> > > > SG list (urb->num_sgs) instead of mapped SG list because DMA mapping
> > > > fnuction can adjust the number of SG list (urb->num_mapped_sgs).
> > > > And vhci_map_urb_for_dma() prevents isoc pipe from using SG as
> > > > hcd_map_urb_for_dma() does.
> > > > 
> > > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > > ---
> > > > v3 - v4:
> > > > - Replace WARN_ON() with pr_err() in the error path.
> > > > 
> > > > v2 - v3
> > > > - Move setting URB_DMA_MAP_SG flag to the patch 2.
> > > > - Prevent isoc pipe from using SG buffer.
> > > > 
> > > > v1 - v2
> > > > - Add setting URB_DMA_MAP_SG flag in urb->transfer_flags to tell
> > > > stub driver to use SG buffer.
> > > > ---
> > > >    drivers/usb/usbip/vhci_hcd.c | 19 +++++++++++++++++++
> > > >    1 file changed, 19 insertions(+)
> > > > 
> > > > diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> > > > index 000ab7225717..429e4e989f38 100644
> > > > --- a/drivers/usb/usbip/vhci_hcd.c
> > > > +++ b/drivers/usb/usbip/vhci_hcd.c
> > > > @@ -1288,6 +1288,22 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
> > > >    	return 0;
> > > >    }
> > > > +static int vhci_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
> > > > +				gfp_t mem_flags)
> > > > +{
> > > > +	if (usb_endpoint_xfer_isoc(&urb->ep->desc) && urb->num_sgs) {
> > > > +		pr_err("SG is not supported for isochronous transfer\n");
> > > 
> > > Any reason to not use dev_err()?
> > 
> > Because some codes in vhci_hcd.c use pr_err().There is no other
> > reason. However, dev_err() seems more appropriate than pr_err().
> > I will replace pr_err() with dev_err(urb->dev->dev, "SG is ...")
> > Is it ok?
> > 
> 
> Please. This way we will have the device information. pr_err()
> won't us that. In general I prefer dev_* if dev is available in
> the code path, which is the case here.

Ok. I will resend v5.

Regards
Suwan Kim
