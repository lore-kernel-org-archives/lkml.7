Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE01C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AF82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZNGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfCZNGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:06:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ED2D300273A;
        Tue, 26 Mar 2019 13:06:11 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9848092AC0;
        Tue, 26 Mar 2019 13:06:09 +0000 (UTC)
Message-ID: <bc247133bb00ef1f00dd0757c6d84d315cab1bbc.camel@redhat.com>
Subject: Re: [PATCH] scsi: ses: fix some risks of out of bound access
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 09:06:09 -0400
In-Reply-To: <1553499602-27810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553499602-27810-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 26 Mar 2019 13:06:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See below.

On Mon, 2019-03-25 at 15:40 +0800, Jianchao Wang wrote:
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

I think "if (type_ptr + 1 >= page1_end)" would be more consistent.

> +			sdev_printk(KERN_ERR, sdev, "Access out of bound of page1"
> +					"%p page1_end %p\n", page1_end, type_ptr);

This message is not helpful for someone with a device reporting
invalid enclosure data.  It should be more generic, like
"Enclosure data too short" or "invalid" or something.  And, the
actual pointer values are irrelevant, it all depends upon the
contents of the buffer.

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

See above, the message is unhelpful.  The actual problem is that
the Enclosure data is too short or invalid.

> +			err = -EINVAL;
> +			goto err_free;
> +		}
> +
>  		types += type_ptr[2];
>  		type_ptr += type_ptr[3] + 4;
>  	}

This will still potentially leave type_ptr past the end of the
buffer in the subsequent code, though, right?

This might fix the problem for your malfunctioning device, but
does not look like it would handle the general case.

-Ewan

