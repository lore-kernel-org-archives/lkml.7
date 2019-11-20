Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065B8C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C675F2244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 05:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574229527;
	bh=p0H6HwLa45oCbagaqqjdkdF/Wd5VpVqr3Nn+QZyA4c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U/jxtNR5V2cNWcgpwyCHEnDJcJ2wQ5xkcnEuBxcdY66CRyshSKDAXiTvJRGCgYSIA
	 FlaHvEIGOilwN0UxxarFx9N4rESif9s2wGjq1w7AYIZqwh8mRx56I+nF/iu/+N1aYP
	 qh3//dD/EX2N6nPaKom8caucoLzIP1NZqE3LthK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfKTF6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 00:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfKTF6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 00:58:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414B0205C9;
        Wed, 20 Nov 2019 05:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574229525;
        bh=p0H6HwLa45oCbagaqqjdkdF/Wd5VpVqr3Nn+QZyA4c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fW+YefVTZqzJYrUOK+NT0ti/4O2Y4GZUF3pevZh44xhbvuwlX/85UeTGRbROJJlmt
         gGfQqOOlpSOHcltjGArVwZDI3q76L9rXqeXMdG+eEGkarXkOnif6X/hxKZQrtHSoTp
         j6tmJsoRTdpHz35sMgEcFsZI9F8cElXKY4W4YdII=
Date:   Wed, 20 Nov 2019 06:58:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 000/422] 4.19.85-stable review
Message-ID: <20191120055842.GA2853442@kroah.com>
References: <20191119051400.261610025@linuxfoundation.org>
 <TYAPR01MB22854E4F20C28F3A10DA65E3B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119122909.GC1913916@kroah.com>
 <TYAPR01MB228560FC98FFD1D449FA4EC2B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119154839.GB1982025@kroah.com>
 <TYAPR01MB2285698B8E0F38B9EEF47128B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191119165207.GA2071545@kroah.com>
 <20191119180002.GA17608@roeck-us.net>
 <20191119181619.GB2283647@kroah.com>
 <TYAPR01MB22851F2F6D26C0971588DD92B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB22851F2F6D26C0971588DD92B74C0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 08:00:59PM +0000, Chris Paterson wrote:
> > Ok, I've now done just that, and pushed out a -rc4.
> 
> Thanks Greg.
> 
> Linux 4.19.85-rc4 (824c9ada & d0112da1) works for me.

Wonderful, thanks for testing all of this.

greg k-h
