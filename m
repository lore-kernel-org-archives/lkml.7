Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49747C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188FA213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCTNYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:24:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfCTNYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 660E630842CF;
        Wed, 20 Mar 2019 13:24:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id E696517F8D;
        Wed, 20 Mar 2019 13:24:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 20 Mar 2019 14:24:14 +0100 (CET)
Date:   Wed, 20 Mar 2019 14:24:11 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     syzbot <syzbot+b70f2aabc707c69c9239@syzkaller.appspotmail.com>,
        chanho.min@lge.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        rafael.j.wysocki@intel.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: WARNING: syz-executor still has locks held!
Message-ID: <20190320132410.GB21673@redhat.com>
References: <0000000000000e4a41057b6c9792@google.com>
 <0000000000004cdec6058485b2ce@google.com>
 <20190320131655.GA8696@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320131655.GA8696@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 20 Mar 2019 13:24:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20, Michal Hocko wrote:
>
> Yes we do hold the cgred mutex while calling freezable_schedule but why
> are we getting a warning is not really clear to me. The task should be
> hidden from the freezer so why do we warn at all?

try_to_freeze() calls debug_check_no_locks_held() and this makes sense.

Another task can sleep waiting for the same lock; in this case
try_to_freeze_tasks() will fail but it won't blame the lock holder exactly
because it is "hidden from the freezer".

Oleg.

