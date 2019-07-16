Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9D7C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4C420880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfGPNLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:11:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbfGPNLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:11:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GCwEip012006
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:11:48 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tset09esm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:11:47 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Tue, 16 Jul 2019 14:11:45 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 14:11:42 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GDBeDN42336360
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 13:11:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8704CAE045;
        Tue, 16 Jul 2019 13:11:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33210AE055;
        Tue, 16 Jul 2019 13:11:40 +0000 (GMT)
Received: from localhost (unknown [9.152.212.110])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jul 2019 13:11:40 +0000 (GMT)
Date:   Tue, 16 Jul 2019 15:11:38 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Petr Tesarik <PTesarik@suse.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Raymund Will <rw@suse.com>
Subject: Re: [PATCH] s390: enable detection of kernel version from bzImage
References: <your-ad-here.call-01563228330-ext-8076@work.hours>
 <patch.git-94e9726bbfe5.your-ad-here.call-01563228538-ext-5706@work.hours>
 <20190716123006.2d426ec8@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716123006.2d426ec8@ezekiel.suse.cz>
X-TM-AS-GCONF: 00
x-cbid: 19071613-0016-0000-0000-0000029304B3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071613-0017-0000-0000-000032F0D5A3
Message-Id: <your-ad-here.call-01563282698-ext-9575@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:30:14AM +0000, Petr Tesarik wrote:
> On Tue, 16 Jul 2019 00:12:19 +0200
> Vasily Gorbik <gor@linux.ibm.com> wrote:
> 
> > Extend "parmarea" to include an offset of the version string, which is
> > stored as 8-byte big endian value.
> > 
> > To retrieve version string from bzImage reliably, one should check the
> > presence of "S390EP" ascii string at 0x10008 (available since v3.2),
> > then read the version string offset from 0x10428 (which has been 0
> > since v3.2 up to now). The string is null terminated.
> > 
> > Could be retrieved with the following "file" command magic (requires
> > file v5.34):
> > 8 string \x02\x00\x00\x18\x60\x00\x00\x50\x02\x00\x00\x68\x60\x00\x00\x50\x40\x40\x40\x40\x40\x40\x40\x40 Linux S390
> > >0x10008       string          S390EP  
> > >>0x10428      bequad          >0  
> > >>>(0x10428.Q) string          >\0             \b, version %s  
> > 
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> This looks great! Much cleaner than the original approach.
> 
> Thank you,
> Petr T

Then I'll add
Reported-by: Petr Tesarik <ptesarik@suse.com>
Suggested-by: Petr Tesarik <ptesarik@suse.com>
if you don't mind and try to queue that for 5.3.

