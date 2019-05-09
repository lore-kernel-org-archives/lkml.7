Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15631C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD3B2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557404738;
	bh=3UPzRLHDfSoVigDN2UxnHZ4gUOJ1xilPkyQW4K1lCvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mCJyjK5hCC3VXGwLP5Ow3iT0LPwtpxo1U0OAccCxUmjG7hHy2zn31KG80cv51HpCe
	 IojNLiPr3TghGzrz/x/xwlKY32fDcvCrsT9r51WLDLP5cJcvzdupqoefA3qI4mg265
	 e0nIv46S0cPKsBlGFfyWKdQEMap/Wrr6jqwb3Dyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEIMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbfEIMZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:25:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE2A216C4;
        Thu,  9 May 2019 12:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557404737;
        bh=3UPzRLHDfSoVigDN2UxnHZ4gUOJ1xilPkyQW4K1lCvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VymesX1bFMmR6yZyA9P+9qVNcaucdCS85WQfJCwJ8QpTGj4PM9bMgEfja57tf57gP
         1OypPTl+Ab/RLQaF3PnNA1DmFHuxgp9AkrUZoEruJ1zNpxk19ijmPF4OvfR61FauEi
         Xc69wk5MHryV4WoJxNCEvDBFd5vZe111w1TvO3Ig=
Date:   Thu, 9 May 2019 14:25:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        keescook@chromium.org, nsaenzjulienne@suse.de, jflat@chromium.org,
        malat@debian.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] usb: xhci: Add Clear_TT_Buffer
Message-ID: <20190509122534.GA31542@kroah.com>
References: <1557403395-30877-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557403395-30877-1-git-send-email-jilin@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 08:03:15PM +0800, Jim Lin wrote:
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -625,6 +625,7 @@ struct usb3_lpm_parameters {
>   *		parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
>   *
>   *	Will be used as wValue for SetIsochDelay requests.
> + * @devaddr: address on a USB bus, assigned by controller like XHCI
>   *
>   * Notes:
>   * Usbcore drivers should not set usbdev->state directly.  Instead use
> @@ -709,6 +710,7 @@ struct usb_device {
>  	unsigned lpm_disable_count;
>  
>  	u16 hub_delay;
> +	int devaddr;

Shouldn't this be u32?


