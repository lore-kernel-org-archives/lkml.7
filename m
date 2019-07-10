Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E752C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5542087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="axQtLVlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGJRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:44:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46414 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfGJRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:44:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id c73so1412871pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iWMY9Ra6fhg6EXLcSiaO3PQbn2oiv74r4PYLZuZM2BU=;
        b=axQtLVlxBbG2rukB4uIEh3aDgpy4FVcpO0GP/piahI3Obgr+rZibgLCVElkJiFLY7w
         3JeU1pgGcUvAjJcRn1s0c75htzs2+FGj/9N0jRvMyrTOIrRKuoNx+MB+l7IkG8G+s71L
         89cqtxOCVpM5EfPFLvBjibAvHWJvgCpc2nVLRUGbBX0UKtG1lxR7l/ToMmPkdPDSn7So
         fZ9asLA/swzK89Ng61WiyMSN19TnEfEsP0wWxWd6vVTYQ59wz7HTFto7++v2UlC/wnZt
         XCH/XEdhlxPfFZJ0WwkBRJ1tgzdA8vKk19ExiwlatWdYZVOo1JH5BsmesMvm1aWejERz
         pSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iWMY9Ra6fhg6EXLcSiaO3PQbn2oiv74r4PYLZuZM2BU=;
        b=rcYFSv9B8N6nQVyKPveEjXmmc0QiBmUSWYNEf+bIVSuSef51E0dIMpISOp0g4OLBkH
         j5ke6Vdcmf1T3des4Xp+r5PJi/ZUOoXnzBODOEfj/7rKCszJ0YcSxnzkMgdP7Rmff0Xe
         BH42+R5kBt6ELEwiCS5wMD4u0Dn1WsTX+PKA660nKCEQw262ge8A6WBaOQnpDcJS7Fn9
         RZgfXM8OOyPl5juZaDVnkXYHWSXMCDNFqmtUl+JdFyj6Zo62jjKnPD2AWyvcMS3T1sY7
         B2pDiWmaAuuZ/VdoeXylUh/guoUZWNsgJUhm+Z2AgDj9h922ZW5qmsTaRzP4aG9n4ZRK
         sYgw==
X-Gm-Message-State: APjAAAXpxvZhhGJ3AuBOLt6pl0Hp5RY2BB/80JIS3No/pe/mhDSqyMIG
        PM1dO7aJOvJ4Narsd42u4KyL4Q==
X-Google-Smtp-Source: APXvYqzEHvJg5Hy2iDWq+GUuLPTBgqSstjUxb2RpWlYFGd98AAweC/ipWaTWFhYqPANU2G6KTh+dcQ==
X-Received: by 2002:a63:2606:: with SMTP id m6mr38342826pgm.436.1562780663359;
        Wed, 10 Jul 2019 10:44:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5b9d])
        by smtp.gmail.com with ESMTPSA id l189sm2874023pfl.7.2019.07.10.10.44.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 10:44:22 -0700 (PDT)
Date:   Wed, 10 Jul 2019 13:44:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew.wilcox@oracle.com,
        kirill.shutemov@linux.intel.com, kernel-team@fb.com,
        william.kucharski@oracle.com, akpm@linux-foundation.org,
        hdanton@sina.com
Subject: Re: [PATCH v9 1/6] filemap: check compound_head(page)->mapping in
 filemap_fault()
Message-ID: <20190710174418.GA11197@cmpxchg.org>
References: <20190625001246.685563-1-songliubraving@fb.com>
 <20190625001246.685563-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625001246.685563-2-songliubraving@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 05:12:41PM -0700, Song Liu wrote:
> Currently, filemap_fault() avoids trace condition with truncate by

                                   -t

> checking page->mapping == mapping. This does not work for compound
> pages. This patch let it check compound_head(page)->mapping instead.
>
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
