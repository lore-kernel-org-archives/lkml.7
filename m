Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31910C31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04744216C8
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 07:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFPHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 03:14:26 -0400
Received: from mail5.windriver.com ([192.103.53.11]:58148 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfFPHOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 03:14:25 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x5G7CC6u031011
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 16 Jun 2019 00:12:27 -0700
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 16 Jun
 2019 00:12:06 -0700
Subject: Re: memory leak in tipc_buf_acquire
To:     Xin Long <lucien.xin@gmail.com>,
        syzbot <syzbot+78fbe679c8ca8d264a8d@syzkaller.appspotmail.com>
CC:     davem <davem@davemloft.net>, Jon Maloy <jon.maloy@ericsson.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        <tipc-discussion@lists.sourceforge.net>
References: <000000000000000c060589a8bc66@google.com>
 <CADvbK_cMohjd3U=8H8ECT74rK85Tjy1FZYAXQQ_CsWgFq3c5gA@mail.gmail.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <ccbfc1eb-e371-d890-14ee-ec1429d4e751@windriver.com>
Date:   Sun, 16 Jun 2019 15:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CADvbK_cMohjd3U=8H8ECT74rK85Tjy1FZYAXQQ_CsWgFq3c5gA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/19 2:44 AM, Xin Long wrote:
> Looks we need to purge each member's deferredq list in tipc_group_delete():
> diff --git a/net/tipc/group.c b/net/tipc/group.c
> index 992be61..23823eb 100644
> --- a/net/tipc/group.c
> +++ b/net/tipc/group.c
> @@ -218,6 +218,7 @@ void tipc_group_delete(struct net *net, struct
> tipc_group *grp)
> 
>   rbtree_postorder_for_each_entry_safe(m, tmp, tree, tree_node) {
>   tipc_group_proto_xmit(grp, m, GRP_LEAVE_MSG, &xmitq);
> + __skb_queue_purge(&m->deferredq);
>   list_del(&m->list);
>   kfree(m);
>   }

Good catch! I agree with you.
