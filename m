Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3764CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A08F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfDSSxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbfDSSxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:53:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52F4830917F0;
        Fri, 19 Apr 2019 11:44:27 +0000 (UTC)
Received: from localhost (ovpn-12-186.pek2.redhat.com [10.72.12.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE3A5D70D;
        Fri, 19 Apr 2019 11:44:24 +0000 (UTC)
Date:   Fri, 19 Apr 2019 19:44:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kairui Song <kasong@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419114421.GH11060@MiWiFi-R3L-srv>
References: <20190419101733.GA10324@zn.tnic>
 <20190419105014.GE11060@MiWiFi-R3L-srv>
 <20190419112801.GB10324@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419112801.GB10324@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 19 Apr 2019 11:44:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/19 at 01:28pm, Borislav Petkov wrote:
> Why does that "seem" so?
> 
> Read again what I said: "should all be passed through boot_params".
> Which means, boot_params should be extended with a field of a flag to
> say: "this is a kexec'ed kernel".
> 
> If it "seems" then it should be made to not "seem" but to work properly.

No objection to extending with fields of a flag to mark kexec'ed kernel.
Or kdump kernel either. We now check kdump kernel by /proc/vmcore.

> 
> > Yeah, adding the systab mapping looks good. Kairui put it in
> > decompressing stage just because he wants to cover the case in which the
> > old kernel kexec jumping to 2nd kernel. Now it seems not very
> > reasonable, we also have the new kernel kexec jumping to old 2nd kernel.
> 
> I don't think we can guarantee kexec between old<->new kernel to always
> work. Otherwise, we can forget all development and improvements of new
> kernel.

I personally agree with this. Very earlier, we tried to remove the
896 MB limitation of crashkernel=xM, to extend it to 4G or the whole
RAM, but rejcted by linus since he worried it could break the old kernel
kdumping. I may not remember well.
