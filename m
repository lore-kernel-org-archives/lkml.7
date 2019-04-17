Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D596C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6022E20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/CqysnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732799AbfDQPtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:49:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfDQPtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FCODExTNsFUPdjtSIpGHQlu+n8l5qEJjh02LTVeFR6Y=; b=S/CqysnTSDonZSFmBBkBl4pR7
        vX85t6bdF5Hf7Vx8JSbbn8GKJU6rfSg3Z37TB+dHQvIbkZQkp+nOobXOd9PNvrGo/H2js2ngl2O8Q
        ppGLMT3sau6BKPhYATyIlL1rVt3k5nohtN5iNePmE8indh1/3aJpY6QALj0YaQpCbRkSFtO+kTmgT
        uL6Y6Qrf+FLt8X/pbL6I6Uz65+vpWWZJB2bTXjVugwomNQIX0Pk0ypx4GW6fW/Rs9Bhi2Bn2wD2Y5
        hd1WYO+9q8LAyBTwiHBTmjYDrDHDWNOILr5duBXQ/og3Z3eJcb2P1g5pixoDfJnb+u0Ao+DJEGgeS
        Qz2bCJDsQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGmo0-0001uo-Kb; Wed, 17 Apr 2019 15:49:00 +0000
Date:   Wed, 17 Apr 2019 08:49:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
Message-ID: <20190417154900.GD7751@bombadil.infradead.org>
References: <20190417131531.9525-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417131531.9525-1-mcroce@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:15:31PM +0200, Matteo Croce wrote:
> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
> 
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
> 
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
> 
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     245
> 
> This patch adds three const variables for the most commonly used values,
> and use them instead of creating a local one for every object file.

Does this actually cause the kernel size to shrink?  EXPORT_SYMBOL isn't
free, you know.
