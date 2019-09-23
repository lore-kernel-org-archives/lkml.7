Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABCAC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A4F20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502155AbfIWQ6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:58:09 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:49212 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390958AbfIWQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:58:09 -0400
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1iCRf5-0003Pz-D9; Mon, 23 Sep 2019 12:58:07 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 01610560162; Mon, 23 Sep 2019 12:58:06 -0400 (EDT)
Date:   Mon, 23 Sep 2019 12:58:06 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Subject: Re: ntp audit spew.
Message-ID: <20190923165806.GA21466@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
References: <20190923155041.GA14807@codemonkey.org.uk>
 <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 12:14:14PM -0400, Paul Moore wrote:
 > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
 > >
 > > I have some hosts that are constantly spewing audit messages like so:
 > >
 > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
 > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
 > > [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
 > > [48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
 > > [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
 > > [49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
 > >
 > > This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.
 > >
 > >
 > > Audit isn't even enabled on these machines.
 > >
 > > # auditctl -l
 > > No rules
 > 
 > What happens when you run 'auditctl -a never,task'?  That *should*
 > silence those messages as the audit_ntp_log() function has the
 > requisite audit_dummy_context() check.

They still get emitted.

 > FWIW, this is the distro
 > default for many (most? all?) distros; for example, check
 > /etc/audit/audit.rules on a stock Fedora system.

As these machines aren't using audit, they aren't running auditd either.
Essentially: nothing enables audit, but the kernel side continues to log
ntp regardless (no other audit messages seem to do this).

	Dave

