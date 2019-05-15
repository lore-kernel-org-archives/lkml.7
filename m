Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBBDC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B6220881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557908977;
	bh=cb6Z72ERql0xdgtLEheM3Mr6tP+8TTkYRDEjF92YdbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g0A7a+5vDZgzlqAuQ/6GSb6DxVpjB89Q6ecw7Rcn3THNIsQR1VXzC4BFA+iVBWypN
	 hxJr/AtFsZNtYfJ4DrBS/+OlDWSNKFqPSiqDO+hVNDjWxMRnUO9gFPJ2lE82VldPgL
	 eNQK1CWweOSQ+x+L8VAG15gCw7mBXelVpLfVeQR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfEOI3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfEOI3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:29:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43E7720843;
        Wed, 15 May 2019 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557908973;
        bh=cb6Z72ERql0xdgtLEheM3Mr6tP+8TTkYRDEjF92YdbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdigXGYpCHahSil4CZYyy/NiXojNHYkhugo43zeFTqjlrDGXb1oFyhTfCwi/uoHhq
         1O+0Z8NwBTRc07OTs3Ya+ehdtc6bQJiPl6GgiBEbpVUYO61xxkovBN++Wra2EE8d3A
         N6fYSRwKLhMwU1A0EEfRgvm2nD05P96Ok4Xgcpfk=
Date:   Wed, 15 May 2019 10:29:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, erhard_f@mailbox.org,
        Michael Neuling <mikey@neuling.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH stable 4.9] powerpc/lib: fix book3s/32 boot failure due
 to code patching
Message-ID: <20190515082931.GA28349@kroah.com>
References: <629c2acb1fcd09c2d2e3352370c3d9853372cf39.1557902321.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <629c2acb1fcd09c2d2e3352370c3d9853372cf39.1557902321.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 06:40:47AM +0000, Christophe Leroy wrote:
> [Backport of upstream commit b45ba4a51cde29b2939365ef0c07ad34c8321789]
> 
> On powerpc32, patch_instruction() is called by apply_feature_fixups()
> which is called from early_init()
> 
> There is the following note in front of early_init():
>  * Note that the kernel may be running at an address which is different
>  * from the address that it was linked at, so we must use RELOC/PTRRELOC
>  * to access static data (including strings).  -- paulus
> 
> Therefore init_mem_is_free must be accessed with PTRRELOC()
> 
> Fixes: 1c38a84d4586 ("powerpc: Avoid code patching freed init sections")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203597
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> Can't apply the upstream commit as such due to several other unrelated stuff
> like for instance STRICT_KERNEL_RWX which are missing.
> So instead, using same approach as for commit 252eb55816a6f69ef9464cad303cdb3326cdc61d

Now queued up, thanks.

greg k-h
