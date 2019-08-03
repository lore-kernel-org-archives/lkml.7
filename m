Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF5DC433FF
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2D21726
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbfHCHnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:43:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfHCHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:43:05 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1htogw-0001hY-Kp; Sat, 03 Aug 2019 09:43:02 +0200
Date:   Sat, 3 Aug 2019 09:43:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
cc:     Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        kimbrownkd <kimbrownkd@gmail.com>
Subject: Re: [PATCH 1/1] genirq: Properly pair kobject_del with kobject_add
In-Reply-To: <20190803071555.GB24757@kroah.com>
Message-ID: <alpine.DEB.2.21.1908030942180.4029@nanos.tec.linutronix.de>
References: <1564703564-4116-1-git-send-email-mikelley@microsoft.com> <20190802063423.GA12360@kroah.com> <MWHPR21MB078463AB854A336842118405D7D90@MWHPR21MB0784.namprd21.prod.outlook.com> <20190803071555.GB24757@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Aug 2019, gregkh@linuxfoundation.org wrote:
> On Fri, Aug 02, 2019 at 08:19:37PM +0000, Michael Kelley wrote:
> > > Relying on irq_kobj_base to be present or not seems like an odd test
> > > here.
> > > 
> > 
> > It's the same test that is used in irq_sysfs_add to decide whether to
> > call kobject_add.  So it makes everything paired up and symmetrical.
> 
> Ugh, that's a tangled mess and totally not obvious at all.  I'm sure
> there's a good reason for all of that, and I really don't want to know
> :)

It's all your fault that the sysfs stuff does not work in very early boot.

/me runs
