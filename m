Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B5DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FE82087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1KSpUVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbfJ2N0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:26:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726858AbfJ2N0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572355605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ZnfhT7+7jRkPyL+7J38NPLykuSAFsrZtZChreOrEfg=;
        b=c1KSpUVmhiQfnmyPNUZAM0NihCm+EfpVFXcsKbOXQpEJOwMMSW4Fx1Vk9QZfht001MiV6+
        QqQqWkqa/t4KXJZB+kPd/nN390ala9UeRZN5hAYl9ASf77XfmBCuSQ3Y2rqeH6qrRwhKZi
        IxuL9/9r/mjjOnUm42OzeaIJ/is8Uy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-pCW1U5pPO5aWK09p80hpHQ-1; Tue, 29 Oct 2019 09:26:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B38B476;
        Tue, 29 Oct 2019 13:26:40 +0000 (UTC)
Received: from [10.36.118.30] (unknown [10.36.118.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6C9600C4;
        Tue, 29 Oct 2019 13:26:37 +0000 (UTC)
Subject: Re: [RFC v2] mm: add page preemption
To:     Hillf Danton <hdanton@sina.com>, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
References: <20191029123058.19060-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2586aa78-9120-cd33-7f02-2542b74a64a4@redhat.com>
Date:   Tue, 29 Oct 2019 14:26:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029123058.19060-1-hdanton@sina.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: pCW1U5pPO5aWK09p80hpHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.10.19 13:30, Hillf Danton wrote:
>=20
> Date: Tue, 29 Oct 2019 09:41:53 +0100 Michal Hocko wrote:
>>
>> As already raised in the review of v1. There is no real life usecase
>> described in the changelog.
>=20
> No feature, no user; no user, no workloads.
> No linux-6.x released, no 6.x users.
> Are you going to be one of the users of linux-6.0?
>=20
> Even though, I see a use case over there at
> https://lore.kernel.org/lkml/20191023120452.GN754@dhcp22.suse.cz/
>=20
> That thread terminated because of preemption, showing us how useful
> preemption might be in real life.
>=20
>> I have also expressed concerns about how
>> such a reclaim would work in the first place
>=20
> Based on what?
>=20
>> (priority inversion,
>=20
> No prio inversion will happen after introducing prio to global reclaim.
>=20
>> expensive reclaim etc.).
>=20
> No cost, no earn.
>=20
>=20

Side note: You should really have a look what your mail client is=20
messing up here. E.g., the reply from Michal correctly had

Message-ID: <20191029084153.GD31513@dhcp22.suse.cz>
References: <20191026112808.14268-1-hdanton@sina.com>
In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>

Once you reply to that, you have

Message-Id: <20191029123058.19060-1-hdanton@sina.com>
In-Reply-To: <20191026112808.14268-1-hdanton@sina.com>
References:

Instead of

Message-Id: <20191029123058.19060-1-hdanton@sina.com>
In-Reply-To: <20191029084153.GD31513@dhcp22.suse.cz>
References: <20191029084153.GD31513@dhcp22.suse.cz>

Which flattens the whole thread hierarchy. Nasty. Please fix that.

--=20

Thanks,

David / dhildenb

