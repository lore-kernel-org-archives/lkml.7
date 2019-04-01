Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F046C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1802086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="SVHocj+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfDAJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:58:26 -0400
Received: from mx.sdf.org ([205.166.94.20]:56425 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfDAJ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:58:25 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x319u8Fl017367
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Mon, 1 Apr 2019 09:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
        t=1554112582; bh=nfyrQ8GwYN1dR+36K+w2KJmeeTK++gvNmVw4hbCgtQ4=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=SVHocj+qYv7EIPnLIfPgOVaNlCkoSdLXLVw6GFrl9DCOnxhLWUjOM9vbGSgCCoGcp
         D1nD66gIhO4CU+TNaRxHv3p9OlqQMQLiL6LH5yenIMo9bJvE6E7MQYstcxd8XbGkjb
         GywuxAxfIpYFvEK00nepx2+Z/kokFUYZ+IxaQyMI=
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x319u70q021113;
        Mon, 1 Apr 2019 09:56:07 GMT
Date:   Mon, 1 Apr 2019 09:56:07 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201904010956.x319u70q021113@sdf.org>
To:     andriy.shevchenko@linux.intel.com, st5pub@yandex.ru
Subject: Re: [PATCH v2 5/5] Lib: sort.h: replace int size with size_t size in the swap function
Cc:     adrian.hunter@intel.com, ard.biesheuvel@linaro.org,
        benh@kernel.crashing.org, bp@alien8.de, darrick.wong@oracle.com,
        dchinner@redhat.com, dedekind1@gmail.com,
        gregkh@linuxfoundation.org, hpa@zytor.com, jannh@google.com,
        jlbec@evilplan.org, jpoimboe@redhat.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        lkml@sdf.org, mark@fasheh.com, mingo@redhat.com,
        mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
        ocfs2-devel@oss.oracle.com, paulus@samba.org, peterz@infradead.org,
        richard@nod.at, sfr@canb.auug.org.au, tglx@linutronix.de,
        vgupta@synopsys.com, x86@kernel.org
In-Reply-To: <20190401093555.GD9224@smile.fi.intel.com>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net>,
    <23051461554058370@iva6-3ac3de5fcc31.qloud-c.yandex.net>,
    <20190401093555.GD9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 at 12:35:55 +0300, Andy Shevchenko wrote:
> Hmm... If (*swap)() is called recursively it means the change might increase
> stack usage on 64-bit platforms.
> 
> Am I missing something?

Under what conceivable circumstance would someone write a recursive
(*swap)() function?

You're technically right, but the precondition is more fantastical
than "if the U.K.'s parliament get their shit together before the
12th", so I have a hard time worrying about it.

But you did make me think of something: the whole reason swap()
takes a size argument is for the benefit of the (no longer existing)
generic swap functions.  All of the custom swap functions ignore
it.

So how about *deleting* the parameter instead?  That simplifies
everything.
