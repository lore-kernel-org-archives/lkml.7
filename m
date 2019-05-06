Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D6C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB4F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 05:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ToyvBRQr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ToyvBRQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFFLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 01:11:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfEFFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 01:11:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A351960E40; Mon,  6 May 2019 05:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557119506;
        bh=DqprrUG2On7X5AKgP2JeFG6hrsMFcEW8ibKQnnEvhHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ToyvBRQrYExvL/0GBr9aGynzIpkZ2XA1tkUZlTTr7w37yt3FZceAsUcTUl6nVB0NH
         kjzFIvywK8VONhlSapNbTu82WfP1jGdyH3UGnG9goH37biE9fKYr/0vFr6oZWwCqyn
         eKPNQUVf95LgE49QafhJAcBvINfy78ea7nMEZb+o=
Received: from [10.204.79.19] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94D2660DA8;
        Mon,  6 May 2019 05:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557119506;
        bh=DqprrUG2On7X5AKgP2JeFG6hrsMFcEW8ibKQnnEvhHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ToyvBRQrYExvL/0GBr9aGynzIpkZ2XA1tkUZlTTr7w37yt3FZceAsUcTUl6nVB0NH
         kjzFIvywK8VONhlSapNbTu82WfP1jGdyH3UGnG9goH37biE9fKYr/0vFr6oZWwCqyn
         eKPNQUVf95LgE49QafhJAcBvINfy78ea7nMEZb+o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94D2660DA8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH v3] drivers: core: Remove glue dirs early only when
 refcount is 1
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     sramana@codeaurora.org, linux-kernel@vger.kernel.org
References: <20190501065313.GA30616@kroah.com>
 <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <0aac6bf3-6691-7c5a-31f1-fb7231c6b585@codeaurora.org>
Date:   Mon, 6 May 2019 10:41:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556711999-16898-1-git-send-email-prsood@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 5:29 PM, Prateek Sood wrote:
> While loading firmware blobs parallely in different threads, it is possible
> to free sysfs node of glue_dirs in device_del() from a thread while another
> thread is trying to add subdir from device_add() in glue_dirs sysfs node.
> 
>     CPU1                                           CPU2
> fw_load_sysfs_fallback()
>   device_add()
>     get_device_parent()
>       class_dir_create_and_add()
>         kobject_add_internal()
>           create_dir() // glue_dir
> 
>                                            fw_load_sysfs_fallback()
>                                              device_add()
>                                                get_device_parent()
>                                                  kobject_get() //glue_dir
> 
>   device_del()
>     cleanup_glue_dir()
>       kobject_del()
> 
>                                                kobject_add()
>                                                  kobject_add_internal()
>                                                    create_dir() // in glue_dir
>                                                      kernfs_create_dir_ns()
> 
>        sysfs_remove_dir() //glue_dir->sd=NULL
>        sysfs_put() // free glue_dir->sd
> 
>                                                        kernfs_new_node()
>                                                          kernfs_get(glue_dir)
> 
> Fix this race by making sure that kernfs_node for glue_dir is released only
> when refcount for glue_dir kobj is 1.
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> 
> ---
> 
> Changes from v2->v3:
>  - Added patch version change related comments.
> 
> Changes from v1->v2:
>  - Updated callstack from _request_firmware_load() to fw_load_sysfs_fallback().
> 
> 
>  drivers/base/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4aeaa0c..3955d07 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1820,12 +1820,15 @@ static inline struct kobject *get_glue_dir(struct device *dev)
>   */
>  static void cleanup_glue_dir(struct device *dev, struct kobject *glue_dir)
>  {
> +	unsigned int refcount;
> +
>  	/* see if we live in a "glue" directory */
>  	if (!live_in_glue_dir(glue_dir, dev))
>  		return;
>  
>  	mutex_lock(&gdp_mutex);
> -	if (!kobject_has_children(glue_dir))
> +	refcount = kref_read(&glue_dir->kref);
> +	if (!kobject_has_children(glue_dir) && !--refcount)
>  		kobject_del(glue_dir);
>  	kobject_put(glue_dir);
>  	mutex_unlock(&gdp_mutex);
> 

Folks,

Please share feedback on the race condition and the patch to
fix it.

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
