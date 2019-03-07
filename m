Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773AEC10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450322064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCGQT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:19:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:22766 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGQT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:19:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 08:19:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="120467065"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2019 08:19:55 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DFE713013CC; Thu,  7 Mar 2019 08:19:55 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:19:55 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select: avoid clang stack usage warning
Message-ID: <20190307161955.GD7535@tassilo.jf.intel.com>
References: <20190307090146.1874906-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307090146.1874906-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:01:36AM +0100, Arnd Bergmann wrote:
> The select() implementation is carefully tuned to put a sensible amount
> of data on the stack for holding a copy of the user space fd_set,
> but not too large to risk overflowing the kernel stack.
> 
> When building a 32-bit kernel with clang, we need a little more space
> than with gcc, which often triggers a warning:
> 
> fs/select.c:619:5: error: stack frame size of 1048 bytes in function 'core_sys_select' [-Werror,-Wframe-larger-than=]
> int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
> 
> I experimentally found that for 32-bit ARM, reducing the maximum
> stack usage by 64 bytes keeps us reliably under the warning limit
> again.

Could just use 768 bytes unconditionally. I doubt a few bytes more or less
will make too much difference.

Other than that

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
