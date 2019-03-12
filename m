Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F632C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5402C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCLQvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbfCLQvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:51:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CGbEor069222
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 12:51:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6f3m6akp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 12:51:35 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Mar 2019 16:51:31 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 16:51:26 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CGpPNp52559932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 16:51:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C32AE053;
        Tue, 12 Mar 2019 16:51:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD06AAE056;
        Tue, 12 Mar 2019 16:51:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 16:51:24 +0000 (GMT)
Subject: Re: [PATCH v3 5/7] selftests/ima: kexec_file_load syscall test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Matthew Garrett <mjg59@google.com>
Date:   Tue, 12 Mar 2019 12:51:14 -0400
In-Reply-To: <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
References: <1552304473-3966-1-git-send-email-zohar@linux.ibm.com>
         <1552304473-3966-6-git-send-email-zohar@linux.ibm.com>
         <20190312121001.GA18510@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031216-0020-0000-0000-00000321B8F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031216-0021-0000-0000-00002173E579
Message-Id: <1552409474.24794.63.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-12 at 20:10 +0800, Dave Young wrote:
> Hi Mimi,
> On 03/11/19 at 07:41am, Mimi Zohar wrote:
> > The kernel can be configured to verify PE signed kernel images, IMA
> > kernel image signatures, both types of signatures, or none.  This test
> > verifies only properly signed kernel images are loaded into memory,
> > based on the kernel configuration and runtime policies.
> 
> I understand this is for IMA testing only, but I still wonder if this
> can be expanded to common kexec tests, like
> tools/testing/selftests/kexec/kexec_load.sh
> tools/testing/selftests/kexec/kexec_file_load.sh
> 
> Is it possible for ima/test_kexec_load.sh to call the
> ../kexec/kexec_load.sh, probably add extra argument eg "ima"?

These kexec tests are meant to coordinate between the different
methods of verifying the kexec kernel image signatures.  Nothing about
them is IMA specific.  Moving these tests to
tools/testing/selftests/kexec makes sense.

> 
> Frankly I did not read and followup much about the testing code changes,
> not sure if it is doable or not.  The code sharing under testing folder
> seems not very good.  For example the basic check_root is needed by
> different parts, but all have its own implementation.  Anyway this is
> not the duty of this patch set.
> Also the selftests/lib/ is not a folder for sharing code for different
> tests, it looks a standalone test instead.

Shuah suggested upstreaming these tests first and defer introducing a
common set of functions to later.

> So if split kexec tests to another folder is not doable please just
> ignore the comment.

Left in the selftests/ima is a similar test for kernel modules, which
uses the "common" functions.  So either we wait to move the kexec
tests or allow them to reach into the ima directory and use the
ima_common_lib functions.

> 
> BTW, does CONFIG_KEXEC* is checked?  in case a kernel without KEXEC or
> KEXEC_FILE compiled in then the tests can just return directly.

Good point.  Now that there is a common function for reading the
Kconfig, I'll add that check to both the test_kexec_load.sh and
test_kexec_file_load.sh tests respectively.

Mimi

