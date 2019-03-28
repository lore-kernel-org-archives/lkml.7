Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13EDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24412075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfC1DoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:44:10 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46193 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfC1DoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:44:10 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        (Authenticated sender: pshelar@ovn.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 1968A200008;
        Thu, 28 Mar 2019 03:44:06 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id f22so7598925vso.7;
        Wed, 27 Mar 2019 20:44:06 -0700 (PDT)
X-Gm-Message-State: APjAAAU4UTVR3nAPY+tqcM1EqcwpNpLxlmLktRpjIGjK5g/C2QOAj+M4
        /nqdzhA3YKnIUpXfgRSl2W8+n4SD7OP/vtIji/A=
X-Google-Smtp-Source: APXvYqwo95ycdGMg8rrGPtbzrxmBn0fdsZ3cV+aSi/bmZhU0g/ZAACuWOKSH4fIrVrdmNiYPdjhEPtbxQjyfxmfwKpk=
X-Received: by 2002:a67:e30a:: with SMTP id j10mr2042476vsf.103.1553744645541;
 Wed, 27 Mar 2019 20:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190327221148.GA16096@xps-13>
In-Reply-To: <20190327221148.GA16096@xps-13>
From:   Pravin Shelar <pshelar@ovn.org>
Date:   Wed, 27 Mar 2019 20:43:54 -0700
X-Gmail-Original-Message-ID: <CAOrHB_Bnd3bEZhqOUaBQB3TeO0sRCK++O6Q40TQ0UQO8u9Y-6g@mail.gmail.com>
Message-ID: <CAOrHB_Bnd3bEZhqOUaBQB3TeO0sRCK++O6Q40TQ0UQO8u9Y-6g@mail.gmail.com>
Subject: Re: [PATCH] openvswitch: fix flow actions reallocation
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ovs dev <dev@openvswitch.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 3:11 PM Andrea Righi <andrea.righi@canonical.com> wrote:
>
> The flow action buffer can be resized if it's not big enough to contain
> all the requested flow actions. However, this resize doesn't take into
> account the new requested size, the buffer is only increased by a factor
> of 2x. This might be not enough to contain the new data, causing a
> buffer overflow, for example:
>
> [   42.044472] =============================================================================
> [   42.045608] BUG kmalloc-96 (Not tainted): Redzone overwritten
> [   42.046415] -----------------------------------------------------------------------------
>
> [   42.047715] Disabling lock debugging due to kernel taint
> [   42.047716] INFO: 0x8bf2c4a5-0x720c0928. First byte 0x0 instead of 0xcc
> [   42.048677] INFO: Slab 0xbc6d2040 objects=29 used=18 fp=0xdc07dec4 flags=0x2808101
> [   42.049743] INFO: Object 0xd53a3464 @offset=2528 fp=0xccdcdebb
>
> [   42.050747] Redzone 76f1b237: cc cc cc cc cc cc cc cc                          ........
> [   42.051839] Object d53a3464: 6b 6b 6b 6b 6b 6b 6b 6b 0c 00 00 00 6c 00 00 00  kkkkkkkk....l...
> [   42.053015] Object f49a30cc: 6c 00 0c 00 00 00 00 00 00 00 00 03 78 a3 15 f6  l...........x...
> [   42.054203] Object acfe4220: 20 00 02 00 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
> [   42.055370] Object 21024e91: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.056541] Object 070e04c3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.057797] Object 948a777a: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [   42.059061] Redzone 8bf2c4a5: 00 00 00 00                                      ....
> [   42.060189] Padding a681b46e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
>
> Fix by making sure the new buffer is properly resized to contain all the
> requested data.
>
> BugLink: https://bugs.launchpad.net/bugs/1813244
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

This must be rare combination of action that trigger this case.

> ---
>  net/openvswitch/flow_netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> index 691da853bef5..e6f789badaa3 100644
> --- a/net/openvswitch/flow_netlink.c
> +++ b/net/openvswitch/flow_netlink.c
> @@ -2306,14 +2306,14 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
>
>         struct sw_flow_actions *acts;
>         int new_acts_size;
> -       int req_size = NLA_ALIGN(attr_len);
> +       size_t req_size = NLA_ALIGN(attr_len);
>         int next_offset = offsetof(struct sw_flow_actions, actions) +
>                                         (*sfa)->actions_len;
>
>         if (req_size <= (ksize(*sfa) - next_offset))
>                 goto out;
>
> -       new_acts_size = ksize(*sfa) * 2;
> +       new_acts_size = max(req_size, ksize(*sfa) * 2);
>
Don't we need to compare current_action_size+req_size and
current_action_size*2 here ?

>         if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
>                 if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
> --
> 2.19.1
>
