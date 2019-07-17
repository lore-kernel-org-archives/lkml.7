Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEFEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ACC21851
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563400718;
	bh=AVPhuQRO0imI6YrRXaqcsADJ5D+m0LchIU7hp9OgbjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2XVXpwLgWSEW4J7jEcK7EGJ6TYqWGI3OtNlMIEjd849zc367E2R61q+N42sIFhmSb
	 TIKghR+G+vW18T16mAWgt7YDRQVPqNSQRrn2O99nmzJMe/ZH66cw5FFGXfTULaw/1c
	 V4S1zPrXa+UeyGMdxRWUR6wJFtoanBnvtx/2EhxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfGQV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGQV6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:58:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1530121849;
        Wed, 17 Jul 2019 21:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563400715;
        bh=AVPhuQRO0imI6YrRXaqcsADJ5D+m0LchIU7hp9OgbjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1fdC9jpgdyHwO7OXjIber/c3MPrHN9zcddL/xG+2Je6BtgqOnBCfIhwCHrhabudU+
         U3uBHdRGGGc2+F+eTCnoXGMDoxckOzaMY/2F/jju5l+mnAlye3jwU26j8DsQ2+C0ps
         vJ72kl6qTS/E0vA2fJhA7zhh6yW4tDBzFWF9gU6c=
Date:   Wed, 17 Jul 2019 14:58:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, broonie@kernel.org,
        mhocko@suse.cz, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-07-16-17-14 uploaded
Message-Id: <20190717145834.1cb98d9987a63602a441f136@linux-foundation.org>
In-Reply-To: <a1179bac-204d-110e-327f-845e9b09a7ab@infradead.org>
References: <20190717001534.83sL1%akpm@linux-foundation.org>
        <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
        <20190717143830.7f7c3097@canb.auug.org.au>
        <a9d0f937-ef61-1d25-f539-96a20b7f8037@infradead.org>
        <072ca048-493c-a079-f931-17517663bc09@infradead.org>
        <20190717180424.320fecea@canb.auug.org.au>
        <a1179bac-204d-110e-327f-845e9b09a7ab@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 07:55:57 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> On 7/17/19 1:04 AM, Stephen Rothwell wrote:
> > Hi Randy,
> > 
> > On Tue, 16 Jul 2019 23:21:48 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> drivers/dma-buf/dma-buf.c:
> >> <<<<<<< HEAD
> >> =======
> >> #include <linux/pseudo_fs.h>
> >>>>>>>>> linux-next/akpm-base  
> > 
> > I can't imagine what went wrong, but you can stop now :-)
> > 
> > $ grep '<<< HEAD' linux-next.patch | wc -l
> > 1473
> 
> Yes, I did the grep also, decided to give up.

I forgot to fix all those :(

iirc they're usually caused by people merging a patch into mainline
which differs from the version they had in -next.

