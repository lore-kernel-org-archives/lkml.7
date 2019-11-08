Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D92C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B68C218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbfKHJgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:36:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730616AbfKHJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:36:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89WQm3044826
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 04:36:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w545dknup-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:36:02 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Fri, 8 Nov 2019 09:36:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 09:35:55 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA89Zsv937224532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 09:35:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96EFC5204F;
        Fri,  8 Nov 2019 09:35:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F40635204E;
        Fri,  8 Nov 2019 09:35:53 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.221.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C9C28A01E3;
        Fri,  8 Nov 2019 20:35:49 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 11/11] fsi: aspeed: Fix OPB0 byte order register values
Date:   Fri, 08 Nov 2019 20:31:12 +1100
In-Reply-To: <20191108051945.7109-12-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au> <20191108051945.7109-12-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19110809-0008-0000-0000-0000032CAD21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110809-0009-0000-0000-00004A4BB52E
Message-Id: <1856299.kAykGyoYJU@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OPB data mirroring is pretty special, glad someone has figured it out and made 
some artwork in the process.

Acked-by: Alistair Popple <alistair@popple.id.au>

On Friday, 8 November 2019 4:19:45 PM AEDT Joel Stanley wrote:
> From: Andrew Jeffery <andrew@aj.id.au>
> 
> The data byte order selection registers in the APB2OPB primarily expose some
> internal plumbing necessary to get correct write accesses onto the OPB.
> OPB write cycles require "data mirroring" across the 32-bit data bus to
> support variable data width slaves that don't implement "byte enables".
> For slaves that do implement byte enables the master can signal which
> bytes on the data bus the slave should consider valid.
> 
> The data mirroring behaviour is specified by the following table:
> 
>     +-----------------+----------+-----------------------------------+
>     |                 |          |          32-bit Data Bus          |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |         |       |          |         |         |       |       |
>     |   ABus  | Mn_BE |  Request |   Dbus  |   Dbus  |  Dbus |  Dbus |
>     | (30:31) | (0:3) | Transfer |   0:7   |   8:15  | 16:23 | 24:31 |
>     |         |       |   Size   |  byte0  |  byte1  | byte2 | byte3 |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    00   |  1111 | fullword |  byte0  |  byte1  | byte2 | byte3 |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    00   |  1110 | halfword |  byte0  |  byte1  | byte2 |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    01   |  0111 |   byte   | _byte1_ |  byte1  | byte2 | byte3 |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    00   |  1100 | halfword |  byte0  |  byte1  |       |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    01   |  0110 |   byte   | _byte1_ |  byte1  | byte2 |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    10   |  0011 | halfword | _byte2_ | _byte3_ | byte2 | byte3 |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    00   |  1000 |   byte   |  byte0  |         |       |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    01   |  0100 |   byte   | _byte1_ |  byte1  |       |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    10   |  0010 |   byte   | _byte2_ |         | byte2 |       |
>     +---------+-------+----------+---------+---------+-------+-------+
>     |    11   |  0001 |   byte   | _byte3_ | _byte3_ |       | byte3 |
>     +---------+-------+----------+---------+---------+-------+-------+
> 
> Mirrored data values are highlighted by underscores in the Dbus columns.
> The values in the ABus and Request Transfer Size columns correspond to
> values in the field names listed in the write data order select register
> descriptions.
> 
> Similar configuration registers are exposed for reads which enables the
> secondary purpose of configuring hardware endian conversions. It appears the
> data bus byte order is switched around in hardware so set the registers such
> that we can access the correct values for all widths. The values were
> determined by experimentation on hardware against fixed CFAM register
> values to configure the read data order, then in combination with the
> table above and the register layout documentation in the AST2600
> datasheet performing write/read cycles to configure the write data order
> registers.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-master-aspeed.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-
aspeed.c
> index 95e226ac78b9..f49742b310c2 100644
> --- a/drivers/fsi/fsi-master-aspeed.c
> +++ b/drivers/fsi/fsi-master-aspeed.c
> @@ -459,11 +459,11 @@ static int fsi_master_aspeed_probe(struct 
platform_device *pdev)
>  	writel(fsi_base, aspeed->base + OPB_FSI_BASE);
>  
>  	/* Set read data order */
> -	writel(0x0011bb1b, aspeed->base + OPB0_READ_ORDER1);
> +	writel(0x00030b1b, aspeed->base + OPB0_READ_ORDER1);
>  
>  	/* Set write data order */
> -	writel(0x0011bb1b, aspeed->base + OPB0_WRITE_ORDER1);
> -	writel(0xffaa5500, aspeed->base + OPB0_WRITE_ORDER2);
> +	writel(0x0011101b, aspeed->base + OPB0_WRITE_ORDER1);
> +	writel(0x0c330f3f, aspeed->base + OPB0_WRITE_ORDER2);
>  
>  	/*
>  	 * Select OPB0 for all operations.
> 




