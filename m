Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E21AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1E206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564582549;
	bh=ijc5WLdf1v13FrC8F9SXX7PftjW7BYIoAw3PMCgYPsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VXIfs+4geHCqhgiCPkZdA4NhN1SiFETOH1vhx4hh3mk/ybouMRr9ZBebLsnpBW4zw
	 a36IiTY7CjPxkAm19mdxQCO0kTd1SAgVWoTSED+SojMrG22GD3YicJ4caf4yFil4zf
	 MUYIaqQWqOX0ng21LlZVTV/g5AV3M8pTajlPP18I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGaOPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:50096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbfGaOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B30EADA2;
        Wed, 31 Jul 2019 14:15:46 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:15:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] drivers/base/memory.c: Don't store end_section_nr in
 memory blocks
Message-ID: <20190731141545.GV9330@dhcp22.suse.cz>
References: <20190731122213.13392-1-david@redhat.com>
 <20190731124356.GL9330@dhcp22.suse.cz>
 <f0894c30-105a-2241-a505-7436bc15b864@redhat.com>
 <20190731132534.GQ9330@dhcp22.suse.cz>
 <58bd9479-051b-a13b-b6d0-c93aac2ed1b3@redhat.com>
 <92a8ba85-b913-177c-66a2-d86074e54700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a8ba85-b913-177c-66a2-d86074e54700@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 16:04:10, David Hildenbrand wrote:
> On 31.07.19 15:42, David Hildenbrand wrote:
[...]
> > Powerpc userspace queries it:
> > https://groups.google.com/forum/#!msg/powerpc-utils-devel/dKjZCqpTxus/AwkstV2ABwAJ
> 
> FWIW, powerpc-utils also uses the "removable" property - which means
> we're also stuck with that unfortunately. :(

Yeah, I am aware of that and I strongly suspect this is actually in use
because it is terribly unreliable for any non-idle system. There is
simply no way to find out whether something is offlinable than to try
it.
-- 
Michal Hocko
SUSE Labs
