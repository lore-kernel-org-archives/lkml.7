Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAEBC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA39020828
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCKQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:55:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbfCKQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:55:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BGn2QY021093
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:55:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r5tsvtje9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 12:55:00 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 11 Mar 2019 16:54:58 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 11 Mar 2019 16:54:54 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2BGsrG952232348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Mar 2019 16:54:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE96811C05C;
        Mon, 11 Mar 2019 16:54:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF7FC11C050;
        Mon, 11 Mar 2019 16:54:52 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 11 Mar 2019 16:54:52 +0000 (GMT)
Subject: Re: [PATCH 3/3] x86/ima: retry detecting secure boot mode
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Justin Forbes <jforbes@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Date:   Mon, 11 Mar 2019 12:54:52 -0400
In-Reply-To: <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
         <1542657371-7019-4-git-send-email-zohar@linux.ibm.com>
         <CACdnJusqHZ1OLJD1baN=fXK9KE+bSqzB4OUbmLXH5-qZNrQXJg@mail.gmail.com>
         <CAFbkSA39RwB+E4SaG_ueu-_B=y7JytEYKw1+eXNQ_eCuMfnv=g@mail.gmail.com>
         <CACdnJuuHmK0qKjMxxonRYDUCatxqs930QGNQmREhRjimpNKzYw@mail.gmail.com>
         <1551998897.31706.461.camel@linux.ibm.com>
         <CACdnJusiLSCyqx7NX5bkpFr2N5YjBt_h3miOgkbey-Zndc3+Kg@mail.gmail.com>
         <1552052377.4134.23.camel@linux.ibm.com>
         <CACdnJut3Y7CogvgtNsEcrEtA1WOxSb9OWP_wZ=3xNgCft2oeDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031116-0008-0000-0000-000002CB59EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031116-0009-0000-0000-000022377582
Message-Id: <1552323292.6100.45.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=862 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903110120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-08 at 09:51 -0800, Matthew Garrett wrote:
> On Fri, Mar 8, 2019 at 5:40 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2019-03-07 at 14:50 -0800, Matthew Garrett wrote:
> > > Is the issue that it gives incorrect results on the first read, or is
> > > the issue that it gives incorrect results before ExitBootServices() is
> > > called? If the former then we should read twice in the boot stub, if
> > > the latter then we should figure out a way to do this immediately
> > > after ExitBootServices() instead.
> >
> > Detecting the secure boot mode isn't the problem.  On boot, I am
> > seeing "EFI stub: UEFI Secure Boot is enabled", but setup_arch() emits
> > "Secure boot could not be determined".
> >
> > In efi_main() the secure_boot mode is initially unset, so
> > efi_get_secureboot() is called.  efi_get_secureboot() returns the
> > secure_boot mode correctly as enabled.  The problem seems to be in
> > saving the secure_boot mode for later use.
> 
> Hm. And this only happens on certain firmware versions? If something's
> stepping on boot_params then we have bigger problems.

I was seeing this problem before and after updating the system
firmware on my laptop last summer.  If updating the firmware had
resolved the problem, I wouldn't have included this patch.

Mimi

