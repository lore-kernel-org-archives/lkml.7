Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6AFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470A92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCSW4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:56:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbfCSW4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:56:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JMrSBt028549
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:56:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb8gfaqpb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:56:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 19 Mar 2019 22:56:43 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 22:56:40 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JMufLm61276258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 22:56:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1A611C050;
        Tue, 19 Mar 2019 22:56:41 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DEA111C052;
        Tue, 19 Mar 2019 22:56:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 22:56:40 +0000 (GMT)
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware
 TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Date:   Tue, 19 Mar 2019 18:56:29 -0400
In-Reply-To: <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1552955080.2785.26.camel@linux.ibm.com>
         <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031922-0012-0000-0000-00000304E279
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031922-0013-0000-0000-0000213BF32A
Message-Id: <1553036189.4899.136.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:

Sorry for the late reply.

> On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com> wrote:
> >
> > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > Rather than fail initialization of the trusted.ko module, arrange for
> > > the module to load, but rely on trusted_instantiate() to fail
> > > trusted-key operations.
> >
> > What actual problem is this fixing?  To me it would seem like an
> > enhancement to make the trusted module fail at load time if there's no
> > TPM rather than waiting until first use to find out it can never work.
> > Is there some piece of user code that depends on the successful
> > insertion of trusted.ko?
> 
> The module dependency chain relies on it. If that can be broken that
> would also be an acceptable fix.
> 
> I found this through the following dependency chain: libnvdimm.ko ->
> encrypted_keys.ko -> trusted.ko.
> 
> "key_type_trusted" is the symbol that encrypted_keys needs regardless
> of whether the tpm is present.

Commit 982e617a313b ("encrypted-keys: remove trusted-keys dependency")
removed the dependency on trusted keys.  masterkey_trusted.c should
only be included if "CONFIG_TRUSTED_KEYS" is enabled.  Is
CONFIG_TRUSTED_KEYS enabled?

Mimi

