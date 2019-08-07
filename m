Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86B4C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E3821E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565176203;
	bh=Vq2npu9qMy3ZqaCzN2MnrJysGD5g2Rtrj7n/5e5Lct8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GyktvbNkEhcb2Ef0S1N6q1/IH00K96lUeNe+ioynv3V12bDszMRe52zXaSH9pUwPj
	 K+wFxYyxWtVKzag1l6c+XtYJ5bl5aPhAYW0NsrKLSLxjgUakOxyrI73kg/8GqUU8+4
	 O7iVMYFyn4trH3yqrzGKytp54zBp9p/CAotuYrdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfHGLKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 07:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfHGLKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 07:10:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9FB21922;
        Wed,  7 Aug 2019 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565176201;
        bh=Vq2npu9qMy3ZqaCzN2MnrJysGD5g2Rtrj7n/5e5Lct8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUv84g6rvSfIfVN4nmM8/Fn817fqIm/npqcHrA8tLuIqk56sKKIUUkcBCFhZg7bqa
         d8+RSFhPZZVIqfyVE+yzZ7H9RC8cNxaUdYTKrolgrSUkfXYEkwLUBapWLe5iDXW9YQ
         s43IIo0ktgn5/Xq6JYRRklrWpVZld9z8yu+Q1bxk=
Date:   Wed, 7 Aug 2019 13:09:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tri Vo <trong@android.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org, rafael@kernel.org,
        hridya@google.com, sspatil@google.com, kaleshsingh@google.com,
        ravisadineni@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 1/3] PM / wakeup: Drop wakeup_source_init(),
 wakeup_source_prepare()
Message-ID: <20190807110959.GA16863@kroah.com>
References: <20190807014846.143949-1-trong@android.com>
 <20190807014846.143949-2-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807014846.143949-2-trong@android.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:48:44PM -0700, Tri Vo wrote:
> wakeup_source_init() has no users. Remove it.
> 
> As a result, wakeup_source_prepare() is only called from
> wakeup_source_create(). Merge wakeup_source_prepare() into
> wakeup_source_create() and remove it.
> 
> Change wakeup_source_create() behavior so that assigning NULL to wakeup
> source's name throws an error.

The kernel C code can not "throw" errors :)

Anyway, odd verbage asside, patch looks good to me:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

