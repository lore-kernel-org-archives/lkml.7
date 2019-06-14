Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC29C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1840F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFNMEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbfFNMEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:04:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A226AD0C;
        Fri, 14 Jun 2019 12:04:14 +0000 (UTC)
Subject: Re: [RFC PATCH 09/16] xen/evtchn: support evtchn in xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-10-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c91abc40-03e3-2ebd-a878-b251a97869db@suse.com>
Date:   Fri, 14 Jun 2019 14:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-10-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Largely mechanical patch that adds a new param, xenhost_t * to the
> evtchn interfaces. The evtchn port instead of being domain unique, is
> now scoped to xenhost_t.
> 
> As part of upcall handling we now look at all the xenhosts and, for
> evtchn_2l, the xenhost's shared_info and vcpu_info. Other than this
> event handling is largley unchanged.
> 
> Note that the IPI, timer, VIRQ, FUNCTION, PMU etc vectors remain
> attached to xh_default. Only interdomain evtchns are allowable as
> xh_remote.

I'd do only the interface changes for now (including evtchn FIFO).

The main difference will be how to call the hypervisor for sending an
event (either direct or via a passthrough-hypercall).


Juergen
