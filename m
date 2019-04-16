Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB01C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F2120693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555407950;
	bh=BlHaJfX+k2skE3lCGc1AtyXKIgrIDTDVlB8GM+upJLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2XA7mwC0CoqXYz65vGKNDFPP3AzOQ2zyictgVf8EdfuUf66xRRafQuacfnF4DXHUX
	 euxSR/R49bM8VGuXInVvEAS+fkvScWPfMymOLAMiRI0/9+5K88bxCasQYiIn9U2vkU
	 0UNA7OeZ6ziHSxVo2PibzXMe0R8Od+SwD+iSXaI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDPJps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfDPJps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:45:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A18020684;
        Tue, 16 Apr 2019 09:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555407947;
        bh=BlHaJfX+k2skE3lCGc1AtyXKIgrIDTDVlB8GM+upJLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bP90p6aArRpifF4Ml1slnpTGtQ3SSFBoSeR6E6qRbSXkxbbcmtdRf0V05qYoUREp6
         3YH7C7sdiKNPlPQCI5zB+51ZlQe9tmAz4jfyVYwbfEnGtoh26w5vv++EOJtUnjP2o/
         KGlFQDyZYXAxfhYowuagW+0vHXxB02MePBlkLTSg=
Date:   Tue, 16 Apr 2019 11:45:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhuyan <zhuyan34@huawei.com>
Cc:     anton@enomsg.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
Message-ID: <20190416094545.GA896@kroah.com>
References: <1554820632-13782-1-git-send-email-zhuyan34@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554820632-13782-1-git-send-email-zhuyan34@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> In function fhci_queue_urb, the divisor of expression
> (urb->transfer_buffer_length % usb_maxpacket(urb->dev, urb->pipe,
> usb_pipeout(urb->pipe))) may be zero.

How can you hit that?

> When it is zero, unexpected results may occur, so it is necessary to
> ensure that the divisor is not zero.
> 
> Signed-off-by: zhuyan <zhuyan34@huawei.com>

I need a "Full" name here, not just a single name.  Whatever you use to
sign documents is good.

thanks,

greg k-h
