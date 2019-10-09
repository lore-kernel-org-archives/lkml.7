Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B142C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFF1206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g306avEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfJIMbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:31:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfJIMbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ge6IyJp6CtTVfQFWwPeoTTgBQJKNq3jXQ5sYXlhTiXg=; b=g306avEzv3jgEY934wrhMuzKR
        zIhvCldX2J/FPckX6Bx/kBxHWTpxiX98Ymnv29/3esKUagx5w3x+LrTTAh4z1Y2080usgkbf7u+Iq
        z7g82y1WIFQxYLPVH/VDXjWoAQOnXDGBpENx8994QU3c9hi2lCXYdclO2jvAa8O+37nhZs1h3mu8j
        g8uN96gsUtdqn4774KU9dF91S0bOQn98mn04mcRt21yJsyuWW/QtYFAYqGcZD6kTSFCQHN5kNl5cb
        YEy0+TZSJRUTNwUpQDB3YhcHUlcGYjhpQHzATA8YCohK7Gre/A8r04eU92qgVGbTWbSXErljCa6s2
        kzqkxRnHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIB7Y-0002Ki-Kw; Wed, 09 Oct 2019 12:31:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 703A0300565;
        Wed,  9 Oct 2019 14:30:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B7732009B59E; Wed,  9 Oct 2019 14:31:06 +0200 (CEST)
Date:   Wed, 9 Oct 2019 14:31:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH -tip v4 0/4] x86: kprobes: Prohibit kprobes on Xen/KVM
 emulate prefixes
Message-ID: <20191009123106.GK2311@hirez.programming.kicks-ass.net>
References: <156777561745.25081.1205321122446165328.stgit@devnote2>
 <20190917151403.60023814bda80304777a35e5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917151403.60023814bda80304777a35e5@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:14:03PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> Could you review this version?

These look good to me; shall I merge them or what was the plan?
