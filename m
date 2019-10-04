Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E94C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE682133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570202331;
	bh=wUmIZgOi316Gx1c2Bgu9pvkNvahIooD2MgUXDmA5RtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RFmfUua8JvNENVlyMaFbXuNAVmFII3YLaJ/wgJ7mrOuSPJbQ3MadGiIXA11MjFGdD
	 iRN5WqgCvwzHagsvov83/2XsdFcS/GSnWR9EZRKi6vwKTR7Q+yo/aJvQkRzi/bYuFm
	 dS83hWWQKgDGJ+mSXHwmHA088mSRJyXgHR/AKBo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfJDPSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:18:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59578207FF;
        Fri,  4 Oct 2019 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570202329;
        bh=wUmIZgOi316Gx1c2Bgu9pvkNvahIooD2MgUXDmA5RtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qi9XBSfoMPqAVRBYg8Qr1gIRO9VpSMjZ/mfmIETJM+N8uvj/ZWodO8WaZakrWFIHx
         Fx7rHcpK9URzfLFL2dK381p7oI8kV4wdTVUZMz/sADhCn7S6ozKeToPU1Gnodps/Gi
         5sIK3vYaUasAbLl/vitlX77/hUfE70qke3KJf2as=
Date:   Fri, 4 Oct 2019 17:18:46 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
Message-ID: <20191004151846.GA760679@kroah.com>
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:40:07AM +0000, Dmitry Goldin wrote:
> From: Dmitry Goldin <dgoldin+lkml@protonmail.ch>
> 
> In commit 43d8ce9d65a5 ("Provide in-kernel headers to make
> extending kernel easier") a new mechanism was introduced, for kernels
> >=5.2, which embeds the kernel headers in the kernel image or a module
> and exposes them in procfs for use by userland tools.
> 
> The archive containing the header files has nondeterminism caused by
> header files metadata. This patch normalizes the metadata and utilizes
> KBUILD_BUILD_TIMESTAMP if provided and otherwise falls back to the
> default behaviour.
> 
> In commit f7b101d33046 ("kheaders: Move from proc to sysfs") it was
> modified to use sysfs and the script for generation of the archive was
> renamed to what is being patched.
> 
> Signed-off-by: Dmitry Goldin <dgoldin+lkml@protonmail.ch>


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
