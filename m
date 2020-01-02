Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129DAC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC292072C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgABSYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:24:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgABSYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:24:48 -0500
Received: from [172.58.107.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1in59J-0000wJ-Ex; Thu, 02 Jan 2020 18:24:46 +0000
Date:   Thu, 2 Jan 2020 19:24:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amanieu d'Antras <amanieu@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        stable@vger.kernel.org
Subject: Re: [PATCH 7/7] clone3: ensure copy_thread_tls is implemented
Message-ID: <20200102182439.kzqabfuadph5cvaf@wittgenstein>
References: <20200102172413.654385-1-amanieu@gmail.com>
 <20200102172413.654385-8-amanieu@gmail.com>
 <20200102180901.tgtl7wxtq434h5ny@wittgenstein>
 <CA+y5pbT8yhDEjHnZvGcKM3=H2a+hjY0QOQZOu=YjnvPOJC00Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+y5pbT8yhDEjHnZvGcKM3=H2a+hjY0QOQZOu=YjnvPOJC00Gg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 07:19:11PM +0100, Amanieu d'Antras wrote:
> On Thu, Jan 2, 2020 at 7:09 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > I'm in favor of this change. But we need to make sure that any arch
> > which now has ARCH_WANTS_SYS_CLONE3 set but doesn't implement
> > copy_thread_tls() is fixed.
> >
> > Once all architectures have clone3() support - and there are
> > just a few by now (IA64 comes to mind) this means we should also be able
> > to get rid of of copy_thread() completely. That seems desirable to me as
> > it makes the codepaths easier to follow.
> 
> I've already implemented copy_thread_tls for all arches that currently
> have ARCH_WANTS_SYS_CLONE3 in the previous 5 patches. The #error is
> there so that any future arches that wire up clone3 don't forget to
> implement copy_thread_tls as well.

Right, my point is: Once _all_ arches have ARCH_WANT_SYS_CLONE3 they
also must implement copy_thread_tls at which point we can remove:
- ARCH_WANT_SYS_CLONE3 ifdefines
- copy_thread()
We can't do this right now because e.g. IA64 does not set
ARCH_WANT_SYS_CLONE3 and also does not select HAVE_COPY_THREAD_TLS.

Christian
