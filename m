Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E13C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F505207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDBXoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36326 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfDBXoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:44:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1ED2DAC8D;
        Tue,  2 Apr 2019 23:44:08 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:43:57 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alan Tull <atull@kernel.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Wu Hao <hao.wu@intel.com>,
        linux-mm@kvack.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-ID: <20190402234357.tn3tik4r7k6nbrau@linux-r8p5>
Mail-Followup-To: Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Lameter <cl@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
        Wu Hao <hao.wu@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
 <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Apr 2019, Andrew Morton wrote:

>Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
>thinking that the benefit of removing a few mmap_sem-takings from a few
>obscure drivers (sorry ;)) is pretty small.

afaik porting the remaining incorrect users of locked_vm to pinned_vm was
the next step before this one, which made converting locked_vm to atomic
hardly worth it. Daniel?

Thanks,
Davidlohr
