Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB76C04AAA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BF62075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVLgl0fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfECUyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:54:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DrwnEZ0jPLsFz0jW7P9u5r38DMTWFjUguZ+Ev/6WmO4=; b=JVLgl0fRopyF1En17yM958COm
        OXNkSscnyIL1JiUyn9BBOfpNOInMqgaTNc8asvtb8v4mdi38dJymdPDTNLyypMJMmSv47kjMOvE6U
        9z+bHu6SdGNf0EXNOtDeUepQbZW6e1ik2Gg1OhxbosiAx+wDAJ6+n/pql+B5nfD9gLF0sRdhPe+Lq
        gOYkSw8KXZ4VXmyLLj5MCbArRrhov9DLklRdMSh4GtIanO3UizoPZw7kc0N4L7kuHTC7bYnQc4O+A
        Sp4FKLgxKyy3ffBBMzj/yh6fvP8UyPnj+Dnr11GFvl1QGW7LtCRgWqu3Qs63Sli35lZo2NsDOif6J
        MTwhT9WsQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMfC8-0001CG-Bi; Fri, 03 May 2019 20:54:12 +0000
Subject: Re: ERROR: "paddr_to_nid" [drivers/md/raid1.ko] undefined!
To:     "Luck, Tony" <tony.luck@intel.com>, lkp <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <201905032019.tzlqufi0%lkp@intel.com>
 <4e48dcb2-6e82-4bbe-3920-e1c5fd5c265a@infradead.org>
 <3908561D78D1C84285E8C5FCA982C28F7E91BABF@ORSMSX104.amr.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8b6fa47-d696-1aa1-4eb1-513de3c71e5a@infradead.org>
Date:   Fri, 3 May 2019 13:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7E91BABF@ORSMSX104.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 1:25 PM, Luck, Tony wrote:
>>> Exporting paddr_to_nid() in arch/ia64/mm/numa.c fixes all of these build errors.
>>> Is there a problem with doing that?
>>
>> I don't see a problem with exporting it.
> 
> But I also don't see these build errors.  I'm using the same HEAD commit. I think the
> same .config (derived from arch/ia64/configs/bigsur_defconfig.
> 
> Big difference is I'm doing a natinve build with a much older compiler (4.6.4)
> 
> -Tony
> 

I was able to reproduce the build errors.
using gcc 8.1.0 cross-compile.

-- 
~Randy
