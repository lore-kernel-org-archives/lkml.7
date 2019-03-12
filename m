Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A5CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B57214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCLHOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:14:41 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:28843
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727225AbfCLHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:14:41 -0400
X-IronPort-AV: E=Sophos;i="5.58,470,1544482800"; 
   d="scan'208";a="298910482"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:14:38 +0100
Date:   Tue, 12 Mar 2019 08:14:37 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     maowenan <maowenan@huawei.com>
cc:     Joe Perches <joe@perches.com>, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        jananis37@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
In-Reply-To: <22e39cdc-6c66-f08a-f2b3-e2637e0b810b@huawei.com>
Message-ID: <alpine.DEB.2.21.1903120813460.2728@hadrien>
References: <20190309032600.98732-1-maowenan@huawei.com> <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com> <e192c19b35ba5a07ed6bea571546800cc3235282.camel@perches.com> <22e39cdc-6c66-f08a-f2b3-e2637e0b810b@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Mar 2019, maowenan wrote:

>
>
> On 2019/3/12 14:35, Joe Perches wrote:
> > On Tue, 2019-03-12 at 14:29 +0800, maowenan wrote:
> >> ping...
> >>
> >> On 2019/3/9 11:26, Mao Wenan wrote:
> >>> Using is_zero_ether_addr() instead of directly use
> >>> memcmp() to determine if the ethernet address is all
> >>> zeros.
> > []
> >>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > []
> >>> @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
> >>>  {
> >>>  	struct list_head *phead, *plist;
> >>>  	struct wlan_network *pnetwork = NULL;
> >>> -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
> >>>
> >>> -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
> >>> +	if (is_zero_ether_addr(addr)) {
> >
> > How did you verify that addr is __aligned(2)?
>
> /**
>  * is_zero_ether_addr - Determine if give Ethernet address is all zeros.
>  * @addr: Pointer to a six-byte array containing the Ethernet address
>  *
>  * Return true if the address is all zeroes.
>  */
> I think they are completely equivalent functions, no need to check addr is __aligned(2),
> because addr may be defined as unsigned char MacAddress[ETH_ALEN]; the length is 6.

Perhaps you are confusing with eth_zero_addr, which is just a memset and
has no alignment requirements.

julia
