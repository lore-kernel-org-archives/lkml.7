Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B352C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA694208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568995037;
	bh=YkAB6iDqGBuaEmEsoSv2kDHz5nZ2DlJXeSJ0ZFuDrOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xl0T/Lb5Uit+cZ8iyVMj+3LkhVDkxZ55zY4nX5/0SGkjeWrCAd+qhbU6zjkfnoiCM
	 ZFD1auKxDJwn2U6zcpiHdzsIgrWTXNc4ySVroZKAEM86q2zfvjaaz61QvKUxBREGyj
	 ZK76o/I3VgUxSKIhY80AN7uea1aqsxtFs/ywYtwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404800AbfITP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404504AbfITP5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:57:15 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4056A2086A;
        Fri, 20 Sep 2019 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568995035;
        bh=YkAB6iDqGBuaEmEsoSv2kDHz5nZ2DlJXeSJ0ZFuDrOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmynmGB6j86h6qM/hKvoXVk1Ds+zm+WCJk8qm1JGzVEIheSnL39HwCQ4nusbGxsm8
         EjLVVKR+f0njPrvszc6aADKFKEjOdHTVGvnn+Cvh6OwBC4aY2OOqRGWs5bE69K8eh2
         olN5YgVHmbheJoTEacaYmXd8/T9HZKmLCYYnTwO8=
Date:   Fri, 20 Sep 2019 16:57:09 +0100
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 02/32] arm64: Use pr_warn instead of pr_warning
Message-ID: <20190920155709.bntgskubbfvrewcg@willie-the-truck>
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com>
 <20190920062544.180997-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920062544.180997-3-wangkefeng.wang@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:25:14PM +0800, Kefeng Wang wrote:
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/kernel/hw_breakpoint.c |  8 ++++----
>  arch/arm64/kernel/smp.c           | 11 +++++------
>  2 files changed, 9 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
