Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC8ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969D121726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572174024;
	bh=Jmt2B0VEl/FUjM+MgzpTzTtF3WYLk8v8TfnsbPH95BE=;
	h=Date:In-Reply-To:References:Subject:To:CC:From:List-ID:From;
	b=0ZuUHeOs4uZ6y3znAxCCrZklIT4twHSYDeyS6wvHsz/yebG4+TsFIsulqgTek4ZjF
	 J8t8McZpQHzI6Nx7gqPxELtOY3+4al1j0MI2Xe+I9GhwN0IChfmUlbMRc5pNSqcNSO
	 /7p0t9gYb5iKXg8AKehKDMt59CY2hxTj6FILPa04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJ0LAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 07:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfJ0LAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:00:23 -0400
Received: from [10.173.153.26] (unknown [2.55.42.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F46D214AF;
        Sun, 27 Oct 2019 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572174022;
        bh=Jmt2B0VEl/FUjM+MgzpTzTtF3WYLk8v8TfnsbPH95BE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=nWmDdz95jS72TenFW6vwu5hnpkWGaIk+42GN2FxxDR78HF8zBHoIhwHWcd2Rwlzhz
         BPaAzQljyMUopkP2ab89nUBAsWWGu6p1Oluy9j+CscUuN7lszAK4lXsB7HKKXgQ3LN
         biHkcQoaYhqZmf4mRHOemJcXCiJq/wuyvnKN1xoY=
Date:   Sun, 27 Oct 2019 13:00:13 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <87d0eieb0i.fsf@mid.deneb.enyo.de>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org> <87d0eieb0i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     Florian Weimer <fw@deneb.enyo.de>
CC:     linux-kernel@vger.kernel.org,
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
From:   Mike Rapoport <rppt@kernel.org>
Message-ID: <385EB6D4-A1B0-4617-B256-181AA1C3BDE3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 27, 2019 12:30:21 PM GMT+02:00, Florian Weimer <fw@deneb=2Eenyo=
=2Ede> wrote:
>* Mike Rapoport:
>
>> The patch below aims to allow applications to create mappins that
>have
>> pages visible only to the owning process=2E Such mappings could be used
>to
>> store secrets so that these secrets are not visible neither to other
>> processes nor to the kernel=2E
>
>How is this expected to interact with CRIU?

CRIU dumps the memory contents using a parasite code from inside the dumpe=
e address space, so it would work the same way as for the other mappings=2E=
 Of course, at the restore time the exclusive mapping should be recreated w=
ith the appropriate flags=2E

>> I've only tested the basic functionality, the changes should be
>verified
>> against THP/migration/compaction=2E Yet, I'd appreciate early feedback=
=2E
>
>What are the expected semantics for VM migration?  Should it fail?

I don't quite follow=2E If qemu would use such mappings it would be able t=
o transfer them during live migration=2E

--=20
Sincerely yours,
Mike
