Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBDCC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FD2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560451496;
	bh=6yS+Fnsn3PuOz05RQi8P/KTQwsadeiCQ2KB9R2l4jTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=juJP+L0kE9oApr2pfQsHkjB+6E6Edw9v6G1xi5lZ7qOCNJSRonTiDj/s1mgW9i56G
	 tqj8ZK+oXj8ErU2DFBarYgMStN1s5QMsbOokc0MkZKpPvfKvC8+0i0X3n8VRA7iStd
	 fXu115eaUgM8V6xahJqloOkFexKbH6GucGylXTro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfFMSoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfFMSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:44:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B507521473;
        Thu, 13 Jun 2019 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560451494;
        bh=6yS+Fnsn3PuOz05RQi8P/KTQwsadeiCQ2KB9R2l4jTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXFkAbW4Gyx06f8rXazYSM9/Y8LE4clCV1wSSnfaPbsSq29LcoXhcp5Ry6IpvrLkN
         FXBMhYwt3dyUfOihUtdDYvWePkTILgNWb8EsogRPojXjykiMDxrjHUCyyRKJd/0toP
         4kfr7YEAtBFqmf5U+9YCNCC5ZlJr1yu2ElLFu91o=
Date:   Thu, 13 Jun 2019 20:44:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     treding@nvidia.com, mathias.nyman@intel.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: Cleanup of -Wunused-const-variable in
 drivers/usb/host/xhci-tegra.c
Message-ID: <20190613184450.GA896@kroah.com>
References: <CAJkfWY4nKwyPDh=MuCURst2SZceceeR2v3qrT9UY=VbvLnEmFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY4nKwyPDh=MuCURst2SZceceeR2v3qrT9UY=VbvLnEmFg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:38:38AM -0700, Nathan Huckleberry wrote:
> Hey all,
> 
> I'm looking into cleaning up ignored warnings in the kernel so we can
> remove compiler flags to ignore warnings.
> 
> There's an unused variable ('mbox_cmd_name') in xhci-tegra.c. Looks
> like it was intended for logging or debugging, but never used. Just
> wanted to reach out to ask the best steps for cleaning this up.
> 
> If the variable is no longer needed I'd like to send a patch to remove it.

You never have to ask permission to send a patch :)
