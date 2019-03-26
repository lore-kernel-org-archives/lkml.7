Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658D2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2646F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553563879;
	bh=jkAx+kty5v2H1VmV7W7HMAjMJbh3KwIEB+4/f8+km9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XF3UlYnNyR4qJ8JcaAx6AlJzrgZU6xGxiyjTv8v9B86qKQjFRmMEHY1Cdu2Hos0cv
	 Jgyu+y8F+O65bRIE3cmYYWf5Efwd06f+NMgWfBpVKZi8AyzcbdKqAoPUGgqrjy0mQk
	 tD/ysgpLKmvL3PZLk7Fhv0TD02VxSKLQguvh0DJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfCZBbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfCZBbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:31:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1A120848;
        Tue, 26 Mar 2019 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553563876;
        bh=jkAx+kty5v2H1VmV7W7HMAjMJbh3KwIEB+4/f8+km9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2ar99z8/QbHDBGHJuB0vlFRl4THKXFatW+qTa5LhVeM2PBWSL6ZFCrb6bZGupP+N
         ahILmhUTUfzH4H45hhHc6mGSffZRhq1p45CxO0u6ZeR7u2DKv0eBRePd/S95u0WTeg
         CVGaEt20m0JEhKlgUXgXCi6bIDmcE1yKa/Xdmxws=
Date:   Tue, 26 Mar 2019 10:31:09 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Qiao Zhou <qiaozhou@asrmicro.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 21/25] arm64: traps: disable irq in die()
Message-ID: <20190326013109.GB21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-22-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-22-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:12PM +0100, Arnd Bergmann wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> In current die(), the irq is disabled for __die() handle, not
> including the possible panic() handling. Since the log in __die()
> can take several hundreds ms, new irq might come and interrupt
> current die().
> 
> If the process calling die() holds some critical resource, and some
> other process scheduled later also needs it, then it would deadlock.
> The first panic will not be executed.
> 
> So here disable irq for the whole flow of die().
> 
> Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> (cherry picked from commit 6f44a0bacb79a03972c83759711832b382b1b8ac)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/traps.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

also added to 4.9.y
