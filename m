Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10484215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PeH+ouAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgACMWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:22:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57087 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgACMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:22:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200103122249euoutp0291fb7a61cd85e260e9dde3b0de2d44c6~mX_fyqLpr2568425684euoutp027
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 12:22:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200103122249euoutp0291fb7a61cd85e260e9dde3b0de2d44c6~mX_fyqLpr2568425684euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578054169;
        bh=qz3vCml/Vlv9r1Aqb/Ae+7dojZSRbFwZFZBgN3gJ9PE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PeH+ouAbYcLItY9Eeq02aCEmLyuCBXJlL1vjfJpM6vxMew8MEboyvnGTNvA28LOT9
         etdkyw1DHRpnPxZ8k5xYK63DWAIsUIQathoxzF+uLDSwxclNok/nW762ehBeSjBHzs
         ORiwL5p6O4BcXhNLh8kcd3iRt3Qt/Z1w9GCUxZHs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200103122249eucas1p17ca28c5846788fef6b0f3b5b00ede7c8~mX_foA69D2967629676eucas1p1Z;
        Fri,  3 Jan 2020 12:22:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.7A.61286.8123F0E5; Fri,  3
        Jan 2020 12:22:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200103122248eucas1p1f3053cb6b27525299714825e771cd92a~mX_fGGjIj2965629656eucas1p1d;
        Fri,  3 Jan 2020 12:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200103122248eusmtrp23d8ab4de1d67357e5c4342a454d60add~mX_fFhsAd2952829528eusmtrp2f;
        Fri,  3 Jan 2020 12:22:48 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-09-5e0f3218a055
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.34.07950.8123F0E5; Fri,  3
        Jan 2020 12:22:48 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200103122248eusmtip2c33eba0f91e0b29ed1c6092afd6d6fb9~mX_eztqxD0532905329eusmtip2J;
        Fri,  3 Jan 2020 12:22:48 +0000 (GMT)
Subject: Re: [PATCH] fbdev: matrox: make array wtst_xlat static const, makes
 object smaller
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Colin King <colin.king@canonical.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <fce5c5cc-bbb3-40a9-27fe-90957d25e7fe@samsung.com>
Date:   Fri, 3 Jan 2020 13:22:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906181714.GU7482@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djPc7oSRvxxBl8vWVj8Xt3LZnHl63s2
        i623pC1O9H1gtbi8aw6bxfd/C5kc2DxmNfSyecw7Gehxv/s4k8fnTXIBLFFcNimpOZllqUX6
        dglcGScvL2AueM1fMWPvC/YGxgM8XYycHBICJhIzTvxi6mLk4hASWMEocez2LjYI5wujxJ8b
        jxghnM+MEpP/7wJyOMBafraIQMSXM0o8uL4Zqv0to8SjD1MZQeYKC8RKbF/zjB3EFhHIlfiz
        /RMrSBGzQCOjxLk7V9lAEmwCVhIT21eBNfAK2EksOf6XGWQDi4CKxKXLkiBhUYEIiU8PDrNC
        lAhKnJz5hAXE5hTQk2i8eRpsPrOAuMStJ/OZIGx5ieats5khflvELvGsmQvCdpFonvKMCcIW
        lnh1fAs7hC0j8X/nfLAHJATWMUr87XjBDOFsZ5RYPvkfG0SVtcSdc7/YQI5jFtCUWL9LHyLs
        KHH75CR2SKjwSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSD6bheSb
        WUi+mYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAVHP63/FPOxi/Xko6xCjA
        wajEw5ugzB8nxJpYVlyZe4hRgoNZSYS3PJA3Tog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKX
        sUIC6YklqdmpqQWpRTBZJg5OqQbGjQaX36aZcDZ8ZuCWMeSJd59c6bT4QdUFx0V8//2LnaqO
        3i9Tjd/pd8R4o2DX0x/tGWwrKlqzZnI8+NZxMM93s1p35oVXd39+uV1i82vprUurPD1Yl1xc
        tDWmv3DFy/dL/t1f0vxwmoKQm+5r64sHnz07MSH8bJ6uqq9KfNhB1+QnEv80l3c6KLEUZyQa
        ajEXFScCAMqB/tcxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7oSRvxxBtdWy1r8Xt3LZnHl63s2
        i623pC1O9H1gtbi8aw6bxfd/C5kc2DxmNfSyecw7Gehxv/s4k8fnTXIBLFF6NkX5pSWpChn5
        xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GScvL2AueM1fMWPvC/YG
        xgM8XYwcHBICJhI/W0S6GLk4hASWMkqc6bnFAhGXkTi+vqyLkRPIFJb4c62LDaLmNaNE16d2
        ZpCEsECsxPY1z9hBbBGBXIkb2zYxgxQxCzQySiw58p8JomMro8TZ3cfBOtgErCQmtq9iBLF5
        Bewklhz/ywyyjUVAReLSZUmQsKhAhMThHbOgSgQlTs58wgJicwroSTTePA22jFlAXeLPvEvM
        ELa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqX
        rpecn7uJERhb24793LKDsetd8CFGAQ5GJR5eDkX+OCHWxLLiytxDjBIczEoivOWBvHFCvCmJ
        lVWpRfnxRaU5qcWHGE2BfpvILCWanA+M+7ySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp
        2ampBalFMH1MHJxSDYyBUy6YSJ3LdlpU1CJ5lOm31MPOfOnpeRO/sDup+8W4XHCUmb+40+3O
        ko9dpxulQqIvCNpvYZVJWO+dstN7y7z6ybnfalZv8by+/n77teyVrVIdp/pLjuaenvWmjW91
        sOwN5oDg+EJ54ZgDK5o3McnbVfpOVperLf1z667tFjadG9Zhd9uSxJVYijMSDbWYi4oTAcCX
        MPbDAgAA
X-CMS-MailID: 20200103122248eucas1p1f3053cb6b27525299714825e771cd92a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190906181721epcas4p4be0f813e9da4d8e386b7a1c0b2ab1da7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190906181721epcas4p4be0f813e9da4d8e386b7a1c0b2ab1da7
References: <20190906181114.31414-1-colin.king@canonical.com>
        <CGME20190906181721epcas4p4be0f813e9da4d8e386b7a1c0b2ab1da7@epcas4p4.samsung.com>
        <20190906181714.GU7482@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/19 8:17 PM, Ville Syrjälä wrote:
> On Fri, Sep 06, 2019 at 07:11:14PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Don't populate the array wtst_xlat on the stack but instead make it
>> static const. Makes the object code smaller by 89 bytes.
>>
>> Before:
>>    text	   data	    bss	    dec	    hex	filename
>>   14347	    840	      0	  15187	   3b53	fbdev/matrox/matroxfb_misc.o
>>
>> After:
>>    text	   data	    bss	    dec	    hex	filename
>>   14162	    936	      0	  15098	   3afa	fbdev/matrox/matroxfb_misc.o
>>
>> (gcc version 9.2.1, amd64)
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

>> ---
>>  drivers/video/fbdev/matrox/matroxfb_misc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/matrox/matroxfb_misc.c b/drivers/video/fbdev/matrox/matroxfb_misc.c
>> index c7aaca12805e..feb0977c82eb 100644
>> --- a/drivers/video/fbdev/matrox/matroxfb_misc.c
>> +++ b/drivers/video/fbdev/matrox/matroxfb_misc.c
>> @@ -673,7 +673,10 @@ static int parse_pins5(struct matrox_fb_info *minfo,
>>  	if (bd->pins[115] & 4) {
>>  		minfo->values.reg.mctlwtst_core = minfo->values.reg.mctlwtst;
>>  	} else {
>> -		u_int32_t wtst_xlat[] = { 0, 1, 5, 6, 7, 5, 2, 3 };
>> +		static const u_int32_t wtst_xlat[] = {
>> +			0, 1, 5, 6, 7, 5, 2, 3
> 
> All of those would easily fit in u8 as well.

Good idea, I've converted the table to u8 while applying the patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> +		};
>> +
>>  		minfo->values.reg.mctlwtst_core = (minfo->values.reg.mctlwtst & ~7) |
>>  						  wtst_xlat[minfo->values.reg.mctlwtst & 7];
>>  	}
>> -- 
>> 2.20.1
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
