Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B63C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9862175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCTBLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:11:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727099AbfCTBLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:11:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2K19ekg045940
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:11:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbakrafq8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:11:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 20 Mar 2019 01:11:02 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 01:10:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K1B3k946596286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 01:11:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED5852052;
        Wed, 20 Mar 2019 01:11:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A677C5204F;
        Wed, 20 Mar 2019 01:11:02 +0000 (GMT)
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up
 request_trusted_key()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     keyrings@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 21:10:52 -0400
In-Reply-To: <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1553040398.4899.149.camel@linux.ibm.com>
         <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032001-0016-0000-0000-00000264EB9A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032001-0017-0000-0000-000032C00283
Message-Id: <1553044252.4899.165.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=938 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> 
> > > diff --git a/security/keys/key.c b/security/keys/key.c
> > > index 696f1c092c50..9045b62afb04 100644
> > > --- a/security/keys/key.c
> > > +++ b/security/keys/key.c
> > > @@ -706,6 +706,7 @@ struct key_type *key_type_lookup(const char *type)
> > >  found_kernel_type:
> > >       return ktype;
> > >  }
> > > +EXPORT_SYMBOL_GPL(key_type_lookup);
> 
> This needs to be moved to patch1.
> 
> > Only the kernel is calling key_type_lookup().  Why does
> > key_type_lookup() need to be exported?
> 
> This patch series adds several new callers outside of keys-subsystem
> core that need this export, the first one being encrypted-keys itself
> in patch1.

It's needed, because they could be compiled as kernel modules, not
builtin (eg. EVM).

Mimi

> 
> drivers/nvdimm/security.c:57:   type = key_type_lookup("encrypted");
> fs/ecryptfs/keystore.c:1627:    type = key_type_lookup("encrypted");
> security/integrity/evm/evm_crypto.c:361:        type =
> key_type_lookup("encrypted");
> security/keys/encrypted-keys/encrypted.c:440:   type =
> key_type_lookup("trusted");
> 

