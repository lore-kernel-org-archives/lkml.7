Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0ADC04AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5509F21734
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 00:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AyTp4DAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfENAa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 20:30:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60426 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfENAa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 20:30:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4E0PJ3N096987;
        Tue, 14 May 2019 00:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=awusX5KusKoMqfGq8orFA79bqB9DalQkbscQVXD0cSU=;
 b=AyTp4DAk6mUOuwSpYVVIcwjT7nknRD0dOMS+MSxR96tdcGMsUmruqfgH7riJbVm4nmtz
 EQ9a8eoMKOX8okolgRI+qfFpIhJUTp3dEL0Dca1VjMn7D6Ae6ZT/9Dfb7rFiZ//cdhPZ
 Y0ZoexEH4z9X6cGfUlF3Qb3UfUG4NqCDQeoFXLs3OfzpSY0rPZ6YqCZZ6ckZRJy14r0e
 wktqMfoyAdN0ODqXzwCJprtRozrmoeQb+JIJko7+kGKiibCKwfx/KfzS09pxhJRJIUk+
 487qNT1PtwYFCVTdgY3nF2Udw+gr4q/hkqpGCqbT6v6+doAOVkEEqUawoG9oh0q77Es5 6w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2sdq1qacq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 00:30:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4E0TI8J082352;
        Tue, 14 May 2019 00:30:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2se0tvuq9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 00:30:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4E0UDQo012725;
        Tue, 14 May 2019 00:30:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 17:30:12 -0700
To:     <Don.Brace@microchip.com>
Cc:     <erwanaliasr1@gmail.com>, <e.velu@criteo.com>,
        <don.brace@microsemi.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <esc.storagedev@microsemi.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: smartpqi: Reporting unhandled SCSI errors
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190321094928.4198-1-e.velu@criteo.com>
        <CAL2JzuyHb_gfu5Suf3yaMF1883JN1667yhEwpdmoiqYrUTO2YA@mail.gmail.com>
        <SN6PR11MB2767E3FB513853E9666779B9E13B0@SN6PR11MB2767.namprd11.prod.outlook.com>
Date:   Mon, 13 May 2019 20:30:10 -0400
In-Reply-To: <SN6PR11MB2767E3FB513853E9666779B9E13B0@SN6PR11MB2767.namprd11.prod.outlook.com>
        (Don Brace's message of "Wed, 1 May 2019 14:22:11 +0000")
Message-ID: <yq1imudg9nx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140001
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=897 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> When a HARDWARE_ERROR is triggered for asc=0x3e, the actual code is
>> only considering the case where ascq=0x1.
>>
>> Following the http://www.t10.org/lists/asc-num.htm#ASC_3E
>> specification, other values may occur like a timeout (ascq=0x2).
>>
>> This patch is about printing an error message when a non-handled
>> message is received.  This could help diagnose a possible
>> miss-behavior of the controller and/or a missing implementation in
>> the Linux Kernel.
>>
>> This patch keeps the exact same error handling but prints a message
>> if an ascq != 1 income.
>>
>> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> Acked-by: Don Brace <don.brace@microsemi.com>

Applied to 5.2/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
