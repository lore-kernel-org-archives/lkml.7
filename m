Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582ABC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB6218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ldwz6J2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfLQJNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:13:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lskMEB2lNFJ+fzrxSPwkowIiVDMJBnd5kusbBEblZ9Y=; b=Ldwz6J2aoAYnB2WV3T1aW3Ecg
        8FubXUGud5uDciswfTOGBnDHHUpFYjFCl2OIdSJ9w5BTGffAMnZUrRBD4r+SfteoNsmIYfnztm7vk
        R0kE0R+plRiAY6kY8CK4emETFkd6QGJSk4Yl991n14mSuqr0ZVooWPNmmb/VLVfn+4BTNyDFnuZ5h
        875VkEqzdBGM0zsVSlAk5s+B1Xkizs/UZeBG22iGm4LfkYx8e0xIZFyj37Xtnrp9Gw14gtAeVmbL1
        6xSKVv1GXuIYyYUkP7eUJo/dMbDU72mqnwXxqiiEl0cj1FWwCZeKQyfbHqO8TcsKnkBnCF2AP4jOJ
        JFSi/m/jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih8ug-0005GW-0O; Tue, 17 Dec 2019 09:13:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 912CD3040CB;
        Tue, 17 Dec 2019 10:11:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20C942B3D7E82; Tue, 17 Dec 2019 10:13:04 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:13:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: locking: add releases(lock) annotation
Message-ID: <20191217091304.GY2844@hirez.programming.kicks-ass.net>
References: <20191216153952.37038-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216153952.37038-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 03:39:52PM +0000, Jules Irenge wrote:
> Add releases(lock) annotation to remove issue detected by sparse tool.
> warning: context imbalance in xxxxxxx() - unexpected unlock
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

So, personally I detest these sparse things.

But I'm also confused, as that function already has the annotation, see
spinlock_api_smp.h. In order for sparse to see these annotations at the
usage size, they need to be on the declaration, not the definition.
