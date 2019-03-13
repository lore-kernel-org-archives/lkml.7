Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C04C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1542070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfCMVGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:06:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58750 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfCMVGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:06:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7F88AB71;
        Wed, 13 Mar 2019 21:06:09 +0000 (UTC)
Date:   Wed, 13 Mar 2019 14:06:03 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] Using XArray to manage the VMA
Message-ID: <20190313210603.fguuxu3otj5epk3q@linux-r8p5>
Mail-Followup-To: Laurent Dufour <ldufour@linux.ibm.com>,
        lsf-pc@lists.linux-foundation.org, Linux-MM <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7da20892-f92a-68d8-4804-c72c1cb0d090@linux.ibm.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019, Laurent Dufour wrote:

>If this is not too late and if there is still place available, I would 
>like to attend the MM track and propose a topic about using the XArray 
>to replace the VMA's RB tree and list.
>
>Using the XArray in place of the VMA's tree and list seems to be a 
>first step to the long way of removing/replacing the mmap_sem.

So threaded (not as in threads of execution) rbtrees are another
alternative to deal with the two data structure approach we currently
have. Having O(1) rb_prev/next() calls allows us to basically get rid of
the vma list at the cost of an extra check for each node we visit on
the way down when inserting.

Thanks,
Davidlohr
