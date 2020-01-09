Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C3C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5E62073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578560854;
	bh=80VO7IRaadflRsWGeFaWpP4uMh6gHTYCmJeL67RjZyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y029idu/u6Hk4zWPucEUiQc7ZholcskgSJ2skmKIo3M72hG6GLl+TjMRvJq8R3Ito
	 QfXAZaX8Sl1CdjKncOkw6KL7W1AGx9dHF+k/IfgqL8Z73Ad0FUmbioQykp+ULqt0Ih
	 DUUBbopl7x3UH1h/UImqKHr6fmPXXJZhGfhv25zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgAIJHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:07:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgAIJHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:07:33 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1E920673;
        Thu,  9 Jan 2020 09:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578560852;
        bh=80VO7IRaadflRsWGeFaWpP4uMh6gHTYCmJeL67RjZyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5FmlW6oNXmmHi8t5SgWv6hqbdIOcUc7kC9MBmRyqClnLeB0DbMUArm6zNITYQbZM
         X3khTwxh8dUFqbTImNB9UVzgMvIDlRJW427ftIDOSroG+TSjzJJ7++lD9C0seZcwE+
         32RfwPZhjFiLV95ZOf0ynTo5+MVxORQ//gS9cugs=
Date:   Thu, 9 Jan 2020 11:07:20 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/1] arm/arm64: add support for folded p4d page tables
Message-ID: <20200109090719.GA14426@rapoport-lnx>
References: <20191230082734.28954-1-rppt@kernel.org>
 <19fc0640-2b7e-a06f-a4c8-2736d54dd565@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fc0640-2b7e-a06f-a4c8-2736d54dd565@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 08:38:54AM +0530, Anshuman Khandual wrote:
> 
> 
> On 12/30/2019 01:57 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> 
> Hello Mike,
> 
> > 
> > This is a part of clean up of the page table manipulation code that aims to
> > remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
> > 
> > There is a single patch for both arm and arm64 because doing the conversion
> > separately would mean breaking the shared mmu bits in virt/kvm/arm.
> > 
> > The patch is build tested and boot tested on qemu-system-{arm,aarch64}.
> 
> There are lots of code changes here for a single patch but as you have
> mentioned shared KVM bits would have prevented splitting arm and arm64
> changes into separate patches. Just curious, are you planning to respin
> this patch sooner after fixing the reported build problems caused by
> missing p4d_offset_kimg() and p4d_sect() definitions ?

Well, I was waiting to see if there was some feedback except kbuild robot
response :)

I'm planning to send v2 soon, probably next week.
 
> - Anshuman

-- 
Sincerely yours,
Mike.
