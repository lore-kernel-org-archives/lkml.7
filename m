Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19DCC32754
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE412070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfHFPeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:34:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55838 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728156AbfHFPeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:34:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDDA3AFBD;
        Tue,  6 Aug 2019 15:34:20 +0000 (UTC)
Message-ID: <1565105624.8136.32.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Date:   Tue, 06 Aug 2019 17:33:44 +0200
In-Reply-To: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1908061009450.1571-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 06.08.2019, 10:19 -0400 schrieb Alan Stern:
> In any case, I don't know if this missing "get" would cause the 
> problem, but it might well.

Hi,

upon further thought, this should be automated. Checking for
refcount leaks is KASAN's job. In particular, refcounts
should not

* decrease in probe()
* increase in disconnect()
* change in case probe() fails

	Regards
		Oliver

