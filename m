Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A645C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0B82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T9GsiCwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbfCYLjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:39:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dnk+6veBR430CV74ZvvWIo26+r8KyGtq/ckWLhOc45c=; b=T9GsiCwfZ3iX/IyYdyaOJNNca
        W885bdi0lpzTqEqtyxEfHt3B1ndUJ7RI0JQzcXr063roJXtS3Cy65pfHOWNLns0MwRRbEed10lBx6
        L5iiCWLfNUhSR5vzCJc5KMfrB20kjwhKeGiNPATxYh7NC4VXm6i92WDwqo3YBjg7vvgVSi4YwI3Kv
        0zUK8a47tbL5ktXLO+IEBEB3S6vPJ0wXo0G9TbBKVQG9z1ezUP7z0Nlc5DRYuv8a+TkoOnGQjHyhS
        5/S2Dbjz9OFfEkQRGUgtKBElJUEeUg/jAF1cvt8iD+ue8AcZPaEreU93Gb/K67nveLjbAaGt/KT/l
        P5pkTspew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8Nx1-0000b1-MH; Mon, 25 Mar 2019 11:39:35 +0000
Date:   Mon, 25 Mar 2019 04:39:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] RISC-V: Allow booting kernel from any 4KB aligned
 address
Message-ID: <20190325113935.GD27843@infradead.org>
References: <20190325092234.5451-1-anup.patel@wdc.com>
 <20190325092234.5451-5-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092234.5451-5-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still not sold on this at all.  It is a lot more code, a lot harder
to read code and all for a very narrow corner case that isn't even
going to be enabled in default configs.
