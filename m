Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE9AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6DE24655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m0TtVy0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfLQOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:42:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfLQOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:42:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHEgliP008098;
        Tue, 17 Dec 2019 08:42:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576593767;
        bh=NJtBk/dGuHmYEJrEP7nO7ApfX+m+JO+r6K26fO3v6j4=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=m0TtVy0hw+Hujrbk70nHOmcfaSOfowMCUglRNHSpq9q5cpT4nB61sJOkJUiKRJ4sv
         8wQb+XHg/vxqZ5axZAnltjb9pfAsj9rGFIY0cFSvKD0OEMQNRXjDJ+fd9QPcf3IPix
         RiVtsIkgsrv9QDnozLM4vw8H/S+u8w94bbw4bWb0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHEglYi044197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 08:42:47 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 08:42:47 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 08:42:47 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHEgli2041553;
        Tue, 17 Dec 2019 08:42:47 -0600
Date:   Tue, 17 Dec 2019 08:42:06 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v3 2/7] usb: musb: dma: Add support for shared IRQ
Message-ID: <20191217144206.GM16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
References: <20191210171110.62141-1-paul@crapouillou.net>
 <20191210171110.62141-2-paul@crapouillou.net>
 <20191211185224.GD16429@iaqt7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191211185224.GD16429@iaqt7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 11, 2019 at 12:52:24PM -0600, Bin Liu wrote:
> On Tue, Dec 10, 2019 at 06:11:05PM +0100, Paul Cercueil wrote:
> > The implementation of the Inventra IP in some of the Ingenic JZ47xx SoCs
> > does not use a separate IRQ line for DMA transfers.
> > 
> > Allow these SoCs to be supported by adding a flag 'dma_share_usb_irq'
> > in the struct musb. If set, no extra IRQ line is required, and the musb
> > glue will need to call the API function musbhs_dma_controller_irq()
> > within its interrupt handler.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Tested-by: Artur Rojek <contact@artur-rojek.eu>
> > ---
>  
> Queued for usb-next. Thanks.

I removed this and the next patch [3/7] in this series from my queue.
Sorry. Ming Guo has posted a series "Add MediaTek MUSB Controller
Driver" which has done the similar implementation [1] but without adding
the flag in struct musb. Can you please check if you can use Ming's
implementation instead? The patch of his musb glue driver which uses the
implementation is [2], just for your reference.

[1] https://marc.info/?l=linux-usb&m=157602930627195&w=2
[2] https://marc.info/?l=linux-usb&m=157602932427210&w=2

Thanks,
-Bin.
