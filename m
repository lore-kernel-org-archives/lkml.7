Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D401C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AD82064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hd33JvtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGJM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:26:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oFDADlC2ju9lttZIwCvIydgfwE/7qWdsHDo+YyNGXHQ=; b=Hd33JvtV6D0Lc+VAeX5f7BDSn
        DZPLB9IpmgMoQ3Lz8zUyiAN5/zX9A0sNVbPwDE+xK5B/XKkN81SSua4C8fuNGp+KsgHdqzv5+hvIt
        MBaMBQ4Zl1TaYR+Vz5fEp3AVfb5neEc7+w77ThFjsJP4C4HuvrBajIohm2dAwiRpDYcalsd/djy0l
        Gh6+B4+dszsX4ysMUMj9uYe2TuiE7ds8mc5z5QMwcz5wo7xMuijMmx6jhlnc2lTbyGBqrgVCGnGEe
        5GHn/aOGvSwJjE8dNeZAHQSUHKsC2Hl0rpMZcS083Ck63zVetnxtnUvi0vf9l//1nAp27AfELFA1P
        S27fnLbXA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlBfR-000675-Kh; Wed, 10 Jul 2019 12:25:49 +0000
Date:   Wed, 10 Jul 2019 05:25:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     bsauce <bsauce00@gmail.com>
Cc:     alexander.h.duyck@intel.com, vbabka@suse.cz, mgorman@suse.de,
        l.stach@pengutronix.de, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, alex@ghiti.fr, adobriyan@gmail.com,
        mike.kravetz@oracle.com, rientjes@google.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com, ksspiers@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/seq_file.c: Fix a UAF vulnerability in seq_release()
Message-ID: <20190710122549.GM32320@bombadil.infradead.org>
References: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 06:26:29PM +0800, bsauce wrote:
> In seq_release(), 'm->buf' points to a chunk. It is freed but not cleared to null right away. It can be reused by seq_read() or srm_env_proc_write().

Well, no.  The ->release method is called when there are no more file
descriptors referring to this file.  So there's no way to call seq_read()
or srm_env_proc_write() after seq_release() is called.

> For example, /arch/alpha/kernel/srm_env.c provide several interfaces to userspace, like 'single_release', 'seq_read' and 'srm_env_proc_write'.
> Thus in userspace, one can exploit this UAF vulnerability to escape privilege.

Please provide a PoC.
