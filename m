Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E83C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFADE21707
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfGALQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:16:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:50618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728081AbfGALQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:16:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80A00ACEF;
        Mon,  1 Jul 2019 11:16:18 +0000 (UTC)
Message-ID: <1561978947.10014.12.camel@suse.com>
Subject: Re: [RFC] deadlock with flush_work() in UAS
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Tejun Heo <tj@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Mon, 01 Jul 2019 13:02:27 +0200
In-Reply-To: <Pine.LNX.4.44L0.1906261036550.1550-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1906261036550.1550-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 26.06.2019, 10:38 -0400 schrieb Alan Stern:
> On Wed, 26 Jun 2019, Oliver Neukum wrote:
> 
> > Am Montag, den 24.06.2019, 10:22 -0400 schrieb Alan Stern:
> > > But that pattern makes no sense; a driver would never use it.  The 
> > > driver would just do the reset itself.
> > 
> > Correct. But UAS and storage themselves still need to use
> > WQ_MEM_RECLAIM for their workqueues, don't they?
> 
> Perhaps so for uas.  usb-storage uses a work queue only for scanning 
> targets, which doesn't interfere with the block I/O pathway.

Are you sure? What about hub_tt_work? As far as I can tell, hub_quiesce
will flush it, hence it is used in error handling.

	Regards
		Oliver

