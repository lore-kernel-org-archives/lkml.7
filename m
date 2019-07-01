Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB98C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF52206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZMRbdM6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGAPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:18:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59130 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfGAPSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 11:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u8Ydyg4ThM0wZoBNokarC4fhtypB6gh7eVSA4X7ZgvI=; b=ZMRbdM6eOD9DM9nl6ih789M+y
        /weD9Lv7MDAu/CkQxbpv6QZnMuIyETVExshi+1qmnmnaTXdmHMSrlLoIXuaO7l0dnM4tD4+VfHeov
        AZK1HKJTguGVTdeXg8LvmaNayitxSZjnDL+h+Hl/eBzxAClHClYV+1lrcnrioPqf04ucw5hIc0gMP
        7bbnXDhHd+WL/tYi3+f46y24jlftwmt0AoqQzjccriLZLGt7l0YjsbrMfsc4k65raCANyn6stx65w
        eK/FAwcqvNmmPGNbv661FRa6YFXNZW+8nAQgUPqATFtFbUOFkFcGoGezQh/jUAQjtMBJLL/XVj+SV
        5qSjmlCFg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhy4Z-0003oc-HJ; Mon, 01 Jul 2019 15:18:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: generic gup fixups
Date:   Mon,  1 Jul 2019 17:18:16 +0200
Message-Id: <20190701151818.32227-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

below two fixups for the generic GUP series, as reported by Guenter.
