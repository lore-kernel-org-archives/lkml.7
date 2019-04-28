Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F99DC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC07206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556467921;
	bh=2Ih74ArNwrd6gnsd0tRO11DhEMb/gVUv+2PFxNCE+G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qbo0Uq/Lt46CcZ5oNJktJoaI0kZMBccvLovoWMYtVPkq3Uir30SxXptQ+Jy1/ATwQ
	 qSh16ST36Br7H/9O2Tzkn8n88QkCJSzExBC65QcdODNgla8RUO16o7QdcINyeVnhx0
	 CFT3IBT0QyO2UYkcPg7Nym7wLClxO1DtlS4GKo8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfD1QL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 12:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfD1QL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 12:11:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0148206BB;
        Sun, 28 Apr 2019 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556467917;
        bh=2Ih74ArNwrd6gnsd0tRO11DhEMb/gVUv+2PFxNCE+G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DAN4lk4g6/dTf1qoG/xYQWHG4nkNjfg65R3CC6FHYwrqsB/Rp87fBqdFpZisa5ST9
         uZ3chYsuUVm+r+rfEYUcJtQeWOXlUm0fOYNK3uvf3ZsRA850AgjBUrkE0NjSnpWUHt
         coeI8RomF3dpN3F47qVhw/MU7UvGceCSrC2AW644=
Date:   Sun, 28 Apr 2019 18:11:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix kobject memleak in SLUB
Message-ID: <20190428161154.GA13309@kroah.com>
References: <20190427234000.32749-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427234000.32749-1-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 09:40:00AM +1000, Tobin C. Harding wrote:
> Currently error return from kobject_init_and_add() is not followed by a
> call to kobject_put().  This means there is a memory leak.
> 
> Add call to kobject_put() in error path of kobject_init_and_add().
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
