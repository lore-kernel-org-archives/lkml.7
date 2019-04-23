Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47052C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4992177B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfDWKtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbfDWKtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 340FD81F0F;
        Tue, 23 Apr 2019 10:49:32 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-71.pek2.redhat.com [10.72.12.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7591B60142;
        Tue, 23 Apr 2019 10:49:28 +0000 (UTC)
Date:   Tue, 23 Apr 2019 18:49:24 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Kairui Song <kasong@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Message-ID: <20190423104924.GA1730@dhcp-128-65.nay.redhat.com>
References: <20190422092804.15534-1-kasong@redhat.com>
 <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 23 Apr 2019 10:49:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/23/19 at 06:20am, Junichi Nomura wrote:
> On 4/22/19 6:28 PM, Kairui Song wrote:
> > The reason is the systab region is not mapped by the identity mapping
> > provided by kexec. Currently kexec only create identity mapping for
> > mem regions, wihch won't cover the systab. So second kernel will be
> > accessing a not mapped memory region and cause fault.
> > But as kexec tend to pad the map region up to PUD size, the
> > systab could be included in the map by accident, so it worked on
> > some machines, but that will be broken easily and unstable.
> 
> Is the mapping of ACPI tables just by luck, too?

Hmm, guess it should be mapped by luck, here is the range on the T420: 
da99f000 - dae9efff Reserved (efi systab fall in this region)
daf9f000 - daffefff ACPI tables

Thanks
Dave
