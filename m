Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FC0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7FB20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980819;
	bh=1RSAAoDl+MfB8HGRc1Opl1CrXXA7wmKimpQdk1qa2rU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1GYriN7yFaL0k8uu2BkfiawwHxEiPZyogTnjp0/+OwwOXwlUP2ZJveyvb9m2TwWen
	 +0/HFz5bK3RaE1ikOwA+NhQLyzxSBZem7EEF/O+EgZbF4vBaAMeEbtR2Q6WHv9WPzt
	 6t4ZCq7pFboHMrOlfj26TQs00AO0aHdsmB5EVSe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfCGRq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfCGRq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:56 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 17DE1C139;
        Thu,  7 Mar 2019 17:46:55 +0000 (UTC)
Date:   Thu, 7 Mar 2019 09:46:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-Id: <20190307094654.35391e0066396b204d133927@linux-foundation.org>
In-Reply-To: <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
References: <20190129165428.3931-10-jglisse@redhat.com>
        <CAPcyv4gNtDQf0mHwhZ8g3nX6ShsjA1tx2KLU_ZzTH1Z1AeA_CA@mail.gmail.com>
        <20190129193123.GF3176@redhat.com>
        <CAPcyv4gkYTZ-_Et1ZriAcoHwhtPEftOt2LnR_kW+hQM5-0G4HA@mail.gmail.com>
        <20190129212150.GP3176@redhat.com>
        <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
        <20190130030317.GC10462@redhat.com>
        <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
        <20190130183616.GB5061@redhat.com>
        <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
        <20190131041641.GK5061@redhat.com>
        <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
        <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
        <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019 20:20:10 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> My hesitation would be drastically reduced if there was a plan to
> avoid dangling unconsumed symbols and functionality. Specifically one
> or more of the following suggestions:
> 
> * EXPORT_SYMBOL_GPL on all exports to avoid a growing liability
> surface for out-of-tree consumers to come grumble at us when we
> continue to refactor the kernel as we are wont to do.

The existing patches use EXPORT_SYMBOL() so that's a sticking point. 
Jerome, what would happen is we made these EXPORT_SYMBOL_GPL()?

> * A commitment to consume newly exported symbols in the same merge
> window, or the following merge window. When that goal is missed revert
> the functionality until such time that it can be consumed, or
> otherwise abandoned.

It sounds like we can tick this box.

> * No new symbol exports and functionality while existing symbols go unconsumed.

Unsure about this one?
