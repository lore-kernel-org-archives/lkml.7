Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC33C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E6320722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577732227;
	bh=hlj2DHKkMM1q4pyzXt97/QRqhx0WP6RlTBooKDDKySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gR7d1CN9gqlNKj/HKQ5DpRZscrHS41r/xXYv1QQWVhQ1HkYH3e1RrXa4X47Dny5b5
	 CqV/RWiRto+55yu5i4vlaTZKladfvALqHEdGQpyZ3lYvV/8n4+vbbrrSUbZdjGfBqY
	 qaQH9gWS/a0LudwVG28VLesobZRYHgW9LrMiS/+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfL3S5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfL3S5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:57:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CB8206DB;
        Mon, 30 Dec 2019 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577732225;
        bh=hlj2DHKkMM1q4pyzXt97/QRqhx0WP6RlTBooKDDKySg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odisym+nfbCByfuS0MTZroIyHR7MQS9rXPJMVi/qsFjRiHwzE4ii03SC0cdFnuGNe
         CVw7vRN54S3WZbYVKlQlEVOW8utkXYNLDA8jh1MWGGvUpfECe4kHG+rTOVaW46mJSs
         oalcfe32y7VNMCFElpwbAQg+Ky4fcCiEhv++me90=
Date:   Mon, 30 Dec 2019 19:57:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: gadget: Fix failure to detect end of transfer
Message-ID: <20191230185703.GA1763367@kroah.com>
References: <20191230161321.2738541-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230161321.2738541-1-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 04:13:21PM +0000, Bryan O'Donoghue wrote:
> A recent bugfix 8c7d4b7b3d43 ("usb: dwc3: gadget: Fix logical condition")
> correctly fixes a logical error in the gadget driver but, exposes a further
> bug in determining when a transfer has completed.
> 
> Prior to 8c7d4b7b3d43 we were calling dwc3_gadget_giveback() when we
> shouldn't have been. Afer this change the below test fails to complete on
> my hardware.
> 
> Host:
> echo "host" > /dev/ttyACM0
> 
> Device:
> cat < /dev/ttyGS0
> 
> This is caused by the driver incorrectly detecting end of transfer, a
> problem that had previous been masked by the continuous calling of
> dwc3_gadget_giveback() prior to 8c7d4b7b3d43.
> 
> Remediate by making the test <= instead of ==
> 
> Fixes: e0c42ce590fe ("usb: dwc3: gadget: simplify IOC handling")
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/usb/dwc3/gadget.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think this patch:
	https://lore.kernel.org/linux-usb/ac5a3593a94fdaa3d92e6352356b5f7a01ccdc7c.1576291140.git.thinhn@synopsys.com/

should fix this issue instead, right?

If not, do I need to include both of these?

thanks,

greg k-h
