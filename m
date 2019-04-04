Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ED7C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855CD2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554339472;
	bh=mJwodE2gRa2C3WW5YdRbgfUkn8szJ9u1XhmMgYBgYBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dh/xjaY9KXS89+a0KX6bXo4XL88eJxIZ+bRAIv0XTSQpK6WySrC6PATsFMqPLVCpH
	 L72aGVe+MjCAv0Ue0ktd9Erna3ST7gaxs6QtUXavlkjW6/1MyFuZfPv3vK2kXLNOEt
	 6OfU5Pjg539/i2ozlYHV9CwCMMD1U7ERPAd77zoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDDA5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:57:51 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F278C2082E;
        Thu,  4 Apr 2019 00:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554339470;
        bh=mJwodE2gRa2C3WW5YdRbgfUkn8szJ9u1XhmMgYBgYBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYg9X80sINpVkIevZK5YRlzuwm0+NB1xTF+vpBpkMQnI4BlXUVa3ItjY0O9e4GYm6
         t6Q7tRM3rgDP7r6EYRrh/FJ4mrSr1avZZkifdEoeXcKMQxMSwbznEe3lQd/hjJuUy7
         2dByCQhDwXcwg4uZVBI9YgDUAM9WHinBax6BHAU8=
Date:   Wed, 3 Apr 2019 20:57:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Guo Ren <ren_guo@c-sky.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        Rich Felker <dalias@libc.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 5.0 015/262] memblock:
 memblock_phys_alloc_try_nid(): don't panic
Message-ID: <20190404005748.GJ16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-15-sashal@kernel.org>
 <20190328055720.GB14864@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328055720.GB14864@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:57:21AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Wed, Mar 27, 2019 at 01:57:50PM -0400, Sasha Levin wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> [ Upstream commit 337555744e6e39dd1d87698c6084dd88a606d60a ]
>>
>> The memblock_phys_alloc_try_nid() function tries to allocate memory from
>> the requested node and then falls back to allocation from any node in
>> the system.  The memblock_alloc_base() fallback used by this function
>> panics if the allocation fails.
>>
>> Replace the memblock_alloc_base() fallback with the direct call to
>> memblock_alloc_range_nid() and update the memblock_phys_alloc_try_nid()
>> callers to check the returned value and panic in case of error.
>
>This is a part of memblock refactoring, I don't think it should be applied
>to -stable.

Dropped, thanks!

--
Thanks,
Sasha
