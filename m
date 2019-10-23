Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32851CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E1B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR5JxMha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfJWSHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:07:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58406 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbfJWSHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571854057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dJ7zg/nfTRnTIg9LMwikxyAPQbbTem0V3IKC5Taois=;
        b=JR5JxMhaIjS7gbjlTgoL3ED9my7UX4lbzQ6h6ljc4l4XFRfVllFR2X4o9ZtU/yt4sQlete
        ppM0f+xldemWWDDokSQc/swft2oObmvsNVOkXospX7LGKA4wqP1ktq/gY7q+k6ReHG/iAE
        Fg95v3pz9V+8dmppdnS1qBS8+VBvDok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-iF2ObA_CNoecP4FMtzToVA-1; Wed, 23 Oct 2019 14:07:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A8E91005500;
        Wed, 23 Oct 2019 18:07:13 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18DD85C222;
        Wed, 23 Oct 2019 18:07:08 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm, vmstat: List total free blocks for each order in
 /proc/pagetypeinfo
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
References: <20191023102737.32274-3-mhocko@kernel.org>
 <20191023173423.12532-2-longman@redhat.com>
 <20191023180217.GO17610@dhcp22.suse.cz>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <724cbfa3-2a04-718b-5c98-942a452566f4@redhat.com>
Date:   Wed, 23 Oct 2019 14:07:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191023180217.GO17610@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: iF2ObA_CNoecP4FMtzToVA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 2:02 PM, Michal Hocko wrote:
> On Wed 23-10-19 13:34:23, Waiman Long wrote:
> [...]
>> @@ -1419,6 +1419,17 @@ static void pagetypeinfo_showfree_print(struct se=
q_file *m,
>>  =09=09}
>>  =09=09seq_putc(m, '\n');
>>  =09}
>> +
>> +=09/*
>> +=09 * List total free blocks per order
>> +=09 */
>> +=09seq_printf(m, "Node %4d, zone %8s, total             ",
>> +=09=09   pgdat->node_id, zone->name);
>> +=09for (order =3D 0; order < MAX_ORDER; ++order) {
>> +=09=09area =3D &(zone->free_area[order]);
>> +=09=09seq_printf(m, "%6lu ", area->nr_free);
>> +=09}
>> +=09seq_putc(m, '\n');
> This is essentially duplicating /proc/buddyinfo. Do we really need that?

Yes, you are right. As the information is available elsewhere. I am fine
with dropping this.

Cheers,
Longman

