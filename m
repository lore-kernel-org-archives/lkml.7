Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B79C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0CE2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 11:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WbQMl8Q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgAGLch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:32:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54700 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgAGLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 06:32:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200107113235euoutp01acf5f678fb578f63347aef5c48228dd1~nl3yGW_O80160301603euoutp01W
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jan 2020 11:32:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200107113235euoutp01acf5f678fb578f63347aef5c48228dd1~nl3yGW_O80160301603euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578396755;
        bh=ZpHmTs0uJvuMs8mkZW+0snMhdt1maNdaJnzN8zhd98g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WbQMl8Q51QXJ9l2O+g2qHLVVKQVuPVCfJqlojrf1a/T1cNiYKob6sMd9xnLAXc+Wu
         bnwHnwvunqKv+YrQMWCrA2mQkwbRIOPc3WUL3klXRw9p06dPqqEVwq3S6a9G3dkYPj
         BvdbKDBPbcO2RdVQabVQH0mU04bwTK8FC3PYNdOM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200107113235eucas1p143fb5cd1bb80064e2c5254f5a3ff2f8e~nl3xvyytl2625126251eucas1p1-;
        Tue,  7 Jan 2020 11:32:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.E4.61286.35C641E5; Tue,  7
        Jan 2020 11:32:35 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200107113234eucas1p270ac654ada73edf9301acee9ab431b13~nl3xJnWjD3226932269eucas1p2c;
        Tue,  7 Jan 2020 11:32:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200107113234eusmtrp1a7fa29f00f05fe903095d0d78f0d99e9~nl3xI9vli2458124581eusmtrp1D;
        Tue,  7 Jan 2020 11:32:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-04-5e146c53c1e8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CE.DC.08375.25C641E5; Tue,  7
        Jan 2020 11:32:34 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200107113234eusmtip15edd9f58d885624922c8e37789999248~nl3wuYE0y0293302933eusmtip1Y;
        Tue,  7 Jan 2020 11:32:33 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc3: use proper initializers for property entries
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <f2f41b28-2ca5-7fad-5b19-2ad51c689e5a@samsung.com>
Date:   Tue, 7 Jan 2020 12:32:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2a8a5e6b-9372-978e-03d0-350ab65a2d0a@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87rBOSJxBtMusVgca3vCbnF40QtG
        i+bF69ks3hyfzmRxedccNotFy1qZLeZ+mcrswO6xc9Zddo9NqzrZPPbPXcPu8X7fVTaPz5vk
        AlijuGxSUnMyy1KL9O0SuDIedL1iKlgmUnH/9C2mBsZewS5GTg4JAROJZ8uXsHYxcnEICaxg
        lGjY2sgC4XxhlGj+f5MNwvnMKDGlcwIzTMvfzi6oluWMEqum/4Fy3jJKbFx+kAWkSljAR+Lc
        vY2MIAkRgUWMEs8vNbKBJJgF8iQOn7/DCmKzCRhKdL3tAovzCthJbJw9hRHEZhFQkTg/5Qc7
        iC0qECvxf+ZWJogaQYmTM5+ALeAEqj/xfgUTxEx5ieats5khbHGJW0/mM0Gcuo5dYsedmi5G
        DiDbRaJ7BjtEWFji1fEtULaMxOnJPWA/Swg0M0o8PLeWHcLpYZS43DSDEaLKWuLOuV9sIIOY
        BTQl1u/Shwg7Smx7d5MdYj6fxI23ghAn8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCo
        NAvJY7OQPDMLyTOzEPYuYGRZxSieWlqcm55abJiXWq5XnJhbXJqXrpecn7uJEZiETv87/mkH
        49dLSYcYBTgYlXh4J8gIxwmxJpYVV+YeYpTgYFYS4dXSEYkT4k1JrKxKLcqPLyrNSS0+xCjN
        waIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgbFZc5vZvf0nD/Z+el/L8lVt3oz9NXpT1iT/
        9l8eMvVXqFATo4JJlXTSp2hrltfeEbX8/CIfRDiYAhrZtwctf9M2a/uGq7Od2c0EnCWZGoSS
        uRjSZh7Z/NfFe02mV8/l34GpjmVuaw5M6v5tyu7pfd+5+5fm5h6Wvlopp5vPK+5JenJ12qu8
        VmIpzkg01GIuKk4EAFA5+5g+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xu7pBOSJxBjdfS1oca3vCbnF40QtG
        i+bF69ks3hyfzmRxedccNotFy1qZLeZ+mcrswO6xc9Zddo9NqzrZPPbPXcPu8X7fVTaPz5vk
        Alij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIe
        dL1iKlgmUnH/9C2mBsZewS5GTg4JAROJv51drF2MXBxCAksZJZZcPsQGkZCRODmtgRXCFpb4
        c62LDaLoNaPEzmOfwBLCAj4S5+5tZARJiAgsYpS49u86WIJZIE/i3d4N7BAdWxglln/cywiS
        YBMwlOh62wW2glfATmLj7ClgcRYBFYnzU36wg9iiArES2zc/ZIaoEZQ4OfMJC4jNCVR/4v0K
        JogFZhLzoGqYBeQlmrfOhrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJD
        veLE3OLSvHS95PzcTYzAyNt27OfmHYyXNgYfYhTgYFTi4Z0gIxwnxJpYVlyZe4hRgoNZSYRX
        S0ckTog3JbGyKrUoP76oNCe1+BCjKdBzE5mlRJPzgUkhryTe0NTQ3MLS0NzY3NjMQkmct0Pg
        YIyQQHpiSWp2ampBahFMHxMHp1QDo2x3xMGzPkdTWB+G37d89c/6d/gE17c6cu7/j7XvbZxa
        //bwJKcdy0+2Ln+WZyqdwxFWqy7IVrBVadG9/ZmO9tOW1H2urXzm1vmL39V1ifLRP/2ch888
        VdGK5Fb7OSn1bbd/t6sRW9yfWdYF2o9fMc84UXbr4K3MVfcXBjXydUS4b1+hFxf7QImlOCPR
        UIu5qDgRAM32K3PSAgAA
X-CMS-MailID: 20200107113234eucas1p270ac654ada73edf9301acee9ab431b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191215164117eucas1p159471bd0b90b76b6ff64f26f17a6580e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191215164117eucas1p159471bd0b90b76b6ff64f26f17a6580e
References: <20191213174623.GA20267@dtor-ws>
        <CGME20191215164117eucas1p159471bd0b90b76b6ff64f26f17a6580e@eucas1p1.samsung.com>
        <2a8a5e6b-9372-978e-03d0-350ab65a2d0a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 15.12.2019 17:41, Hans de Goede wrote:
> Hi,
>
> On 13-12-2019 18:46, Dmitry Torokhov wrote:
>> We should not be reaching into property entries and initialize them by
>> hand, but rather use proper initializer macros. This way we can alter
>> internal representation of property entries with no visible changes to
>> their users.
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>
>> It would be good if this could go through Rafael's tree as it is needed
>> for the rest of my software_node/property_entry rework patch series
>> which I would love not to delay till 5.6.
>
> Patch looks good to me:
>
> Acked-by: Hans de Goede <hdegoede@redhat.com>

This patch is instantly needed as the issue it fixes is again triggered 
in current (20200107) linux-next by commit e6bff4665c59 "software node: 
replace is_array with is_inline".

Felipe: could You ack it, so it could be merged via Rafael's tree 
together with related device property changes?

>>
>>   drivers/usb/dwc3/host.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
>> index 5567ed2cddbec..fa252870c926f 100644
>> --- a/drivers/usb/dwc3/host.c
>> +++ b/drivers/usb/dwc3/host.c
>> @@ -88,10 +88,10 @@ int dwc3_host_init(struct dwc3 *dwc)
>>       memset(props, 0, sizeof(struct property_entry) * 
>> ARRAY_SIZE(props));
>>         if (dwc->usb3_lpm_capable)
>> -        props[prop_idx++].name = "usb3-lpm-capable";
>> +        props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
>>         if (dwc->usb2_lpm_disable)
>> -        props[prop_idx++].name = "usb2-lpm-disable";
>> +        props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
>>         /**
>>        * WORKAROUND: dwc3 revisions <=3.00a have a limitation
>> @@ -103,7 +103,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>>        * This following flag tells XHCI to do just that.
>>        */
>>       if (dwc->revision <= DWC3_REVISION_300A)
>> -        props[prop_idx++].name = "quirk-broken-port-ped";
>> +        props[prop_idx++] = 
>> PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
>>         if (prop_idx) {
>>           ret = platform_device_add_properties(xhci, props);
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

