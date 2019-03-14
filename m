Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF2AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE5921019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfCNMiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:38:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbfCNMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:38:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5E28AEFE;
        Thu, 14 Mar 2019 12:38:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C014F1E3FE8; Thu, 14 Mar 2019 13:38:11 +0100 (CET)
Date:   Thu, 14 Mar 2019 13:38:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, kbuild-all@01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro
 'pr_warn_ratelimited'
Message-ID: <20190314123811.GH16658@quack2.suse.cz>
References: <201903140234.4FpTWdW3%lkp@intel.com>
 <20190314083758.GA16658@quack2.suse.cz>
 <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-03-19 14:01:18, Amir Goldstein wrote:
> On Thu, Mar 14, 2019 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
> >
> > AFAICS this is the known problem with weird mips definitions of
> > __kernel_fsid_t which uses long whereas all other architectures use int,
> > right? Seeing that mips can actually have 8-byte longs, I guess this
> > bogosity is just wired in the kernel API and we cannot easily fix it in
> > mips (mips guys, correct me if I'm wrong). So what if we just
> > unconditionally typed printed values to unsigned int to silence the
> > warning?
> 
> I don't understand why. To me that sounds like papering over a bug.
> 
> See this reply from mips developer Paul Burton:
> https://marc.info/?l=linux-fsdevel&m=154783680019904&w=2
> mips developers have not replied to the question why __kernel_fsid_t
> should use long.

Ah, right. I've missed that mips defines __kernel_fsid_t only if
sizeof(long) == 4. OK, than fixing MIPS headers is definitely what we ought
to do. Mips guys, any reason why the patch from Ralf didn't get merged yet?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
