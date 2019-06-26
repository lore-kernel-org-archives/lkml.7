Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4370FC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3222085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1+BBmAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFZTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:40:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46024 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:40:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id z19so1670976pgl.12;
        Wed, 26 Jun 2019 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQV/ucNJOmS1ZAuf0ofCnIQPznZqg2rdsUBQ0lFLvlw=;
        b=V1+BBmAHZXxAASzYHMT4TCKNzE1BVsAiEs7csx39/e2p24wz830GSKv/2qV4M1E/oR
         GQsw+v6MyX/Dx0+BqL7fXiTZ5vNmnizEz1U1CIbypmHiJd1L9pjTaWYCgqyrIvXUN7JG
         cZ4s8EuhmtBUHqi5BtHBXPxXT4Xc/gm5HePZkGQiMTOVEi/jfcOSw0J3vQC20KxPQ+R4
         NOtkE6oH+HuQdCgmnFalxJzw09ghTtzW2uH/G12ZawW/7xgC4sDjpYMpYQ+NMS4yISgm
         w0Rug3p6DasIp7e2EGnLiUfUKgUeVYQprQJRVpogHIEI6jnpx5IjBS+4q5H/W2VOCRdT
         E9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQV/ucNJOmS1ZAuf0ofCnIQPznZqg2rdsUBQ0lFLvlw=;
        b=LLLBlrG+OVm1j+otgkg5QbWuH80hbhngOI3rv+wwX6/0mdQHWR1zlZ0fYnSa8oPR2s
         XWHc9kkygu5X1a1Au4moeRvqqSntN913ky1pXA/lcH+uWcBMv/LrOvreWN9VCbXOIuW1
         lmvxDcAvbMF8sZukD/y5LURd8ugWP2nnPEDFoclHh45aZXf3+Vm2COIr6UF94N4sQhqg
         m5wcUGyzKRkMtA0CknWmgFy7aVX0+f4iaRziHsYIKRJczWfSdrLFW9OIuqLhccDPIlcz
         +Kc0stXDFao+gsaNj7hLnAX51mazUdAGx0JMk7gaLMdLDgJXQPrZcd6WIrKTOlezchU5
         c9DA==
X-Gm-Message-State: APjAAAXWuvGGypSAciXLMk23oizqF9h3nkCA7y1fxoEVicrXzZ1NiQWW
        o5vLg7B6kGYaazfBb1hQYQE=
X-Google-Smtp-Source: APXvYqxz/GIQh0t+zyp9mwXfexf0u3nLyharYhio5tE/0ds7Atx79wyUiKZ9RcmZ5PvSri4AD1SgSw==
X-Received: by 2002:a65:50cb:: with SMTP id s11mr4529535pgp.371.1561578051319;
        Wed, 26 Jun 2019 12:40:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24sm15000pfh.133.2019.06.26.12.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 12:40:50 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:40:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, mine260309@gmail.com
Subject: Re: [PATCH] OCC: FSI and hwmon: Add sequence numbering
Message-ID: <20190626194048.GA7374@roeck-us.net>
References: <1561576395-6429-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561576395-6429-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 02:13:15PM -0500, Eddie James wrote:
> Sequence numbering of the commands submitted to the OCC is required by
> the OCC interface specification. Add sequence numbering and check for
> the correct sequence number on the response.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume this will be pushed through drivers/fsi.

Guenter

> ---
>  drivers/fsi/fsi-occ.c      | 15 ++++++++++++---
>  drivers/hwmon/occ/common.c |  4 ++--
>  drivers/hwmon/occ/common.h |  1 +
>  3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index a2301ce..7da9c81 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -412,6 +412,7 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  		msecs_to_jiffies(OCC_CMD_IN_PRG_WAIT_MS);
>  	struct occ *occ = dev_get_drvdata(dev);
>  	struct occ_response *resp = response;
> +	u8 seq_no;
>  	u16 resp_data_length;
>  	unsigned long start;
>  	int rc;
> @@ -426,6 +427,8 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  
>  	mutex_lock(&occ->occ_lock);
>  
> +	/* Extract the seq_no from the command (first byte) */
> +	seq_no = *(const u8 *)request;
>  	rc = occ_putsram(occ, OCC_SRAM_CMD_ADDR, request, req_len);
>  	if (rc)
>  		goto done;
> @@ -441,11 +444,17 @@ int fsi_occ_submit(struct device *dev, const void *request, size_t req_len,
>  		if (rc)
>  			goto done;
>  
> -		if (resp->return_status == OCC_RESP_CMD_IN_PRG) {
> +		if (resp->return_status == OCC_RESP_CMD_IN_PRG ||
> +		    resp->seq_no != seq_no) {
>  			rc = -ETIMEDOUT;
>  
> -			if (time_after(jiffies, start + timeout))
> -				break;
> +			if (time_after(jiffies, start + timeout)) {
> +				dev_err(occ->dev, "resp timeout status=%02x "
> +					"resp seq_no=%d our seq_no=%d\n",
> +					resp->return_status, resp->seq_no,
> +					seq_no);
> +				goto done;
> +			}
>  
>  			set_current_state(TASK_UNINTERRUPTIBLE);
>  			schedule_timeout(wait_time);
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index d593517..a7d2b16 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -124,12 +124,12 @@ struct extended_sensor {
>  static int occ_poll(struct occ *occ)
>  {
>  	int rc;
> -	u16 checksum = occ->poll_cmd_data + 1;
> +	u16 checksum = occ->poll_cmd_data + occ->seq_no + 1;
>  	u8 cmd[8];
>  	struct occ_poll_response_header *header;
>  
>  	/* big endian */
> -	cmd[0] = 0;			/* sequence number */
> +	cmd[0] = occ->seq_no++;		/* sequence number */
>  	cmd[1] = 0;			/* cmd type */
>  	cmd[2] = 0;			/* data length msb */
>  	cmd[3] = 1;			/* data length lsb */
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index fc13f3c..67e6968 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -95,6 +95,7 @@ struct occ {
>  	struct occ_sensors sensors;
>  
>  	int powr_sample_time_us;	/* average power sample time */
> +	u8 seq_no;
>  	u8 poll_cmd_data;		/* to perform OCC poll command */
>  	int (*send_cmd)(struct occ *occ, u8 *cmd);
>  
> -- 
> 1.8.3.1
> 
