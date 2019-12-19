Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB2D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fK/vdp83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSPWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:22:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37158 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726760AbfLSPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576768929;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sv2ROrXh7f8SaxkMKHELvqrWudHsHniNHJkfBfNFQXA=;
        b=fK/vdp83V+2Fgns1vbJC1OF0HPSLIbd8JXgUplO8iwbURD4HWM7xX1erVOgxcPcqCgsrKn
        M3rM2PHyfTXKpytsVLRKq1uj52sG34E8+y7x3Uwcv7b/p8c5YJ7DfBkNFOityuiBqI42Hz
        lnhpg6TtXRRSTMkz2vXDJC2dRyGQ+Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-8_7f2AwAPiuM5uHeqvDK8g-1; Thu, 19 Dec 2019 10:22:05 -0500
X-MC-Unique: 8_7f2AwAPiuM5uHeqvDK8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 187E58D8A40;
        Thu, 19 Dec 2019 15:22:03 +0000 (UTC)
Received: from ovpn-112-19.phx2.redhat.com (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25EE369414;
        Thu, 19 Dec 2019 15:21:59 +0000 (UTC)
Message-ID: <db7acdee9a85ce5b74332b3869efa6c9e18bad9e.camel@redhat.com>
Subject: Re: [Q] ld: Does LTO reorder ro variables in two files?
From:   Jeff Law <law@redhat.com>
Reply-To: law@redhat.com
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>, gcc-help@gcc.gnu.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Dec 2019 08:21:58 -0700
In-Reply-To: <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
         <20191219131242.GK2827@hirez.programming.kicks-ass.net>
         <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-12-19 at 17:04 +0300, Kirill Tkhai wrote:
> CC: gcc-help@gcc.gnu.org
> 
> Hi, gcc guys,
> 
> this thread starts here: https://lkml.org/lkml/2019/12/19/403
> 
> There are two const variables:
> 
>    struct sched_class idle_sched_class
> and
>    struct sched_class fair_sched_class,
> 
> which are declared in two files idle.c and fair.c.
> 
> 1)In Makefile the order is: idle.o fair.o
> 2)the variables go to the same ro section
> 3)there is no SORT(.*) keyword in linker script.
> 
> Is it always true, that after linkage &idle_sched_class < &fair_sched_class?
I certainly wouldn't depend on it.   The first and most obvious problem
is symbol sorting by the linker.  Longer term I'd be worried about LTO
reordering things.

In the end I'm pretty sure it'd be well outside what I'd be comfortable
depending on.

jeff
> 

