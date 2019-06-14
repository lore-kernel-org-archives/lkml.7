Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B799C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7102133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFNMBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:01:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfFNMBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:01:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60B4FADCB;
        Fri, 14 Jun 2019 12:01:15 +0000 (UTC)
Subject: Re: [RFC PATCH 08/16] x86/xen: irq/upcall handling with multiple
 xenhosts
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-9-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <7eb08024-73c8-ef1f-cacc-e5105102c28d@suse.com>
Date:   Fri, 14 Jun 2019 14:01:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-9-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> For configurations with multiple xenhosts, we need to handle events
> generated from multiple xenhosts.
> 
> Having more than one upcall handler might be quite hairy, and it would
> be simpler if the callback from L0-Xen could be bounced via L1-Xen.
> This will also mean simpler pv_irq_ops code because now the IF flag
> maps onto the xh_default->vcpu_info->evtchn_upcall_mask.
> 
> However, we still update the xh_remote->vcpu_info->evtchn_upcall_mask
> on a best effort basis to minimize unnecessary work in remote xenhost.

This is another design decision yet to be taken.

My current prefernce is L1 Xen mapping events from L0 to L1 guest
events.


Juergen
