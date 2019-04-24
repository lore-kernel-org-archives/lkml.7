Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA9DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5183C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uSbQjGKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfDXOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:55:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51888 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731272AbfDXOzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:55:19 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OEtDvR115379;
        Wed, 24 Apr 2019 09:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556117713;
        bh=h7BkjkKX+qx2rUolg4bMIbzVo5irITD/VvdLJOXugT0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=uSbQjGKHPIki3NrzFtkKCZ7N89qi+DLeoOW17DBIpa0qnVMGIBmt0U5RxcyZE0exU
         tQqCnVHNcrBcltSqFDKGDZc4NSfHFLuFPwmHDldgUbofIEda+bZh7R8Ev+Sz25sgbE
         8O3Iqe0cAfhK426m1SFYRZqDeyXVePXK/YRRtrRw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OEtDGi041214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 09:55:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 09:55:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 09:55:13 -0500
Received: from [172.22.184.139] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OEtAS2075145;
        Wed, 24 Apr 2019 09:55:11 -0500
Subject: Re: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg
 in dual_mac mode
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
 <20190424122230.GA6075@khorivan>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <be83a21e-4831-d592-8fd4-608d4da05b63@ti.com>
Date:   Wed, 24 Apr 2019 17:55:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190424122230.GA6075@khorivan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.04.19 15:22, Ivan Khoronzhuk wrote:
> On Tue, Apr 23, 2019 at 04:09:02PM +0300, Grygorii Strashko wrote:
>> Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
>> Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
>> belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
>> working in non dual_mac mode, but in dual_mac - it causes
>> enabling/disabling ALLMULTI flag for both ports.
>>
>> Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
>> specify ALE port number for which ALLMULTI has to be enabled and check if
>> port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
>> drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
>> drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
>> 3 files changed, 20 insertions(+), 6 deletions(-)
>>
> [...]
>> +        vlan_members =
>> +            cpsw_ale_get_vlan_member_list(ale_entry,
>> +                              ale->vlan_field_bits);
> Seems like declaration for cpsw_ale_get_vlan_member_list() is not
> part of the patchset
> 
> 

It's define :)
DEFINE_ALE_FIELD1(vlan_member_list,	0)


-- 
Best regards,
grygorii
