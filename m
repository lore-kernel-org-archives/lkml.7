Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2862085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="MGkYENT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfCYHxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:53:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34758 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfCYHxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:53:49 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CBF11EC0310;
        Mon, 25 Mar 2019 08:53:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553500428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wCQ2sMH0EHR963ttG8Fg9nl/R+S87SD1MCvCqoc6kvY=;
        b=MGkYENT8mlyY8sGSYfQj5VMNWzwF19EHrqpcNpTeUapDB3A0YM8CwC5mV/gT+VRupBFgJQ
        KSOzCSwJxI/fccFetmLEJgTwMSp4ytroKQRY1OfFMwTWpMDJoQUleNH5LiBAyTwIjh5JaO
        a8kfRN5SGUELmYI8JOdU8QEvl9aFlKY=
Date:   Mon, 25 Mar 2019 08:53:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/boot: Use EFI setup data if provided
Message-ID: <20190325075342.GE12016@zn.tnic>
References: <20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp>
 <20190322152328.GD12472@zn.tnic>
 <20190325072710.GA31828@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325072710.GA31828@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:27:10PM +0800, Baoquan He wrote:
> Kexec kernel also need to get rsdp to get SRAT tables so that KASLR can
> avoid those hotpluggable regions in boot compression stage.
> 
> The kexec_file_load has filled in acpi_rsdp_addr of kexec kernel in
> below code. It will return direclty in get_rsdp_addr() since
> acpi_rsdp_addr is got from boot_params->acpi_rsdp_addr.
> 
> arch/x86/kernel/kexec-bzimage64.c <<setup_boot_parameters>>
> 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> 
> The other interface, kexec_load, its boot_params filling is done in user
> space kexec_tools. And we haven't made the acpi_rsdp_addr filling yet.
> And the old kexec_tools utility can also cause the new kexec kernel to
> search efi rspd pointer even thought it's fixed.

Yes, kexec is a pile of ugly and fragile hackery.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
