Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C64BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5882184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558667907;
	bh=XwHg2mXb8WzJvbztibhVXfbFYRpVR6mtdv8vVyp0Duk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rDdGZio0Q7N+7AcLxTeoHGQ59bNBDEBohj9zjvvgPSIY/HIKdXtc9zcLS/d+fcbwk
	 ljDSy8ftVPMpYFj54R5RC7AJ0vtYI2kd4pB3dTcYKASWAqIaBnrhf6+vvC2f2i5rNX
	 zdd9rPYY8mBmVsKgVxXE1Im7xe61/KKW0vo3EoDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbfEXDS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729972AbfEXDSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:18:25 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAB621773;
        Fri, 24 May 2019 03:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558667905;
        bh=XwHg2mXb8WzJvbztibhVXfbFYRpVR6mtdv8vVyp0Duk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOH1cU9zPFjRxln9OKY2r62pmt7/PemAORYbGNQaegIo+iNyQgDReb7QKaxHNrJMV
         wSO5kvL30yjVKbx/3MMAoDgQQRq/1VMw0+WCa8a6BuYmGleZmEV4g/sve7Ch1/cBre
         NLuOxJNpsd1jJge2pGr1UmmlztkDedgK2+m3hZgI=
Date:   Thu, 23 May 2019 20:18:22 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v18 1/3] proc: add /proc/<pid>/arch_status
Message-Id: <20190523201822.cc554d68ec567164bec781e1@linux-foundation.org>
In-Reply-To: <20190425143219.102258-1-aubrey.li@linux.intel.com>
References: <20190425143219.102258-1-aubrey.li@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 22:32:17 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:

> The architecture specific information of the running processes
> could be useful to the userland. Add /proc/<pid>/arch_status
> interface support to examine process architecture specific
> information externally.

I'll give this an

Acked-by: Andrew Morton <akpm@linux-foundation.org>

from a procfs POV and shall let the x86 maintainers worry about it.

I must say I'm a bit surprised that we don't already provide some form
of per-process CPU-specific info anywhere in procfs.  Something to
piggy-back this onto.  But I can't find such a thing.

I assume we've already discussed why this is a new procfs file rather
than merely a new line in /proc/<pid>/status.  If so, please add the
reasoning to the changelog.  If not, please discuss now ;)


