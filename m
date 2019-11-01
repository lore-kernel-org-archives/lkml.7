Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21359CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1554218DE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oXzZMDiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfKAQDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:03:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53920 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKAQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:03:30 -0400
Received: from nazgul.tnic (unknown [46.218.74.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D17B1EC0CA1;
        Fri,  1 Nov 2019 17:03:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572624209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ogloGTuKzErds3QtzMzbyR6KG8QBHw26DAOsxdW4CV8=;
        b=oXzZMDiOp9kXKm0jYXAUKuwrjfeersHhy+4h0dD1MGoQLbv4XWmk8UTBn94Vk5W53aL4cB
        a7FHn0xOyWcgDVBnovzj6yZG2RHH09kzZI7+A/DP2BtPrEWiYqDwckZvsqOyAJDonb8v/6
        qTkCuQ1xD++ANrffeftQPV9N2rIAIpI=
Date:   Fri, 1 Nov 2019 17:03:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() +
 WARN_ON_ONCE()
Message-ID: <20191101160323.GB2300@nazgul.tnic>
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
 <20191031110304.GE21133@nazgul.tnic>
 <5DBACB61.90809@huawei.com>
 <20191031154916.GA24152@nazgul.tnic>
 <5DBB03B0.5060003@huawei.com>
 <20191101084524.GA29724@nazgul.tnic>
 <5DBC4FFB.5030200@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5DBC4FFB.5030200@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:32:11PM +0800, zhong jiang wrote:
> WARN_ONCE will alway return true if its condition is true.:-)

And if its condition is false?

Lemme save you some time: WARN_ONCE() returns the @condition value so
constructs like

	if (WARN_ONCE(condition,...))

are possible. Grep the code for examples.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
