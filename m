Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53BCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A26214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572267629;
	bh=7B5KqT02XX9UUIrQVYUjxF/tdp4AX2fxoquk/g1eYlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NzPg+RFYkkCXL2EJdxgQ31cRPW8vP31t8tWTAZl4Vu8p70Bax7HVT3dNVae5kXLw0
	 OHNt2pj5ybQSiFRRy2N6MKa2Jot2IgrJP6JbNLolGg8pafOHUXpwbk3Jqp+7qrbH6y
	 vLbuVFgvljCTl0lOfzYOnzwYbY2jORSEaA97UxQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfJ1NA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 09:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfJ1NA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:00:27 -0400
Received: from rapoport-lnx (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4CD220873;
        Mon, 28 Oct 2019 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572267626;
        bh=7B5KqT02XX9UUIrQVYUjxF/tdp4AX2fxoquk/g1eYlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W+ACpEJtAVmweITcDAONS+d676IgPfKwQtn05LXqUIkznSdTZHf+QRrS2253omIX6
         f4YsmExVRa7lT6Sble5zHX+YPVeEOxeSUnSA2MCF1zYGfMN7ZbZtMsP1sGncjGcRyA
         H1P+eY3WBy01O4yAzuWeWSC4E50ZtAkaNQbdeAzo=
Date:   Mon, 28 Oct 2019 14:00:19 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191028130018.GA7192@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028123124.ogkk5ogjlamvwc2s@box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 03:31:24PM +0300, Kirill A. Shutemov wrote:
> On Sun, Oct 27, 2019 at 12:17:32PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The mappings created with MAP_EXCLUSIVE are visible only in the context of
> > the owning process and can be used by applications to store secret
> > information that will not be visible not only to other processes but to the
> > kernel as well.
> > 
> > The pages in these mappings are removed from the kernel direct map and
> > marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> > the pages are mapped back into the direct map.
> 
> I probably blind, but I don't see where you manipulate direct map...

__get_user_pages() calls __set_page_user_exclusive() which in turn calls
set_direct_map_invalid_noflush() that makes the page not present.
 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
