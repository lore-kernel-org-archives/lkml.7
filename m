Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D520675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FXW9xAom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCEHSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:18:17 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:47994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEHSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:18:17 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190305071813epoutp02b3774c496ce6be00d6026a06d987f800~I-tww97fD1291012910epoutp02d
        for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2019 07:18:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190305071813epoutp02b3774c496ce6be00d6026a06d987f800~I-tww97fD1291012910epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551770293;
        bh=i4zEeTT43EE+Dr1b7LVsVjeb/bJRaNEu06/u2twqYLg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=FXW9xAomrIQaR++Iemf7IzHiagM+9XYGJHXT2kP6vFW3CaR4547xfYQRWVmPiTl8G
         C/+hsaEO29vd03O/85VLiQu0jwov3Xzdvd5cIMaIyYhJhIznRggzBOxE9XQA6RkPxU
         BR6Arv7ZPppyltXRuf5uJPqOYsVTuIiCe0i6CbnE=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190305071810epcas1p3b071497b6f8a3fba2ea04b8f7ba40daf~I-tuPavS-1678416784epcas1p30;
        Tue,  5 Mar 2019 07:18:10 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-40-5c7e22b02373
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.3A.04069.0B22E7C5; Tue,  5 Mar 2019 16:18:08 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4] PM / devfreq: Restart previous governor if new
 governor fails to start
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Sibi Sankar <sibis@codeaurora.org>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm-owner@vger.kernel.org" 
        <linux-arm-msm-owner@vger.kernel.org>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <946aa4e13aec4f84e6ae2d91e772fb1f@codeaurora.org>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190305071808epcms1p89cd924ae1c7fc344b7e554f5f18592d2@epcms1p8>
Date:   Tue, 05 Mar 2019 16:18:08 +0900
X-CMS-MailID: 20190305071808epcms1p89cd924ae1c7fc344b7e554f5f18592d2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA11SbUhTYRjt3Z3zal15WzPf1te6VKAwt6vOrjaHMamBBUL9Esku7uKW+2J3
        ShbJkqKyDMWgNJ1aVmDQVpkbKiUro7JJIhRW9iFJJNMCDRTXxz5R+nc4nOec57zvg2PCeoEY
        15tsrNXEGEhBIr/3SapU6iJrSuS+ke30d28q/Xb+Wxztq/XH00s3GuLpsb5WAT1X/xTQbzp/
        xNGDo42CfFwzdqmep7nU0w00c/e3FGHFFUody2hZq4Q1lZm1elN5Hll4sFRdqsiWU1Iqh95F
        SkyMkc0jC/YXSffqDcEFSEkVY6gMUkUMx5EyldJqrrSxEp2Zs+WRrEVrsORY0jnGyFWaytPL
        zMZcSi7PUASFRyp0L5f+YJbRpGPtk25gB+9X14EEHMEsdPnKA6wOJOJC6AHI2dvMqwM4TsC1
        6LdnXUizDmpRZ/8FEMJCSCL7+CMswsvQuc+9YV4Apeiha4IfwiJ4EA24FkHIE4O3eMjun8Yi
        YQS6enaKH8Ebkfv2w/BwAlSh8wu1vAifjMbvzMTH8I9n7SCCRejMR1/UZy36vNgPYj5XL/+N
        ep5AkxdHw2UQPA1Qd3Nv1FSGXrW9EESKHUD+js0hmg93oLrf49HZAnTTExCEMAa3IvdMKxaS
        YzAVOftksfXt95bi/8cYTEKzvy7GxXiP42s0dSfy9ndF9ZvQ8JXOsCWCGnSqXdQAtrUsP3TL
        ityW5dwOgHWD9ayFM5azHGXJXPm390H4FNN2eYBrZL8XQByQawhd9skSYRxTxVUbvQDhGCki
        Aik1JUJCy1QfZ63mUmulgeW8QBGs34iJk8vMwcM22UopRUZmZiadRWUrKIpMIZz56hIhLGds
        bAXLWlhrbI6HJ4jtABC5M5pAU0DXsb0pF9dPyK7pR9ih9TXfc5yHbD+rCffCADm7cBg7+unb
        F2X6cJKfns7/iItNp6eZMeOew6p9tV3+Zv/uHofjw6Baid8detf6or1hfjLr9Z4qx/EBl0r9
        uHjV7FSyPeFkm891ZnGDXynjdjgLVRLP9ecujiD5nI6h0jArx/wDEjj3yqADAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07
References: <946aa4e13aec4f84e6ae2d91e772fb1f@codeaurora.org>
        <20181212135313.30268-1-sibis@codeaurora.org>
        <20181214014527epcms1p6c783b4cd1602bbcbcb6e725f840db479@epcms1p6>
        <39d3a906-b734-9bb8-c60a-48948bb21338@codeaurora.org>
        <CGME20181212135338epcas5p12f7a8cd1c7aab5d5c936cbc5c33eee07@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hey MyungJoo, Kyungmin
>Did you get a chance to think about how you
>want this fix implemented?
>
>On 2019-02-19 10:42, Sibi Sankar wrote:
>> Hey MyungJoo,
>> 
>> On 12/14/18 7:15 AM, MyungJoo Ham wrote:
>>>> From: Saravana Kannan <skannan@codeaurora.org>
>>>> 
>>>> If the new governor fails to start, switch back to old governor so 
>>>> that the
>>>> devfreq state is not left in some weird limbo.
>>>> 
>>>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> 
>>> Hello,
>>> 
>>> In overall, the idea and the implementation looks good.
>>> 
>>> However, I have a question:
>>> 
>>> What if the following line fails?
>>> 
>>> +		df->governor->event_handler(df, DEVFREQ_GOV_START,
>>> +					    NULL);
>>> 
>>> Don't we still need something to handle for such events?
>> 
>> The original discussion went as follows:
>> governor_store is expected to be used only on cases
>> where devfreq_add_device() succeeded i.e prev->governor
>> is expected to be present and DEVFREQ_GOV_START is
>> expected to succeed. Hence falling back to the previous
>> governor seems like a sensible idea.
>> 
>> This would also prevent DEVFREQ_GOV_STOP from being called
>> on a governor were DEVFREQ_GOV_START had failed which is
>> ideal.
>> 
>> That being said DEVFREQ_GOV_START can still fail for the
>> prev-governor due to some change in state of the system.
>> Do you want to handle this case by clearing the state of
>> governor rather than switching to previous governor?
>> 

If moving back to previous governor fails after
failing for "next" governor, we may assume it's fatal
and stop the device; we can simply return errors.

In such a case, df->governor may need to be NULL as well.


Cheers,
MyungJoo
