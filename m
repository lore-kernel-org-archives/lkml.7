Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D9CC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF1A72077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDZKQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbfDZKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:16:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C4D23082B4D;
        Fri, 26 Apr 2019 10:16:41 +0000 (UTC)
Received: from localhost (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9360E600C7;
        Fri, 26 Apr 2019 10:16:38 +0000 (UTC)
Date:   Fri, 26 Apr 2019 18:16:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>, dyoung@redhat.com,
        Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190426101635.GQ3584@localhost.localdomain>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
 <20190419113621.GD10324@zn.tnic>
 <20190422143346.GD3584@localhost.localdomain>
 <20190422151723.GD21457@zn.tnic>
 <20190426095134.GP3584@localhost.localdomain>
 <20190426095800.GB4608@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426095800.GB4608@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 26 Apr 2019 10:16:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/19 at 11:58am, Borislav Petkov wrote:
> On Fri, Apr 26, 2019 at 05:51:34PM +0800, Baoquan He wrote:
> > I can make a patch to add a bit into xloadflags, to indicate that this
> > is kexec-ed kernel. It can help to differentiate kexec-ed kernel from
> > kdump kernel.
> 
> From the recent snafu, the only thing we needed is to differentiate
> between the *first* kernel and the following kernel(s) which has been
> started/loaded using a kexec syscall.

OK. To make sure I got it, the loader type 0xD is enough for this, right? 

It's fine to me, we can add it later if needed. I remember there's an
issue in intel/amd iommu, in which we need differentiate between
kexec/kdump kernel, but not very sure. I will check it when I have time
to work on that.

Thanks
Baoquan


