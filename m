Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E97C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FA42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCTMGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:06:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbfCTMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:06:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KBxnIM022674
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:06:38 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rbkrsn7t4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 08:06:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 20 Mar 2019 12:06:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Mar 2019 12:06:31 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2KC6UQf33619984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Mar 2019 12:06:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8E96AE055;
        Wed, 20 Mar 2019 12:06:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED020AE04D;
        Wed, 20 Mar 2019 12:06:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.235])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Mar 2019 12:06:29 +0000 (GMT)
Subject: Re: [PATCH 2/6] security/keys/encrypted: Clean up
 request_trusted_key()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     keyrings@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 20 Mar 2019 08:06:19 -0400
In-Reply-To: <CAPcyv4gySHayfwtp1PgxEoM-T_s_1A4RTcnXefx5iRLn9g=D5w@mail.gmail.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
         <155297558570.2276575.11731393787282486177.stgit@dwillia2-desk3.amr.corp.intel.com>
         <1553040398.4899.149.camel@linux.ibm.com>
         <CAPcyv4heLwdJR+xKZfvx5TAvqsKr3sNCda_ovivguLKbiXhyYg@mail.gmail.com>
         <1553049331.4899.177.camel@linux.ibm.com>
         <CAPcyv4gySHayfwtp1PgxEoM-T_s_1A4RTcnXefx5iRLn9g=D5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032012-0028-0000-0000-000003564121
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032012-0029-0000-0000-00002414E274
Message-Id: <1553083579.4899.239.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 22:48 -0700, Dan Williams wrote:
> On Tue, Mar 19, 2019 at 7:36 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Tue, 2019-03-19 at 17:20 -0700, Dan Williams wrote:
> > > On Tue, Mar 19, 2019 at 5:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > >
> > > > On Mon, 2019-03-18 at 23:06 -0700, Dan Williams wrote:
> > > >
> > > > < snip >
> > > >
> > > > > +/*
> > > > > + * request_trusted_key - request the trusted key
> > > > > + *
> > > > > + * Trusted keys are sealed to PCRs and other metadata. Although userspace
> > > > > + * manages both trusted/encrypted key-types, like the encrypted key type
> > > > > + * data, trusted key type data is not visible decrypted from userspace.
> > > > > + */
> > > > > +static struct key *request_trusted_key(const char *trusted_desc,
> > > > > +                             const u8 **master_key, size_t *master_keylen)
> > > > > +{
> > > > > +     struct trusted_key_payload *tpayload;
> > > > > +     struct key_type *type;
> > > > > +     struct key *tkey;
> > > > > +
> > > > > +     type = key_type_lookup("trusted");
> > > >
> > > > The associated key_type_put() will need to be called.
> > >
> > > Yes.
> >
> > I don't know if defining a key_type_lookup() wrapper, perhaps named
> > is_key_type_available(), would help.  Both key_type_lookup() and
> > key_type_put() would be called.  The existing code could then remain
> > the same.
> >
> 
> Maybe, but something still needs to pin the hosting module. I think
> this means that the first call to key_type->instantiate() pins the
> hosting module, and the ->destroy() of the last key for the key_type
> unpins the module. It does mean that the ->destroy() method is no
> longer optional.

This sounds like it isn't a new problem.  Both issues need to be
addressed, but I think we should differentiate between them and
address them separately.

In terms of the original nvdimm encrypted/trusted key problem, the
above suggestion requires the least amount of change.  For v5.2, I
would replace it with the full updated patch set.

Mimi

