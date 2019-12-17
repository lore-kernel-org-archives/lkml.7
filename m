Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9E021835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576569661;
	bh=S2ZJz3dmg/iV/HXN0K8nTRakpRHEekt71LuYRmWiS1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oqQdkBAusKf1A/XMYKo6WHinWLbC21nFG4i/F046CHtcfN0o/PXp+hhHFcx9nkM5i
	 mWwj2u/HIMeS/Dr/YDP/ygIR0nvGPPwFrjlACe8d5XARhNLHUGlq0B6LlalTLY17it
	 O9Aqraa7c5IS+IFgdJL5vJB/rrVh75NElInRzqyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLQIBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfLQIA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:00:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F60207FF;
        Tue, 17 Dec 2019 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576569656;
        bh=S2ZJz3dmg/iV/HXN0K8nTRakpRHEekt71LuYRmWiS1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNomV5mbcvv6DBQ0Ba/ZgFDnLZqCa8UqHlhj/bJQH+uSJ/fDGF5JFB9e+MnsqJ366
         mZIiNTdgquVMQdFuXEUrWzSApd4Uxn23bahmTxIHJDGOdWi8kZXW1OsI/oX7zDDVTH
         mWSdKWSdRI1TDLubAzAfG0mMas7CxRCpBMHvRke0=
Date:   Tue, 17 Dec 2019 09:00:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild test robot <lkp@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Olof's autobuilder <build@lixom.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Karsten Keil <isdn@linux-pingi.de>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [staging-next] isdn: don't mark kcapi_proc_exit as __exit
Message-ID: <20191217080054.GA2525210@kroah.com>
References: <20191216194909.1983639-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216194909.1983639-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 08:48:56PM +0100, Arnd Bergmann wrote:
> As everybody pointed out by now, my patch to clean up CAPI introduced
> a link time warning, as the two parts of the capi driver are now in
> one module and the exit function may need to be called in the error
> path of the init function:
> 
> >> WARNING: drivers/isdn/capi/kernelcapi.o(.text+0xea4): Section mismatch in reference from the function kcapi_exit() to the function .exit.text:kcapi_proc_exit()
>    The function kcapi_exit() references a function in an exit section.
>    Often the function kcapi_proc_exit() has valid usage outside the exit section
>    and the fix is to remove the __exit annotation of kcapi_proc_exit.
> 
> Remove the incorrect __exit annotation.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/isdn/capi/kcapi_proc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for this, now applied.

greg k-h
