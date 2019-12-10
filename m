Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E353BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CD12073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 08:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJI2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 03:28:18 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:60970 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLJI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 03:28:18 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ieasE-000QG4-No; Tue, 10 Dec 2019 09:28:02 +0100
Message-ID: <7da5a054f533eabf2ffa110c236f011bf9d23954.camel@sipsolutions.net>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 10 Dec 2019 09:28:01 +0100
In-Reply-To: <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
         <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
         <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
         <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 07:34 +0000, Anton Ivanov wrote:

> > Further to this - any properly written piece of networking code which 
> > uses the newer functions for name/service resolution will have the same 
> > problem. You can be static only if you do everything "manually" the old 
> > way.
> 
> The offending piece of code is the glibc implementation of getaddrinfo().
> 
> If you use it and link static the resulting binary is not really static.

However, this (getaddrinfo) really only applies if you use the vector
network driver, if you e.g. use only virtio then this particular problem
isn't present.

Note sure if we implicitly call getaddrinfo from libpcap, but again,
that's just a single driver.

IOW, we could just make CONFIG_STATIC_LINK depend on !VECTOR && !PCAP?

johannes

