Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B412084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbfFRWoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:44:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730176AbfFRWoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E361C308FC4E;
        Tue, 18 Jun 2019 22:43:59 +0000 (UTC)
Received: from mchristi.msp.csb (unknown [10.64.242.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6903D5C1B5;
        Tue, 18 Jun 2019 22:43:58 +0000 (UTC)
Reply-To: mchristi@redhat.com
Subject: Re: [PATCH] scsi: tcmu: Simplify 'tcmu_update_uio_info()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190616070220.24189-1-christophe.jaillet@wanadoo.fr>
From:   Michael Christie <mchristi@redhat.com>
Organization: Red Hat
Message-ID: <2ffa1964-30b1-d8bd-a2e2-608fe4f06f45@redhat.com>
Date:   Tue, 18 Jun 2019 17:43:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20190616070220.24189-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 22:44:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2019 02:02 AM, Christophe JAILLET wrote:
> Use 'kasprintf()' instead of:
>    - snprintf(NULL, 0...
>    - kmalloc(...
>    - snprintf(...
> 
> This is less verbose and saves 7 bytes (i.e. the space for '/(null)') if
> 'udev->dev_config' is NULL.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/target/target_core_user.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
> index b43d6385a1a0..04eda111920e 100644
> --- a/drivers/target/target_core_user.c
> +++ b/drivers/target/target_core_user.c
> @@ -1824,20 +1824,18 @@ static int tcmu_update_uio_info(struct tcmu_dev *udev)
>  {
>  	struct tcmu_hba *hba = udev->hba->hba_ptr;
>  	struct uio_info *info;
> -	size_t size, used;
>  	char *str;
>  
>  	info = &udev->uio_info;
> -	size = snprintf(NULL, 0, "tcm-user/%u/%s/%s", hba->host_id, udev->name,
> -			udev->dev_config);
> -	size += 1; /* for \0 */
> -	str = kmalloc(size, GFP_KERNEL);
> -	if (!str)
> -		return -ENOMEM;
>  
> -	used = snprintf(str, size, "tcm-user/%u/%s", hba->host_id, udev->name);
>  	if (udev->dev_config[0])
> -		snprintf(str + used, size - used, "/%s", udev->dev_config);
> +		str = kasprintf(GFP_KERNEL, "tcm-user/%u/%s/%s", hba->host_id,
> +				udev->name, udev->dev_config);
> +	else
> +		str = kasprintf(GFP_KERNEL, "tcm-user/%u/%s", hba->host_id,
> +				udev->name);
> +	if (!str)
> +		return -ENOMEM;
>  
>  	/* If the old string exists, free it */
>  	kfree(info->name);
> 

Thanks.

Acked-by: Mike Christie <mchristi@redhat.com>
