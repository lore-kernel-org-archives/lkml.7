Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8580DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557FB213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfCSVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:05:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbfCSVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:05:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JKx58O079277
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:05:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb75vt8qp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:05:25 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 19 Mar 2019 21:05:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 21:05:15 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JL5I8j31260794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:05:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 355A5A4040;
        Tue, 19 Mar 2019 21:05:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2099DA4051;
        Tue, 19 Mar 2019 21:05:17 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.239])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 19 Mar 2019 21:05:17 +0000 (GMT)
Date:   Tue, 19 Mar 2019 23:05:09 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Philip Derrin <philip@cog.systems>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: mm: make use of new memblocks_present() helper
References: <20190319181357.9305-1-logang@deltatee.com>
 <20190319204253.GB17966@rapoport-lnx>
 <a9b528f1-0c4b-3894-18e1-a4999c18f4a4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9b528f1-0c4b-3894-18e1-a4999c18f4a4@deltatee.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19031921-0008-0000-0000-000002CF4822
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031921-0009-0000-0000-0000223B5CD1
Message-Id: <20190319210508.GD17966@rapoport-lnx>
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

On Tue, Mar 19, 2019 at 02:50:25PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-03-19 2:42 p.m., Mike Rapoport wrote:
> > On Tue, Mar 19, 2019 at 12:13:57PM -0600, Logan Gunthorpe wrote:
> >> Cleanup the arm_memory_present() function seeing it's very
> >> similar to other arches.
> >>
> >> The new memblocks_present() helper checks for node ids which the
> >> arm version did not. However, this is equivalent seeing
> >> HAVE_MEMBLOCK_NODE_MAP should be false in this arch and therefore
> >> memblock_get_region_node() should return 0.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Philip Derrin <philip@cog.systems>
> >> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > 
> > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Strangely, I've got a feeling I've already reviewed such patch from a
> > different person...
> 
> You're probably referring to [1] which was for arm64 and was redundant
> as my patch for that architecture was already picked up by Catalin.

I've found the patch [1] I mentioned, and it was for ARM.

> I was the person who originally introduced memblocks_present() and I'm
> still hoping to get the cleanup patches for the arm and sh arches to be
> picked up.

AFAIK, For ARM you'd need to put it into Russel's patch tracking system [2].

> Thanks,
> 
> Logan
> 
> [1]
> https://lore.kernel.org/lkml/20190210093738.30923-1-peng.fan@nxp.com/T/#u
> 

[1] https://lore.kernel.org/lkml/20190211131602.3294-1-peng.fan@nxp.com
[2] https://www.arm.linux.org.uk/developer/patches/

-- 
Sincerely yours,
Mike.

