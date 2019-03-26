Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3DA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SIpxk/dM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfCZBTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:19:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51826 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfCZBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:19:23 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q1Eh2a022028;
        Tue, 26 Mar 2019 01:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PzAy+wGH5zEY6wfTwUk1PtN5WgnyaT54m4kVACSLfQM=;
 b=SIpxk/dMs9QmlkGqpbEQpS4LZfUnRHE5TfSxKCWIagXul6YuW1eYWKM4JXfS1xx9wrIy
 +rO9fRGJHiBle15Vx03CkalhNK0OO9P2m2oMpkN7MpcxkU0dqNrg+GSfab+9jmPTcnUW
 NAVcdr4gESdziPb/pzgYZ2CXcl++An825xFnc/+X6g8Xhv0qL/iULBS4TRS/llunu0hw
 QaMBfWRtjW7iihJdaPMtVOq6X/wGbAaEoEhwQwFiqccXxgOlpPv0N6ixcAyLYwXopNht
 yVCGI/hN1fZ00ZoRm1bx9whL6GpQWkqVStahp7SVnQdckjRBEhVvsJGNVLb6xUdpQrcz Ew== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g0qeg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 01:19:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q1JJPY027661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 01:19:19 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q1JITR008026;
        Tue, 26 Mar 2019 01:19:19 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 18:19:18 -0700
Subject: Re: [PATCH] scsi: ses: fix some risks of out of bound access
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553499602-27810-1-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <4ce7e311-e1c8-9914-fb01-9ac3778f793c@oracle.com>
Date:   Tue, 26 Mar 2019 09:19:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553499602-27810-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would anyone please take a look at this.
Our customer encounter terrible memory corruption and panic due to this.

Thanks
Jianchao

On 3/25/19 3:40 PM, Jianchao Wang wrote:
> We have some places with risk of accessing out of bound of the
> buffer allocated from slab, even it could corrupt the memory.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/ses.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index 0fc3922..42e6a1f 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -520,6 +520,7 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
>  	struct ses_device *ses_dev = edev->scratch;
>  	int types = ses_dev->page1_num_types;
>  	unsigned char *hdr_buf = kzalloc(INIT_ALLOC_SIZE, GFP_KERNEL);
> +	unsigned char *page1_end = ses_dev->page1 + ses_dev->page1_len;
>  
>  	if (!hdr_buf)
>  		goto simple_populate;
> @@ -556,6 +557,11 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
>  	type_ptr = ses_dev->page1_types;
>  	components = 0;
>  	for (i = 0; i < types; i++, type_ptr += 4) {
> +		if (type_ptr > page1_end - 2) {
> +			sdev_printk(KERN_ERR, sdev, "Access out of bound of page1"
> +					"%p page1_end %p\n", page1_end, type_ptr);
> +			break;
> +		}
>  		for (j = 0; j < type_ptr[1]; j++) {
>  			char *name = NULL;
>  			struct enclosure_component *ecomp;
> @@ -566,10 +572,15 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
>  				} else {
>  					len = (desc_ptr[2] << 8) + desc_ptr[3];
>  					desc_ptr += 4;
> -					/* Add trailing zero - pushes into
> -					 * reserved space */
> -					desc_ptr[len] = '\0';
> -					name = desc_ptr;
> +					if (desc_ptr + len >= buf + page7_len) {
> +						desc_ptr = NULL;
> +					} else {
> +
> +						/* Add trailing zero - pushes into
> +						 * reserved space */
> +						desc_ptr[len] = '\0';
> +						name = desc_ptr;
> +					}
>  				}
>  			}
>  			if (type_ptr[0] == ENCLOSURE_COMPONENT_DEVICE ||
> @@ -693,7 +704,13 @@ static int ses_intf_add(struct device *cdev,
>  	/* begin at the enclosure descriptor */
>  	type_ptr = buf + 8;
>  	/* skip all the enclosure descriptors */
> -	for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
> +	for (i = 0; i < num_enclosures; i++) {
> +		if (type_ptr >= buf + len) {
> +			sdev_printk(KERN_ERR, sdev, "Overflow the buf len = %d\n", len);
> +			err = -EINVAL;
> +			goto err_free;
> +		}
> +
>  		types += type_ptr[2];
>  		type_ptr += type_ptr[3] + 4;
>  	}
> 
