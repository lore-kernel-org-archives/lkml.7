Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AF72184D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbfC0TEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:04:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389498AbfC0TEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:04:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RIsNka059060
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:04:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rgdxu2hp2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:04:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 27 Mar 2019 19:04:10 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 19:04:05 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2RJ44Kl54919208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 19:04:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 552BD5205A;
        Wed, 27 Mar 2019 19:04:04 +0000 (GMT)
Received: from dhcp-9-31-103-153.watson.ibm.com (unknown [9.31.103.153])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 951FD52054;
        Wed, 27 Mar 2019 19:04:02 +0000 (GMT)
Subject: Re: [PATCH 1/2] efi: add a function for transferring status to
 string
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>, Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Date:   Wed, 27 Mar 2019 15:04:02 -0400
In-Reply-To: <CAKv+Gu9B6h3zGVTctepd1GE5LaaMaT5x14Le1v05AOhbH36bpQ@mail.gmail.com>
References: <20190324002621.3551-1-jlee@suse.com>
         <CAKv+Gu9B6h3zGVTctepd1GE5LaaMaT5x14Le1v05AOhbH36bpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032719-0016-0000-0000-00000267DC29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032719-0017-0000-0000-000032C31AB4
Message-Id: <1553713442.4608.20.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-27 at 19:58 +0100, Ard Biesheuvel wrote:
> On Sun, 24 Mar 2019 at 01:26, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> >
> > This function can be used to transfer EFI status code to string
> > for printing out debug message. Using this function can improve
> > the readability of log.

Maybe instead of "for transferring status" use "to convert the status
value to a" in the Subject line and here in the patch description.

> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Anton Vorontsov <anton@enomsg.org>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  include/linux/efi.h | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 54357a258b35..a43cb0dc37af 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -1768,4 +1768,32 @@ struct linux_efi_memreserve {
> >  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> >         / sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
> >
> > +#define EFI_STATUS_STR(_status) \
> > +case EFI_##_status: \
> > +       return "EFI_" __stringify(_status);
> > +
> > +static inline char *
> > +efi_status_to_str(efi_status_t status)
> > +{
> > +       switch (status) {
> > +       EFI_STATUS_STR(SUCCESS)
> > +       EFI_STATUS_STR(LOAD_ERROR)
> > +       EFI_STATUS_STR(INVALID_PARAMETER)
> > +       EFI_STATUS_STR(UNSUPPORTED)
> > +       EFI_STATUS_STR(BAD_BUFFER_SIZE)
> > +       EFI_STATUS_STR(BUFFER_TOO_SMALL)
> > +       EFI_STATUS_STR(NOT_READY)
> > +       EFI_STATUS_STR(DEVICE_ERROR)
> > +       EFI_STATUS_STR(WRITE_PROTECTED)
> > +       EFI_STATUS_STR(OUT_OF_RESOURCES)
> > +       EFI_STATUS_STR(NOT_FOUND)
> > +       EFI_STATUS_STR(ABORTED)
> > +       EFI_STATUS_STR(SECURITY_VIOLATION)
> > +       default:
> > +               pr_warn("Unknown efi status: 0x%lx", status);
> > +       }
> > +
> > +       return "Unknown efi status";
> > +}
> > +
> >  #endif /* _LINUX_EFI_H */
> > --
> > 2.16.4
> >
> 
> Please turn this into a proper function so that not every calling
> object has to duplicate all these strings.

Hi Ard,

Keeping the status values and strings in sync is difficult.  I was
going to suggest moving the macro immediately after the status value
definitions.

Mimi 

