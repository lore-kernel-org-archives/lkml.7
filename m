Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D7CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F7720C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407518AbfHISW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:22:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHISW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:22:26 -0400
Received: from 96-95-199-68-static.hfc.comcastbusiness.net ([96.95.199.68] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hw9Wv-0004GP-Ca; Fri, 09 Aug 2019 18:22:21 +0000
Date:   Fri, 9 Aug 2019 20:22:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/2] binder: Add default binder devices through
 binderfs when configured
Message-ID: <20190809182216.5xzx6tss6fh42mso@wittgenstein>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-2-hridya@google.com>
 <20190809145016.GB16262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809145016.GB16262@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 04:50:16PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 08, 2019 at 03:27:25PM -0700, Hridya Valsaraju wrote:
> > Currently, since each binderfs instance needs its own
> > private binder devices, every time a binderfs instance is
> > mounted, all the default binder devices need to be created
> > via the BINDER_CTL_ADD IOCTL.
> 
> Wasn't that a design goal of binderfs?

Sure, but if you solely rely binderfs to be used to provide binder
devices having them pre-created on each mount makes quite some sense,
imho.

> 
> > This patch aims to
> > add a solution to automatically create the default binder
> > devices for each binderfs instance that gets mounted.
> > To achieve this goal, when CONFIG_ANDROID_BINDERFS is set,
> > the default binder devices specified by CONFIG_ANDROID_BINDER_DEVICES
> > are created in each binderfs instance instead of global devices
> > being created by the binder driver.
> 
> This is going to change how things work today, what is going to break
> because of this change?
> 
> I don't object to this, except for the worry of changing the default
> behavior.

This is something that Hridya and Todd can speak better to given that
they suggested this change. :)
From my perspective, binderfs binder devices and the regular binder
driver are mostly used mutually exclusive in practice atm so that this
change has little chance of breaking anyone.

Now I really need to go back to vacation time - which I suck at
apparently. :)

Christian
