Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D89C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E232171F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfDEBgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfDEBgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:36:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8037B3084023;
        Fri,  5 Apr 2019 01:36:53 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0755260A97;
        Fri,  5 Apr 2019 01:36:49 +0000 (UTC)
Date:   Fri, 5 Apr 2019 09:36:45 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190405013645.GA8865@dhcp-128-65.nay.redhat.com>
References: <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190402102529.GA21698@jeru.linux.bs1.fc.nec.co.jp>
 <20190404073233.GC5708@dhcp-128-65.nay.redhat.com>
 <20190404122425.GC22539@zn.tnic>
 <20190404141241.GB7789@dhcp-128-65.nay.redhat.com>
 <20190404144115.GE22539@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404144115.GE22539@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 05 Apr 2019 01:36:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/19 at 04:41pm, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 10:12:41PM +0800, Dave Young wrote:
> > The early code hang can make people confused, it is hard to
> > say what happens and not easy to debug.   But if we return 0 then kernel
> > just continue to boot, and fail later because of no acpi root pointer, at
> > least we can have some kernel boot log.
> 
> Is it clear from that boot log where we failed?

The early boot log in compress/*.c is not visible for kexec EFI boot so
the log is useless unless serial is usable.

the early putstr only works for legacy boot with some ioport outb()
callbacks unless serial is available.  For EFI boot it does not work,
and for kexec, it is even worse because 1st kernel booted with kms mode
setting, it is not like the firmware initialized video mode any more
when we run kexec reboot.
