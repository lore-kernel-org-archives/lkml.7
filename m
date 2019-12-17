Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724FCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392F72146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXhDvqAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfLQTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:38:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50831 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726742AbfLQTis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576611527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tJ1o8nlR0lPNvSLMwteIRJqp9viWARZSJMO3WUBLrv4=;
        b=YXhDvqAHzWHLI4Z9LVECPccM/EfGDC90feovL1L2FmlPFCqz7jROBKRiuvC57B+vZ5XOk5
        Cs48XgVa7AfK1QznVuyV9Vah7TiRKP/7NrSTm41/RJTb8YYs6dw/cNtz1Ipu2QpYcFT7WT
        Pq9/D/SdQ7ud95zLXZHK7OgeBQW9Y+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-Le-WnOEVPPemCJONncbb0A-1; Tue, 17 Dec 2019 14:38:42 -0500
X-MC-Unique: Le-WnOEVPPemCJONncbb0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F00593A0;
        Tue, 17 Dec 2019 19:38:40 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-81.rdu2.redhat.com [10.10.123.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6455D1001281;
        Tue, 17 Dec 2019 19:38:39 +0000 (UTC)
Subject: Re: [PATCH v3] mm/hugetlb: Defer freeing of huge pages if in non-task
 context
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <20191217170331.30893-1-longman@redhat.com>
 <20191217185557.tgtsvaad24j745gf@linux-p48b>
 <4f7b23c9-6e05-3b71-9a94-f8d494d8b0e1@redhat.com>
 <20191217190803.xs6xkmm4struzmru@linux-p48b>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a0038e13-371a-0967-bfcc-aee2d734cd0a@redhat.com>
Date:   Tue, 17 Dec 2019 14:38:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191217190803.xs6xkmm4struzmru@linux-p48b>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 2:08 PM, Davidlohr Bueso wrote:
> On Tue, 17 Dec 2019, Waiman Long wrote:
>
>> I could use this helper, but the statement is simple enough to
>> understand.
>
> Yes, but I'm mainly thinking for the sake of anyone looking through
> llist users in the future, which can easily miss this when grepping
> for example. Anyway, yes probably does not merit a v4 unless akpm wants
> to fold it in or something. 

You can send a follow up patch to make that change if akpm doesn't roll
it in.

Cheers,
Longman

