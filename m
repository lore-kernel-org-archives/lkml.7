Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B2C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43533222BD
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfIZC7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:59:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728722AbfIZC7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:59:37 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8Q2uma0002928
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:59:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v8mgxh2wu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 22:59:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Thu, 26 Sep 2019 03:59:33 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 26 Sep 2019 03:59:28 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8Q2xR0g44302450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 02:59:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD03A4040;
        Thu, 26 Sep 2019 02:59:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8FE4A4053;
        Thu, 26 Sep 2019 02:59:26 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Sep 2019 02:59:26 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6391BA00D3;
        Thu, 26 Sep 2019 12:59:25 +1000 (AEST)
Subject: Re: [PATCH 4/5] ocxl: Add functions to map/unmap LPC memory
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Allison Randal <allison@lohutok.net>,
        David Gibson <david@gibson.dropbear.id.au>
Date:   Thu, 26 Sep 2019 12:59:25 +1000
In-Reply-To: <b790c190-4800-6e2a-0d2b-e89f04d14dd9@linux.ibm.com>
References: <20190917014307.30485-1-alastair@au1.ibm.com>
         <20190917014307.30485-5-alastair@au1.ibm.com>
         <b790c190-4800-6e2a-0d2b-e89f04d14dd9@linux.ibm.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19092602-4275-0000-0000-0000036B3D7E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092602-4276-0000-0000-0000387DBA68
Message-Id: <1bea85d80c6662fa7e18c79a3dc35fa0672f824c.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-23 at 13:39 +0200, Frederic Barrat wrote:
> 
> 
> > diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> > index 2874811a4398..9e303a5f4d85 100644
> > --- a/drivers/misc/ocxl/link.c
> > +++ b/drivers/misc/ocxl/link.c
> > @@ -738,7 +738,7 @@ int ocxl_link_add_lpc_mem(void *link_handle,
> > u64 size)
> >   }
> >   EXPORT_SYMBOL_GPL(ocxl_link_add_lpc_mem);
> >   
> > -u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev)
> > +u64 ocxl_link_lpc_online(void *link_handle, struct pci_dev *pdev)
> >   {
> >   	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> >   
> 
> A bit of a nitpick, but is there any specific reason to rename with 
> "online" suffix? I'm discovering it myself, but with memory hotplug, 
> "onlining" seems to refer to the second, a.k.a logical memory
> hotplug 
> phase (as described in Documentation/admin-guide/mm/memory-
> hotplug.rst). 
> We'll need to worry about it, but the function here is really doing
> the 
> first phase, a.k.a physical memory hotplug.
> 
>    Fred

It's been a while since I wrote that, so I can't remember why, but your
reasoning is sound, I'll drop the rename.

> 
> 
> > @@ -759,7 +759,7 @@ u64 ocxl_link_lpc_map(void *link_handle, struct
> > pci_dev *pdev)
> >   	return link->lpc_mem;
> >   }
> >   
> > -void ocxl_link_lpc_release(void *link_handle, struct pci_dev
> > *pdev)
> > +void ocxl_link_lpc_offline(void *link_handle, struct pci_dev
> > *pdev)
> >   {
> >   	struct ocxl_link *link = (struct ocxl_link *) link_handle;
> >   
> > diff --git a/drivers/misc/ocxl/ocxl_internal.h
> > b/drivers/misc/ocxl/ocxl_internal.h
> > index db2647a90fc8..5656a4aab5b7 100644
> > --- a/drivers/misc/ocxl/ocxl_internal.h
> > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > @@ -52,6 +52,12 @@ struct ocxl_afu {
> >   	void __iomem *global_mmio_ptr;
> >   	u64 pp_mmio_start;
> >   	void *private;
> > +	u64 lpc_base_addr; /* Covers both LPC & special purpose memory
> > */
> > +	struct bin_attribute attr_global_mmio;
> > +	struct bin_attribute attr_lpc_mem;
> > +	struct resource lpc_res;
> > +	struct bin_attribute attr_special_purpose_mem;
> > +	struct resource special_purpose_res;
> >   };
> >   
> >   enum ocxl_context_status {
> > @@ -170,7 +176,7 @@ extern u64 ocxl_link_get_lpc_mem_sz(void
> > *link_handle);
> >    * @link_handle: The OpenCAPI link handle
> >    * @pdev: A device that is on the link
> >    */
> > -u64 ocxl_link_lpc_map(void *link_handle, struct pci_dev *pdev);
> > +u64 ocxl_link_lpc_online(void *link_handle, struct pci_dev *pdev);
> >   
> >   /**
> >    * Release the LPC memory device for an OpenCAPI device
> > @@ -181,6 +187,6 @@ u64 ocxl_link_lpc_map(void *link_handle, struct
> > pci_dev *pdev);
> >    * @link_handle: The OpenCAPI link handle
> >    * @pdev: A device that is on the link
> >    */
> > -void ocxl_link_lpc_release(void *link_handle, struct pci_dev
> > *pdev);
> > +void ocxl_link_lpc_offline(void *link_handle, struct pci_dev
> > *pdev);
> >   
> >   #endif /* _OCXL_INTERNAL_H_ */
> > diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> > index 06dd5839e438..a1897737908d 100644
> > --- a/include/misc/ocxl.h
> > +++ b/include/misc/ocxl.h
> > @@ -212,6 +212,24 @@ int ocxl_irq_set_handler(struct ocxl_context
> > *ctx, int irq_id,
> >   
> >   // AFU Metadata
> >   
> > +/**
> > + * Map the LPC system & special purpose memory for an AFU
> > + *
> > + * Do not call this during device discovery, as there may me
> > multiple
> > + * devices on a link, and the memory is mapped for the whole link,
> > not
> > + * just one device. It should only be called after all devices
> > have
> > + * registered their memory on the link.
> > + *
> > + * afu: The AFU that has the LPC memory to map
> > + */
> > +extern int ocxl_map_lpc_mem(struct ocxl_afu *afu);
> > +
> > +/**
> > + * Get the physical address range of LPC memory for an AFU
> > + * afu: The AFU associated with the LPC memory
> > + */
> > +extern struct resource *ocxl_afu_lpc_mem(struct ocxl_afu *afu);
> > +
> >   /**
> >    * Get a pointer to the config for an AFU
> >    *
> > 
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

