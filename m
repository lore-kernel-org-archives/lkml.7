Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E6520857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 13:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfCRN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 09:57:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbfCRN50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 09:57:26 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11874AE1C3FF3EE5510F;
        Mon, 18 Mar 2019 21:57:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.96.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Mar 2019
 21:57:17 +0800
Subject: Re: [PATCH net] staging: rtl8188eu: use is_zero_ether_addr() instead
 of memcmp()
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20190309032600.98732-1-maowenan@huawei.com>
 <20190317112647.GG4614@kroah.com>
CC:     <Larry.Finger@lwfinger.net>, <straube.linux@gmail.com>,
        <jananis37@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <davem@davemloft.net>
From:   maowenan <maowenan@huawei.com>
Message-ID: <eac0fbf3-c52c-fd76-06cf-5bd27f94b39f@huawei.com>
Date:   Mon, 18 Mar 2019 21:57:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190317112647.GG4614@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.96.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/3/17 19:26, Greg KH wrote:
> On Sat, Mar 09, 2019 at 11:26:00AM +0800, Mao Wenan wrote:
>> Using is_zero_ether_addr() instead of directly use
>> memcmp() to determine if the ethernet address is all
>> zeros.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> ---
>>  drivers/staging/rtl8188eu/core/rtw_mlme.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> index 714f7a70ed64..beae367df93b 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
>> @@ -180,9 +180,8 @@ struct wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
>>  {
>>  	struct list_head *phead, *plist;
>>  	struct wlan_network *pnetwork = NULL;
>> -	u8 zero_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
>>  
>> -	if (!memcmp(zero_addr, addr, ETH_ALEN)) {
>> +	if (is_zero_ether_addr(addr)) {
> 
> As Joe said, you have to prove that this is properly aligned before you
> can call this function.  Please do so.

The previous function to call rtw_find_network(), has been aligned for parameter 'addr',
because it has been defined an arry[6];
such as unsigned char MacAddress[ETH_ALEN] in struct wlan_bssid_ex;
 179 struct wlan_bssid_ex {
 180         u32  Length;
 181         unsigned char MacAddress[ETH_ALEN];
 182         u8  Reserved[2];/* 0]: IS beacon frame */
 183         struct ndis_802_11_ssid  ssid;
 184         u32  Privacy;
 185         NDIS_802_11_RSSI  Rssi;/* in dBM,raw data ,get from PHY) */
 186         enum  NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
 187         struct ndis_802_11_config  Configuration;
 188         enum ndis_802_11_network_infra  InfrastructureMode;
 189         unsigned char SupportedRates[NDIS_802_11_LENGTH_RATES_EX];
 190         struct wlan_phy_info    PhyInfo;
 191         u32  ie_length;
 192         u8  ies[MAX_IE_SZ];     /* timestamp, beacon interval, and
 193                                  * capability information)
 194                                  */
 195 } __packed;

rtw_survey_event_callback->rtw_find_network(&pmlmepriv->scanned_queue,  pnetwork->MacAddress);
struct wlan_bssid_ex *pnetwork;

> 
> thanks,
> 
> greg k-h
> 
> .
> 

