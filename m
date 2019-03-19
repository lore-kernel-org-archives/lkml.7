Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41594C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0451C2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nBPWCPPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCSL34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:29:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47130 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:29:56 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JBTl4w093726;
        Tue, 19 Mar 2019 06:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552994987;
        bh=Es6vVtWdeJw30D9IEs+AiNyE0v+OEBRQ3nwhlu3+zcc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nBPWCPPZYiQU2K4IoDaIcFfUX0coZ7qeeDkfbudf19LAn9vRosAtzS6tEUmVCZ0xA
         yiPihtICQB7RlkRILhFEiSYSTBFaxPVw17lTce3DzB+niQcRFO6lP4oAP9CRhbRfMP
         eIu95rgz9xqQr+v297bxhhhAQgQe3eVj7NqN2LeM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JBTlAm038920
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 06:29:47 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 06:29:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 06:29:46 -0500
Received: from [172.22.111.142] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JBTkKb012195;
        Tue, 19 Mar 2019 06:29:46 -0500
Subject: Re: [PATCH v10 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190315170257.12847-1-dmurphy@ti.com>
 <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <455ea343-818a-e647-6315-e8855ca43ad2@ti.com>
Date:   Tue, 19 Mar 2019 06:29:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 3/19/19 1:24 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> checkpatch still reports one "line over 80 characters".
> 

Yes I saw that one before I submitted I was not happy with how it was to be resolved.
It made the line unreadable I will see how to fix it.

<snip>

>> +
>> +	if (priv->is_peripheral) {
>> +		if (priv->tx_skb) {
>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>> +			return NETDEV_TX_BUSY;
>> +		}
>> +
>> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
>> +			m_can_clean(dev);
>> +		} else {
> 
> Could you please add a comment here about stopping the queue early. I
> would also mention that an improved version may use an array of tx_skbs
>  to support queueing of outgoing messages.
> 

Ack

>> +			priv->tx_skb = skb;
>> +			netif_stop_queue(priv->net);
>> +			queue_work(priv->tx_wq, &priv->tx_work);
>> +		}
>> +	} else {
>> +		priv->tx_skb = skb;
>> +		return m_can_tx_handler(priv);
>>  	}
>>  
>>  	return NETDEV_TX_OK;
>>  }
> 
> At the next respin, you can then add my
> 
>   Acked-by: Wolfgang Grandegger <wg@grandegger.com>
> 
> to the Patch 1/1, 1/2 and 1/4.
> 
> Thanks for your contribution and patience.
> 

No worries.  I am wrapping up tests on our side and see if there is any customer
feedback on this version.  So far the tests look fine no changes.

I should have v11 out by the end of the week.

Latest cangen data for tcan is below.

bitrate 500000 dbitrate 2000000
cangen can0 -g 0 -i  -f &

    11118 transmitted frames (TXF)                                                                                                                                
    11118 received frames (RXF)                                                                                                                                   
        0 matched frames (RXMF)                                                                                                                                   
                                                                                                                                                                  
        0 % total match ratio (RXMR)                                                                                                                              
      442 frames/s total tx rate (TXR)                                                                                                                            
      442 frames/s total rx rate (RXR)                                                                                                                            
                                                                                                                                                                  
        0 % current match ratio (CRXMR)                                                                                                                           
      117 frames/s current tx rate (CTXR)                                                                                                                         
      123 frames/s current rx rate (CRXR)                                                                                                                         
                                                                                                                                                                  
        0 % max match ratio (MRXMR)                                                                                                                               
      498 frames/s max tx rate (MTXR)                                                                                                                             
      488 frames/s max rx rate (MRXR)                                                                                                                             
                                                                                                                                                                  
        0 current receive list entries (CRCV)                                                                                                                     
        0 maximum receive list entries (MRCV)   

> Wolfgang
> 


-- 
------------------
Dan Murphy
