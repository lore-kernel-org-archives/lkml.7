Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671EDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3401E21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572636947;
	bh=TD/4EVGajF1pvAJu8BvCJSc0WAO+35JeCmCE73abJz8=;
	h=Date:From:To:Subject:In-Reply-To:References:List-ID:From;
	b=Yv3gIeZ8p7DM7vTpcve1bfMHVHD2o4FG7U4kIpoorySuBdBnOJgQrx+QwTJpceV4I
	 Hk1B4pBfnP5ylkD9ptvtYEXK95AplIeqz+hkMJqMWIOAw4UUEYz5s9yiwf2l20dVgY
	 dxWlfQE0nzolWXCMqccjJJolr6wtP3X/+dt+9T+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfKATfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfKATfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:35:45 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF13217D9;
        Fri,  1 Nov 2019 19:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572636945;
        bh=TD/4EVGajF1pvAJu8BvCJSc0WAO+35JeCmCE73abJz8=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=kcj21evp7laeZ3PBP7m9bhba8T8SgvmLhPTex6Zfu4JzkEMl33NA3ZSwOg1lEwDMG
         ALaElUIt9ThCCZ2uo/WBuyEu1Q9/rtZ5gFk1aXIOtvnDpS+F4604rpPq3uvAqcu8rK
         acruqAA2YvAFT+xcRHPj35GAijhKWCAzwpiUXExg=
Date:   Fri, 1 Nov 2019 12:35:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-Id: <20191101123544.c9b0024a1e8f5ddf63148b48@linux-foundation.org>
In-Reply-To: <20191101122920.798a6d61b2725da8cfe80549@linux-foundation.org>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
        <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
        <20191101110901.GB690103@chrisdown.name>
        <20191101144540.GA12808@cmpxchg.org>
        <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
        <20191101192405.GA866154@chrisdown.name>
        <20191101122920.798a6d61b2725da8cfe80549@linux-foundation.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 12:29:20 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> > Either change is an upgrade from the current situation, at least. I prefer 
> > towards whatever makes the API the least confusing, which appears to be 
> > Johannes' original change, but I'd support a patch which always set it to 
> > 0 instead if it was deemed safer.
> 
> On the other hand..  As I mentioned earlier, if someone's code is
> failing because of the permissions change, they can chmod
> /proc/sys/vm/drop_caches at boot time and be happy.  They have no such
> workaround if their software misbehaves due to a read always returning
> "0".

I lied.  I can chmod things in /proc but I can't chmod things in
/proc/sys/vm.  Huh, why did we do that?
