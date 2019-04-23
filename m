Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47DC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1BA206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lcyKxotY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfDWRfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:35:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbfDWRfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0lW8tbqTddRuthpqdeLLF9UYeGcIn5hcXfw3DTezumc=; b=lcyKxotYB9WxRLGq88wyETmzX
        CHxTlNqSxDwnjGi/iUX7VOXSynOIe/toKeJvmexzjiKk5pDHVdKLWVeI6n3RJbBAiMRzeAdU7G5xT
        WSwfKHQqMUJjgZ29BaB92iEPOz8aEaKtw47EylFWGMkWhonOlH3leVRjcXv1Lc3cMvDNBTkasKCG1
        FeMlBSMLatvz5r+md3+mqjPJKUF66uSX/qo1sMdalHd5IFNiNLNZZgcVLfGBDg1Jy0SYCllqRTKYH
        2nIXYiRbsLjhwC+kbeRRmUbSJCtd4DgtFGRE+v1NlDx9TQxFC3RYN8irwEkB5L/caWIccY0Mcv1Im
        gX5UpRiBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIzKV-0007VH-0n; Tue, 23 Apr 2019 17:35:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF08029C30E04; Tue, 23 Apr 2019 19:35:37 +0200 (CEST)
Date:   Tue, 23 Apr 2019 19:35:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-next@vger.kernel.org,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
Message-ID: <20190423173537.GI12232@hirez.programming.kicks-ass.net>
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org>
 <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org>
 <20190423082448.GY11158@hirez.programming.kicks-ass.net>
 <CAHk-=wg_yKXPmkTcHWPsf61BXNLzz9bEUDWboN4QfeHKZsCoXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_yKXPmkTcHWPsf61BXNLzz9bEUDWboN4QfeHKZsCoXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:19:50AM -0700, Linus Torvalds wrote:

> Ack on that patch. Except I think the uaccess.h part should be a
> separate commit: 

Of course, I'll go write proper patches.
