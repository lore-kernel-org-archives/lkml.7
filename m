Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73593C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C6720665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502431AbfIWTtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502394AbfIWTtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 147E48980F5;
        Mon, 23 Sep 2019 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.11.216.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD911001B05;
        Mon, 23 Sep 2019 19:49:52 +0000 (UTC)
Message-ID: <d5d92540ca5aab8916ac4d93f6b5677ab52d2e7d.camel@redhat.com>
Subject: Re: ntp audit spew.
From:   Eric Paris <eparis@redhat.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-audit@redhat.com
Date:   Mon, 23 Sep 2019 15:49:52 -0400
In-Reply-To: <20190923194901.GA2787@codemonkey.org.uk>
References: <20190923155041.GA14807@codemonkey.org.uk>
         <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
         <20190923165806.GA21466@codemonkey.org.uk>
         <CAHC9VhTh+cD5pkb8JAHnG1wa9-UgivSb7+-yjjYaD+6vhyYKjA@mail.gmail.com>
         <20190923194901.GA2787@codemonkey.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.0 (3.34.0-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 23 Sep 2019 19:49:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this the thing where systemd is listening on the multicast netlink
socket and causes everything to come out kmesg as well?

On Mon, 2019-09-23 at 15:49 -0400, Dave Jones wrote:
> On Mon, Sep 23, 2019 at 02:57:08PM -0400, Paul Moore wrote:
>  > On Mon, Sep 23, 2019 at 12:58 PM Dave Jones <
> davej@codemonkey.org.uk> wrote:
>  > > On Mon, Sep 23, 2019 at 12:14:14PM -0400, Paul Moore wrote:
>  > >  > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <
> davej@codemonkey.org.uk> wrote:
>  > >  > >
>  > >  > > I have some hosts that are constantly spewing audit
> messages like so:
>  > >  > >
>  > >  > > [46897.591182] audit: type=1333 audit(1569250288.663:220):
> op=offset old=2543677901372 new=2980866217213
>  > >  > > [46897.591184] audit: type=1333 audit(1569250288.663:221):
> op=freq old=-2443166611284 new=-2436281764244
>  > >  > > [48850.604005] audit: type=1333 audit(1569252241.675:222):
> op=offset old=1850302393317 new=3190241577926
>  > >  > > [48850.604008] audit: type=1333 audit(1569252241.675:223):
> op=freq old=-2436281764244 new=-2413071187316
>  > >  > > [49926.567270] audit: type=1333 audit(1569253317.638:224):
> op=offset old=2453141035832 new=2372389610455
>  > >  > > [49926.567273] audit: type=1333 audit(1569253317.638:225):
> op=freq old=-2413071187316 new=-2403561671476
>  > >  > >
>  > >  > > This gets emitted every time ntp makes an adjustment, which
> is apparently very frequent on some hosts.
>  > >  > >
>  > >  > >
>  > >  > > Audit isn't even enabled on these machines.
>  > >  > >
>  > >  > > # auditctl -l
>  > >  > > No rules
>  > >  >
>  > >  > What happens when you run 'auditctl -a never,task'?  That
> *should*
>  > >  > silence those messages as the audit_ntp_log() function has
> the
>  > >  > requisite audit_dummy_context() check.
>  > >
>  > > They still get emitted.
>  > >
>  > >  > FWIW, this is the distro
>  > >  > default for many (most? all?) distros; for example, check
>  > >  > /etc/audit/audit.rules on a stock Fedora system.
>  > >
>  > > As these machines aren't using audit, they aren't running auditd
> either.
>  > > Essentially: nothing enables audit, but the kernel side
> continues to log
>  > > ntp regardless (no other audit messages seem to do this).
>  > 
>  > What does your kernel command line look like?  Do you have
> "audit=1"
>  > somewhere in there?
> 
> nope.
> 
> ro root=LABEL=/ biosdevname=0 net.ifnames=0 fsck.repair=yes
> systemd.gpt_auto=0 pcie_pme=nomsi ipv6.autoconf=0 erst_disable
> crashkernel=128M console=tty0 console=ttyS1,57600
> intel_iommu=tboot_noforce
> 
> 	Dave
> 

