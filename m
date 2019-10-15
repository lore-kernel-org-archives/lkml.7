Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC09205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kwKKa1eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfJOMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:38:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:59815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfJOMip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571143113;
        bh=vuznGR+7EAZBra/dwVLbt6VUA/Wj14MKPyeyloZDGww=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=kwKKa1ebAZlTNwIELcLTR+NqSYf3kbJWr1bQA2X6fbYSemwdZ5Vv2HpozehB2kcyD
         b1eRJLHBLgUe7ivVgBb+4iyclBy/Kd9d7+fW0c0dM+KdmBMB6WCJe3oRiqnNLEGxe6
         VeO1xmHMFhP+t238Gs7nDhS/vz230rfE3uJHMx68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.139.68]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0NU-1heNRh1Dxo-00kNJj; Tue, 15
 Oct 2019 14:38:33 +0200
Date:   Tue, 15 Oct 2019 14:38:30 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.4-rc4
Message-ID: <20191015123830.GA1797@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:YvwKaTYQ3PifiFidqbpLwsEvkUw/oC/ojVLEExDf8lTG5TFvyoS
 zqA9HB4CM+gsZjq6ZSFJlJKnxX3HDgGmURaE/HtJbr13980yJg/Hn0DwBwm0VpALIQR0/qJ
 iZfIfgG9FyKonVWid4RskYMFFWM2dG/fLsS7JnK6RtBO9Od952rHNPrSoqV4XJm/lDxvRso
 22wrF4mff6c78c3z1eQtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NF/IkInm9MA=:NACbM9xkPInxB++g7YjgND
 ns1TvFU+v9pYTXJ71751nVEq60I+80wYK5RT6I7YXqBUOnI1praKbPCWYxPRAeYrPLPXcuXnQ
 C6g1NTgq6j7yTYqCluClI63gDY3+qV5GQ8JQjgQmRBM+XM57B1fBVWKOxtFT1zHXqJsGvsGdX
 avsuRH3bvvcqxxwkWoIvdphEKwtc+weKijPZdaDu5ncXfFazaKjUrhtRIjVgCQCeBJs0a9T2T
 s0rmgDv0m6Vg9GTOMftueiAl3TauGhHOdUvz7iVi/6r3uvZAFxTuYDv8/BWLSSBMzLuixQOnA
 pcP8uzR8C1UNviqpvv0WgKaIw0CN5GmHO7RX/mVi/zg7JMK75JEebG8dEQ0S83vUeVgw4mukB
 Fbjphs4PAr7vUwG5wPpOYfxUxoQrpsRFdTzAo6/PWLmNz7tGUIjV3STDKCQyg11AlBFXM6qO5
 FMqRgxwH/JtT1pC4Nbqnfh0XV3VdzqjxRe0R2VuSF34K49iYYWuudDk+tRvj3TiFREbJfpUGa
 6pnsETWDusXTRphcNmByFP74d6zA+bCDBKhn6+hDuRG1u4MF/Fxzyn/cqaEg5/jtqM6hVg4t1
 YsEFyyUABd3OEHe2GG4qyaYeLtXJFMSZ8rhemaB4o8EYQH8zarnKdIEHFrX7Zuo3uSyZfb9FY
 FNgXadaBHdZhOJQZPtWF0Z8E6EzRvsvbVRvwHMNEAPuDdXatwRbgxj6N3gLaSEfiEfQ0/Vbbx
 AooSyp2JdSwK4rpnrs+Z+uhD/aDDcwTMyGkW/k5GRicmpjqea1hFUS7EhJqow6+lktkBZneHw
 iF8iHLTMafl5hPeBu656gkfF5Rz78Nnj9YsGyJCBVspmIYSxWJ9FxzfFLXS8SL99ynAOF/BKk
 mWCP7yr5Is5RR0RX+PTt0pA1FwuLI+CLfQ6wWZAsC01E1YP3M/tuROo1CS0HSGkR6PMHo5zs3
 TPAZbehZL0phlKdmXi2SgV+p1jj/61IMwwzSBVCau6loRA5gn4JoIePT8LnM+rzKEBYFyIDpg
 7zHmuaTnpQRqnTtzcITZ/4sluBxDV/K1NSfxpB+4Kr2tK07aHatJLQpqWuyUUPhEXPM8laVPw
 nNiPxaB2GSnTuXKJe/LlfrnrYQo/fxtvwyX/LNk4CMYV5mcllyAnPlIskY4FEPIt4D+Ywbad0
 tRUyfLKfTsFidiEGBxoeQzveZ5NM0Xj4Extp+u2ojK3Ld3/NfPGIsI/HZF+bCXC/L7BNMya/f
 /avIkmeseiCy8ATSiN4NS6hXyALKEFQxRT7oXlg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some fixes for the parisc architecture for kernel 5.4-rc4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-2

Changes:
* Fix a parisc-specific fallout of Christoph's dma_set_mask_and_coherent() patches (Sven)
* Fix a vmap memory leak in ioremap()/ioremap() (Helge)
* Some minor cleanups and documentation updates (Nick, Helge)

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (3):
      MAINTAINERS: Add hp_sdc drivers to parisc arch
      parisc: sysctl.c: Use CONFIG_PARISC instead of __hppa_ define
      parisc: Fix vmap memory leak in ioremap()/iounmap()

Nick Desaulniers (1):
      parisc: prefer __section from compiler_attributes.h

Sven Schnelle (1):
      parisc: Remove 32-bit DMA enforcement from sba_iommu

 MAINTAINERS                     |  3 +++
 arch/parisc/include/asm/cache.h |  2 +-
 arch/parisc/include/asm/ldcw.h  |  2 +-
 arch/parisc/mm/ioremap.c        | 12 +++++++-----
 drivers/parisc/sba_iommu.c      |  8 --------
 kernel/sysctl.c                 |  4 ++--
 6 files changed, 14 insertions(+), 17 deletions(-)
