Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5F8C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FA221882
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 00:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571098722;
	bh=rwoRiB+wQGU744n1zKSEPj4a2yJrIqPtZgHsJ+gOmQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eobJtvSXkblD3Zg5WTODoEu5Q/WLHFHs3FVeV9HO5RlnDywYSXsPTGpGEL3EQEgs4
	 imkhgZNZdpnqXKQE27u18+IxPoEffPMPc+ZJGIZSQ0Tf/iOF+o0EdFhmyBOEa4aMrA
	 0oylE3ePX04/oKsstY9cGpDNIRD6ItKO9DtiIsmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfJOASl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 20:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfJOASl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 20:18:41 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66448217D9;
        Tue, 15 Oct 2019 00:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571098720;
        bh=rwoRiB+wQGU744n1zKSEPj4a2yJrIqPtZgHsJ+gOmQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InkkdLmSnOzul4H4R5ACoiK7D9dwZxnAkDvsoMiPOFdD26XeTzvD/ipLadEpVE5VL
         o1swarhHFBdtMoU+xGI8GEUhSp0cFOACydk/7GZf8nAj21bwbn4Nl30wkhwhsMAlaM
         40fUHKf8UxJMK48BHD/nH3V+ReS9VpmKXsknnDn8=
Date:   Tue, 15 Oct 2019 01:18:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, hejianet@gmail.com,
        Kaly Xin <Kaly.Xin@arm.com>, nd@arm.com
Subject: Re: [PATCH v12 0/4] fix double page fault in cow_user_page for pfn
 mapping
Message-ID: <20191015001834.wwkd46t6dwicta7n@willie-the-truck>
References: <20191011140939.6115-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011140939.6115-1-justin.he@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:09:35PM +0800, Jia He wrote:
> When we tested pmdk unit test vmmalloc_fork TEST1 in arm64 guest, there
> will be a double page fault in __copy_from_user_inatomic of cow_user_page.
> 
> As told by Catalin: "On arm64 without hardware Access Flag, copying from
> user will fail because the pte is old and cannot be marked young. So we
> always end up with zeroed page after fork() + CoW for pfn mappings. we
> don't always have a hardware-managed access flag on arm64."
> 
> -Changes
> v12:
>     refine PATCH 01, remove the !! since C languages can convert unsigned
>     to bool (Catalin)

Thanks. I think it's a bit late to take something like this for 5.4 now,
especially as the current behaviour has always been there. Hopefully
somebody can queue it for 5.5 instead.

Will
