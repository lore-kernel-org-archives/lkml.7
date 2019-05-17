Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D15C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144DE2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558129853;
	bh=XAnihnyM8tPVIS0duJIIenhFswdE2ITYujhIk4/YYXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ublhGbZh3VuuPbvo6ta1P3mO3cdU40LuqLiWH8kUD7mF528ZQw2owUbX1IBSpYNDT
	 8UjPWsnSTK0ElRz6c2cx2x5qxurZ+zaHd3JvfUQ4gOvTbkrNpPob8HLiKYOx8Hl+vz
	 WD3rhLMvpDns+ddMGu2nAs+Yick/JK6UX99hinBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfEQVuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfEQVuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:50:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AACD2166E;
        Fri, 17 May 2019 21:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558129851;
        bh=XAnihnyM8tPVIS0duJIIenhFswdE2ITYujhIk4/YYXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tztgk972S74ZcA0fIcYynWU2LA6EGW/8HyY1lB7Z8Q+uZTYmr5mdXyxHJCz53nGPN
         0LRMAq2ZvAahbXimeMA4ojr8ed3jGYLdSUCeY8iDqMbVa2nQtEjkF+MxliNjSgYj93
         QqElp0UTIeYT/VIePfTOf4ZQv7nK+VAlzZryhb1c=
Date:   Fri, 17 May 2019 14:50:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com, jglisse@redhat.com,
        ldufour@linux.vnet.ibm.com
Subject: Re: [PATCH] mm/dev_pfn: Exclude MEMORY_DEVICE_PRIVATE while
 computing virtual address
Message-Id: <20190517145050.2b6b0afdaab5c3c69a4b153e@linux-foundation.org>
In-Reply-To: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
References: <1558089514-25067-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 16:08:34 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> The presence of struct page does not guarantee linear mapping for the pfn
> physical range. Device private memory which is non-coherent is excluded
> from linear mapping during devm_memremap_pages() though they will still
> have struct page coverage. Just check for device private memory before
> giving out virtual address for a given pfn.

I was going to give my standard "what are the user-visible runtime
effects of this change?", but...

> All these helper functions are all pfn_t related but could not figure out
> another way of determining a private pfn without looking into it's struct
> page. pfn_t_to_virt() is not getting used any where in mainline kernel.Is
> it used by out of tree drivers ? Should we then drop it completely ?

Yeah, let's kill it.

But first, let's fix it so that if someone brings it back, they bring
back a non-buggy version.

So...  what (would be) the user-visible runtime effects of this change?
