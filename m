Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9013DC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC6F20842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 04:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfJBEge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 00:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfJBEge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 00:36:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA59AAF56;
        Wed,  2 Oct 2019 04:36:32 +0000 (UTC)
Subject: Re: [PATCH] x86/xen: Return from panic notifier
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     james@dingwall.me.uk
References: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <3fb02346-16b8-1885-32b3-8d136ad7118b@suse.com>
Date:   Wed, 2 Oct 2019 06:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001151633.1659-1-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.19 17:16, Boris Ostrovsky wrote:
> Currently execution of panic() continues until Xen's panic notifier
> (xen_panic_event()) is called at which point we make a hypercall that
> never returns.
> 
> This means that any notifier that is supposed to be called later as
> well as significant part of panic() code (such as pstore writes from
> kmsg_dump()) is never executed.
> 
> There is no reason for xen_panic_event() to be this last point in
> execution since panic()'s emergency_restart() will call into
> xen_emergency_restart() from where we can perform our hypercall.
> 
> Reported-by: James Dingwall <james@dingwall.me.uk>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
