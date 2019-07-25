Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B10C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8BC21871
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mlck0tH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfGYHqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:46:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfGYHqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=slTSqFCIhfxn5wYzIqGB9W4Rnj3J8ckOZ2kpLbw/Uss=; b=mlck0tH+lI0sDx9hkCz586My5
        P0uBKxF8i6WTlmp1DR55rTIFLF+dFhswORO1Sg8FKinGbI4rb21G//nN3GAdW7t8JN349/0nWdzgM
        ivnJ9VeS7Z2M/HxPxvnjThW+B+Jk+06Oc3aGtJgJJaCFJu1ewtkK8AuLZ0dIhR5xMDkRLtRmCRGdp
        UF4MGyQhsUz91TQvzeiR0DhAVsg8Em79YQ4VSxrB9YICyKo8GUj3aFG6sCNwi3n37SLVvVUtMMna6
        WCYnmuw5ba7lZJmcyhRbcSVNNsCzPWlAZAjvfuKpDSUXudePzhPI7z0ttuH7RTKUDSfNfUcKx3R1G
        BFPHzOOyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqYSP-00011D-Ak; Thu, 25 Jul 2019 07:46:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBD12202674D6; Thu, 25 Jul 2019 09:46:31 +0200 (CEST)
Date:   Thu, 25 Jul 2019 09:46:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] perf/x86: Apply more accurate check on hypervisor
 platform
Message-ID: <20190725074631.GF31381@hirez.programming.kicks-ass.net>
References: <1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564022366-18293-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:39:26AM +0800, Zhenzhong Duan wrote:
> check_msr is used to fix a bug report in guest where KVM doesn't support
> LBR MSR and cause #GP.
> 
> The msr check is bypassed on real HW to workaround a false failure,
> see commit d0e1a507bdc7 ("perf/x86/intel: Disable check_msr for real HW")
> 
> When running a guest with CONFIG_HYPERVISOR_GUEST not set or "nopv"
> enabled, current check isn't enough and #GP could trigger.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks!
