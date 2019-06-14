Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5AC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E9F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="gMVMFGjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfFNHCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:02:21 -0400
Received: from [115.28.160.31] ([115.28.160.31]:33790 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbfFNHCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:02:21 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 03:02:19 EDT
Received: from ld50 (unknown [116.227.76.7])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 49A406011D;
        Fri, 14 Jun 2019 14:55:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1560495323; bh=KIsjpnrc1kWTp5mngPR3Kyeg7MjoHz37JvngBJKfgLc=;
        h=Date:From:To:Cc:Subject:From;
        b=gMVMFGjQp+7oPQFpt+QkMFgKOYBR7sQOKe1S/hD3ZFWtuwUqQrMOHH5TTZIThER98
         rcwnX4kWid+KtKsLH6btPuQ0HU+NInL7eFyQM32DRDT+gLdrKa/yeyS2M9MaoMLd9z
         AXUy1bgNk7f3AWGkjJ/XgYhiupgXhdG4amz84lzQ=
Date:   Fri, 14 Jun 2019 14:55:18 +0800
From:   WANG Xuerui <kernel@xen0n.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@vger.kernel.org
Subject: DMI: support for non-EFI platforms with non-standard SMBIOS
 entrypoint?
Message-ID: <20190614065518.GA53855@ld50>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are several MIPS platforms floating around with firmware SMBIOS
support, primarily Loongson 3-series, but their SMBIOS entrypoint is
non-standard.  According to the SMBIOS spec the non-EFI platforms should
have the tables in the 000F_0000h-000F_FFFFh physical range, however
these boards put the table at 0FFF_E000h.

How do we enable DMI for these non-EFI yet non-standard-compliant
systems without resorting to firmware fixing, which is not always
feasible?  It is possible to move the address definition to arch realm
with the standard value as default, but I would like to first ask for
suggestions, as I am fairly new to kernel development (personal hobby
for now).

Regards,

Xuerui
