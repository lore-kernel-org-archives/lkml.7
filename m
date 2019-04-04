Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0F3C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BD214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554339408;
	bh=seoAILuz7Cv84t/mKF94j2odiJmdprtCCeRrEcdf+54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vZB0CBTN6ZJUzbw0DhEhDSDNxDwMmCXuqUMqljP62ANKbCYgk4kNYfTDsOxduhzi9
	 lCKsgEf2rlxy9vVZM+Dy+cO0/63uKSSL4hM5HBF9J3pcQhCPpqYismQO8CojnbqJ9B
	 phXBMkgSpAiyZqhgv0Lsgr+1xPEHGehfJE0j0tEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfDDA4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDA4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:56:46 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A7D32133D;
        Thu,  4 Apr 2019 00:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554339405;
        bh=seoAILuz7Cv84t/mKF94j2odiJmdprtCCeRrEcdf+54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYeahpNnvcaa4TUyHMtut0+8C6K7pSl2xXOrA0pKdmywE335pIRFooI9qWl8nKxsz
         9ObiVRQSLAvNyN2PUD9M4Lllx3pgSvdxIoJx6U6dtVw8WtY6hKJ4/1KRSfiOqpL4wH
         FHVbLCDaMEsT57Ca0mstNRHXvrWty2CfdQCrHtfk=
Date:   Wed, 3 Apr 2019 20:56:44 -0400
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
        Michael Ellerman <mpe@ellerman.id.au>,
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
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH AUTOSEL 5.0 008/262] swiotlb: add checks for the return
 value of memblock_alloc*()
Message-ID: <20190404005644.GI16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-8-sashal@kernel.org>
 <20190328055520.GA14864@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190328055520.GA14864@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 07:55:20AM +0200, Mike Rapoport wrote:
>Hi,
>
>On Wed, Mar 27, 2019 at 01:57:43PM -0400, Sasha Levin wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>
>> [ Upstream commit a0bf842e89a3842162aa8514b9bf4611c86fee10 ]
>>
>> Add panic() calls if memblock_alloc() returns NULL.
>>
>> The panic() format duplicates the one used by memblock itself and in
>> order to avoid explosion with long parameters list replace open coded
>> allocation size calculations with a local variable.
>
>This patch is a part of a series that removes panic() calls from memblock
>allocators rather than a fix.

I've dropped it, thanks!

--
Thanks,
Sasha
