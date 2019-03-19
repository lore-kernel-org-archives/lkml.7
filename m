Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E1820989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCSA4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:56:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbfCSA4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:56:39 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J0sSEn121040
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:56:37 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ramuh306g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:56:37 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Tue, 19 Mar 2019 00:56:37 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 00:56:33 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2J0uWE425428012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 00:56:32 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F04B5124054;
        Tue, 19 Mar 2019 00:56:31 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89A41124052;
        Tue, 19 Mar 2019 00:56:30 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.215])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 00:56:30 +0000 (GMT)
Subject: Re: [PATCH] security/keys/trusted: Allow operation without hardware
 TPM
From:   James Bottomley <jejb@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Date:   Mon, 18 Mar 2019 17:56:29 -0700
In-Reply-To: <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1552955080.2785.26.camel@linux.ibm.com>
         <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031900-2213-0000-0000-00000366BC3E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010782; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176367; UDB=6.00615292; IPR=6.00957051;
 MB=3.00026041; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-19 00:56:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031900-2214-0000-0000-00005DB8296F
Message-Id: <1552956989.2785.31.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-18_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=850 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 5:24 PM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > 
> > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > Rather than fail initialization of the trusted.ko module, arrange
> > > for the module to load, but rely on trusted_instantiate() to fail
> > > trusted-key operations.
> > 
> > What actual problem is this fixing?  To me it would seem like an
> > enhancement to make the trusted module fail at load time if there's
> > no TPM rather than waiting until first use to find out it can never
> > work. Is there some piece of user code that depends on the
> > successful insertion of trusted.ko?
> 
> The module dependency chain relies on it. If that can be broken that
> would also be an acceptable fix.
> 
> I found this through the following dependency chain: libnvdimm.ko ->
> encrypted_keys.ko -> trusted.ko.
> 
> "key_type_trusted" is the symbol that encrypted_keys needs regardless
> of whether the tpm is present.

That's a nasty dependency caused by every key type module exporting a
symbol for its key type.  It really seems that key types should be
looked up by name not symbol to prevent more of these dependency issues
from spreading.  Something like this (untested and definitely won't
work without doing an EXPORT_SYMBOL on key_type_lookup).

If it does look acceptable we can also disentangle the nasty module
dependencies in the encrypted key code around masterkey which alone
should be a huge improvement because that code is too hacky to live.

James

---
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index dc3d18cae642..b98416f091e2 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -19,6 +19,7 @@
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
 #include "encrypted.h"
+#include "../internal.h"
 
 /*
  * request_trusted_key - request the trusted key
@@ -32,8 +33,14 @@ struct key *request_trusted_key(const char *trusted_desc,
 {
 	struct trusted_key_payload *tpayload;
 	struct key *tkey;
+	struct key_type *type;
 
-	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
+	type = key_type_lookup("trusted");
+	if (IS_ERR(type)) {
+		tkey = (struct key *)type;
+		goto error;
+	}
+	tkey = request_key(type, trusted_desc, NULL);
 	if (IS_ERR(tkey))
 		goto error;
 

