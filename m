Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF11C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A514D2190F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 23:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569021743;
	bh=FN/Lerp2b3ubf7CVg953Cj/AlJTpxRlHeVx64/izgIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ku6+6m760pkY2WggSR99VC/BtOCF+1hJUJo5Su9AFwxSFuZoNU6rK7LBf9xOP7Ygm
	 gIhaP9NOWcrvJtbg+fEnZI+K7imIK9fps5JjVyqaVIZ9yk12XVxfml7zDAwlwSR0JJ
	 9J7ljJTMSyISswy3/3k1oRMCM4WQMInDH3aoNmOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407140AbfITXWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 19:22:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392595AbfITXWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 19:22:22 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3602173E;
        Fri, 20 Sep 2019 23:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569021742;
        bh=FN/Lerp2b3ubf7CVg953Cj/AlJTpxRlHeVx64/izgIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gLu1SzT+IWoQ4F+7fwDVxfR7LVBSf1GSBfOD3/UfDDngFXw+5ozkOQ+ft4pb7Qlib
         L1CD8V9S7JU05U3iPcZSN7f/wptDiTuGzGHP9iLadCUqooTfeSZ0ALMikRIVIHtDV8
         4shgFNjPnJVyv+wPTcJ5x5PXh/QjP/eO2Q5HKz7g=
Date:   Fri, 20 Sep 2019 16:22:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Qian Cai <cai@lca.pw>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/kmemleak: record the current memory pool size
Message-Id: <20190920162221.51a800630561489a7e62821a@linux-foundation.org>
In-Reply-To: <20190815100215.GB9352@arrakis.emea.arm.com>
References: <1565809631-28933-1-git-send-email-cai@lca.pw>
        <20190815100215.GB9352@arrakis.emea.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019 11:02:16 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Wed, Aug 14, 2019 at 03:07:11PM -0400, Qian Cai wrote:
> > The only way to obtain the current memory pool size for a running kernel
> > is to check back the kernel config file which is inconvenient. Record it
> > in the kernel messages.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  mm/kmemleak.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index b8bbe9ac5472..1f74f8bcb4eb 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -1967,7 +1967,8 @@ static int __init kmemleak_late_init(void)
> >  		mutex_unlock(&scan_mutex);
> >  	}
> >  
> > -	pr_info("Kernel memory leak detector initialized\n");
> > +	pr_info("Kernel memory leak detector initialized (mem pool size: %d)\n",
> > +		mem_pool_free_count);
> 
> I wouldn't actually call it the "memory pool size" as I see the size as
> a constant set at config time. What about "memory pool available"?
> 
> (even this one is not entirely accurate since we have a
> mem_pool_free_list but I expect such list not to have too many elements
> at the late_initcall time)
> 
> If you change the printed string:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

--- a/mm/kmemleak.c~mm-kmemleak-record-the-current-memory-pool-size-fix
+++ a/mm/kmemleak.c
@@ -1967,7 +1967,7 @@ static int __init kmemleak_late_init(voi
 		mutex_unlock(&scan_mutex);
 	}
 
-	pr_info("Kernel memory leak detector initialized (mem pool size: %d)\n",
+	pr_info("Kernel memory leak detector initialized (mem pool available: %d)\n",
 		mem_pool_free_count);
 
 	return 0;
_

