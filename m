Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F42C4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA9820673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XO1svo7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732307AbfFXVoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:44:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:53305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbfFXVoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561412653;
        bh=VfU45A+TCZs81IW1811J5XbDAucySKVUe2Hrt0lPo8A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=XO1svo7HpdIIZI3RWZeJlVCQcSTIgsKT5w+zAAyn3xnkfq8yoICDovU/VdRQ9Wmf0
         lKRTVNDFe+XIt326s8gwMTDkOw2AQb7sHl6n/qm3DgOpb+Acf+PM3wVfYZauwGM28G
         kR7MGP9DWaA5qxhvzwFrBQ7q78oP6uM15zWnQyVg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.168.122]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MTiPv-1i8vCK2xu1-00U544; Mon, 24 Jun 2019 23:44:13 +0200
Date:   Mon, 24 Jun 2019 23:44:08 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Jeroen Roovers <jer@gentoo.org>
Subject: [GIT PULL] parisc architecture fix for kernel v5.2-rc7
Message-ID: <20190624214408.GA9531@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:/u6W4v8kpGXw0N2E0ST14IxQ4Yq4jVXGEqvQll7FOug73LZ1R6Y
 9R5sJwKCoQVBYWU7cgGmRMxLe/LQ+1WejjFGHF0FSyqNG/ZFhuI1GHvnQDoJWr29I0+oK7s
 F4/H10mVVBja5pNeiBojJuGtwpjpG11ULge2xH7T61+C78Pq47AYnsFBbVWdp4n1Z2BXV2K
 i8LsC26Lglk1Tk8U/iYTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S9baFugE5Tg=:Q+8OqgKvLkqOm0cRj9UkUh
 W2z5TvNJ25NnEQwtxquLBAwwtARNCe65jCCBeYEeMiDwiTrXbQQD4yFNsRKXefiUYilaC3f1T
 6gn0ecBARWqYtgb1xF7JlRZ1Gowb+1IVoIwBLwVHUDCHef6NaNIcX+pPJwLKnYAawlrxggepf
 T+F7tBb17xS6XpWbdMiVdw6p7bTOxoZPPIv/Th0MyNXJxTUcnXrhDBWeIb6ks/DNhypvf4txb
 LXRlwfXpuLrqZTKgFu/R8UB+XfZkRZ6XFs7BCgfxqT8RFatT4PQDefdR4Cn97MoKv+LLWom44
 8129/1497TByGup2Wql6BcMCNT8ZsIZYoOL/A2m74nATThbn2UursGOy4UpYb/IHr1GHWVjlA
 Oi+mzB8bRnYrriMba5Oazt20uPgTE9P79b12l84MSQTwjcg1NpC3WCvQ63uHS0y5RS4JV8CU0
 PVKuW4Bdxk3PLXaynLhgDcpkwNc2o5A81HHwDimCgUOH5TLa0KLZX4J8TO19wzIu8NMNax1iv
 /reLml4SY32C5gvbofmOuO68vcRRMCOC68Ht1P9bEh5w6fcNYTMqQltCOBmlhwtQA0VhDsLOS
 i0cqnLKn1dfabugLXNxWIHoVv5t9vtqSlC2uinw0gre3arc05K0XUE2g0inhH5cRq/4alc++r
 ayQedJx78/UoVynSvKCet7kHb1uZOdgfZKPOfBu1j/3S2w3WRyErZB+CUiGOh7o+e/hCWEn6x
 ZfKbhEzBeVovPNTbTUV1sr9LRmAlHI2iUwhdDdHh95JuBWflV6kL5UTzBHPRhgcUfVzw2nnkh
 /V27vOrXVN4xAeaC0Ync1aya2QFaDcnD0uuu3B6swFSlDnkec0fyavv9mC0Bbj2PsTWCbHSIf
 ylw1SzCjtyDRLzZbXIcuJbDvxyByRCYxSTA5DBRm+FT5YIjq9w5UZ9Z7L6Bvzl470ABbCt6Hf
 haFLHpzaE5AZfY5+Fy7lTqiaU+xQ8zItaCUrclBLdL0iS8LAuIvsTTUcn+ygqsb/4Xj2sto7z
 PzpJ53bSsqcNq6LzaY1o/z0FmgJ7yLbW+qBLeeiJmsL9StYgKRzx/gVfa9zmvzwd8Pti2JE2u
 rYoC2tTbPugVGg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one fix for the parisc architecture for kernel 5.2-rc7 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-4

Add missing PCREL64 relocation in module loader to fix module load errors when
the static branch and JUMP_LABEL feature is enabled on a 64-bit kernel.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix module loading error with JUMP_LABEL feature

 arch/parisc/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)
