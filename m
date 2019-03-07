Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B065F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCGWsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:48:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbfCGWsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:48:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27MjFA0028812
        for <linux-kernel@vger.kernel.org>; Thu, 7 Mar 2019 17:48:37 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r38ya9ba2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:48:36 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Mar 2019 22:48:35 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 22:48:30 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x27MmTOd61145110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Mar 2019 22:48:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A60C111C058;
        Thu,  7 Mar 2019 22:48:29 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 644B711C04A;
        Thu,  7 Mar 2019 22:48:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.211])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 22:48:28 +0000 (GMT)
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>,
        Justin Forbes <jforbes@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Date:   Thu, 07 Mar 2019 17:48:17 -0500
In-Reply-To: <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
         <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
         <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
         <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
         <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030722-4275-0000-0000-000003185441
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030722-4276-0000-0000-00003826AFEF
Message-Id: <1551998897.31706.461.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 14:44 -0800, Matthew Garrett wrote:
> On Thu, Mar 7, 2019 at 2:38 PM Justin Forbes <jforbes@redhat.com> wrote:
> > On Thu, Mar 7, 2019 at 4:29 PM Matthew Garrett <mjg59@google.com> wrote:
> >>
> >> On Mon, Nov 19, 2018 at 11:57 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> >
> >> > The secure boot mode may not be detected on boot for some reason (eg.
> >> > buggy firmware).  This patch attempts one more time to detect the
> >> > secure boot mode.
> >>
> >> Do we have cases where this has actually been seen? I'm not sure what
> >> the circumstances are that would result in this behaviour.
> >
> >
> > We have never seen it in practice, though we only ever do anything with it with x86, so it is possible that some other platforms maybe?
> 
> I'm not sure that it buys us anything to check this in both the boot
> stub and the running kernel. If a platform *is* giving us different
> results, anything else relying on the information from the boot stub
> is also going to be broken, so we should do this centrally rather than
> in the IMA code.

I added this last attempt because I'm seeing this on my laptop, with
some older, buggy firmware.

Mimi

