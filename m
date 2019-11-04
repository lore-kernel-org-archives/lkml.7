Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BFBCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181E320842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 09:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="ByqSth9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfKDJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 04:21:51 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:52712 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfKDJVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 04:21:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 108D440666;
        Mon,  4 Nov 2019 10:21:38 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=ByqSth9y;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COSmvI3aZtJa; Mon,  4 Nov 2019 10:21:36 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 3C07540663;
        Mon,  4 Nov 2019 10:21:27 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id A001336018B;
        Mon,  4 Nov 2019 10:21:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1572859286; bh=4xBA0Dni2o2Q85TuTFyQusIiI73YaZ6L+DTBUOzo9Nk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ByqSth9yKsVbQ72KoftTKl9uWmOfkTVKCreEAYXtN7Hgni/cQP8BlQwxuGzjlOrnk
         F13EbHuirJq/UVTAKxaWqabLZox/hLxdboH9/IYf/ExR9JmHC2AAmT380Q99t9u4vZ
         SZHQVViKoQ/H0JgMWgmNBsTvZ+3GdJo06YmOItko=
Subject: -mm maintainer? WAS Re: [PATCH v6 0/8] Emulated coherent graphics
 memory take 2
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191014132204.7721-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <a31f0d40-d8a5-faca-016b-0066f5ac31a2@shipmail.org>
Date:   Mon, 4 Nov 2019 10:21:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191014132204.7721-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

On 10/14/19 3:22 PM, Thomas Hellström (VMware) wrote:
> From: Thomas Hellström <thellstrom@vmware.com>
>
> Graphics APIs like OpenGL 4.4 and Vulkan require the graphics driver
> to provide coherent graphics memory, meaning that the GPU sees any
> content written to the coherent memory on the next GPU operation that
> touches that memory, and the CPU sees any content written by the GPU
> to that memory immediately after any fence object trailing the GPU
> operation is signaled.
>
> Paravirtual drivers that otherwise require explicit synchronization
> needs to do this by hooking up dirty tracking to pagefault handlers
> and buffer object validation.
>
> Provide mm helpers needed for this and that also allow for huge pmd-
> and pud entries (patch 1-3), and the associated vmwgfx code (patch 4-7).
>
> The code has been tested and exercised by a tailored version of mesa
> where we disable all explicit synchronization and assume graphics memory
> is coherent. The performance loss varies of course; a typical number is
> around 5%.
>
> I would like to merge this code through the DRM tree, so an ack to include
> the new mm helpers in that merge would be greatly appreciated.
>

I'm a bit confused as how to get this merged? Is there an -mm maintainer 
or who is supposed to ack -mm patches and get them into the kernel?

Any input appreciated,

Thanks,

Thomas


