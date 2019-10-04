Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973DC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7720873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PsIURk83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbfJDN4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:56:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45703 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388491AbfJDN4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:56:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id z67so5818430qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2Il7BaECJsWIskdenM7M97r0s/NvzNhUCufnwSYYzs=;
        b=PsIURk83Pa180b008RSqEfoYKXR+bbjKVuxA6hrfm8Px55/gcwWAsuAh+rpSU3nzTM
         gTkhzm7mpfggtQKmzS0fchLdmPd9ko8elm0j981km/uPdV5rYu4qMaPpqcEHyHOubyry
         qVMsCOrfNa6xshEdj6HHAw7g76Gu6MmBZAAXr1PJDzlrvc1eQVARTR4oNHg/rkw8uIeO
         LGxO8X5yCnWW7TsWXOEBuFqrarw7JwFiOVL2DaTcwrIIB3bLH+gbihRBQozv6MstIV2v
         Xl0EwxPaXKVY4iYAz3kON+MEnOlgSRLhmTZAfp3e/Gz6pflmiQCS519P0J6hjh9fHPFt
         3ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2Il7BaECJsWIskdenM7M97r0s/NvzNhUCufnwSYYzs=;
        b=lHePmG7ClFmxgD4AXXV6keeNHSzHOl4B59XuWKxUiZ6AkryloY108W4flRyGBZPR7p
         BNluiZf2aCRDEC8ybD1xCtycB0sYA4SIyfPOfMxvqHQ/bYbgviXEZs4b40kaNjSLGVRJ
         iY/oyk3KcW7JIt4vln7/HQkVuDV1Y+v1h6ih9v/IAhP5qkn+pvvRvZwPkHjKA0wC+ud3
         ovPuLF7mb/8agSdeUG6Jr/UmJKO2BkcU4+pZKJawdqZXUvzwD14Pw54uA9YBIy+LS6KD
         WOjQITNM8EMRZb2YcSBB8HwmWG6jVc6tDFFNl0BEQzFrx0eamg/nRzv2EFZxobwgPcPf
         cfTA==
X-Gm-Message-State: APjAAAXdLWj/5Viaj/2A96MHCq2GSDVVRC9v9nqGn3UnCrhLd/Jhikyu
        kFOfSuUG2dW131ClklVPYWt5tA==
X-Google-Smtp-Source: APXvYqwc0Uf5Q9FcSvf9BpaxQRxiq+AqV3wxA52T62RpEsO8jmlWiy80I4as4DxFRRoKJ92eJBCVhg==
X-Received: by 2002:a37:8cc6:: with SMTP id o189mr10362919qkd.82.1570197363305;
        Fri, 04 Oct 2019 06:56:03 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q64sm3453144qkb.32.2019.10.04.06.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:56:02 -0700 (PDT)
Message-ID: <1570197360.5576.275.camel@lca.pw>
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:56:00 -0400
In-Reply-To: <20191004133814.GM9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
         <20191004105824.GD9578@dhcp22.suse.cz>
         <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
         <1570193776.5576.270.camel@lca.pw> <20191004130713.GK9578@dhcp22.suse.cz>
         <1570195839.5576.273.camel@lca.pw> <20191004133814.GM9578@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 15:38 +0200, Michal Hocko wrote:
> On Fri 04-10-19 09:30:39, Qian Cai wrote:
> > On Fri, 2019-10-04 at 15:07 +0200, Michal Hocko wrote:
> > > On Fri 04-10-19 08:56:16, Qian Cai wrote:
> > > [...]
> > > > It might be a good time to rethink if it is really a good idea to dump_page()
> > > > at all inside has_unmovable_pages(). As it is right now, it is a a potential
> > > > deadlock between console vs memory offline. More details are in this thread,
> > > > 
> > > > https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/
> > > 
> > > Huh. That would imply we cannot do any printk from that path, no?
> > 
> > Yes, or use something like printk_deferred()
> 
> This is just insane. The hotplug code is in no way special wrt printk.
> It is never called from the printk code AFAIK and thus there is no real
> reason why this particular code should be any special. Not to mention
> it calls printk indirectly from a code that is shared with other code
> paths.

Basically, printk() while holding the zone_lock will be problematic as console
is doing the opposite as it always needs to allocate some memory. Then, it will
always find some way to form this chain,

console_lock -> * -> zone_lock.

> 
> > or it needs to rework of the current console locking which I have no
> > clue yet.
> 
> Yes, if the lockdep is really referring to a real deadlock which I
> haven't really explored.
> 
