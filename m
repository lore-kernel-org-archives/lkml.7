Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B939C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131F721D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P417idu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfKEMRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:17:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41264 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKEMRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:17:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so21079701wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5WjUuFi1lzsZ0jYBoaXwxIPUs2nhOsZLPkdWBs2AKLE=;
        b=P417idu8xkSOp83bucE6v/1E1W1RvIuAVTDiRCXs18VWSccTtXfC2aJ4GJu5jds6ZH
         uBJCgJE3ExZ52WKimdaza0yOBUaXRuh7bdWeQ2I3ynlSEB+YpwPjeRqXCVtdrmi8vAap
         DI9GyZy5yMsGuTYmT0V+qqaQFq59NGpnVxLHW1uDAifGPTIJHyV2FFqi0Glf9/WLyDY7
         2AHiPKVrhqw0mqhBfVmq46u5888cPcLrea00kDAAgQ5jy0GlP5wZBchsJhnQ05B7F0gv
         NAnylj9LeqvqQqCHWMLLUu5pOWkckz9FzpzgQEcbufw1DoXqiMfamjxJHFyOPwrLEGub
         4zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5WjUuFi1lzsZ0jYBoaXwxIPUs2nhOsZLPkdWBs2AKLE=;
        b=UcB5kqLVcaRfHTuQfHvA+0gXi6+Zn4k9LX6pPDraV6pfZ1QqUWVwlS4wEaAbMl6WZf
         tgaXLtva8IiC7vS+udUmRRMh0SysKNaNclGNzhht7ljJ8p/d5I2VJJCrpPYywHLvv8mV
         /8FDdVkKz3S8ZzVDwx+2BFDaNf+JSP12k1/g+myAJiJoNSYybG1AwBUvLoFtlNeEoFjn
         /xn1v3hp/2z7UH1BR1XMsiDDPUJAcpHPWXP90llY1xfjY6/udK6UYfQKt0YsbqUcgU7b
         vV6SmR5Su+GTSlndip0xiyTu0fW83N5UOhcWF3GXOgM7v4i4K1ocatkesFbFedBU5D5/
         QCbw==
X-Gm-Message-State: APjAAAWflTBb3wbeoS+DWGsdMG9mKT6cU1DNOsEp0Hjv+W8xU+B5+28J
        GMIvzxEp2qnH31f7XZ7KudVmew==
X-Google-Smtp-Source: APXvYqwErB67f7DBD+wdgWRB8DG4qf1Fxi2tzJbIRlf8rBiYnT674amq+eMXIK0jGQf3/caWICJLYw==
X-Received: by 2002:adf:f452:: with SMTP id f18mr29422850wrp.264.1572956263645;
        Tue, 05 Nov 2019 04:17:43 -0800 (PST)
Received: from [10.83.36.220] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b62sm18477866wmc.13.2019.11.05.04.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 04:17:43 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Ensure pci transactions coming from PLX NTB are handled
 when  IOMMU is turned on
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
Date:   Tue, 5 Nov 2019 12:17:42 +0000
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0B8FAD0D-B598-4CEA-A614-67F4C7C5B9CA@arista.com>
References: <A3FA9DE1-2EEF-41D8-9AC2-B1F760E7F5D5@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

Cheers,
James.

> On 24 Oct 2019, at 13:52, James Sewart <jamessewart@arista.com> wrote:
>=20
> The PLX PEX NTB forwards DMA transactions using Requester ID's that =
don't exist as
> PCI devices. The devfn for a transaction is used as an index into a =
lookup table
> storing the origin of a transaction on the other side of the bridge.
>=20
> This patch aliases all possible devfn's to the NTB device so that any =
transaction
> coming in is governed by the mappings for the NTB.
>=20
> Signed-Off-By: James Sewart <jamessewart@arista.com>
> ---
> drivers/pci/quirks.c | 22 ++++++++++++++++++++++
> 1 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..647f546e427f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5315,6 +5315,28 @@ SWITCHTEC_QUIRK(0x8574);  /* PFXI 64XG3 */
> SWITCHTEC_QUIRK(0x8575);  /* PFXI 80XG3 */
> SWITCHTEC_QUIRK(0x8576);  /* PFXI 96XG3 */
>=20
> +/*
> + * PLX NTB uses devfn proxy IDs to move TLPs between NT endpoints. =
These IDs
> + * are used to forward responses to the originator on the other side =
of the
> + * NTB. Alias all possible IDs to the NTB to permit access when the =
IOMMU is
> + * turned on.
> + */
> +static void quirk_PLX_NTB_dma_alias(struct pci_dev *pdev)
> +{
> +	if (!pdev->dma_alias_mask)
> +		pdev->dma_alias_mask =3D kcalloc(BITS_TO_LONGS(U8_MAX),
> +					      sizeof(long), GFP_KERNEL);
> +	if (!pdev->dma_alias_mask) {
> +		dev_warn(&pdev->dev, "Unable to allocate DMA alias =
mask\n");
> +		return;
> +	}
> +
> +	// PLX NTB may use all 256 devfns
> +	memset(pdev->dma_alias_mask, U8_MAX, (U8_MAX+1)/BITS_PER_BYTE);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b0, =
quirk_PLX_NTB_dma_alias);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PLX, 0x87b1, =
quirk_PLX_NTB_dma_alias);
> +
> /*
>  * On Lenovo Thinkpad P50 SKUs with a Nvidia Quadro M1000M, the BIOS =
does
>  * not always reset the secondary Nvidia GPU between reboots if the =
system
> --=20
> 2.19.1
>=20
>=20

