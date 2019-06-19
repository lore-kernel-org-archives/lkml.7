Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9828C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887152084E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfFSRJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:09:42 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSRJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:09:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hde5c-00072w-7A; Wed, 19 Jun 2019 17:09:40 +0000
Date:   Wed, 19 Jun 2019 18:09:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190619170940.GG17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
 <bf2b3aa6-bda1-43f1-9a01-e4ad3df81c0b@gmail.com>
 <20190619162802.GF17978@ZenIV.linux.org.uk>
 <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc774f6b-711e-4a20-ad85-c282f9761392@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 06:51:51PM +0200, Vicente Bergas wrote:

> > What's your config, BTW?  SMP and DEBUG_SPINLOCK, specifically...
> 
> Hi Al,
> here it is:
> https://paste.debian.net/1088517

Aha...  So LIST_BL_LOCKMASK is 1 there (same as on distro builds)...

Hell knows - how about
static inline void hlist_bl_lock(struct hlist_bl_head *b)
{
	BUG_ON(((u32)READ_ONCE(*b)&~LIST_BL_LOCKMASK) == 0x01000000);
        bit_spin_lock(0, (unsigned long *)b);
}

and

static inline void hlist_bl_unlock(struct hlist_bl_head *b)
{
        __bit_spin_unlock(0, (unsigned long *)b);
	BUG_ON(((u32)READ_ONCE(*b)&~LIST_BL_LOCKMASK) == 0x01000000);
}

to see if we can narrow down where that happens?
