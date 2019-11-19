Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149CC33CA0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34682231A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 02:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKSCso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 21:48:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727146AbfKSCso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:48:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAJ2kuCS118554
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 21:48:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2way216047-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 21:48:41 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Tue, 19 Nov 2019 02:48:39 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Nov 2019 02:48:31 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAJ2mUkX393582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 02:48:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C46E1A405C;
        Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D8F3A4054;
        Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Nov 2019 02:48:30 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D0373A012A;
        Tue, 19 Nov 2019 13:48:25 +1100 (AEDT)
Subject: Re: [PATCH 08/10] nvdimm: Add driver for OpenCAPI Storage Class
 Memory
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@samba.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>, Qian Cai <cai@lca.pw>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Linux MM <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Tue, 19 Nov 2019 13:48:26 +1100
In-Reply-To: <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
         <20191025044721.16617-9-alastair@au1.ibm.com>
         <8232c1a6-d52a-6c32-6178-de082174a92a@linux.ibm.com>
         <CAPcyv4g9b6PyREurH9NcQf4BO2YcRGJPBZDqGKy-Vz91mBKjew@mail.gmail.com>
         <02374c9a-39fb-5693-3d9c-aa7e7674a6c1@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111902-0020-0000-0000-0000038A0D94
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111902-0021-0000-0000-000021E0371A
Message-Id: <7fd5a4571062a06da8f09f18300794b48ead5dc1.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_08:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=886
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-19 at 10:47 +1100, Andrew Donnellan wrote:
> On 15/11/19 3:35 am, Dan Williams wrote:
> > > Have you discussed with the directory owner if it's ok to split
> > > the
> > > driver over several files?
> > 
> > My thought is to establish drivers/opencapi/ and move this and the
> > existing drivers/misc/ocxl/ bits there.
> 
> Is there any other justification for this we can think of apart from
> not 
> wanting to put this driver in the nvdimm directory? OpenCAPI drivers 
> aren't really a category of driver unto themselves.
> 

There is a precedent for bus-based dirs, eg. drivers/(ide|w1|spi) all
contain drivers for both controllers & connected devices.

Fred, how do you feel about moving the generic OpenCAPI driver out of
drivers/misc?

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

