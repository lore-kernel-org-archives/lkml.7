Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E5C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2421473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rqob12LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDIQMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:12:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDIQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S4ArIDjaRDVjCCD9jFlCWpRZQeGdzkqhD5RJ38zmT0E=; b=Rqob12LH5hzWj8W2SGMi5q29e
        svi4BDLLyD1KhsIuTCL0A4XEv1pOg9Xbl8FjySeacDai0aSgV3i10xMlE6hXM3uwA07gZZkq+/Stg
        jPn364PabvUwaExrJV7TcjEq1LSsaPf+2y77pErxZ5eDu30eK89+mmLa12V9Oq+Zk/F+FhFadNtV+
        VSHHJeKfVILSpMw2vZ0Ep4zZQ5Um/8+9QVCGl4F+yhga9Hma023W5glynqMhKFqSOnthkCyVuKmA1
        XJavWI3MS0QarwmtjgT4Ik0moTrvkpqkHadHC5v15IxUWjV0I0GGgLbWtnCjKEcm8Zc5XSQWcICyU
        xVgxGejKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDtM0-0001AC-Id; Tue, 09 Apr 2019 16:12:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5477201F29A3; Tue,  9 Apr 2019 18:12:04 +0200 (CEST)
Date:   Tue, 9 Apr 2019 18:12:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry@arm.com
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Message-ID: <20190409161204.GS11158@hirez.programming.kicks-ass.net>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409135243.12424-4-raphael.gault@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm just doing my initial read-through,.. however

On Tue, Apr 09, 2019 at 02:52:40PM +0100, Raphael Gault wrote:
> +		if (!(sec->sh.sh_flags & SHF_EXECINSTR)
> +			&& (strcmp(sec->name, ".altinstr_replacement") || !IGNORE_SHF_EXEC_FLAG))
>  			continue;

could you please not format code like that. Operators go at the end of
the line, and continuation should match the indentation of the opening
paren. So the above would look like:

> +		if (!(sec->sh.sh_flags & SHF_EXECINSTR) &&
> +		    (strcmp(sec->name, ".altinstr_replacement") || !IGNORE_SHF_EXEC_FLAG))
>  			continue;

You appear to be doing that quit consistently, and it is against style.
