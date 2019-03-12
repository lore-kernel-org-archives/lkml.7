Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCLHPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbfCLHPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E75A2723D9;
        Tue, 12 Mar 2019 07:15:31 +0000 (UTC)
Received: from [10.72.12.17] (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0731660A9A;
        Tue, 12 Mar 2019 07:15:23 +0000 (UTC)
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
 <20190308194845.GC26923@redhat.com>
 <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
 <20190311084525-mutt-send-email-mst@kernel.org>
 <ff45ea43-1145-5ea6-767c-1a99d55a9c61@redhat.com>
 <20190311234956-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3b00dc4a-b1b7-aa3f-c4ba-515138e4d6dd@redhat.com>
Date:   Tue, 12 Mar 2019 15:15:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311234956-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 12 Mar 2019 07:15:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/12 上午11:50, Michael S. Tsirkin wrote:
>>>> Using direct mapping (I
>>>> guess kernel will always try hugepage for that?) should be better and we can
>>>> even use it for the data transfer not only for the metadata.
>>>>
>>>> Thanks
>>> We can't really. The big issue is get user pages. Doing that on data
>>> path will be slower than copyXuser.
>> I meant if we can find a way to avoid doing gup in datapath. E.g vhost
>> maintain a range tree and add or remove ranges through MMU notifier. Then in
>> datapath, if we find the range, then use direct mapping otherwise
>> copy_to_user().
>>
>> Thanks
> We can try. But I'm not sure there's any reason to think there's any
> locality there.
>

Ok, but what kind of locality do you mean here?

Thanks

