Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA5CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C633421874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfCUR2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfCUR2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:28:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 582FE308213A;
        Thu, 21 Mar 2019 17:28:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6E4A05D71C;
        Thu, 21 Mar 2019 17:28:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Mar 2019 18:28:37 +0100 (CET)
Date:   Thu, 21 Mar 2019 18:28:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190321172833.GB12297@redhat.com>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
 <20190320132410.GB21673@redhat.com>
 <20190320132936.GB8696@dhcp22.suse.cz>
 <20190320150053.GD21673@redhat.com>
 <20190320151242.GC8696@dhcp22.suse.cz>
 <20190320173041.GE21673@redhat.com>
 <20190320194512.GD8696@dhcp22.suse.cz>
 <20190320203216.GF8696@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320203216.GF8696@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 21 Mar 2019 17:28:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Michal Hocko wrote:
>
> So we need
> freezable_schedule_unsafe unsafe here to workaround the original problem
> and do not trigger the warning.

Yes, but note the comment above freezable_schedule_unsafe() ;)

that is why I didn't even try to suggest to use _unsafe() instead of reverting.

And to remind, until we solve the problem with cred_guard_mutex the freezer
can fail anyway although much less likely.

Oleg.

