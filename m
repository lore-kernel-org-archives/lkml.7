Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0FAC4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 14:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3992073F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yBP2+Gcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394250AbfIUOvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 10:51:52 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51044 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390272AbfIUOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 10:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5uEWlv+YZPMagviqGoaCOmaRhzAaU16AabXiiu/WTp8=; b=yBP2+Gcp6981oNkmo+8auN+bN
        PFtE88xelUYFBkMpwNFnM5GQcBN+rG0tOygO8bNBi8ACy5C5uozoMseWibUQUyUI3tHJyQIJ3IPyF
        5DKHK9whSHlzY/eUsG32qrffEiZ6g2OPr6pKwPo2tx1biRltQWhrySB1pzpRzkrhOIrkmc153GnON
        8x7iSRwF32WkIfI0cbkdH/QTCmYx2fIJtZdSOQ4n9UbCstr1Ou5a+u1ElCKXe0286koGCOxhhkiwl
        QEPzmbHTzEEq+L7vr7T8aU+Qid+Laq9uA8egaQ7I/YK6krxq5eL/vTcg/yygTuO1KyjKsWvH/2q36
        Vucz1INFg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:34782)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iBgjg-0001wh-Jz; Sat, 21 Sep 2019 15:51:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iBgja-0006qg-Uf; Sat, 21 Sep 2019 15:51:38 +0100
Date:   Sat, 21 Sep 2019 15:51:38 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Yu Chen <33988979@163.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yu.chen3@zte.com.cn
Subject: Re: [PATCH] arm: export memblock_reserve()d regions via /proc/iomem
Message-ID: <20190921145138.GN25745@shell.armlinux.org.uk>
References: <1569070969-5168-1-git-send-email-33988979@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1569070969-5168-1-git-send-email-33988979@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2019 at 09:02:49PM +0800, Yu Chen wrote:
> From: Yu Chen <yu.chen3@zte.com.cn>
> 
> memblock reserved regions are not reported via /proc/iomem on ARM, kexec's
> user-space doesn't know about memblock_reserve()d regions and thus
> possible for kexec to overwrite with the new kernel or initrd.

Many reserved regions come from the kernel allocating memory during
boot.  We don't want to prevent kexec re-using those regions.

> [    0.000000] Booting Linux on physical CPU 0xf00
> [    0.000000] Linux version 4.9.115-rt93-dirty (yuchen@localhost.localdomain) (gcc version 6.2.0 (ZTE Embsys-TSP V3.07.2
> 0) ) #62 SMP PREEMPT Fri Sep 20 10:39:29 CST 2019
> [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=30c5387d
> [    0.000000] CPU: div instructions available: patching division code
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt:Machine model: LS1021A TWR Board
> [    0.000000] INITRD: 0x80f7f000+0x03695e40 overlaps in-use memory region - disabling initrd

Is the overlapping region one that is marked as reserved in DT?
Where is the reserved region that overlaps the initrd coming from?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
