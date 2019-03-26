Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A6E20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563392;
	bh=M+7MENbk1nNPgov0KHp8UWU2y624IzxWo/AlDpDqK28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9X0WdOCTUYxc1QWhynZaA4QRz+faYsMf/iDIvn2vivJHTAq/pSmAlqrTQ2HcqHoF
	 PNGtbMG3RmUcsx4zZkbfylaedgnk1NG0fBRiClQxQtBlq4+xCQNkPPgwiCa1YJEAVL
	 YLkXjEH0Ggy4Au3MWUyGFWhav4ZkTCkXE9zpitug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfCZBXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:23:10 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F27206DF;
        Tue, 26 Mar 2019 01:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563389;
        bh=M+7MENbk1nNPgov0KHp8UWU2y624IzxWo/AlDpDqK28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJ3gUwIhTPMAPiD+BGfROqtuvcpmcJryICFmlfj72ubg7NlTLD+WlM1HgGz+8fsSu
         MzLYFgDl1Zg+DrJdmCgVXgJ/KMIiUO497ArDg7MK81kp/7JN8buEK3Fhnha9xCsCkV
         qv74qpHuZ4czfZ/LSvoTOUOU3ROJj5Y+a/mt4uKg=
Date:   Tue, 26 Mar 2019 10:13:19 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Ralf Spenneberg <ralf@spenneberg.net>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 04/25] USB: iowarrior: fix oops with malicious
 USB descriptors
Message-ID: <20190326011319.GC29420@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-5-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-5-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:43:55PM +0100, Arnd Bergmann wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
> 
> The iowarrior driver expects at least one valid endpoint.  If given
> malicious descriptors that specify 0 for the number of endpoints,
> it will crash in the probe function.  Ensure there is at least
> one endpoint on the interface before using it.
> 
> The full report of this issue can be found here:
> http://seclists.org/bugtraq/2016/Mar/87
> 
> Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 4ec0ef3a82125efc36173062a50624550a900ae0)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/misc/iowarrior.c | 6 ++++++
>  1 file changed, 6 insertions(+)

This commit has been in the tree for a long time.  It was in the 4.4.7
release, back in April 2016.  And then it was reverted in commit
b7321e81fc36 ("USB: iowarrior: fix NULL-deref at probe") as it broke
systems.  So why add it back, the correct functionality should be there
today, right?

thanks,

greg k-h
