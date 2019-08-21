Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F34C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74CB22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 10:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfHUKJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 06:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbfHUKJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 06:09:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F05063003185;
        Wed, 21 Aug 2019 10:09:10 +0000 (UTC)
Received: from [10.36.116.152] (ovpn-116-152.ams2.redhat.com [10.36.116.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 433F75B807;
        Wed, 21 Aug 2019 10:09:07 +0000 (UTC)
From:   "Eelco Chaudron" <echaudro@redhat.com>
To:     "Ilya Maximets" <i.maximets@samsung.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@intel.com>,
        "Magnus Karlsson" <magnus.karlsson@intel.com>,
        "Jakub Kicinski" <jakub.kicinski@netronome.com>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, "William Tu" <u9012063@gmail.com>
Subject: Re: [PATCH net] ixgbe: fix double clean of tx descriptors with xdp
Date:   Wed, 21 Aug 2019 12:09:06 +0200
Message-ID: <9EFD9B47-2CD0-4D7A-BA22-D87018894E91@redhat.com>
In-Reply-To: <20190820151611.10727-1-i.maximets@samsung.com>
References: <CGME20190820151644eucas1p179d6d1da42bb6be0aad8f58ac46624ce@eucas1p1.samsung.com>
 <20190820151611.10727-1-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 21 Aug 2019 10:09:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Aug 2019, at 17:16, Ilya Maximets wrote:

> Tx code doesn't clear the descriptor status after cleaning.
> So, if the budget is larger than number of used elems in a ring, some
> descriptors will be accounted twice and xsk_umem_complete_tx will move
> prod_tail far beyond the prod_head breaking the comletion queue ring.
>
> Fix that by limiting the number of descriptors to clean by the number
> of used descriptors in the tx ring.
>
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>
> Not tested yet because of lack of available hardware.
> So, testing is very welcome.
>
Hi Ilya, this patch fixes the issue I reported earlier on the Open 
vSwitch mailing list regarding complete queue overrun.

Tested-by: Eelco Chaudron <echaudro@redhat.com>

<SNIP>
