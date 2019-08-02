Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB4C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B9216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GzpkhbUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfHBQE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:04:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:40889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfHBQE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564761890;
        bh=dLpsQ1iH69g0++ZhF0jGcUGdS+h3bQX95IXstzVutoM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=GzpkhbUxg1vC5JeSMzaY/wgqvE+XGvr9jVK/afqgRzvGhW4sjp0InoJx3IEunKxxo
         lrhXE14RbmzYrT/VYJs2YwaQMH2XTv5WLE7tleX2vrVlvQlFdz3YVT8XuzGvYCzEvH
         1hHFn12dObQfXxTgxpJRWVmLrhjcR7+wCOZ1YzG0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.188.238]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7CRe-1iF4iK27eQ-00x2fp; Fri, 02
 Aug 2019 18:04:50 +0200
Date:   Fri, 2 Aug 2019 18:04:47 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.3-rc3
Message-ID: <20190802160447.GA27285@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:NB1uTSTwHfWwJlUWLyzzESzh6e9K69xslnFCLUkeWbjCLT6hZ8b
 ofwyezaTmVIpyS06vM2+zbPmplCBsWGgUEl1COYMNPCcB537HtoMOp58T2iGPVlIf1wiQrb
 piSUD+imU/8w9mAma5bpEg13QPcDZ9VOazyIpFYWMsWd/bD+VjVtgvoyALdEzJJb2J32PU5
 8Yt9X/j4MDCKhX+C5a/+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7/G+fC8RfI=:Y4RMmrubRSrynP3tfGfns/
 sxEEHsah0Q2NIIMv9YtoP17vwLPthxHwS8/YegQnnfj6I9KVofPdtINcexftc1kiEfAaHsoll
 dFkLeLyA64ONepQiFjjZkbwqmtMVMOABNMEGAIwsZyiP1s9xt6XtZAt7oR51QukKg9l54DlEx
 7qcMUpLjZ5+FOCuPFuamPk1tOaIFhhXv+utF/SvVoEc+hivls2BvyI/FHIn+tZVo93sAFYPoc
 MPI4lC/RgDcX1yeCmDTeua271HyYORNTyWbOoU6P1sptPENdXcKJv5uo6AAX9hcfJJ0OqPBt2
 Xp55u/HZjZdplH7gE82DT70yQe2TomARXoCAc68DnHDLd+rWePSVJipEDYYykiake5EDAu+TA
 sHAFre6xfqrP0eD6pJ0msOCnCSqLlsOjU8kAdru554NYAklg6SY6cUGKicemxUsuEdrhHy4GK
 0JUr7XAS/y4xt9bcQSp0/2/Hk355OZ84h2vhWGyOlxTGrzSQxyfh8m21MkvHc7aps71upjqIt
 OCA1vB/3gjfJimaSfH7tJPwFYqPA5YNadg44iEX62roix9o3upErZKoWLHtpLPB8BZIhvPaSc
 8XU4McuwuOKKNm908vM16OhjNHXJWyQsC8ua6CXiYK0Y2OUyxeKzjp20eSQJ3IH9C1k5s8CR9
 SGu4DhjLANB8I6Y0C/kDGF/LQ937xmGRSt8jLnnkMYLq0JMewC5pTxGJbQkuyVBfEvZlwp7Fi
 s4nYjdp9WtTxjekXhop+uwPc6QcgYc6XfA3dNFeKi51C+lIbxPnZFOoGI3ZGbdx5imRR0XWHG
 cWMVBwRDDO3o+1kMMRCrh03yLFm8Ju/Bi/iKE+3vcYPOJ0IRkkRjvNRieypodfFjBLzg+ZWVd
 Pc5LvcbDWZf9ptatxEV8qTEB3F9LTQsAKEGMcGlh7lcwD/1p+xXMQ7CjEXo7YUv9NzTjAiE1Z
 3VRFtwpjvX59m66rhGx1lzEu9YkEqs9hKmFaqsM1Wa/GShnsmh46e687qtpX46TjhbZGHi3C3
 sjeHKRmO3nAHIJrkMjKUW8A+dq9cOWyhmAq44T1ELfgA4fqW8Mg3Sbh6jZ2vIGG0tRXpMgYmn
 FdLEZL4p4IVwLCpLP94qpzvic/LHJkie5bnSwlXpfXeusbJSMewklBTvA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few small fixes for the parisc architecture for kernel 5.3-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-4

Changes:
* Fix fall-through warnings in parisc math emu code
* Fix vmlinuz linking failure with debug-enabled kernels
* Fix a race condition in kernel live-patching code
* Add missing archclean Makefile target & defconfig adjustments

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (4):
      parisc: Mark expected switch fall-throughs in fault.c
      parisc: Fix fall-through warnings in fpudispatch.c
      parisc: Fix build of compressed kernel even with debug enabled
      parisc: Strip debug info from kernel before creating compressed vmlinuz

James Bottomley (1):
      parisc: Add archclean Makefile target

Masahiro Yamada (1):
      parisc: rename default_defconfig to defconfig

Sven Schnelle (1):
      parisc: fix race condition in patching code

 arch/parisc/Makefile                                 | 5 +++--
 arch/parisc/boot/compressed/Makefile                 | 4 +++-
 arch/parisc/boot/compressed/vmlinux.lds.S            | 4 ++--
 arch/parisc/configs/{default_defconfig => defconfig} | 0
 arch/parisc/kernel/ftrace.c                          | 3 ++-
 arch/parisc/math-emu/Makefile                        | 1 +
 arch/parisc/mm/fault.c                               | 1 +
 7 files changed, 12 insertions(+), 6 deletions(-)
 rename arch/parisc/configs/{default_defconfig => defconfig} (100%)
