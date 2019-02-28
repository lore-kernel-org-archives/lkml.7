Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F432171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfB1Lnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:43:49 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:21287 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731013AbfB1Lns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:43:48 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="79311923"
Subject: Re: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
To:     Paul Durrant <Paul.Durrant@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
References: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
 <8424fba34a1f43908a6dae3a9308863b@AMSPEX02CL02.citrite.net>
 <20190228110136.somjads2f5ivqhju@zion.uk.xensource.com>
 <e5ef3c0291854b67841b6c532f7651b9@AMSPEX02CL02.citrite.net>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <447cd231-3ea4-e56d-29b0-6528804c9e9a@citrix.com>
Date:   Thu, 28 Feb 2019 11:43:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e5ef3c0291854b67841b6c532f7651b9@AMSPEX02CL02.citrite.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 11:21, Paul Durrant wrote:
>>> @@ -1153,6 +1152,10 @@ static int xenvif_tx_submit(struct xenvif_queue *queue)
>>>                                 kfree_skb(skb);
>>>                                 continue;
>>>                         }
>>> +
>>> +                       /* Copied all the bits from the frag list. */
>>> +                       skb_frag_list_init(skb);
>>> +                       kfree(nskb);
>>
>> I think you want kfree_skb here?
> 
> No. nskb is the frag list... it is unlinked from skb by the call to skb_frag_list_init() and then it can be freed on its own. The skb is what we need to retain, because that now contains all the data.
> 

Are you saying previous code in xenvif_handle_frag_list() incorrectly
called kfree_skb()?

Igor
