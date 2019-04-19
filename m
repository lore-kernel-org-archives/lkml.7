Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC014C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C4C217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 01:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="noNrtn3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfDSBHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 21:07:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46810 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfDSBHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 21:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=35diIJS73KQvDrRnDVHsGCCD+aQpo2DkYGTkvHNwcks=; b=noNrtn3lmSJKq6RLqjIMAiPu3
        AhijGEwYtPqa1qnwcAhTihn0PKpcjata3vuw+0ZO5tC7AfFI6vf8EM+2kzf1t/AoVyuuB6iYVl19+
        ou9sn9kCdUEPB473KOFAukioBAY5otnlL7YfteDsOGUCyiOfpzpmWHrnkFT1agzKEo+Bf8URBhGvc
        qvc5XgF/LbofWAR/LMkK/pf0dLTB7w53gIClNvrMOCapP0DlKbiRWfOnCJJJLEg5de44V9EWucJ29
        d7ACqawnoLFVZjzF0w0SKiQ+kSG+ChfIcAuIm2gZdJw0MgZ6B/CMGogyCtmrIwbTpQ7NRZYilInbK
        3H4Cxm8XA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hHHzm-0006YG-JW; Fri, 19 Apr 2019 01:07:14 +0000
Date:   Thu, 18 Apr 2019 18:07:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
Message-ID: <20190419010714.GH7751@bombadil.infradead.org>
References: <20190417131531.9525-1-mcroce@redhat.com>
 <20190418154045.2ad0bd50e73a6e71c0fac768@linux-foundation.org>
 <1109DAD2-E25B-47A3-8381-E02260FE51B9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109DAD2-E25B-47A3-8381-E02260FE51B9@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:17:17AM +0900, Matteo Croce wrote:
> > extern const int sysctl_zero;
> > /* comment goes here */
> > #define SYSCTL_ZERO ((void *)&sysctl_zero)
> > 
> > and then use SYSCTL_ZERO everywhere.  That centralizes the ugliness
> > and
> > makes it easier to switch over if/when extra1&2 are constified.
> > 
> > But it's all a bit sad and lame :( 
> 
> No, we didn't decide yet. I need to check for all extra1,2 assignment. Not an impossible task, anyway.
> 
> I agree that the casts are ugly. Your suggested macro moves the ugliness in a single point, which is good. Or maybe we can do a single macro like:
> 
> #define SYSCTL_VAL(x) ((void *)&sysctl_##x)
> 
> to avoid defining one for every value. And when we decide that everything can be const, we just update the macro.

If we're going to do that, we can save two EXPORTs and do:

const int sysctl_vals[] = { 0, 1, -1 };
EXPORT_SYMBOL(sysctl_vals);

#define SYSCTL_ZERO	((void *)&sysctl_vals[0])
