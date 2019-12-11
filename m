Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC90C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924122073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576027876;
	bh=wnOl6p1K/SUEQXiY8Gpr2seeZ+i631yAH+xs0grtRy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kryCfUZ3+SzSE7VvGBJvcPYYiSzAaXp9RX49C3svZ7KVOoSjRnN/j7MuqG55jmfvA
	 F00UwPPNje1fWPAchxzBSEgnqwRR7Cp5BYaVCIkGD+SBE28bfjZoxyM2WFScBMgGts
	 qoEBfcBHNosMQotTVkDabxCySpVPro3SN1TNQPl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLKBbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbfLKBbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:31:15 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C61206D5;
        Wed, 11 Dec 2019 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576027875;
        bh=wnOl6p1K/SUEQXiY8Gpr2seeZ+i631yAH+xs0grtRy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0PE2HvuI9LIwtOeysXUN1ImbZRJLb/XthDWqd7Fg+5tFfEnUZ5OwJQmAXJFJvLVyl
         gNqkavvXjrKRMzn98OZgTHmr5M7KYttwI86S5Vc6NrKn6NKm1d6RYBL95gAzwyByiG
         y3R52W39slW/aKnJDxwbm7FvsvpkxmbtHYFRCMT8=
Date:   Tue, 10 Dec 2019 17:31:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        daniel@iogearbox.net, cai@lca.pw
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
Message-Id: <20191210173114.31a6f3e868f94173de76f5cb@linux-foundation.org>
In-Reply-To: <20191209073458.GA3852@infradead.org>
References: <20191205140407.1874-1-dja@axtens.net>
        <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
        <20191209073458.GA3852@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Dec 2019 23:34:58 -0800 Christoph Hellwig <hch@infradead.org> wrote:

> Or a flags argument with descriptive flags to the existing function?
> These magic bool arguments don't scale..

True.  But it's easy enough to do s/bool create/enum mode/ in the
future should the need arise.  For now, the code is clearer.

