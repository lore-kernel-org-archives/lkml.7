Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EEC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1E2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576877440;
	bh=OWFFlIFJu9+vFiYIMboBgbTadMTkcxwtUqVCINB1DYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dbU573Fx1KHtfWxehINAWjHYw2U0TmOnsIf5GeyMK47XF1sgB6c5XiDLPu4osDy5Y
	 FpuaeN6G12E7uAMfubHkcpuy947SADWqjAuzFiARvBgs6Tojtrn9wCgWkZOw4wW+Ug
	 uqPTaxg2100WZ2ggWOOc5Wtqhb1qlxSAm21PgVrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfLTVaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfLTVaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:30:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16884206DA;
        Fri, 20 Dec 2019 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576877438;
        bh=OWFFlIFJu9+vFiYIMboBgbTadMTkcxwtUqVCINB1DYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJE5m0aimHakfSYRP3rdRl1lMpGESGPN7vxfi3+kqbzYkORGuJcjbrvTJUjX23hjW
         gDhZ+Zx6W3y8IUOCtcvAsRi1DLe9S/KbpWFP4Qk5Loat/0haxAc9qoV0krrktHeNIi
         I5koj2vjEIKr7H5OAH4PkgXuGS/BgeJyT0jhZKSE=
Date:   Fri, 20 Dec 2019 22:30:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Kim <david.kim@ncipher.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Tim Magee <tim.magee@ncipher.com>
Subject: Re: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20191220213036.GA27120@kroah.com>
References: <20191220154738.31448-1-david.kim@ncipher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191220154738.31448-1-david.kim@ncipher.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:47:38PM +0000, Dave Kim wrote:
> ﻿From: David Kim <david.kim@ncipher.com>
> 
> This is the driver for nCipher’s Solo and Solo XC hardware security modules.
> These modules implement a proprietary command set (the ’nCore API’) to
> perform cryptographic operations - key generation, signature, and so on. HSM
> commands and their replies are passed in a serialised binary format over the
> PCIe bus via a shared memory region. Multiple commands may be in-flight at
> any one time - command processing is multi-threaded and asynchronous. A write
> operation may, therefore, deliver multiple commands, and multiple replies may
> be retrieved in one read operation.

If this is "just" a crypto accelerator, why isn't this driver using the
existing in-kernel hardware crypto api?  What is lacking from it that
you need here?

thanks,

greg k-h
