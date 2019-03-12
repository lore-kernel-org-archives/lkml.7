Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6775C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3EB214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCLGff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:35:35 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:44299 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbfCLGfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:35:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 03025180A8128;
        Tue, 12 Mar 2019 06:35:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast78_4d5733bdfe242
X-Filterd-Recvd-Size: 1746
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Mar 2019 06:35:31 +0000 (UTC)
Message-ID: <e192c19b35ba5a07ed6bea571546800cc3235282.camel@perches.com>
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr()
 instead of memcmp()
From:   Joe Perches <joe@perches.com>
To:     maowenan <maowenan@huawei.com>, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        jananis37@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        davem@davemloft.net
Date:   Mon, 11 Mar 2019 23:35:30 -0700
In-Reply-To: <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
References: <20190309032600.98732-1-maowenan@huawei.com>
         <951c83d2-fa0d-11ed-96a9-cee620c9c096@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 14:29 +0800, maowenan wrote:
> ping...
> 
> On 2019/3/9 11:26, Mao Wenan wrote:
> > Using is_zero_ether_addr() instead of directly use
> > memcmp() to determine if the ethernet address is all
> > zeros.
[]
> > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
[]
> > @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
> >  {
> >  	struct list_head *phead, *plist;
> >  	struct wlan_network *pnetwork = NULL;
> > -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
> >  
> > -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
> > +	if (is_zero_ether_addr(addr)) {

How did you verify that addr is __aligned(2)?


