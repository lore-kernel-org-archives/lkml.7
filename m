Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23259ECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF10920873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IVAFH//q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfJOIIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:08:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbfJOIIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2snK84LN8J44TKP/PMH63Ii6JR83EPG71zBYu2QJ0XQ=; b=IVAFH//qF+3iYwoEY58Rr19Rh
        ANswVS1RGYeMa/xUPjus6757cq9LlQ9Qgg9o27aoVDlfQUdg00HKQ3AgIlvH2QQvDQfPlAvQmDUa6
        i1wQtAerUNuFu79cQoLaNHCJ76RJINrvivPmJ8jrPQ5nKrvQggbPn71p+CwzJvCncQFC3ynbHWXAe
        v3ONS5UOk0Pg7dvNfJHnc34UiAJgc/0IIfl9D/cDTOOcOG364WYQ8xsj8BJzHiqNAEobs1vn8he+/
        hOIIuSzOx8kO8TxyNEGlcpq1Tjd1F7R8kyvtdUwWYGEy0iDDPyjLqsD7xorHbbqJ88I7H8KE0oWHD
        WTvZhl48A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHsg-0004Uc-8r; Tue, 15 Oct 2019 08:08:34 +0000
Date:   Tue, 15 Oct 2019 01:08:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, nnk@google.com, nosh@google.com,
        timmurray@google.com
Subject: Re: [PATCH 2/7] Add a concept of a "secure" anonymous file
Message-ID: <20191015080834.GB16814@infradead.org>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-3-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012191602.45649-3-dancol@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:15:57PM -0700, Daniel Colascione wrote:
> A secure anonymous file is one we hooked up to its own inode (as
> opposed to the shared inode we use for non-secure anonymous files). A
> new selinux hook gives security modules a chance to initialize, label,
> and veto the creation of these secure anonymous files. Security
> modules had limit ability to interact with non-secure anonymous files
> due to all of these files sharing a single inode.

Again please add Al.  Also explain what the problem would be to always
use a separate inode.
