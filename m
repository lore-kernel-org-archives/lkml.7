Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E23C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36C7207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfLJIeb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:34:31 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55286 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfLJIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:34:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DE3616126B4E;
        Tue, 10 Dec 2019 09:34:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q_Z9Gqszl3oz; Tue, 10 Dec 2019 09:34:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 78A126126B50;
        Tue, 10 Dec 2019 09:34:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qA8_bD_Ce_Zd; Tue, 10 Dec 2019 09:34:28 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 573736126B4E;
        Tue, 10 Dec 2019 09:34:28 +0100 (CET)
Date:   Tue, 10 Dec 2019 09:34:28 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     anton ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        davidgow <davidgow@google.com>
Message-ID: <392256369.112046.1575966868218.JavaMail.zimbra@nod.at>
In-Reply-To: <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
References: <20191209230248.227508-1-brendanhiggins@google.com> <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at> <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com> <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove support for CONFIG_STATIC_LINK
Thread-Index: ya1XNgp+8/P69KzagcMtEIkLZe+uUw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
>> LIBC itself tries to dynamic load stuff internally.
>> 
>> It is beyond our control and it claims that it will work only on EXACTLY
>> the same version of libc library as the one used for static link.
>> 
>> So you get a not-exactly static binary which is not properly moveable
>> between systems.
>> 
>> This is specifically in the name resolution, etc parts of libc which all
>> of: pcap, vector, vde, etc rely on.
>> 
>> Another alternative is to turn off static specifically for those.
>> 
>> Further to this - any properly written piece of networking code which
>> uses the newer functions for name/service resolution will have the same
>> problem. You can be static only if you do everything "manually" the old
>> way.
> 
> The offending piece of code is the glibc implementation of getaddrinfo().
> 
> If you use it and link static the resulting binary is not really static.

glibc tries to load NSS and NIS stuff, yes. But what is the problem?

The goal of CONFIG_STATIC_LINK is that you can run UML without dependencies,
this used to work since ever. Lately it broke, but hey, let's fix it.
I have tons of old statically linked UML systems on my disk which I can
just run because they don't depend on specific libs.

Thanks,
//richard
