Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C6C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE8320B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfHAAl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:41:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33438 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfHAAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:41:27 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsz9l-0001ln-Kn; Thu, 01 Aug 2019 02:41:21 +0200
Date:   Thu, 1 Aug 2019 02:41:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RFC 1/2] futex: Split key setup from key queue locking
 and read
In-Reply-To: <85sgql7nok.fsf@collabora.com>
Message-ID: <alpine.DEB.2.21.1908010240260.1788@nanos.tec.linutronix.de>
References: <20190730220602.28781-1-krisman@collabora.com> <alpine.DEB.2.21.1908010131200.1788@nanos.tec.linutronix.de> <85sgql7nok.fsf@collabora.com>
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

On Wed, 31 Jul 2019, Gabriel Krisman Bertazi wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Tue, 30 Jul 2019, Gabriel Krisman Bertazi wrote:
> >
> >> split the futex key setup from the queue locking and key reading.  This
> >> is useful to support the setup of multiple keys at the same time, like
> >> what is done in futex_requeue() and what will be done for the
> >
> > What has this to do with futex_requeue()? Absolutely nothing unleass you
> > can reused that code there, which I doubt.
> 
> futex_requeue is another place where more than one key is setup at a
> time.  Just that.  I think it could be reused there, but this change is
> out of scope for this patch.

No it can't. And if it could, then it would be definitely in scope of this
patch set to reuse functionality.

Thanks,

	tglx
