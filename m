Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E41FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52552214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfKHJgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:36:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730623AbfKHJgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:36:04 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89WDDS091170
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 04:36:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w541c3vu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:36:02 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Fri, 8 Nov 2019 09:36:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 09:35:58 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA89ZvnI57933912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 09:35:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DF6E11C04A;
        Fri,  8 Nov 2019 09:35:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 498D811C05E;
        Fri,  8 Nov 2019 09:35:57 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 09:35:57 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.221.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 42310A020A;
        Fri,  8 Nov 2019 20:35:55 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 01/11] fsi: Add fsi-master class
Date:   Fri, 08 Nov 2019 20:17:49 +1100
In-Reply-To: <20191108051945.7109-2-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au> <20191108051945.7109-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19110809-0028-0000-0000-000003B416AB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110809-0029-0000-0000-00002477177D
Message-Id: <2193954.caYg6ACHYT@townsend>
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

Support for the new paths has been added to our user space tools as well so it 
shouldn't change anything there.

Acked-by: Alistair Popple <alistair@popple.id.au>

On Friday, 8 November 2019 4:19:35 PM AEDT Joel Stanley wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> 
> This change adds a device class for FSI masters, allowing access under
> /sys/class/fsi-master/, and easier udev rules.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 1f76740f33b6..0861f6097b33 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -1241,6 +1241,10 @@ static ssize_t master_break_store(struct device *dev,
>  
>  static DEVICE_ATTR(break, 0200, NULL, master_break_store);
>  
> +struct class fsi_master_class = {
> +	.name = "fsi-master",
> +};
> +
>  int fsi_master_register(struct fsi_master *master)
>  {
>  	int rc;
> @@ -1249,6 +1253,7 @@ int fsi_master_register(struct fsi_master *master)
>  	mutex_init(&master->scan_lock);
>  	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
>  	dev_set_name(&master->dev, "fsi%d", master->idx);
> +	master->dev.class = &fsi_master_class;
>  
>  	rc = device_register(&master->dev);
>  	if (rc) {
> @@ -1350,8 +1355,15 @@ static int __init fsi_init(void)
>  	rc = bus_register(&fsi_bus_type);
>  	if (rc)
>  		goto fail_bus;
> +
> +	rc = class_register(&fsi_master_class);
> +	if (rc)
> +		goto fail_class;
> +
>  	return 0;
>  
> + fail_class:
> +	bus_unregister(&fsi_bus_type);
>   fail_bus:
>  	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
>  	return rc;
> @@ -1360,6 +1372,7 @@ postcore_initcall(fsi_init);
>  
>  static void fsi_exit(void)
>  {
> +	class_unregister(&fsi_master_class);
>  	bus_unregister(&fsi_bus_type);
>  	unregister_chrdev_region(fsi_base_dev, FSI_CHAR_MAX_DEVICES);
>  	ida_destroy(&fsi_minor_ida);
> 




