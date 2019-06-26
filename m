Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F1C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2FA216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oXeJYZx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfFZH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:58:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZH6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wk3gTV2rxOUxzK6dYo6NPW/evlC+KmzGL/BklH8DVGI=; b=oXeJYZx84PoEDtYajsGmQzn39
        xi9TIEcA8hiu2D5oFu9mbD1PgsbVdgRnAOLsgOnh1Gxe4tPvZxOHCu8mXty01blDpfv3jUECQtMvl
        XeZpFefr4u+CYnn5ZBMMQJ7x7j2t06Z3FBAEUv0klRe0pjqbEImOdN2RQrj84aSAOL02chEbh8NfQ
        8rJVk5VUinGHxU9zF5JXtwxjfsFdK9OfURrkjt8japaN5G0VqyRJeB29xmRkNw4p9sGWyQCBri8Aj
        qqWS9CtcR4C0yi0q96eWQHvehJ1kKps51KJb+zlrtdYv5tzdNXYyx7tpPTSstvXlwqKZ3sh8hNENn
        EuNRJTulQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hg2oT-0006vL-19; Wed, 26 Jun 2019 07:57:53 +0000
Date:   Wed, 26 Jun 2019 00:57:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: Cleanup & allow modules to hotplug memory
Message-ID: <20190626075753.GA24711@infradead.org>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626061124.16013-1-alastair@au1.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:11:20PM +1000, Alastair D'Silva wrote:
>   - Drop mm/hotplug: export try_online_node
>         (not necessary)

With this the subject line of the cover letter seems incorrect now :)
