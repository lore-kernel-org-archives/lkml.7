Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B529C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CDE206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPeiQp9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:11:24 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:11:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKJAHoD177728;
        Fri, 20 Dec 2019 19:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8GZNBShQQ7V7PrA2Jhwg30hVOWFWIPLHm0EN5lU1Eu8=;
 b=mPeiQp9yK7rPQbnlM57whCzPPwFGWhjdmk33fMFd39X7bXX5KmyxbqzlImmNHgWyZegU
 w2/BaDaQbVjLp2KtL3lWEh8Axw+YkVqId93CtbxRDnG3Qlb+mbsrfCs3BUB/lEIVPXMv
 e43jw8VrixidUhz2BwT2V+vd5o0eeBsaRXy7qW0B1StKicT+0YrOg6eEHLVHDvECebPW
 wimz8t79xTJNgcfKqKA7zN+ReoGrKJw7hBJTNBIv/UR4lsXcMXRLfl24XOnwJSmhHGPG
 GpY0FJwupGjKq5VtIyVBZfwumEqBPZhvq+RDbeXwZKTn+gu4AqK1vweJoVvycXfrwPhq Xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2x01kntfh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 19:11:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBKJALLZ041856;
        Fri, 20 Dec 2019 19:11:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2x13tjuuyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 19:11:07 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBKJB4xp008032;
        Fri, 20 Dec 2019 19:11:04 GMT
Received: from bostrovs-us.us.oracle.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Dec 2019 11:11:04 -0800
Subject: Re: [PATCH v2] xen-pciback: optionally allow interrupt enable flag
 writes
To:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org
Cc:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191219034941.19141-1-marmarek@invisiblethingslab.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <4ed998e1-c8e6-a2c3-031a-9104c912cb76@oracle.com>
Date:   Fri, 20 Dec 2019 14:11:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191219034941.19141-1-marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=994
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9477 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/19 10:49 PM, Marek Marczykowski-Górecki wrote:
> ---
>   drivers/xen/xen-pciback/conf_space.c          | 35 ++++++++
>   drivers/xen/xen-pciback/conf_space.h          | 10 +++
>   .../xen/xen-pciback/conf_space_capability.c   | 88 +++++++++++++++++++
>   drivers/xen/xen-pciback/conf_space_header.c   | 19 ++++
>   drivers/xen/xen-pciback/pci_stub.c            | 66 ++++++++++++++
>   drivers/xen/xen-pciback/pciback.h             |  1 +
>   6 files changed, 219 insertions(+)

This also needs an update to Documentation/ABI/testing/sysfs-driver-pciback.


> @@ -64,6 +64,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>   	int err;
>   	u16 val;
>   	struct pci_cmd_info *cmd = data;
> +	u16 cap_value;

What is this for?


>   
>   	dev_data = pci_get_drvdata(dev);
>   	if (!pci_is_enabled(dev) && is_enable_cmd(value)) {
> @@ -117,6 +118,24 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
>   		pci_clear_mwi(dev);
>   	}
>   
> +	if (dev_data && dev_data->allow_interrupt_control) {
> +		if (!(cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    (value & PCI_COMMAND_INTX_DISABLE)) {
> +			pci_intx(dev, 0);
> +		} else if ((cmd->val & PCI_COMMAND_INTX_DISABLE) &&
> +		    !(value & PCI_COMMAND_INTX_DISABLE)) {
> +			/* Do not allow enabling INTx together with MSI or MSI-X. */
> +			switch (xen_pcibk_get_interrupt_type(dev)) {
> +				case INTERRUPT_TYPE_NONE:
> +				case INTERRUPT_TYPE_INTX:
> +					pci_intx(dev, 1);
> +					break;
> +				default:
> +					return PCIBIOS_SET_FAILED;
> +			}
> +		}


Perhaps this is slightly easier to read:

if (cmd->val ^ val)  &  PCI_COMMAND_INTX_DISABLE) {
         if (value & PCI_COMMAND_INTX_DISABLE) {
                 pci_intx(dev, 0);
         } else {
                 /* Do not allow enabling INTx together with MSI or 
MSI-X. */
             switch (xen_pcibk_get_interrupt_type(dev)) {
                 case INTERRUPT_TYPE_NONE:
                 case INTERRUPT_TYPE_INTX:
                     pci_intx(dev, 1);
                     break;
                 default:
                     return PCIBIOS_SET_FAILED;
             }
        }
}

And also, if INTERRUPT_TYPE_INTX, aren't you already enabled?


-boris

