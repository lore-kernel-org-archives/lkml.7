Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9670AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68420213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfCSVIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:08:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726933AbfCSVIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:08:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKx6ux087429
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:08:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rb75kjkmv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:08:44 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Tue, 19 Mar 2019 21:08:48 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 21:08:44 -0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JL8cYZ23003308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:08:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50067BE051;
        Tue, 19 Mar 2019 21:08:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CF2BBE04F;
        Tue, 19 Mar 2019 21:08:35 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.215])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 21:08:35 +0000 (GMT)
Subject: Re: [PATCH 0/6] security/keys/encrypted: Break module dependency
 chain
From:   James Bottomley <jejb@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>, keyrings@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org, ecryptfs@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 14:08:34 -0700
In-Reply-To: <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <CAPcyv4ij2nHD7JumKNcNYB4gAGujWzCPkcpoi=XafmG3EP2b0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031921-0036-0000-0000-00000A9B5F69
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010787; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176768; UDB=6.00615535; IPR=6.00957455;
 MB=3.00026060; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-19 21:08:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031921-0037-0000-0000-00004B1666B7
Message-Id: <1553029714.2932.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 14:01 -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 11:18 PM Dan Williams <dan.j.williams@intel.c
> om> wrote:
> > 
> > With v5.1-rc1 all the nvdimm sub-system regression tests started
> > failing because the libnvdimm module failed to load in the qemu-kvm 
> > test environment.  Critically that environment does not have a TPM.
> > Commit 240730437deb "KEYS: trusted: explicitly use tpm_chip
> > structure..." started to require a TPM to be present for the
> > trusted.ko module to load where there was no requirement for that
> > before.
> > 
> > Rather than undo the "fail if no hardware" behavior James points
> > out that the module dependencies can be broken by looking up the
> > key-type by name. Remove the dependencies on the "key_type_trusted"
> > and "key_type_encrypted" symbol exports, and clean up other
> > boilerplate that supported those exports in different
> > configurations.
> 
> Any feedback? Was hoping to get at least patch1 in the queue for
> v5.1-rc2 since this effectively disables the nvdimm driver on typical
> configurations. Jarkko, would you be willing to merge it since the
> regression came through your tree?

The reason I sent out the RFC was to see if the people who actually
wrote the code had any reasons they needed the current way of doing
things preserving.

I think your series looks fine except you need to export
key_type_lookup (patch 2) before you use it (patch 1) to preserve
bisectability of builds.

James

