Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5866C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E4A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAFJpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:45:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbgAFJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:45:39 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0069gQle066037
        for <linux-kernel@vger.kernel.org>; Mon, 6 Jan 2020 04:45:38 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb93j48h0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 04:45:38 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Mon, 6 Jan 2020 09:45:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 Jan 2020 09:45:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0069jWMp33554560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jan 2020 09:45:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C10DAAE055;
        Mon,  6 Jan 2020 09:45:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 955C8AE04D;
        Mon,  6 Jan 2020 09:45:31 +0000 (GMT)
Received: from [9.124.31.198] (unknown [9.124.31.198])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jan 2020 09:45:31 +0000 (GMT)
Subject: Re: [RFC 0/3] Integrate Support for self-save and determine
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        pratik.sampat@in.ibm.com
References: <20191204093255.11849-1-psampat@linux.ibm.com>
 <20200103230551.GB5562@oc0525413822.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Mon, 6 Jan 2020 15:15:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103230551.GB5562@oc0525413822.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010609-0016-0000-0000-000002DAD016
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010609-0017-0000-0000-0000333D42AD
Message-Id: <31b49402-8af9-fcd7-0c43-d8dd15ce78d7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_02:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=958
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments Ram,
>> A list of preferred SPRs are maintained in the kernel which contains two
>> properties:
>> 1. supported_mode: Helps in identifying if it strictly supports self
>>                     save or restore or both.
> Will be good to capture the information that, 'supported_mode' gets
> initialized using the information from the device tree.
>
>> 2. preferred_mode: Calls out what mode is preferred for each SPR. It
>>                     could be strictly self save or restore, or it can also
>>                     determine the preference of  mode over the other if both
>>                     are present by encapsulating the other in bitmask from
>>                     LSB to MSB.
> and 'preferred_mode'  is statically initialized.
>
Sure thing, I'll mention that.

>> Below is a table to show the Scenario::Consequence when the self save and
>> self restore modes are available or disabled in different combinations as
>> perceived from the device tree thus giving complete backwards compatibly
>> regardless of an older firmware running a newer kernel or vise-versa.
>>
>> SR = Self restore; SS = Self save
>>
>> .-----------------------------------.----------------------------------------.
>> |             Scenario              |                Consequence             |
>> :-----------------------------------+----------------------------------------:
>> | Legacy Firmware. No SS or SR node | Self restore is called for all         |
>> |                                   | supported SPRs                         |
>> :-----------------------------------+----------------------------------------:
>> | SR: !active SS: !active           | Deep stop states disabled              |
>> :-----------------------------------+----------------------------------------:
>> | SR: active SS: !active            | Self restore is called for all         |
>> |                                   | supported SPRs                         |
>> :-----------------------------------+----------------------------------------:
>> | SR: active SS: active             | Goes through the preferences for each  |
>> |                                   | SPR and executes of the modes          |
>> |                                   | accordingly. Currently, Self restore is|
>> |                                   | called for all the SPRs except PSSCR   |
>> |                                   | which is self saved                    |
>> :-----------------------------------+----------------------------------------:
>> | SR: active(only HID0) SS: active  | Self save called for all supported     |
>> |                                   | registers expect HID0 (as HID0 cannot  |
>> |                                   | be self saved currently)               |
> Not clear, how this will be conveyed to the hypervisor? Through the
> device tree or through some other means?
>
This information will be conveyed through the device tree. I'll frame a sentence
that makes this more explicit.

>> :-----------------------------------+----------------------------------------:
>> | SR: !active SS: active            | currently will disable deep states as  |
>> |                                   | HID0 is needed to be self restored and |
>> |                                   | cannot be self saved                   |
>> '-----------------------------------'----------------------------------------'
>>
>> Pratik Rajesh Sampat (3):
>>    powerpc/powernv: Interface to define support and preference for a SPR
>>    powerpc/powernv: Introduce Self save support
>>    powerpc/powernv: Parse device tree, population of SPR support
>>
>>   arch/powerpc/include/asm/opal-api.h        |   3 +-
>>   arch/powerpc/include/asm/opal.h            |   1 +
>>   arch/powerpc/platforms/powernv/idle.c      | 431 ++++++++++++++++++---
>>   arch/powerpc/platforms/powernv/opal-call.c |   1 +
>>   4 files changed, 379 insertions(+), 57 deletions(-)
>>
>> -- 
>> 2.21.0

