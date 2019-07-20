Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE9C76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593762084C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 16:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfGTQsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 12:48:52 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:48788 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfGTQsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:48:52 -0400
Received: from sf (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:a0f::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id D40F33482BF;
        Sat, 20 Jul 2019 16:48:49 +0000 (UTC)
Date:   Sat, 20 Jul 2019 17:48:44 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
Subject: linux-headers-5.2 and proper use of SIOCGSTAMP
Message-ID: <20190720174844.4b989d34@sf>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit https://github.com/torvalds/linux/commit/0768e17073dc527ccd18ed5f96ce85f9985e9115
("net: socket: implement 64-bit timestamps") caused a bit of userspace breakage
for existing programs:
- firefox: https://bugs.gentoo.org/689808
- qemu: https://lists.sr.ht/~philmd/qemu/%3C20190604071915.288045-1-borntraeger%40de.ibm.com%3E
- linux-atm: https://gitweb.gentoo.org/repo/gentoo.git/tree/net-dialup/linux-atm/files/linux-atm-2.5.2-linux-5.2-SIOCGSTAMP.patch?id=408621819a85bf67a73efd33a06ea371c20ea5a2

I have a question: how a well-behaved app should include 'SIOCGSTAMP'
definition to keep being buildable against old and new linux-headers?

'man 7 socket' explicitly mentions SIOCGSTAMP and mentions only
    #include <sys/socket.h>
as needed header.

Should #include <linux/sockios.h> always be included by user app?
Or should glibc tweak it's definition of '#include <sys/socket.h>'
to make it available on both old and new version of linux headers?

CCing both kernel and glibc folk as I don't understand on which
side issue should be fixed.

Thanks!

-- 

  Sergei
