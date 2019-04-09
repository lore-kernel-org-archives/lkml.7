Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C530E20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYWG8C9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDIMNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:13:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDIMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VRvsXTQ3GjdpdN5n2kYCn2enLOEYsHiI8Nby7QD3k1k=; b=uYWG8C9fa2W/1ofQ/6IyFNpSO
        iu0V82Kq9jQiAgCdfjkjKw22uXQPkJMHiYDnFmiTPazLx6S1iUbd6O2uU8UWQKigb3LKxiuwwUlgJ
        es8/g9LVDGAPfERmZO5jE5hTxgoi6XD/ZKl4vUm6HU9Vgn7BVC8C9//Jky9Rgcs6wTYggR6JnbTeq
        MWCyz+g4viZ43BaZzTYSyJxJllb79/Tb/Qe67urnB/U0sXvBsdb/B9KDgv50dFC/hm4lv0N0KOBtn
        Jnyy1hwkXfhvsJ+jySxvJjcVAg8i8swVl0wtetpC1Sf3TQPK9jPuJvRD0I0ZclNbO36pE9UmYfddb
        BR/4NS4NQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDpcs-0000al-IJ; Tue, 09 Apr 2019 12:13:18 +0000
Date:   Tue, 9 Apr 2019 05:13:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, x86@kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Subject: Re: [RFC PATCH 4/5] acpi/hmat: Register special purpose memory as a
 device
Message-ID: <20190409121318.GA16955@infradead.org>
References: <155440490809.3190322.15060922240602775809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155440492988.3190322.4475460421334178449.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155440492988.3190322.4475460421334178449.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:08:49PM -0700, Dan Williams wrote:
> Memory that has been tagged EFI_SPECIAL_PURPOSE, and has performance
> properties described by the ACPI HMAT is expected to have an application
> specific consumer.
> 
> Those consumers may want 100% of the memory capacity to be reserved from
> any usage by the kernel. By default, with this enabling, a platform
> device is created to represent this differentiated resource.

This sounds more than weird.  Since when did we let the firmware decide
who can use the memory?
