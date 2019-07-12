Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7820EC742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52372208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562942261;
	bh=Q0fQ8cIZPQQvRl+HqtEP93tavumXUJrRQeEzq/T0ZjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J1hj+UFhOrOVIMk+bsxMZyCy+B3AnFsLMUqySLxgThGcIzMQXaT7A8Dup+ATkeEDT
	 P+XYRZA7ayLSdwpi93dc5gz14FybHJvXdMFYTF67HHo10PAV1D0mDgtthM95PBBCyV
	 OYO/VcTnuMI94Y+FchkQGNJXqHn+WLs0pwXUu3WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGLOhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 10:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLOhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 10:37:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 997A82080A;
        Fri, 12 Jul 2019 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562942258;
        bh=Q0fQ8cIZPQQvRl+HqtEP93tavumXUJrRQeEzq/T0ZjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSDuCh7A+Xs42MXbXEieBsFty+Z7wObUN12OgwqLbOFW9oih/BmQBTm6f9I5uATLs
         k3FxtcxVs2OyWqrnzMXueSISfTrdrWEpEWu7/gxb4zS9dLiXyM0oMjuEOYKj4+vyf3
         slAytCaCOnyinCVXlJAAWb5BUeKOp+4U+rFpZcIw=
Date:   Fri, 12 Jul 2019 15:37:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hoan Tran OS <hoan@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Paul Mackerras <paulus@samba.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "x86@kernel.org" <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S . Miller" <davem@davemloft.net>, willy@infradead.org
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20190712143730.au3662g4ua2tjudu@willie-the-truck>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
 <20190712070247.GM29483@dhcp22.suse.cz>
 <586ae736-a429-cf94-1520-1a94ffadad88@os.amperecomputing.com>
 <20190712121223.GR29483@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712121223.GR29483@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Jul 12, 2019 at 02:12:23PM +0200, Michal Hocko wrote:
> On Fri 12-07-19 10:56:47, Hoan Tran OS wrote:
> [...]
> > It would be good if we can enable it by-default. Otherwise, let arch 
> > enables it by them-self. Do you have any suggestions?
> 
> I can hardly make any suggestions when it is not really clear _why_ you
> want to remove this config option in the first place. Please explain
> what motivated you to make this change.

Sorry, I think this confusion might actually be my fault and Hoan has just
been implementing my vague suggestion here:

https://lore.kernel.org/linux-arm-kernel/20190625101245.s4vxfosoop52gl4e@willie-the-truck/

If the preference of the mm folks is to leave CONFIG_NODES_SPAN_OTHER_NODES
as it is, then we can define it for arm64. I just find it a bit weird that
the majority of NUMA-capable architectures have to add a symbol in the arch
Kconfig file, for what appears to be a performance optimisation applicable
only to ia64, mips and sh.

At the very least we could make the thing selectable.

Will
