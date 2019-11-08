Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A015BC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB312084C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfKHAha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:37:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbfKHAh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:37:29 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA80YUF5034511
        for <linux-kernel@vger.kernel.org>; Thu, 7 Nov 2019 19:37:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w4tumnj6x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 19:37:27 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 8 Nov 2019 00:37:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 00:37:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA80bGhr40173716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 00:37:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C106F52050;
        Fri,  8 Nov 2019 00:37:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2601B5204E;
        Fri,  8 Nov 2019 00:37:16 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C87D3A01E3;
        Fri,  8 Nov 2019 11:37:13 +1100 (AEDT)
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the
 generic OCXL driver
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Date:   Fri, 08 Nov 2019 11:37:14 +1100
In-Reply-To: <b70644d6-2c71-cd71-5d00-e25d99beea91@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
         <20191025044721.16617-11-alastair@au1.ibm.com>
         <b70644d6-2c71-cd71-5d00-e25d99beea91@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110800-0020-0000-0000-0000038390E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110800-0021-0000-0000-000021D9C758
Message-Id: <46d72d7b2f91900c4499db127e365baade38e18c.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 19:08 +0100, Frederic Barrat wrote:
> 
> Le 25/10/2019 à 06:47, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > This patch allows the user to bind OpenCAPI SCM devices to the
> > generic OCXL
> > driver.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> 
> I'm wondering if we should upstream this. Is it of any use outside
> of 
> some serious debug session for a developer?
> Also we would now have 2 drivers picking up the same device ID,
> since 
> the SCM driver is always registering for that ID, irrespective of 
> CONFIG_OCXL_SCM_GENERIC
> 
>    Fred
> 

I think I'll drop this patch. It's easy enough to maintain out-of-tree
for our in-house SCM hardware engineers.

> 
> >   drivers/misc/ocxl/Kconfig | 7 +++++++
> >   drivers/misc/ocxl/pci.c   | 3 +++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/misc/ocxl/Kconfig b/drivers/misc/ocxl/Kconfig
> > index 1916fa65f2f2..8a683715c97c 100644
> > --- a/drivers/misc/ocxl/Kconfig
> > +++ b/drivers/misc/ocxl/Kconfig
> > @@ -29,3 +29,10 @@ config OCXL
> >   	  dedicated OpenCAPI link, and don't follow the same protocol.
> >   
> >   	  If unsure, say N.
> > +
> > +config OCXL_SCM_GENERIC
> > +	bool "Treat OpenCAPI Storage Class Memory as a generic OpenCAPI
> > device"
> > +	default n
> > +	help
> > +	  Select this option to treat OpenCAPI Storage Class Memory
> > +	  devices an generic OpenCAPI devices.
> > diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
> > index cb920aa88d3a..7137055c1883 100644
> > --- a/drivers/misc/ocxl/pci.c
> > +++ b/drivers/misc/ocxl/pci.c
> > @@ -10,6 +10,9 @@
> >    */
> >   static const struct pci_device_id ocxl_pci_tbl[] = {
> >   	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x062B), },
> > +#ifdef CONFIG_OCXL_SCM_GENERIC
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0625), },
> > +#endif
> >   	{ }
> >   };
> >   MODULE_DEVICE_TABLE(pci, ocxl_pci_tbl);
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

