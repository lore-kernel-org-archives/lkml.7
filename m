Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541C3CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2510420873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfJaJ4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:56:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726864AbfJaJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:56:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9V9o3AE101836
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:56:49 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyu6pw0bq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:56:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 31 Oct 2019 09:56:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Oct 2019 09:56:44 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9V9uhe541287908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 09:56:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 386DB11C05C;
        Thu, 31 Oct 2019 09:56:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDB9711C050;
        Thu, 31 Oct 2019 09:56:42 +0000 (GMT)
Received: from dyn-9-152-96-251.boeblingen.de.ibm.com (unknown [9.152.96.251])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Oct 2019 09:56:42 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] scripts/gdb: fix debugging modules compiled with hot/cold
 partitioning
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
Date:   Thu, 31 Oct 2019 10:56:42 +0100
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 7bit
References: <20191028152734.13065-1-iii@linux.ibm.com>
 <130e31f0-ce38-77cb-58a9-cedf3b0f8113@siemens.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19103109-0020-0000-0000-000003814697
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19103109-0021-0000-0000-000021D75B92
Message-Id: <565ED332-3D0E-4741-BB82-3E82371C7054@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-31_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910310098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 30.10.2019 um 19:29 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
> On 28.10.19 16:27, Ilya Leoshkevich wrote:
>> gcc's -freorder-blocks-and-partition option makes it group frequently
>> and infrequently used code in .text.hot and .text.unlikely sections
>> respectively. At least when building modules on s390, this option is
>> used by default.
>> 
>> gdb assumes that all code is located in .text section, and that .text
>> section is located at module load address. With such modules this is no
>> longer the case: there is code in .text.hot and .text.unlikely, and
>> either of them might precede .text.
>> 
>> Fix by explicitly telling gdb the addresses of code sections.
>> 
>> It might be tempting to do this for all sections, not only the ones in
>> the white list. Unfortunately, gdb appears to have an issue, when telling
>> it about e.g. loadable .note.gnu.build-id section causes it to think that
>> non-loadable .note.Linux section is loaded at address 0, which in turn
>> causes NULL pointers to be resolved to bogus symbols. So keep using the
>> white list approach for the time being.
> 
> Did you report this to gdb?

Yes: https://sourceware.org/bugzilla/show_bug.cgi?id=25152

Best regards,
Ilya

