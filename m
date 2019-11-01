Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46515CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C37D21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JOwFEArD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfKAUUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:20:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:56975 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfKAUUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572639624;
        bh=gEEhob0QambsBd+8IP8sk2yJj2Asu79OD/yDb2XsK9Q=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=JOwFEArDmfVv/FPhbTG9KN5livXCRnB5ZhL6y6g5mVwyGAEeWlNdFElWZlzJgByCd
         VRU+1CCtUsWaB+iFkAN8f9Z3RNw+nTTA7q5wNvaCwRlq2ElIhbKVChWdq3J9CCX0SE
         kW77GmK60XY4+13GnmW7YvJBi2RMzbjKTKnE4kZA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([80.187.110.91]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1igvtz1MCJ-00KgtW; Fri, 01
 Nov 2019 21:20:24 +0100
Date:   Fri, 1 Nov 2019 21:20:19 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture fix for kernel v5.4
Message-ID: <20191101202019.GA22999@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:lmdelkpxDYCvc+DQjD6pvjzZzZKWwNd0Ihgy0KIcKfoXwUw18kA
 sgUW8wf/UhtZnSlFfwJUp6VoVHuYCsJzcqCl8NEBB3Lu4KozrYYZDbjr85sEHcRAdQj59Yo
 97jCtbgxEAH345JQfDtsbh2ZcdYJFwYBQyeb5ySnEZckHs944ZIHE6WcRwN9kr9dhKhNasA
 dXPwga9ZUiSKetsoUz69w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6vrH0e2sQ4=:1zuAaB8186z/5wpMy5Aex3
 Lmjf1Fy/r9SaV0mGsPuPoFNbn4Z66Ft4GNeGX+jMxORsAhDpPKUdNN3gUax9z7nMvh/Fj9Nxx
 8AyyJrdNzzJQSaqOctaPY0nxG5Tg4BWh71xB45VWkCnBatYmSKbkwS9R+M5lYanrsZxoSKgpR
 DJ85fC+RjrGFgfLUtH1mxj3nYppVLyS3tTAY2JNoTud9gaaoCMWh0cbWAaPkj4uSdW20VQ88y
 179V0Xu8CalwBaFCMo8wE/FAP4LJH42NkUfRbqWLRyA08JZnrP0h+VqNi9pK/XynAIKH1huNT
 kj/ZM8l98E8THCX0+NUUPpTBJvm/sW8Y8NCgg3thaDt9+3oSbka45YpGK5bJiQyFx+YvbWpkL
 ldeytF4oy3RaDqevokmtEJL91j3YCm0pJyE/+ULWf2BNLdbPtSbQ1uhAQS6+YgRLHZ8y/CM2Y
 hp0h0tyhClJUBl7TnDWIvn+/d5T8u+mkTtHP1Thm+FcFLqvMrNnBuI7uYMtLP4BesFv/Acmqp
 8CTx+3FUXRW5R/VAmuWWjy/ad8j1xxYVRosVQ6h+8nZ+kI1p6+3KgARJmQ1l67Odq5ki9QlIm
 exTSUh3LlKe3MmwxzDVAiyGHjsvA2GgGGFqKjcU549wKLHVBJ3cYarVQJfuCZIlOLitCxI+MU
 CvSHhCDV5eAlfeNRCrauuBxaS639uwQBmZXR4xAtqd73yQfw/V1FhmaidGI16sTLs6zrsGf4o
 SuaU0YLVej29r837ZIQWwZmT2R2m49H2n0tL2mzKPFasmChG3QUZTcWIqmJHlwfnbmUa78/ws
 aWUNsZN163p1wyj6hoJf3soxKfXfwOn/v60U4fjndDb/Xltn6s+BVBsdO2lB/jmVdwj3k5HNR
 shxAwroSI5uPeKQfQVPD7/vjj/yr5Hm6odwQiKj4Dnj7LzmEjSyoIQp0ekmhKj/bf1BjgoZ5z
 5JGS2MYPGqTI2GaaMk+VRf/mga5TiECz27STkvCRXVJOgzr/QwbE9/zRoB4fnKpciFsFBfzQw
 WvHMjrEm7DfnV5IgyuG3NR5S3SuV7rKUce3wNUlNj1PO59xhQ13qmY6SV2TJudkP6PniW1Ljr
 5hgCXSL7UbTxGNxO3mJcqzFW5Yjp55VmC2IFYk1QV2rShAaD22ijjCG0p1UoByKQ4d96Fu0g9
 IR7OyWEe1iY0wqHSnapzHaGXlfNK7iKdj9QFyZP10nE73DY0rbHv+2WfDAL8DMQmPNdnteXVu
 PyPMIi8eANOBsROb55sRo/ZIRkt17RR5pXX2iSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a one-line fix for the parisc architecture for kernel 5.4 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.4-3

Fix a parisc kernel crash with ftrace functions when compiled without frame
pointers.

Thanks,
Helge

----------------------------------------------------------------
Sven Schnelle (1):
      parisc: fix frame pointer in ftrace_regs_caller()

