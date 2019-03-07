Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47845C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1625D20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="JV++Uxrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGFQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:16:56 -0500
Received: from tomli.me ([153.92.126.73]:47504 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfCGFQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:16:56 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id a650ce95;
        Thu, 7 Mar 2019 05:16:53 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Thu, 07 Mar 2019 05:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=1490979754; bh=qsEcn4Yd3FbIcJ2t1rdPCydfVfPqNnHpdXajScthO58=; b=JV++UxrlMFSxlq+LByndSNRKXYHuA7/bmT/HoA1LbvNLkRrlnaCcHmgZh8RAIcdYUsvrLzmXfgyfNFTT+YcvOrsxAo2Kht0f/WlBM2kbK+KBlGYwNDgI3ciaqg0CX53qAAraNj670wOJC5TZqb4pGfa9X8OVQzA/5L68KyNlJ8MGmDvBPRB0m29eGla4R4JN8K5G38a/rXIlHGgtS8Oddyz4I06uYJYaMKnm++MwD/aqYwGUBy9z/bn2DkyJ2W9P7AaWo3dBR3eY/EUgH6bv9DA5YEkKUZ7QnhCrcEzzIWFnWeDzIoytuGEW4QUY/V44djnEAK8un9fTplyMaRiiwg==
Date:   Thu, 7 Mar 2019 13:16:41 +0800
From:   Tom Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Is it possible to reset graphics controller on reboot in a
 framebuffer driver?
Message-ID: <20190307051641.GA7012@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

As you may have noticed, recently I've been working on a reworked version
of sm712fb, and planned to convert it to a DRM/KMS driver. Besides using
it on embedded/non-x86 systems, I thought it would be a good idea to support
histrocial x86 laptops with this VGA chipset as well, so I've acquired a
machine for testing.

However, soon I found a nasty problem. The BIOS does not reset the chip
on boot! Like most graphics controller of that era, sm712 chipset has a
VGA compatible mode and a 2D framebuffer mode. The power-on default is
VGA. The BIOS writer just assumed this, and does nothing to reinitialize
it. If one uses the framebuffer driver under Linux, once the machine reboots,
the entire LCD panel becomes a piece of garbage.

AFAIK, the framebuffer driver would be running throughout the kernel's life-
cycle, is it really possible to workaround this issue by restoring on VGA
state upon reboot?

Thanks,
Tom Li
