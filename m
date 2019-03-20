Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA98C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8ED20854
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfCTCTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:19:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726749AbfCTCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:19:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2K2EBxf134150
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:19:08 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb8qqrqxq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:19:08 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Wed, 20 Mar 2019 02:19:07 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 02:19:03 -0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K2J3S134603074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 02:19:03 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 265716A047;
        Wed, 20 Mar 2019 02:19:03 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58CC56A051;
        Wed, 20 Mar 2019 02:19:01 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.131.215])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 02:19:01 +0000 (GMT)
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
Date:   Tue, 19 Mar 2019 19:19:00 -0700
In-Reply-To: <CAPcyv4hXKQcdLnKG6rPNOJr2wjq31uCCr+16S5Yu6S5A_5UGrA@mail.gmail.com>
References: <155295271345.1945351.6465460744078693578.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1552955080.2785.26.camel@linux.ibm.com>
         <CAA9_cmcOD2zPaaNbkYAaH5DRDRAebPkW+hwPA0zPKY4kU8R-rg@mail.gmail.com>
         <1552956989.2785.31.camel@linux.ibm.com>
         <CAPcyv4hXKQcdLnKG6rPNOJr2wjq31uCCr+16S5Yu6S5A_5UGrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-8235-0000-0000-00000E6FD588
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01176872; UDB=6.00615598; IPR=6.00957559;
 MB=3.00026062; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-20 02:19:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-8236-0000-0000-000044D69C00
Message-Id: <1553048340.9408.16.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=995 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 18:55 -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 5:56 PM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > 
> > On Mon, 2019-03-18 at 17:30 -0700, Dan Williams wrote:
> > > On Mon, Mar 18, 2019 at 5:24 PM James Bottomley
> > > <jejb@linux.ibm.com> wrote:
> > > > 
> > > > On Mon, 2019-03-18 at 16:45 -0700, Dan Williams wrote:
> > > > > Rather than fail initialization of the trusted.ko module,
> > > > > arrange for the module to load, but rely on
> > > > > trusted_instantiate() to fail trusted-key operations.
> > > > 
> > > > What actual problem is this fixing?  To me it would seem like
> > > > an enhancement to make the trusted module fail at load time if
> > > > there's no TPM rather than waiting until first use to find out
> > > > it can never work. Is there some piece of user code that
> > > > depends on the successful insertion of trusted.ko?
> > > 
> > > The module dependency chain relies on it. If that can be broken
> > > that would also be an acceptable fix.
> > > 
> > > I found this through the following dependency chain: libnvdimm.ko
> > > -> encrypted_keys.ko -> trusted.ko.
> > > 
> > > "key_type_trusted" is the symbol that encrypted_keys needs
> > > regardless of whether the tpm is present.
> > 
> > That's a nasty dependency caused by every key type module exporting
> > a symbol for its key type.  It really seems that key types should
> > be looked up by name not symbol to prevent more of these dependency
> > issues from spreading.  Something like this (untested and
> > definitely won't work without doing an EXPORT_SYMBOL on
> > key_type_lookup).
> > 
> > If it does look acceptable we can also disentangle the nasty module
> > dependencies in the encrypted key code around masterkey which alone
> > should be a huge improvement because that code is too hacky to
> > live.
> > 
> > James
> > 
> > ---
> > diff --git a/security/keys/encrypted-keys/masterkey_trusted.c
> > b/security/keys/encrypted-keys/masterkey_trusted.c
> > index dc3d18cae642..b98416f091e2 100644
> > --- a/security/keys/encrypted-keys/masterkey_trusted.c
> > +++ b/security/keys/encrypted-keys/masterkey_trusted.c
> > @@ -19,6 +19,7 @@
> >  #include <keys/trusted-type.h>
> >  #include <keys/encrypted-type.h>
> >  #include "encrypted.h"
> > +#include "../internal.h"
> > 
> >  /*
> >   * request_trusted_key - request the trusted key
> > @@ -32,8 +33,14 @@ struct key *request_trusted_key(const char
> > *trusted_desc,
> >  {
> >         struct trusted_key_payload *tpayload;
> >         struct key *tkey;
> > +       struct key_type *type;
> > 
> > -       tkey = request_key(&key_type_trusted, trusted_desc, NULL);
> > +       type = key_type_lookup("trusted");
> > +       if (IS_ERR(type)) {
> > +               tkey = (struct key *)type;
> > +               goto error;
> > +       }
> > +       tkey = request_key(type, trusted_desc, NULL);
> >         if (IS_ERR(tkey))
> >                 goto error;
> 
> 
> This falls over with the need to pin the module while any key that
> needs service from the hosting key_type operations might be live in
> the system.
> 
> I could hang a "struct module *" off of the key_type so the host
> module can be pinned, but that requires teaching all consumers of the
> key_type module lifetime. Not impossible, but I think too big for a
> fix, and I'd rather go with this local fixup to drop the dependency
> on tpm_default_chip() successfully enumerating a TPM.

Heh, well this proved to be a can of worms and no mistake. 
Unfortunately all of this does need fixing otherwise the keyctl syscall
has exactly the same problem.  But I think I agree it's getting way out
of scope for the bug you found.

James

