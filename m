Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5CFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293B21883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567631051;
	bh=CyG9oIoncMJdPIfESE/MwEc9Pop3vT18khg6HuUgdU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=loxOINpLc4IT3qBAe3CEWXsLn3zh616wiEB9Ug6KFjIaS7wscNO4771WJ7awFmSEL
	 WBK+YS6qjL81Y3msetMiwr3MX+wWXBYWX2oGCGciuIypDzIo1mlrGdozkbWO4sxtxa
	 82KceMoVe2FrSGUcVwhNi5em1hQ2K5Y7q5dOwNjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfIDVEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:04:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33137 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:04:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id p23so22150835oto.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyG9oIoncMJdPIfESE/MwEc9Pop3vT18khg6HuUgdU4=;
        b=WbzaV9ot54E5yUV/nsJfU5IY6NHqUq7LLT4tI+nzs6a6PTcn23KwDySUvTHygecwnG
         mVVa2kDrSsfakSJEX5oUsUmZHZiskaO2K4QGxi0iGD3sW5K0vsTXXwe8DCir5rOlw55i
         FR0+abu4TaGsW7DY0ebPR9KhPqwmax7sxuweS3MM+4n7p+sJIhWgpx/zo/iZaX9HkKE5
         tBNEZBGJ5lQzpAUrXMRLQR5SGU4JXeAsqF96sraELZIUDi2Rc1H8/V7UcS+Jmv9zjLBl
         aprno+WaoaGf2U4FtzarLL8NW8+DH7H5PHR5rixzpNQ861YSfawHkCbiS1rjt7ngKcm6
         G+gg==
X-Gm-Message-State: APjAAAW5YsfePCXGn+3u/lhYB3AGuMAjrA0QKLtD8FLKiJ5kbPDubAc2
        dmKZaiAQtVh+kqTZKXEV07zm3CATwG7FQHFs5Dw=
X-Google-Smtp-Source: APXvYqyBMGW2epdCXylWthRx1+uM0fTlfSYq43Wm7TdlLx1yia7XV6qhCnZ4LrBFX3sXoy1P05M3+B8rf2pIKTypuWQ=
X-Received: by 2002:a05:6830:154:: with SMTP id j20mr337999otp.266.1567631049639;
 Wed, 04 Sep 2019 14:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190830075156.76873-1-heikki.krogerus@linux.intel.com>
 <20190830075156.76873-2-heikki.krogerus@linux.intel.com> <20190904120725.GA15829@kroah.com>
In-Reply-To: <20190904120725.GA15829@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Sep 2019 23:03:58 +0200
Message-ID: <CAJZ5v0gOnU60OEUex5mSR4=jeHowfY77HSCE8LmsLiiuU59j3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] software node: Initialize the return value in software_node_to_swnode()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 2:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 30, 2019 at 10:51:55AM +0300, Heikki Krogerus wrote:
> > The software node is searched from a list that may be empty
> > when the function is called. This makes sure that the
> > function returns NULL even if the list is empty.
> >
> > Fixes: 80488a6b1d3c ("software node: Add support for static node descriptors")
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks!
