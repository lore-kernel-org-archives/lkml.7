Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97BC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE0E214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZvOkcVeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbfLLUoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:44:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52064 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfLLUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 15:44:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCKi3Y2006089;
        Thu, 12 Dec 2019 14:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576183443;
        bh=Rj6bMZCQXWRSdvUm+2Ymo8/2uiCXnYfPqaz0iwPtsC4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZvOkcVeStiBP30YNQCjoD5aCwDc4So32pLew34D81SE3ehJzY8h+QLZE9BwtPF19O
         KTY9vykaxnxvRQOC4Q1rIHU8iXLLsZ8O2cQ8LsTkoUZnVf2PRZczLob7VBOnGJcfKL
         JmVdA4PnGMvmTUwcxlJwVMc1VKfM2oyne6l3BXtU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCKi3pL091411;
        Thu, 12 Dec 2019 14:44:03 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 14:44:01 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 14:44:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCKi1tn022097;
        Thu, 12 Dec 2019 14:44:02 -0600
Date:   Thu, 12 Dec 2019 14:43:26 -0600
From:   Bin Liu <b-liu@ti.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
CC:     <linux-kernel@lists.codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: musb: fix __iomem in trace functions
Message-ID: <20191212204326.GK16429@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191015150309.17364-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191015150309.17364-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 15, 2019 at 04:03:09PM +0100, Ben Dooks (Codethink) wrote:
> The trace functions should have __iomem on the addr
> pointers. Add __iomem to avoid the following warnings
> from sparse:
> 
> drivers/usb/musb/musb_core.c:253:55: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:253:55:    expected void const *addr
> drivers/usb/musb/musb_core.c:253:55:    got void const [noderef] <asn:2> *addr
> drivers/usb/musb/musb_core.c:259:56: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:259:56:    expected void const *addr
> drivers/usb/musb/musb_core.c:259:56:    got void [noderef] <asn:2> *addr
> drivers/usb/musb/musb_core.c:267:55: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:267:55:    expected void const *addr
> drivers/usb/musb/musb_core.c:267:55:    got void const [noderef] <asn:2> *addr
> drivers/usb/musb/musb_core.c:273:56: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:273:56:    expected void const *addr
> drivers/usb/musb/musb_core.c:273:56:    got void [noderef] <asn:2> *addr
> drivers/usb/musb/musb_core.c:383:55: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:383:55:    expected void const *addr
> drivers/usb/musb/musb_core.c:383:55:    got void const [noderef] <asn:2> *addr
> drivers/usb/musb/musb_core.c:390:56: warning: incorrect type in argument 2 (different address spaces)
> drivers/usb/musb/musb_core.c:390:56:    expected void const *addr
> drivers/usb/musb/musb_core.c:390:56:    got void [noderef] <asn:2> *addr
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks for the patch. But checkpatch.pl complains that the author and
Signed-off-by do not match. Can you please fix it and re-send?

-Bin.
