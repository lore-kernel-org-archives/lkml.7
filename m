Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE12C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F192820740
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574069247;
	bh=Rps6VHNZkf0Vw651PAQcvS5aj/kdFjBNct/TEC/byN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FO8s5sv7hFNwcEjsnuLb7rBKgSF1OoZqUGPNOCUYP+8gDPXN46XJ40yh2ZaS5RTq/
	 PB/RLAnGfrOCFDXuJG1xyCZoXFi8xMFGpzDCBwZQGtIvVaPtITpa3WoyfS7G7r7D8k
	 XhEIvXg7PMeMe/K4/uoxw09LCpi/FlSykivQJxpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfKRJ10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfKRJ1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:27:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8500520727;
        Mon, 18 Nov 2019 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574069245;
        bh=Rps6VHNZkf0Vw651PAQcvS5aj/kdFjBNct/TEC/byN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JdlMt0eutnDFaTXmS4gGFIT/SNFiG3KL7VQ3A+tyzTo69xBX/HJBUYh789u8geWPS
         8y11hoOFVLMo++Klgx3tuBbQONJVkQEzMMaGSqA3GUsnRgEazMdTW0oXpvTtU1WO8K
         k1WAP2xMOCTNXKSFTr8YT5AfjjkGID/hg1v9Wzn8=
Date:   Mon, 18 Nov 2019 10:27:21 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735: possible missing
 return value check
Message-ID: <20191118092721.GA154812@kroah.com>
References: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 09:24:32AM +0000, David Binderman wrote:
> Hello there,
> 
> linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735:5: style: Variable 'rc' is reassigned a value before the old one has been used. [redundantAssignment]
> 
> Source code is
> 
>     if (tpm_suspend_pcr)
>         rc = tpm1_pcr_extend(chip, tpm_suspend_pcr, dummy_hash,
>                      "extending dummy pcr before suspend");
> 
>     rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_SAVESTATE);
> 
> Suggest add test of rc after call to tpm1_pcr_extend.

Great, how about you submit a patch to resolve this?  That way you can
get the full credit for finding and resolveing the issue?

thanks,

greg k-h
