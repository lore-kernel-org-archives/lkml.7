Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D2BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ABA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfCYReg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:34:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbfCYRef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:34:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PHYGma106503
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:34:34 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rf1tqndv0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:34:33 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <fbarrat@linux.ibm.com>;
        Mon, 25 Mar 2019 17:34:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Mar 2019 17:34:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2PHYSC843057276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 17:34:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4264DA4054;
        Mon, 25 Mar 2019 17:34:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2B9AA405F;
        Mon, 25 Mar 2019 17:34:27 +0000 (GMT)
Received: from [9.145.37.149] (unknown [9.145.37.149])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Mar 2019 17:34:27 +0000 (GMT)
Subject: Re: [PATCH v4 0/4] ocxl: OpenCAPI Cleanup
To:     Greg Kurz <groug@kaod.org>,
        "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20190320053448.2098-1-alastair@au1.ibm.com>
 <20190325053456.14599-1-alastair@au1.ibm.com>
 <20190325174919.5c877cf9@bahia.lab.toulouse-stg.fr.ibm.com>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Date:   Mon, 25 Mar 2019 18:34:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325174919.5c877cf9@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032517-0012-0000-0000-00000306F697
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032517-0013-0000-0000-0000213E1BD6
Message-Id: <5d6792fe-f4db-b973-c654-460533f69f2f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/03/2019 à 17:49, Greg Kurz a écrit :
> Hi Alastair,
> 
> I forgot to mention it during v3 but please don't link new version
> of a patchset to the previous one with --in-reply-to. This is to
> ensure I can see them in my email client without having to scroll
> back many days in the past (which likely means a fair number of
> e-mails on linuxppc-dev).


I'm also seeing the other series (ocxl refactoring) somehow under the 
same thread. I haven't checked why, and there may be some mail client 
bug in the way, I just mention it in case you see a reason for it in the 
way you submit the patch set.

   Fred


> 
> Cheers,
> 
> --
> Greg
> 
> On Mon, 25 Mar 2019 16:34:51 +1100
> "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> 
>> From: Alastair D'Silva <alastair@d-silva.org>
>>
>> Some minor cleanups for the OpenCAPI driver as a prerequisite
>> for an ocxl driver refactoring to allow the driver core to
>> be utilised by external drivers.
>>
>> Changelog:
>> V4:
>>    - Drop printf format changes as they omit the format indicator for '0'
>> V3:
>>    - Add missed header in 'ocxl: Remove some unused exported symbols'.
>>      This addresses the introduced sparse warnings
>> V2:
>>    - remove intermediate assignment of 'link' var in
>>                  'Rename struct link to ocxl_link'
>>    - Don't shift definition of ocxl_context_attach in
>>                  'Remove some unused exported symbols'
>>
>>
>> Alastair D'Silva (4):
>>    ocxl: Rename struct link to ocxl_link
>>    ocxl: read_pasid never returns an error, so make it void
>>    ocxl: Remove superfluous 'extern' from headers
>>    ocxl: Remove some unused exported symbols
>>
>>   drivers/misc/ocxl/config.c        | 13 ++---
>>   drivers/misc/ocxl/file.c          |  5 +-
>>   drivers/misc/ocxl/link.c          | 36 ++++++-------
>>   drivers/misc/ocxl/ocxl_internal.h | 85 +++++++++++++++++++------------
>>   include/misc/ocxl.h               | 53 ++++++-------------
>>   5 files changed, 91 insertions(+), 101 deletions(-)
>>
> 

