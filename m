Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E2C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D35820675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 07:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbfDQHDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 03:03:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730813AbfDQHDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 03:03:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6599F3092647;
        Wed, 17 Apr 2019 07:03:05 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02EB16014E;
        Wed, 17 Apr 2019 07:02:59 +0000 (UTC)
Date:   Wed, 17 Apr 2019 15:02:50 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190417070250.GD8411@dhcp-128-65.nay.redhat.com>
References: <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
 <20190415090717.GA29317@zn.tnic>
 <20190415102525.GB29317@zn.tnic>
 <23309b73-d135-a207-564b-6003cee39184@ce.jp.nec.com>
 <20190416094024.GE27892@zn.tnic>
 <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34d02ae0-7182-2983-b601-acbdb4085f33@ce.jp.nec.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Apr 2019 07:03:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/19 at 10:44pm, Junichi Nomura wrote:
> On 4/16/19 6:40 PM, Borislav Petkov wrote:
> > On Mon, Apr 15, 2019 at 11:00:25PM +0000, Junichi Nomura wrote:
> >> I thought we should hang here instead of return so that we
> >> don't run into efi_get_rsdp_addr() in case of kexec.
> > 
> > Hanging that early without debug output is not very friendly to
> > debuggers, methinks.
> 
> Right. But if we could move get_rsdp_addr() after console_init(),
> you get debug output.
> 

move it after console_init looks better, I finally setup IME as a serial
console, I can see debug msg even for kexec reboot now.

How about move it after console_init, and at the same time skip
efi_get_rsdp_addr in case kexec?

Thanks
Dave
