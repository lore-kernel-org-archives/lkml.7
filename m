Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD57C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0CF20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4Xw64OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfDPWMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:12:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfDPWMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:12:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so11021461plb.9;
        Tue, 16 Apr 2019 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IrzDRn60Pv0EZ0uC2UHRSYaWyYVkoEN9BLdSXBtWYsc=;
        b=M4Xw64OGU6Y+a+xKXJPyjxsGe2VBkXi6dNMw5nM8JZ86n0ddwEpKW0jiT3maSuJmQy
         dwDSrdLHV7BXZ+XeyTOXhwCmj5Zn+pMv2bXAc/FWSW0SYIAUqJZsi5cNSaSoqO91kGbF
         61tMBfdYzwnc1hrK0l396cyInUV/u84Mf5T2yyN0L7svTN+D/3Vc0/3quXRG0ywnnkrM
         86w1ED/BnSM5kSGEhotcQRv9AUBwkDefLCr5Ii9Qc+Di2u7DQwNP2cuB1K+A2Yay4XkJ
         0q5NZ9wnhSk+726S96hMa0NSzl7fOpYBd8oRMIu1u9pwq6ory4btiBMwsrcPprI8ea59
         lIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IrzDRn60Pv0EZ0uC2UHRSYaWyYVkoEN9BLdSXBtWYsc=;
        b=kJza6yyhsU1womn8gjn/IYM+zwQ2ZyhLcQkdmu0wjRqhBKNtmmo4w/yenIXdjoDmLf
         /gJRmT7i0NpEWJz/yzMNJXcPVEZ/2+5JTzHFZfyqTuTg7Z6ialxc1ub+CL1J2z7jcwuF
         cxlMGBZTToW/DZa/JnyoLkcWt7lTNkwDo3LKgIDSaqxjV9MeRJ+A6xrtUZFOxakZ2U+E
         tpRb7bg95oHXEZuCrfFwfIU7TJSjtceIAF/pQqJNGXZ2dQbJbJCprIByg0LfpLjAWkWv
         74p6RoZ5i2s20GkuyRKrlhKnCU2ZzzC7I/puQEMHRxeIg6mLzeACD6gmnft9dET4thmx
         DfuA==
X-Gm-Message-State: APjAAAXmsfBv+S/UXNMW5JIHTs4xoAnIZsGwHgKPYjkvrbV4Uw26TmPI
        Ueo/qEVJ3Q001X3XKkTgK/A=
X-Google-Smtp-Source: APXvYqxshyLYTF07lL60WYVayjL7Rqq0S1FyXo2BgTAx3VeMeSTlU5oUMVYDxJJLmynScWfWKGwwGg==
X-Received: by 2002:a17:902:b78c:: with SMTP id e12mr33032125pls.29.1555452753339;
        Tue, 16 Apr 2019 15:12:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o81sm74066248pfa.156.2019.04.16.15.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 15:12:32 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:12:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, andrew@aj.id.au, mine260309@gmail.com
Subject: Re: [PATCH 1/3] hwmon (occ): Store error condition for rate-limited
 polls
Message-ID: <20190416221231.GA31987@roeck-us.net>
References: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555429430-23118-1-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:43:48PM +0000, Eddie James wrote:
> The OCC driver limits the rate of sending poll commands to the OCC. If a
> user reads a hwmon entry after a poll response resulted in an error and
> is rate-limited, the error is invisible to the user. Fix this by storing
> the last error and returning that in the rate-limited case.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c | 4 ++++
>  drivers/hwmon/occ/common.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 9d197e9..13a6290 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -141,6 +141,7 @@ static int occ_poll(struct occ *occ)
>  	/* mutex should already be locked if necessary */
>  	rc = occ->send_cmd(occ, cmd);
>  	if (rc) {
> +		occ->last_error = rc;
>  		if (occ->error_count++ > OCC_ERROR_COUNT_THRESHOLD)
>  			occ->error = rc;
>  
> @@ -149,6 +150,7 @@ static int occ_poll(struct occ *occ)
>  
>  	/* clear error since communication was successful */
>  	occ->error_count = 0;
> +	occ->last_error = 0;
>  	occ->error = 0;
>  
>  	/* check for safe state */
> @@ -210,6 +212,8 @@ int occ_update_response(struct occ *occ)
>  	if (time_after(jiffies, occ->last_update + OCC_UPDATE_FREQUENCY)) {
>  		rc = occ_poll(occ);
>  		occ->last_update = jiffies;
> +	} else {
> +		rc = occ->last_error;
>  	}
>  
>  	mutex_unlock(&occ->lock);
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index ed2cf42..fc13f3c 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -106,7 +106,8 @@ struct occ {
>  	struct attribute_group group;
>  	const struct attribute_group *groups[2];
>  
> -	int error;                      /* latest transfer error */
> +	int error;                      /* final transfer error after retry */
> +	int last_error;			/* latest transfer error */
>  	unsigned int error_count;       /* number of xfr errors observed */
>  	unsigned long last_safe;        /* time OCC entered "safe" state */
>  
