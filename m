Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59710C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22256222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="prv+uukc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfKMLIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:08:55 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:56473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfKMLIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:08:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Chgh6SPTz9sNH;
        Wed, 13 Nov 2019 22:08:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573643331;
        bh=ToKhbEA1zIEt/CqcqU8IvA0xCdgG7bCPEQrifiO4Ef4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=prv+uukcXKixsHi6a8IlTLYS2Risu4DU1MJixf5189oCDB3vTaTA22QlIa7AaGeFp
         yX+zuh+uBXKNykQDYeCciV7d2W7eZ98SmA4fHHynwRiGG4wShJQyVqyWdSlUUD5nn0
         vIxKztntKAp3kLcIYsQW56+F1hwT7VAyfCowvjD53PuzoRDJMG4YmSJIyx4adpTztz
         OJ5q1UhFZyETdY39NfxN3YPvXV6lSP+onIUb3shwisbQxAOY0PRbQAHeNXStRCubzq
         /vd7ysb8tUZUBQNbYrujZVyglaSnOpcVg4M+PgCfxdHKTQtgN6F8euFxIcKjVy+FUm
         5kS2ey3jPm83A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        "Enrico Weigelt\, metux IT consult" <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Arun KS <arunks@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian@brauner.io>,
        Gao Xiang <xiang@kernel.org>,
        Greg Hackmann <ghackmann@google.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v1 08/12] powerpc/pseries: CMM: Implement balloon compaction
In-Reply-To: <8e46b1c5-f52b-0155-4d4f-e3bbdea95384@redhat.com>
References: <20191031142933.10779-1-david@redhat.com> <20191031142933.10779-9-david@redhat.com> <be7c1424-f240-b72c-8d6d-310ebbd816e1@redhat.com> <87blth2wyk.fsf@mpe.ellerman.id.au> <8e46b1c5-f52b-0155-4d4f-e3bbdea95384@redhat.com>
Date:   Wed, 13 Nov 2019 22:08:44 +1100
Message-ID: <87lfsk11ab.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:
> On 12.11.19 11:46, Michael Ellerman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> On 31.10.19 15:29, David Hildenbrand wrote:
>>>> We can now get rid of the cmm_lock and completely rely on the balloon
>>>> compaction internals, which now also manage the page list and the lock.
>> ...
>>>> +
>>>> +static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>>>> +			   struct page *newpage, struct page *page,
>>>> +			   enum migrate_mode mode)
>>>> +{
>>>> +	unsigned long flags;
>>>> +
>>>> +	/*
>>>> +	 * loan/"inflate" the newpage first.
>>>> +	 *
>>>> +	 * We might race against the cmm_thread who might discover after our
>>>> +	 * loan request that another page is to be unloaned. However, once
>>>> +	 * the cmm_thread runs again later, this error will automatically
>>>> +	 * be corrected.
>>>> +	 */
>>>> +	if (plpar_page_set_loaned(newpage)) {
>>>> +		/* Unlikely, but possible. Tell the caller not to retry now. */
>>>> +		pr_err_ratelimited("%s: Cannot set page to loaned.", __func__);
>>>> +		return -EBUSY;
>>>> +	}
>>>> +
>>>> +	/* balloon page list reference */
>>>> +	get_page(newpage);
>>>> +
>>>> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
>>>> +	balloon_page_insert(b_dev_info, newpage);
>>>> +	balloon_page_delete(page);
>>>
>>> I think I am missing a b_dev_info->isolated_pages-- here.
>> 
>> I don't know this code at all, but looking at other balloon drivers they
>> do seem to do that in roughly the same spot.
>> 
>> I'll add it, how can we test that it's correct?
>
> It's certainly correct. We increment when we isolate 
> (balloon_page_isolate()) and decrement when we un-isolate.
>
> Un-isolate happens when we putback a isolated page 
> (balloon_page_putback() - migration aborted) or when we successfully 
> migrate it (via balloon_page_migrate()).
>
> The issue is that we cannot decrement in balloon_page_migrate(), as we 
> have to hold the b_dev_info->pages_lock. That's why we have to do it in 
> the registered callback under lock.

OK, I get it now.

> Please note that b_dev_info->isolated_pages is only needed for a sanity 
> check in balloon_page_dequeue(). That's why I didn't notice during 
> testing. I wonder if we should at some point rip out that sanity check ...

OK. Sanity checks can be good, though checks that call BUG() are less
nice :)  But I'm not an mm expert so I'll defer to you folks on the
sanity check.

For now I've merged this series with the decrement added to
cmm_migratepage().

cheers
