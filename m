Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313EC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBE922543
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWKLpCtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387887AbfGWPmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:42:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42737 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGWPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:42:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so19332569pff.9;
        Tue, 23 Jul 2019 08:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vz8JNCA4OobQyySEBzgksJpFgS03gb8qvM7PnvvkojA=;
        b=MWKLpCtrmhGhopCnWcb2JpEpHsIvTkM+31gp8BTwUJSVNVWEggfWga2+LGywZMi/7a
         GJCPj3k7SQxDgPQo+apcVVyyee5Zct1zjwaJEo+hrJEhhlzg434Yd79ETL7Mv3fqVB6M
         bK5xB7lhlJRO9vEAyg8776avsXut1T+sLycDRaa9OWzAgR9A3RX+bV7Etbm+GbDCjBRE
         9TP7KDR8z5K3NL35lTKfd2cxmWfgvGBnSY1c8msy3waaMWSkrt1OxtLp7DmI7U6V7qK3
         i6pxVyuuqgBgcfeQ5a+V8+vtWYLgRmdRj9LLMQ4N98VgOVkrybdmRJE9hJCnrE2dv+pj
         km5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vz8JNCA4OobQyySEBzgksJpFgS03gb8qvM7PnvvkojA=;
        b=g1x6Wc2JU6irS1f9qQ2su1qKDgocCEWYBvrq8Fn558Ukp6FHl3YDOb2cTJ+WwPjy/4
         YIWWgBbRXY8RotNc9h8tvoFKGgPi8/6nMq+5/r1ar4r67iXSBDCEQIDwbodRRB42qPkU
         BYA3vwRlOgsEcs5L2MYM+n0BqeHtjlh22oum07q6u1q2HLlwXTfT9UiYUkYsL4X6nv/I
         PPAvG0QMEM+3malhlW50z0dHLKX9FBn4iXkAr3kSyUExh3wt7H/H17o+0hMA7DhsINmF
         6U8OL+z6UacAXkzQgm/4gl9xi7Ky6JyYRq7pwhiwZ8Td8ETm47UIyGSc5G4bGY09EOyP
         vaUA==
X-Gm-Message-State: APjAAAWy1sT0D3DxYUzK/VidjEHTCbGTyi6Giodf5TUFbnINKAZEZf/U
        +A4DXeLpveKGvW1l9JZmV3g=
X-Google-Smtp-Source: APXvYqzJoTAj4AaG8hABwwP3tl4mArRcqJY66B39tdgtYyTx/gTdpPsz9grGHnuwbZr3YRX8ca+zRw==
X-Received: by 2002:aa7:9359:: with SMTP id 25mr6258135pfn.261.1563896534332;
        Tue, 23 Jul 2019 08:42:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4sm54198863pgs.71.2019.07.23.08.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 08:42:13 -0700 (PDT)
Date:   Tue, 23 Jul 2019 08:42:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: Linux 5.3-rc1
Message-ID: <20190723154212.GC6198@roeck-us.net>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <20190723054841.GA17148@lst.de>
 <20190723145805.GA5809@roeck-us.net>
 <1563894861.3609.6.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563894861.3609.6.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:14:21AM -0700, James Bottomley wrote:
> On Tue, 2019-07-23 at 07:58 -0700, Guenter Roeck wrote:
> > On Tue, Jul 23, 2019 at 07:48:41AM +0200, Christoph Hellwig wrote:
> > > The fix was sent last morning my time:
> > > 
> > > https://marc.info/?l=linux-scsi&m=156378725427719&w=2
> > 
> > Here is the updated bisect for the ppc scsi problem.
> > 
> > Guenter
> > 
> > ---
> > # bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-
> > fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > # good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-
> > v5.3-2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> > git bisect start 'f65420df914a' '168c79971b4a'
> > # good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix
> > request object use-after-free in send path causing wrong traces
> > git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
> > # bad: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
> > the DMA max mapping size into account
> > git bisect bad bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
> > # good: [0cdc58580b37a160fac4b884266b8b7cb096f539] scsi: sd_zbc: Fix
> > compilation warning
> > git bisect good 0cdc58580b37a160fac4b884266b8b7cb096f539
> > # bad: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi: core: add a
> > host / host template field for the virt boundary
> > git bisect bad 7ad388d8e4c703980b7018b938cdeec58832d78d
> > # good: [f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc] scsi: core: Fix
> > race on creating sense cache
> > git bisect good f9b0530fa02e0c73f31a49ef743e8f44eb8e32cc
> > # first bad commit: [7ad388d8e4c703980b7018b938cdeec58832d78d] scsi:
> > core: add a host / host template field for the virt boundary
> 
> And reverting that commit fixes your problem?
> 
I didn't have time to try yet; I am still on my way to work.
I'll get back later with more info. Give me a couple of hours.

Guenter
