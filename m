Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C73C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A8D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfGOTqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:46:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48688 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOTqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:46:37 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn6vj-0005QV-5x; Mon, 15 Jul 2019 21:46:35 +0200
Date:   Mon, 15 Jul 2019 21:46:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>
cc:     Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop
 targets
In-Reply-To: <20190715193938.GG32439@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1907152146010.1767@nanos.tec.linutronix.de>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com> <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de> <20190715193938.GG32439@tassilo.jf.intel.com>
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

On Mon, 15 Jul 2019, Andi Kleen wrote:

> > Right, we don't know where the PAT invocation comes from and whether they
> > are safe to omit flushing the cache. The module load code would be one
> > obvious candidate.
> 
> Module load just changes the writable/executable status, right? That shouldn't
> need to flush in any case because it doesn't change the caching attributes.

Ah right. We don't flush when the caching attributes are not changed.

Thanks,

	tglx
