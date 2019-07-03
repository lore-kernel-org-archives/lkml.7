Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE47C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55379218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGCPle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:41:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:41:33 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbBO-1hkOCm1z9a-00H6sP; Wed, 03 Jul 2019 17:41:26 +0200
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: [PATCH V2 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
 <20190703144744.GB24961@kroah.com>
Organization: metux IT consult
Message-ID: <d6910b29-3ba6-4a3b-04e2-bc7c3c012554@metux.net>
Date:   Wed, 3 Jul 2019 17:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190703144744.GB24961@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3dOcmIGEkAM08//41I7vay90MaBpkwX4UMW2+gVi+GNdg85Nbam
 yXF03WAXoE9vFBQVhT41c7XGC16rlJng1HdO8y+vA2VxevGZkYBxZZ+ZNhk9IS3Cs7l0tMl
 rKQBkpFnJJMxLDGyOXfFRurBvE1Jzvs+W71kxkeZkDF3LOrFAnTq6pAH/0XXP5lmhOR/FWH
 YLutAL7ErTJ04AGhyXT9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x0KH2hHZ5zg=:N47WCePoky0Mhppuxc+Trt
 oG4amhbYb74t602pHHzdYa/tyZ67ae1OcvWI/i/LOwPykG++L5sDMkBXL/XxwbzZtpbBEICgR
 A5eSpJV253ybL5m4UZywStJsoIdpkHM3ZlthBCAvpQJPly3kf2XyVtChRb2lLIAgVs97p582R
 0WSHwNg9WUU/yZpBDIDc5lR2yNsp7a1Vv4vtWpa8CcffbBwbH5EtedUodGIEEgb5tQlkMfmHK
 EKAkjayYPFUjsZkbNAYfKG5y8v0zd9VQTvTxIU/DhckcoGivJpnZzIbt0iNU32nxn5w1JFq44
 WOVfDBFJPkoOWHLcwQcQUlw2sDK6bCXp11n7FYLZr8T1Pj1JGuCweBD5E80KVUwjr6C3IChy7
 wgh2iN9XT+7553P6WyXIJl52PNv+cPh4IdZs/mz55GfA1wimxo7zIqTjdsNmbX7BCSsN7QQrL
 622SYKRw4H6Qsv1iwZQis2sxegOXFpy/Xytq09CedyzE1fJiHJDvx6Cet2tTIruF8dn4EWJdU
 QlGoJPAJ/WLgbSZJJ6RxRG0VrB7qZnQ9Vc7YgdYzt6q9wS2v5Ff+j73qqA+yevJp9EMZTspQR
 SBjz4QDsMQNJi9vhZSDfj1m10UkEU/h5Zs/v5P1LwJ749bGxp8YPtSeOjFgXjffQqrWykANJJ
 M+VY3u4Lx3lNy6+tlTE0y7ePoS87HWXFVef/u5S6SBgzeK5shU8yYtlMDSGBkNm/9Lq++rFZK
 UJ5g8b6xYV8vntimcsJiUo314WvV0zWY6/FeeuFoXq5d9+O1D56z8fZKHiQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.19 16:47, Greg KH wrote:
> On Wed, Jul 03, 2019 at 03:27:11PM +0200, Enrico Weigelt, metux IT consult wrote:
>>>  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
>> Can we have that renaming as a separate patch, to ease review ?
>>
>> And what about introducing a config sym for the new device specific
>> stuff ? These devices seem to be pretty rare - never seen them in
>> embeded world, where we do need to care of kernel size.
> 
> No, that's not the way this driver works, sorry.

That's sad, because in embedded world we often have to care about
code size, so making those devices optional would be of great help.

OTOH, the 8250 driver already has several such options. What's your
concern about adding another one for a new device ? Config variant
inflation ? Would putting it behind CONFIG_EXPERT or CONFIG_EMBEDDED
an option ?


thx.
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
