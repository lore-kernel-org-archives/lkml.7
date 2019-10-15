Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C83ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD27E20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571156372;
	bh=o+2ADBoaRaNOXQKPdV1EdfBdRnnm07DN8Tz5LueEYEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z5qbbO8FqE2b30y943Mc/PLlBY8+6Lvafln6aFHIJaz0+BAROgJUMBj/sIiiWs+xQ
	 hKvtw4w4eLXACoZ1oLDyJWmyQEju9iS32c5rzxER99coxenTsRzlrUOxjzYwDWmcs8
	 4udCH9OPQC5z/j39xIM4qPB5h2Hg2BWF0QzMDzLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfJOQTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387827AbfJOQTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:19:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBCD2064A;
        Tue, 15 Oct 2019 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571156370;
        bh=o+2ADBoaRaNOXQKPdV1EdfBdRnnm07DN8Tz5LueEYEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X51xcbsCs95Zu90V9+LHMgJjLYvcf2nh+XUccVLBzUN17jhP2xojFID22MPdw+1Dc
         oA5Q/2ZfZAD8/GQ6jF88qr2lBlgvh8YB2ZC4oD29WSCn8O4AgEfvSSAEMqX9+mCCQ8
         ZW9E1h6RfsNxm0gC/Wm8mME6QjISEwUmo48E5VWA=
Date:   Tue, 15 Oct 2019 17:19:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4] arm64: use generic free_initrd_mem()
Message-ID: <20191015161925.5djuqpdeh3z32awn@willie-the-truck>
References: <1569657746-31672-1-git-send-email-rppt@kernel.org>
 <20191015004659.l5xbxv4mlpzqpsdl@willie-the-truck>
 <2AB94CD5-3374-4A15-9422-689EE2549FC6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2AB94CD5-3374-4A15-9422-689EE2549FC6@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 09:39:41AM +0200, Mike Rapoport wrote:
> On October 15, 2019 2:46:59 AM GMT+02:00, Will Deacon <will@kernel.org> wrote:
> >On Sat, Sep 28, 2019 at 11:02:26AM +0300, Mike Rapoport wrote:
> >> From: Mike Rapoport <rppt@linux.ibm.com>
> >> 
> >> arm64 calls memblock_free() for the initrd area in its implementation
> >of
> >> free_initrd_mem(), but this call has no actual effect that late in
> >the boot
> >> process. By the time initrd is freed, all the reserved memory is
> >managed by
> >> the page allocator and the memblock.reserved is unused, so the only
> >purpose
> >> of the memblock_free() call is to keep track of initrd memory for
> >debugging
> >> and accounting.
> >> 
> >> Without the memblock_free() call the only difference between arm64
> >and the
> >> generic versions of free_initrd_mem() is the memory poisoning.
> >> 
> >> Move memblock_free() call to the generic code, enable it there
> >> for the architectures that define ARCH_KEEP_MEMBLOCK and use the
> >generic
> >> implementation of free_initrd_mem() on arm64.
> >> 
> >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> ---
> >> 
> >> v4:
> >> * memblock_free() aligned area around the initrd
> >
> >Looks straightforward to me:
> >
> >Acked-by: Will Deacon <will@kernel.org>
> 
>  Can it go via arm64 tree?

Yes, I was hoping Catalin would pick it up for 5.5.

Will
