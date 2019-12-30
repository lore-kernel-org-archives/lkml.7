Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5044BC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2421F20409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 17:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW06kpVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfL3RDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 12:03:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37526 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfL3RDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 12:03:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so26700763qky.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rka3ilO99bAcq48TNL+hlG2WYcFVK54JT4LskhtH/CE=;
        b=IW06kpVxlvi/ChzeLckluKNsjgCEzeO+qgp6fUtwrfWPfH28vIGifK1gM26HKzHH5w
         zOAkgqwTTvMo4/lDbW/j6esKSNbbYkpLTnT5DnybCbfhCD1GRQ9fESAAAqLkzcb3vxHb
         dRvY7Lf3Fsas2ruCrepZ0zYnZ7lQl2XyTkWs1YEWF71YPet7vb3eEDvG5exd0W9IgEGc
         Qvub15S+BpYk7M5xbA1+N0+XFvrPJegjqbGOLNIQ2H2g/YBkanRM+5kHF2G7qC5HvmbQ
         ogUuUcl2nmqiug6EqHYswAXv1E6fSM671BbNRGvkzeRj/PPXBrissuJTxoU+iibrxQ+s
         Om/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Rka3ilO99bAcq48TNL+hlG2WYcFVK54JT4LskhtH/CE=;
        b=Tbi6G4YtdINBjBYJvZUFYXUkF+jimoKZF/dj18nEWo3zRbwl+xHEA+glo0Ky6ll1df
         iF/SGLyhsQI5SlYmPJr5Y0Fg1q+gWCD3eJ8lfODcrnJArFBwAnsfSZSFczjnlGVIkO+o
         LlWQkUMN1t7Uwe5egZcut2Q+CFCsVYvzBnkOKsjMzcCrVdOeJFXdAZCDNJaYJtL1f0k+
         5KSBlWXT5gpf3yI5qPf+VNeFAvE8x/pPjYJb8N9YnTHJiaD3xXIkqrkVhrBF4eD048WI
         u4LRjOlSMuw2KrCiP950P8irSbRd/ulaDeKv4aEduzFhlCq90tdQinIpaO8TCq0AkCDg
         TUlg==
X-Gm-Message-State: APjAAAUYpWNPhA8SL3dUD4vZBF/VYlxDo3+Umex9qr1Bg6l4wgkKZaEK
        +dKmqouB6+uRmCCvbP4OmMk=
X-Google-Smtp-Source: APXvYqyFJyPMZauoGwKvbX2Q7Bd2cHMdgP16tVanQ76mjfkh2RofRORjAK1g57turgw8N+YTk4lz8g==
X-Received: by 2002:ae9:eb13:: with SMTP id b19mr54487398qkg.6.1577725422980;
        Mon, 30 Dec 2019 09:03:42 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id w20sm14049424qtj.4.2019.12.30.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 09:03:42 -0800 (PST)
Date:   Mon, 30 Dec 2019 12:03:40 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Konrad Rzeszutek Wilk <konrad@kernel.org>,
        Peter Jones <pjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] iscsi_ibft: Don't limits Targets and NICs to two
Message-ID: <20191230170340.GA23237@localhost.localdomain>
References: <20191221070956.268321-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191221070956.268321-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 08:09:56AM +0100, Lubomir Rintel wrote:
> According to iSCSI Boot Firmware Table Version 1.03 [1], the length of
> the control table is ">= 18", where the optional expansion structure
> pointer follow the mandatory ones. This allows for more than two NICs
> and Targets.
> 
> [1] ftp://ftp.software.ibm.com/systems/support/bladecenter/iscsi_boot_firmware_table_v1.03.pdf
> 
> Let's enforce the minimum length of the control structure instead
> instead of limiting it to the smallest allowed size.

Hi!

Do you have an example of such iBFT table? Thanks
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/firmware/iscsi_ibft.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
> index 7e12cbdf957cc..96758b71a8db8 100644
> --- a/drivers/firmware/iscsi_ibft.c
> +++ b/drivers/firmware/iscsi_ibft.c
> @@ -104,6 +104,7 @@ struct ibft_control {
>  	u16 tgt0_off;
>  	u16 nic1_off;
>  	u16 tgt1_off;
> +	u16 expansion[0];
>  } __attribute__((__packed__));
>  
>  struct ibft_initiator {
> @@ -235,7 +236,7 @@ static int ibft_verify_hdr(char *t, struct ibft_hdr *hdr, int id, int length)
>  				"found %d instead!\n", t, id, hdr->id);
>  		return -ENODEV;
>  	}
> -	if (hdr->length != length) {
> +	if (length && hdr->length != length) {
>  		printk(KERN_ERR "iBFT error: We expected the %s " \
>  				"field header.length to have %d but " \
>  				"found %d instead!\n", t, length, hdr->length);
> @@ -749,16 +750,16 @@ static int __init ibft_register_kobjects(struct acpi_table_ibft *header)
>  	control = (void *)header + sizeof(*header);
>  	end = (void *)control + control->hdr.length;
>  	eot_offset = (void *)header + header->header.length - (void *)control;
> -	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control,
> -			     sizeof(*control));
> +	rc = ibft_verify_hdr("control", (struct ibft_hdr *)control, id_control, 0);
>  
>  	/* iBFT table safety checking */
>  	rc |= ((control->hdr.index) ? -ENODEV : 0);
> +	rc |= ((control->hdr.length < sizeof(*control)) ? -ENODEV : 0);
>  	if (rc) {
>  		printk(KERN_ERR "iBFT error: Control header is invalid!\n");
>  		return rc;
>  	}
> -	for (ptr = &control->initiator_off; ptr < end; ptr += sizeof(u16)) {
> +	for (ptr = &control->initiator_off; ptr + sizeof(u16) <= end; ptr += sizeof(u16)) {
>  		offset = *(u16 *)ptr;
>  		if (offset && offset < header->header.length &&
>  						offset < eot_offset) {
> -- 
> 2.24.1
> 
