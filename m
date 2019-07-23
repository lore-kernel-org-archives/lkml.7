Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE2C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F1F223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563884820;
	bh=8DTLQlji01PFrFVN0je2RPPkhKM4wCk/VEirtlaY8WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jd7wu5Gn40CIiHnlXxmnofTczhBwR9UN/TCACzLsp0NV6503eZzyRJ6izr8e71ujp
	 XXkKLzu4X3UZGQ6yXGZiQyOgyaYRpWxM4/IhXXvow0nKQmnWk2bH2PpVxKEGOkk2cK
	 gQKIQ/VfGttDIN7pn9tDZT6pCdTIAnMcrPEMqQ+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfGWM07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 08:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfGWM06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:26:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50420223A1;
        Tue, 23 Jul 2019 12:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563884817;
        bh=8DTLQlji01PFrFVN0je2RPPkhKM4wCk/VEirtlaY8WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqrCm2ed708rXKBTAoRog232CXXma71Tr+mMSntD4aHteafGLtxgAABiV6zGzxzRm
         CA/ejZJ6uVbczoPzQ5iJsZp0tvT8oPJLgbPA+4GZC+vlqNdDT85Zwk8b7ux5DDKe0u
         rQDJQ+eYuidirOX+tAkQ5uYP3JAITxFXCdzwLSvk=
Date:   Tue, 23 Jul 2019 14:26:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <oded.gabbay@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Use dev_get_drvdata where possible
Message-ID: <20190723122654.GA11835@kroah.com>
References: <20190723121949.22021-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723121949.22021-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:19:49PM +0800, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/misc/cardreader/alcor_pci.c      |  6 ++----
>  drivers/misc/habanalabs/habanalabs_drv.c |  6 ++----
>  drivers/misc/mei/pci-me.c                | 19 ++++++++-----------
>  drivers/misc/mei/pci-txe.c               | 19 ++++++++-----------
>  4 files changed, 20 insertions(+), 30 deletions(-)

Please break this up into one-patch-per driver so that they can go
through the various different maintainers of them.

thanks,

greg k-h
