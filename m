Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69928C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD072068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLIXPx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:15:53 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49128 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:15:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9302B60632CA;
        Tue, 10 Dec 2019 00:15:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 11pnfsCsf4tL; Tue, 10 Dec 2019 00:15:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3A62D6125476;
        Tue, 10 Dec 2019 00:15:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fNCfT7CEoPd4; Tue, 10 Dec 2019 00:15:47 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 08C3D60632CA;
        Tue, 10 Dec 2019 00:15:47 +0100 (CET)
Date:   Tue, 10 Dec 2019 00:15:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, davidgow@google.com
Message-ID: <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
In-Reply-To: <20191209230248.227508-1-brendanhiggins@google.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove support for CONFIG_STATIC_LINK
Thread-Index: b8m7foHpOez/Ln062vqdX5Nq4xnVUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Brendan Higgins" <brendanhiggins@google.com>
> An: "Jeff Dike" <jdike@addtoit.com>, "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>
> CC: "Johannes Berg" <johannes.berg@intel.com>, "linux-um" <linux-um@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, davidgow@google.com, "Brendan Higgins" <brendanhiggins@google.com>
> Gesendet: Dienstag, 10. Dezember 2019 00:02:48
> Betreff: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK

> CONFIG_STATIC_LINK appears to have been broken since before v4.20. It
> doesn't play nice with CONFIG_UML_NET_VECTOR=y:
> 
> /usr/bin/ld: arch/um/drivers/vector_user.o: in function
> `user_init_socket_fds': vector_user.c:(.text+0x430): warning: Using
> 'getaddrinfo' in statically linked applications requires at runtime the
> shared libraries from the glibc version used for linking

This is nothing serious.

> And it seems to break the ptrace check:
> 
> Checking that ptrace can change system call numbers...check_ptrace :
> child exited with exitcode 6, while expecting 0; status 0x67f
> [1]    126822 abort      ./linux mem=256M

Didn't we fix that already?

> (Apparently, a patch was recently discussed that fixes this - around
> v5.5-rc1[1] - but the fact that this was broken for over a year
> remains.)
> 
> According to Anton, PCAP throws even more warnings, and the resulting
> binary isn't really even static anyway, so there is really no point in
> keeping this config around[2].

What?
Anton, please explain. Why is it not static when build with CONFIG_STATIC_LINK?

Thanks,
//richard
