Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37504C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C3820872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574281868;
	bh=ZAsD94r5JDGs9DmQJh/W8WRcSASA5q7vIIXbKGEe0lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W/wlCkZ6Ws21RvM4u3116KRhV3faPkeIfDoP8aPc83mOwn59hAeBHvKaKjWIKr66W
	 SeJCPigS5wLdDTUeKIgN+No8MfF2ZjTSNSC5KCBTbSo3036V/3+WAi9nfcIcgKJKkE
	 krOOd29cScWWRq7j6DzQsQ/vWrDjpk8JANxfGwLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKTUbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfKTUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:31:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3057B2075E;
        Wed, 20 Nov 2019 20:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574281862;
        bh=ZAsD94r5JDGs9DmQJh/W8WRcSASA5q7vIIXbKGEe0lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mx4EUAuwL6jDFV1VYKbYUS+OG4hYLZIe3/ZLXdbc04gtf/GY3QVknsNM444T3atsM
         w7pj3GssEFwHP6NoecFM3TFk+NUD5V7soS+ddUSHhyDxQ3V26q+mVpRS8KUpDr2IP+
         ghrdFGrHWsCILfgseb5fdvClDlKtbHxZfSF3V9Ng=
Date:   Wed, 20 Nov 2019 21:31:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v3 01/13] exfat: add in-memory and on-disk structures and
 headers
Message-ID: <20191120203100.GA3109949@kroah.com>
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094020epcas1p26de9d7e4e2ab8ad5d6ecaf23e2dfdca8@epcas1p2.samsung.com>
 <20191119093718.3501-2-namjae.jeon@samsung.com>
 <30222888-e62e-494e-269e-cb1a0746a01f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30222888-e62e-494e-269e-cb1a0746a01f@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:21:13PM +0100, Markus Elfring wrote:
> …
> > +++ b/fs/exfat/exfat_fs.h
> …
> > +/* balloc.c */
> > +int exfat_load_bitmap(struct super_block *sb);
> …
> 
> Such function declarations were grouped according to the mentioned
> source file.
> How do you think about to include them from separate header files
> for the desired programming interface?

No.
