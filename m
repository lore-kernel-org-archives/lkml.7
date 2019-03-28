Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C40C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E322075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 05:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfC1Fqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 01:46:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53596 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfC1Fq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 01:46:29 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h9Nru-00035F-NH
        for linux-kernel@vger.kernel.org; Thu, 28 Mar 2019 05:46:26 +0000
Received: by mail-wr1-f71.google.com with SMTP id u18so8464646wrp.19
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 22:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnWusSuUPplv3PCMitfxLczSv9S6cRhR/+Mv7BdgHE4=;
        b=ub/s8w1ypO0r0hSmzQlCR/yCxW3lXDPihQi0IbkkouNpzvPCUifRdSfdSfJeAsf0Qi
         Yomx5J4cNHlcyyXRboMNBjOF79cWvQW04pyzo1PPXrhWAOPvYcARbEczlMt28Pq+1CuU
         08YXDhHz5e+ordRG2Qt9QPCn8vtibwwbVlAfL8z6jpH77KEHtpWK79/zibRrND9DEW1x
         7+PxNwnP4U2/c598MOynLQejZtPtum5judZea8MaUcGwFikMqhC8/U+xBNGqsKERdRBQ
         a+ued/SGww7OcrXUFAbz5wO7jMYB1HnjjMMU0jcIhdZIrWF9BBvNdwFiEkaSK5MiBiRY
         eUGQ==
X-Gm-Message-State: APjAAAXmDQcXOOLg6Rh3gISx7fU+tUhr72j6t0nDAG7+w2UrT3FuUACr
        aOo/RyHmIZqPnAVeMW//lDs1LmdAVprSTuEM1I7mRzEFRHm8/yMa2ClzIVvz/pK8B87CSJ+vFp+
        EOriz4OFQ12EnLtkfs/tbC8chmCPMJBpdJkiDT/JRdA==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr15218913wmk.103.1553751986399;
        Wed, 27 Mar 2019 22:46:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyU09qtbF6VO8UVn9i+LpxrE45YSmhlFUZf1xUvilvOHt0AWFkgJenjtabgspE3r3QKsirF+w==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr15218904wmk.103.1553751986164;
        Wed, 27 Mar 2019 22:46:26 -0700 (PDT)
Received: from localhost (host141-127-dynamic.17-87-r.retail.telecomitalia.it. [87.17.127.141])
        by smtp.gmail.com with ESMTPSA id w16sm29974146wrt.84.2019.03.27.22.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 22:46:25 -0700 (PDT)
Date:   Thu, 28 Mar 2019 06:46:24 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Pravin Shelar <pshelar@ovn.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ovs dev <dev@openvswitch.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openvswitch: fix flow actions reallocation
Message-ID: <20190328054623.GB16096@xps-13>
References: <20190327221148.GA16096@xps-13>
 <CAOrHB_Bnd3bEZhqOUaBQB3TeO0sRCK++O6Q40TQ0UQO8u9Y-6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOrHB_Bnd3bEZhqOUaBQB3TeO0sRCK++O6Q40TQ0UQO8u9Y-6g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:43:54PM -0700, Pravin Shelar wrote:
> On Wed, Mar 27, 2019 at 3:11 PM Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > The flow action buffer can be resized if it's not big enough to contain
> > all the requested flow actions. However, this resize doesn't take into
> > account the new requested size, the buffer is only increased by a factor
> > of 2x. This might be not enough to contain the new data, causing a
> > buffer overflow, for example:
> >
> > [   42.044472] =============================================================================
> > [   42.045608] BUG kmalloc-96 (Not tainted): Redzone overwritten
> > [   42.046415] -----------------------------------------------------------------------------
> >
> > [   42.047715] Disabling lock debugging due to kernel taint
> > [   42.047716] INFO: 0x8bf2c4a5-0x720c0928. First byte 0x0 instead of 0xcc
> > [   42.048677] INFO: Slab 0xbc6d2040 objects=29 used=18 fp=0xdc07dec4 flags=0x2808101
> > [   42.049743] INFO: Object 0xd53a3464 @offset=2528 fp=0xccdcdebb
> >
> > [   42.050747] Redzone 76f1b237: cc cc cc cc cc cc cc cc                          ........
> > [   42.051839] Object d53a3464: 6b 6b 6b 6b 6b 6b 6b 6b 0c 00 00 00 6c 00 00 00  kkkkkkkk....l...
> > [   42.053015] Object f49a30cc: 6c 00 0c 00 00 00 00 00 00 00 00 03 78 a3 15 f6  l...........x...
> > [   42.054203] Object acfe4220: 20 00 02 00 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
> > [   42.055370] Object 21024e91: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > [   42.056541] Object 070e04c3: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > [   42.057797] Object 948a777a: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > [   42.059061] Redzone 8bf2c4a5: 00 00 00 00                                      ....
> > [   42.060189] Padding a681b46e: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> >
> > Fix by making sure the new buffer is properly resized to contain all the
> > requested data.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1813244
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> 
> This must be rare combination of action that trigger this case.

It is pretty rare indeed, but the test case reported in the BugLink can
trigger it 100% of the times.

> 
> > ---
> >  net/openvswitch/flow_netlink.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
> > index 691da853bef5..e6f789badaa3 100644
> > --- a/net/openvswitch/flow_netlink.c
> > +++ b/net/openvswitch/flow_netlink.c
> > @@ -2306,14 +2306,14 @@ static struct nlattr *reserve_sfa_size(struct sw_flow_actions **sfa,
> >
> >         struct sw_flow_actions *acts;
> >         int new_acts_size;
> > -       int req_size = NLA_ALIGN(attr_len);
> > +       size_t req_size = NLA_ALIGN(attr_len);
> >         int next_offset = offsetof(struct sw_flow_actions, actions) +
> >                                         (*sfa)->actions_len;
> >
> >         if (req_size <= (ksize(*sfa) - next_offset))
> >                 goto out;
> >
> > -       new_acts_size = ksize(*sfa) * 2;
> > +       new_acts_size = max(req_size, ksize(*sfa) * 2);
> >
> Don't we need to compare current_action_size+req_size and
> current_action_size*2 here ?

You are right! We should compare next_offset+req_size and
ksize(*sfa)*2.

Will send a new patch soon, thanks!

-Andrea

> 
> >         if (new_acts_size > MAX_ACTIONS_BUFSIZE) {
> >                 if ((MAX_ACTIONS_BUFSIZE - next_offset) < req_size) {
> > --
> > 2.19.1
> >
