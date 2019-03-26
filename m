Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfCZMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfCZMmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:42:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C00C301EA81;
        Tue, 26 Mar 2019 12:42:49 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80B0B91D8B;
        Tue, 26 Mar 2019 12:42:48 +0000 (UTC)
Date:   Tue, 26 Mar 2019 20:42:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, rppt@linux.ibm.com,
        osalvador@suse.de, william.kucharski@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 4/4] drivers/base/memory.c: Rename the misleading
 parameter
Message-ID: <20190326124245.GA21943@MiWiFi-R3L-srv>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-5-bhe@redhat.com>
 <20190326114358.GM10344@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326114358.GM10344@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 26 Mar 2019 12:42:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/19 at 04:43am, Matthew Wilcox wrote:
> On Tue, Mar 26, 2019 at 05:02:27PM +0800, Baoquan He wrote:
> > The input parameter 'phys_index' of memory_block_action() is actually
> > the section number, but not the phys_index of memory_block. Fix it.
> 
> >  static int
> > -memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
> > +memory_block_action(unsigned long sec, unsigned long action, int online_type)
> 
> 'sec' is a bad abbreviation for 'section'.  We don't use it anyhere else
> in the vm.

Hmm, here 'sec' is in a particular context, we may not confuse it with
other abbreviation. Since Michal also complained about it, seems an
update is needed. I will change it to start_section_nr as Michal
suggested. Thanks.

> 
> Looking through include/, I see it used as an abbreviation for second,
> security, ELF section, and section of a book.  Nowhere as a memory
> block section.  Please use an extra four letters for this parameter.



