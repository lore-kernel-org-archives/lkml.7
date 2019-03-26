Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B05C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046182075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GOz8h2r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfCZLoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:44:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfCZLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aAAXvmmTpqe3PtKH32pMXKJgd7/JMwI32R5uwR173Us=; b=GOz8h2r7e1vwNGCBOWxSWQbu4
        8fdYTyqMl51xZ3W8YhfGeKl/UVtqGgk2ASuGxrwHuwneOJA75P2lw+vim6JCPSc9U+jRFpDtD7Pdl
        s5ppQKd/lFiKG9sPY2/I+HHUHQ0Mh0LxI7V9wHj77oq1GZCdhMQJomdGKLRMF38SWwQgQc1jTyl0l
        5y3BAxKmxUuFy2XK9g74vhMi06RkmAV6iKBh/RnFi0pgZ6Tt43WVFcFMTO9qDvPD78H0KCHWPFTRh
        CAn994OiEly0QewZtj2KYnPynOlF3yKN277iTJT4zt9wSnBvVK1JnyvAowlYyc3cyFgXSuEYeShZv
        UwquBy94Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8kUo-000758-VV; Tue, 26 Mar 2019 11:43:58 +0000
Date:   Tue, 26 Mar 2019 04:43:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, rppt@linux.ibm.com,
        osalvador@suse.de, william.kucharski@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 4/4] drivers/base/memory.c: Rename the misleading
 parameter
Message-ID: <20190326114358.GM10344@bombadil.infradead.org>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326090227.3059-5-bhe@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:02:27PM +0800, Baoquan He wrote:
> The input parameter 'phys_index' of memory_block_action() is actually
> the section number, but not the phys_index of memory_block. Fix it.

>  static int
> -memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
> +memory_block_action(unsigned long sec, unsigned long action, int online_type)

'sec' is a bad abbreviation for 'section'.  We don't use it anyhere else
in the vm.

Looking through include/, I see it used as an abbreviation for second,
security, ELF section, and section of a book.  Nowhere as a memory
block section.  Please use an extra four letters for this parameter.
