Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993F821D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570194436;
	bh=CFOCouonhzz00UEFUDuYK1KXMg/m6E5gMfXnX/sdPAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXYK8xDWmFqIRksW85uG0t509didigkyRbMnEexPLkDQBKaN5G/zWMOQb/ytz7Nk1
	 PG86K02ndhAdv4UJJhRtsGVrBL4gNdVl9wDzENlHfzSo+XpoxYfVCS62wShc3rwZU9
	 Ecvrj23Ka0XJOcmDQY2g7eCql0fKhBQkENyzkIks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbfJDNHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387834AbfJDNHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:07:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827BC215EA;
        Fri,  4 Oct 2019 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570194435;
        bh=CFOCouonhzz00UEFUDuYK1KXMg/m6E5gMfXnX/sdPAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M2hNx4wBJ3d6xKK06wIa4l/jLjZEavgdqqygSEgxPkVPkwhmI+W9ieVmynxzKF+O9
         H16/ubVYs/dKerC8+r7HrMMcIzoocZLmnbamnWenR9kZdXrkDmmrGyQ55hvZvTl+ji
         rrKfFhUVaH7tKWXGggTaeRFccoog52ppxMZOJrOU=
Date:   Fri, 4 Oct 2019 15:07:12 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Message-ID: <20191004130712.GA622272@kroah.com>
References: <20191002130425.28905-1-stefan-gabriel.mirea@nxp.com>
 <20191002130425.28905-4-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002130425.28905-4-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 01:04:42PM +0000, Stefan-gabriel Mirea wrote:
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -290,7 +290,7 @@
>  /* Sunix UART */
>  #define PORT_SUNIX	121
>  
> -/* Freescale Linflex UART */
> -#define PORT_LINFLEXUART	121
> +/* Freescale LINFlexD UART */
> +#define PORT_LINFLEXUART	122

This is a different change, and one that should be split out and
submitted now, for 5.4.  Please do that as the id number is incorrect,
don't bury a valid change in the middle of a "marketing renamed the
device" patch :)

thanks,

greg k-h
