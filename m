Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567B6C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E63C20C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565362220;
	bh=H+aFC41WTfEHyca84kgJ4nvuBia6TgTyEiDk56wKsU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CSW8pJaO6KIVN1ZYwZZSOW4wzybgK8UMWg0F9Fu7odMHQ0/OD16sD3y+Ol/Yv6jjv
	 sUY1jIL5iIbkVAVJTbSMu6J593natYDD1DQGB3hAlAJAxNWuwkaIilYqXQVOACF8Eo
	 rkptTSn2YkFyjd5uHCP6fhNCJnN+Zyzjzb9zYTz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436509AbfHIOuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfHIOuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:50:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E26FB208C4;
        Fri,  9 Aug 2019 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565362218;
        bh=H+aFC41WTfEHyca84kgJ4nvuBia6TgTyEiDk56wKsU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4/m0hTsTJk8ReJo5wAny4/PaHO0Tgr/AsaXR8Cn8fdCDgphvClRMi0xcs01bMFH2
         9TzKWigr+rv0if6J+O07TTne/KD2u8wfZnVYFhRSnKhnuMywKX6nF85KcRfYMq0Ih5
         4teuj5j+vkCom4J6Ovbm7ZheHtQqUFXC8A4Siw74=
Date:   Fri, 9 Aug 2019 16:50:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v3 1/2] binder: Add default binder devices through
 binderfs when configured
Message-ID: <20190809145016.GB16262@kroah.com>
References: <20190808222727.132744-1-hridya@google.com>
 <20190808222727.132744-2-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808222727.132744-2-hridya@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 03:27:25PM -0700, Hridya Valsaraju wrote:
> Currently, since each binderfs instance needs its own
> private binder devices, every time a binderfs instance is
> mounted, all the default binder devices need to be created
> via the BINDER_CTL_ADD IOCTL.

Wasn't that a design goal of binderfs?

> This patch aims to
> add a solution to automatically create the default binder
> devices for each binderfs instance that gets mounted.
> To achieve this goal, when CONFIG_ANDROID_BINDERFS is set,
> the default binder devices specified by CONFIG_ANDROID_BINDER_DEVICES
> are created in each binderfs instance instead of global devices
> being created by the binder driver.

This is going to change how things work today, what is going to break
because of this change?

I don't object to this, except for the worry of changing the default
behavior.

thanks,

greg k-h
