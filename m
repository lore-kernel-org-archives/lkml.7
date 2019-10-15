Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B9ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C5C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfJOPn1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:43:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731230AbfJOPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:43:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FFg3QC021030
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vng7e23b8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 11:43:24 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 15 Oct 2019 16:43:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Oct 2019 16:43:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9FFhJEI39780562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 15:43:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8B3DA4065;
        Tue, 15 Oct 2019 15:43:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC21AA4062;
        Tue, 15 Oct 2019 15:43:18 +0000 (GMT)
Received: from dyn-9-152-98-114.boeblingen.de.ibm.com (unknown [9.152.98.114])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Oct 2019 15:43:18 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] scripts/gdb: fix debugging modules on s390
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
Date:   Tue, 15 Oct 2019 17:43:18 +0200
Cc:     Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Transfer-Encoding: 8BIT
References: <20191015105313.12663-1-iii@linux.ibm.com>
 <356384d7-d14f-2c9d-1c13-3d96e75e1727@siemens.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
X-Mailer: Apple Mail (2.3594.4.19)
X-TM-AS-GCONF: 00
x-cbid: 19101515-0008-0000-0000-000003224AA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101515-0009-0000-0000-00004A416167
Message-Id: <EC1E8F36-C374-4130-9841-CC35F557B7CE@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=866 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am 15.10.2019 um 17:21 schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> 
>> @@ -113,6 +113,12 @@ lx-symbols command."""
>>         if module_file:
>>             gdb.write("loading @{addr}: {filename}\n".format(
>>                 addr=module_addr, filename=module_file))
>> +            if utils.is_target_arch('s390'):
>> +                # Module text is preceded by PLT stubs on s390.
>> +                module_arch = module['arch']
>> +                plt_offset = int(module_arch['plt_offset'])
>> +                plt_size = int(module_arch['plt_size'])
>> +                module_addr = hex(int(module_addr, 0) + plt_offset + plt_size)
> 
> Shouldn't we report the actual address above, ie. reorder this tuning
> with the gdb.write?

That's a tough question. I thought about this, and the argument for
showing the fixed up address is that if someone does the math with
symbol offsets from e.g. objdump, the result will be consistent with
what gdb shows.

On the other hand side, why would anyone do this? that's exactly what
this gdb script is for. So showing the actual address at which the
memory was allocated gives the user some additional information, and is
also consistent with what cat /proc/modules would show.

At the end of the day, I don't have a strong opinion on this, so if you
think it's better to show the fixed up address, I'll send a v2.

Best regards,
Ilya
