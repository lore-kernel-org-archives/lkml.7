Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA3F206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577831613;
	bh=QaZbUxjuLY1oPNTNyLwTGDZ9ozsSFFrFCBC1boCwOD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lG/3r8iRKLKSarC0WijYBIJ3ZS4YipksxRBOFprvgnhOqiDy2AVlBUFReyVv2MDK/
	 RuGF+cENFLNUSg9V2FnO5K0AvEQxi1hv/xxSxZxCmxDkHJwVVLwm10rCxXOYn1e8AM
	 GTEbjp/yyKn+nw7GSuShx2K/UnRgIPQPANItFwIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfLaWdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 17:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfLaWdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 17:33:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0E5205ED;
        Tue, 31 Dec 2019 22:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577831612;
        bh=QaZbUxjuLY1oPNTNyLwTGDZ9ozsSFFrFCBC1boCwOD0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b8cExrddR70yQfCVlcvn8ljGEw0XzycDsmGTgca2kgOKJDaKrWquZGTFbI+XFUM0k
         w/fZgXaPi1gTZHLlh6/5QBCZhmiqqd6yUzuNsxKyceGAysr49rt2A1keUOayLqwdSE
         8/eB5jjSnDJFLqDVV3V8jqc8ffQwFNZwb3/5mbuY=
Date:   Tue, 31 Dec 2019 14:33:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Gang He <GHe@suse.com>
Cc:     "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
Subject: Re: [PATCH] ocfs2: make local header paths relative to C files
Message-Id: <20191231143331.9b77ee5709f2662c54d76a51@linux-foundation.org>
In-Reply-To: <20191227022950.14804-1-ghe@suse.com>
References: <20191227022950.14804-1-ghe@suse.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 02:30:15 +0000 Gang He <GHe@suse.com> wrote:

> From: Masahiro Yamada <masahiroy@kernel.org>
> 
> Gang He reports the failure of building fs/ocfs2/ as an external module
> of the kernel installed on the system:
> 
>  $ cd fs/ocfs2
>  $ make -C /lib/modules/`uname -r`/build M=`pwd` modules
> 
> If you want to make it work reliably, I'd recommend to remove ccflags-y
> from the Makefiles, and to make header paths relative to the C files.
> I think this is the correct usage of the #include "..." directive.
> 
> Reported-by: Gang He <ghe@suse.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Gang He <ghe@suse.com>

Your signed-off-by should appear here, since you were on the patch
delivery path.  I have made that change, OK?
