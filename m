Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD7AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787C820663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFZI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:29:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEB32D7809;
        Wed, 26 Jun 2019 08:29:12 +0000 (UTC)
Received: from localhost (ovpn-12-135.pek2.redhat.com [10.72.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D7FA60BE5;
        Wed, 26 Jun 2019 08:29:09 +0000 (UTC)
Date:   Wed, 26 Jun 2019 16:29:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     airlied@redhat.com
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, dyoung@redhat.com
Subject: Re: mgag200 fails kdump kernel booting
Message-ID: <20190626082907.GY24419@MiWiFi-R3L-srv>
References: <20190626081522.GX24419@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626081522.GX24419@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 26 Jun 2019 08:29:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/19 at 04:15pm, Baoquan He wrote:
> Hi Dave,
> 
> We met an kdump kernel boot failure on a lenovo system. Kdump kernel
> failed to boot, but just reset to firmware to reboot system. And nothing
> is printed out.
> 
> The machine is a big server, with 6T memory and many cpu, its graphic
> driver module is mgag200.
> 
> When added 'earlyprintk=ttyS0' into kernel command line, it printed
> out only one line to console during kdump kernel booting:
>      KASLR disabled: 'nokaslr' on cmdline.
> 
> Then reset to firmware to reboot system.
> 
> By further code debugging, the failure happened in
> arch/x86/boot/compressed/misc.c, during kernel decompressing stage. It's
> triggered by the vga printing. As you can see, in __putstr() of
> arch/x86/boot/compressed/misc.c, the code checks if earlyprintk= is
> specified, and print out to the target. And no matter if earlyprintk= is
> added or not, it will print to VGA. And printing to VGA caused it to
> reset to firmware. That's why we see nothing when didn't specify
> earlyprintk=, but see only one line of printing about the 'KASLR
> disabled'.

Here I mean:
That's why we see nothing when didn't specify earlyprintk=, but see only
one line of printing about the 'KASLR disabled' message when
earlyprintk=ttyS0 added.

> 
> To confirm it's caused by VGA printing, I blacklist the mgag200 by
> writting it into /etc/modprobe.d/blacklist.conf. The kdump kernel can
> boot up successfully. And add 'nomodeset' can also make it work. So it's
> for sure mgag driver or related code have something wrong when booting
> code tries to re-init it.
> 
> This is the only case we ever see, tend to pursuit fix in mgag200 driver
> side. Any idea or suggestion? We have two machines to be able to
> reproduce it stablly.
> 
> Thanks
> Baoquan
