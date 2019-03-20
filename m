Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4450FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182692184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCTCfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:35:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727052AbfCTCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:35:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2K2Y3je089244
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:35:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbacc5svn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:35:49 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 20 Mar 2019 02:35:47 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 02:35:43 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2K2Zh4U60817420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 02:35:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F054A4204B;
        Wed, 20 Mar 2019 02:35:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1FBF4203F;
        Wed, 20 Mar 2019 02:35:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 02:35:41 +0000 (GMT)
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up
 request_trusted_key()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     keyrings@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Mar 2019 22:35:31 -0400
In-Reply-To: <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1553040398.4899.149.camel@linux.ibm.com>
         <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-0028-0000-0000-00000356147D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-0029-0000-0000-00002414B3DF
Message-Id: <1553049331.4899.177.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> >
> > < snip >
> >
> > > +/*
> > > + * request_trusted_key - request the trusted key
> > > + *
> > > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > > + * manages both trusted/encrypted key-types, like the encrypted key type
> > > + * data, trusted key type data is not visible decrypted from userspace.
> > > + */
> > > +static struct key *request_trusted_key(const char *trusted_desc,
> > > +                             const u8 **master_key, size_t *master_keylen)
> > > +{
> > > +     struct trusted_key_payload *tpayload;
> > > +     struct key_type *type;
> > > +     struct key *tkey;
> > > +
> > > +     type = key_type_lookup("trusted");
> >
> > The associated key_type_put() will need to be called.
> 
> Yes.

I don't know if defining a key_type_lookup() wrapper, perhaps named
is_key_type_available(), would help.  Both key_type_lookup() and
key_type_put() would be called.  The existing code could then remain
the same.

Mimi

> 
> >
> > > +     if (IS_ERR(type)) {
> > > +             tkey = (struct key *)type;
> > > +             goto error;
> > > +     }
> > > +     tkey = request_key(type, trusted_desc, NULL);
> > > +     if (IS_ERR(tkey))
> > > +             goto error;
> > > +
> > > +     down_read(&tkey->sem);
> > > +     tpayload = tkey->payload.data[0];
> > > +     *master_key = tpayload->key;
> > > +     *master_keylen = tpayload->key_len;
> > > +error:
> > > +     return tkey;
> > > +}
> > > +
> >

