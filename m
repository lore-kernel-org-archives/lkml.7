Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D7C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB272175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCTSsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:48:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48646 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727166AbfCTSsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:48:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B22A6AFBF;
        Wed, 20 Mar 2019 18:48:50 +0000 (UTC)
Message-ID: <1553107714.2927.2.camel@suse.de>
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
From:   Oscar Salvador <osalvador@suse.de>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        akpm@linux-foundation.org, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Mar 2019 19:48:34 +0100
In-Reply-To: <3c880e88-6eb7-cd6d-fbf3-394b89355e10@linux.alibaba.com>
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
         <20190320081643.3c4m5tec5vx653sn@d104.suse.de>
         <3c880e88-6eb7-cd6d-fbf3-394b89355e10@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 11:31 -0700, Yang Shi wrote:
> No, this is not correct. queue_pages_pmd() may return 0, which means
> THP 
> gets split. If it returns 0 the code should just fall through instead
> of 
> returning.

Right, I overlooked that.

> It sounds not correct to me. We need check if there is existing page
> on 
> the node which is not allowed by the policy. This is what 
> queue_pages_required() does.

Bleh, I guess it was too early in the morning.
That is the whole point of it actually, so that was quite wrong.

Sorry for trying to mislead you ;-)

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
