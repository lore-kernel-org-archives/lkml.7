Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF2CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75272086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572339364;
	bh=RCMUTEieUAqbdDi3UXC44oJQHvnrbU2QZQPBK7vKBHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r47yWgNvKR7rmMk+IZlWAXburQbXXPwQEsIoJ4FNFFh0/dwj2nK3zcTZFI4Js22Lj
	 HOKB7wyTgFTX3xXn7520sNAlgHtjWH9A+mHpj0pVcdmmTIO+5A+FPyV3mpSwwKdsMP
	 UcCZuxUP/ljBa3swncPWVK22WMdJho8XuG8W8738=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfJ2I4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfJ2I4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:56:02 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1031420663;
        Tue, 29 Oct 2019 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572339362;
        bh=RCMUTEieUAqbdDi3UXC44oJQHvnrbU2QZQPBK7vKBHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bK6YBI1jHf1yer+gIAFBkdQfdkJZfxdS24Gvl3LhKuDLpEa8DWiPe8Sr+QPDFcRYj
         4XIAV2Tn4t1Puqkg2rtTqMX+AKf6wJ6qNHzPTy7COE4QD0QxiWPoIiygzCaMPZVLSN
         5WIqGWIJMAxMy0jB5tFSVt1yZ4+rFA618tmvoMTI=
Date:   Tue, 29 Oct 2019 09:55:53 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Christopher Lameter <cl@linux.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20191029085551.GA18773@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
 <20191028123124.ogkk5ogjlamvwc2s@box>
 <20191028130018.GA7192@rapoport-lnx>
 <20191028131623.zwuwguhm4v4s5imh@box>
 <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910290706360.3769@www.lameter.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:08:42AM +0000, Christopher Lameter wrote:
> On Mon, 28 Oct 2019, Kirill A. Shutemov wrote:
> 
> > Setting a single 4k page non-present in the direct mapping will require
> > splitting 2M or 1G page we usually map direct mapping with. And it's one
> > way road. We don't have any mechanism to map the memory with huge page
> > again after the application has freed the page.
> >
> > It might be okay if all these pages cluster together, but I don't think we
> > have a way to achieve it easily.
> 
> Set aside a special physical memory range for this and migrate the
> page to that physical memory range when MAP_EXCLUSIVE is specified?

I've talked with Thomas yesterday and he suggested something similar:

When the MAP_EXCLUSIVE request comes for the first time, we allocate a huge
page for it and then use this page as a pool of 4K pages for subsequent
requests. Once this huge page is full we allocate a new one and append it
to the pool. When all the 4K pages that comprise the huge page are freed
the huge page is collapsed.

And then on top of this we can look into compaction of the direct map.

Of course, this would work if the easy way of collapsing direct map pages
Kirill mentioned on other mail will work.
 
> Maybe some processors also have hardware ranges that offer additional
> protection for stuff like that?
> 

-- 
Sincerely yours,
Mike.
