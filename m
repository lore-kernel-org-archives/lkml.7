Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C899C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F2222B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 00:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKTAVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:21:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48606 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfKTAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 19:21:49 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iXDki-0002tu-38; Wed, 20 Nov 2019 00:21:48 +0000
Date:   Wed, 20 Nov 2019 01:21:47 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] fork: fix pidfd_poll()'s return type
Message-ID: <20191120002145.skgtkx2f5dxagx4f@wittgenstein>
References: <20191120000722.30605-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191120000722.30605-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 01:07:22AM +0100, Luc Van Oostenryck wrote:
> pidfd_poll() is defined as returning 'unsigned int' but the
> .poll method is declared as returning '__poll_t', a bitwise type.
> 
> Fix this by using the proper return type and using the EPOLL
> constants instead of the POLL ones, as required for __poll_t.
> 
> CC: Joel Fernandes (Google) <joel@joelfernandes.org>
> CC: Christian Brauner <christian@brauner.io>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Yeah, that makes sense. Thanks.

This only misses two tags:

Fixes: b53b0b9d9a61 ("pidfd: add polling support")
Cc: stable@vger.kernel.org # 5.3

Can you add these two tags to the commit message for v1 and resend with
stable@vger.kernel.org Cced, please?

Otherwise:
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
