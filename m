Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5603C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975DA20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfCGWl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:41:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbfCGWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:41:59 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27MecxT046754
        for <linux-kernel@vger.kernel.org>; Thu, 7 Mar 2019 17:41:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r3c7u854p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:41:57 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 7 Mar 2019 22:41:55 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 7 Mar 2019 22:41:51 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x27Mfofj57344204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Mar 2019 22:41:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27D94C086;
        Thu,  7 Mar 2019 22:41:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 699114C081;
        Thu,  7 Mar 2019 22:41:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.211])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 22:41:49 +0000 (GMT)
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Thu, 07 Mar 2019 17:41:38 -0500
In-Reply-To: <CACdnJuus7zZWDfJHu+nckn+t-FkRerh7vzX2eh=1nGsbX=kbgw@mail.gmail.com>
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
         <CACdnJuuPyL3Qo4jAiJDQvUF9Ctch6Yo2bKezEuQ2KaM5ZZ1vqw@mail.gmail.com>
         <1551998075.31706.455.camel@linux.ibm.com>
         <CACdnJuus7zZWDfJHu+nckn+t-FkRerh7vzX2eh=1nGsbX=kbgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030722-0028-0000-0000-000003515F41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030722-0029-0000-0000-0000240FD2C6
Message-Id: <1551998498.31706.458.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 14:36 -0800, Matthew Garrett wrote:
> On Thu, Mar 7, 2019 at 2:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Thu, 2019-03-07 at 14:27 -0800, Matthew Garrett wrote:
> > > On Wed, Feb 13, 2019 at 4:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > -       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> > > > +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> > > > +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> > > > +                       set_module_sig_enforced();
> > > >                 return sb_arch_rules;
> > >
> > > Linus previously pushed back on having the lockdown features
> > > automatically enabled on secure boot systems. Why are we doing the
> > > same in IMA?
> >
> > IMA-appraisal is extending the "secure boot" concept to the running
> > system.
> 
> Right, but how is this different to what Linus was objecting to?

Both Andy Lutomirski and Linus objected to limiting the "lockdown"
patch set to secure boot enabled systems.

Mimi

