Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1320C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2BD2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 22:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Zl/1R1gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfCWWkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 18:40:02 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57764 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfCWWkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 18:40:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 66104C4A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 22:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id teDR9uDW6ZsH for <linux-kernel@vger.kernel.org>;
        Sat, 23 Mar 2019 17:39:59 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 37877C81
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 17:39:59 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id e72so4875325iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 15:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:cc:references:in-reply-to:from:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=+fKxgDGSPmUqLXo9HKk8/efhTORtUU9n7nsvOWorgpY=;
        b=Zl/1R1gsw66RM1fBwZICrqbFCFjwnZI0wTSMtiXXQWpp+ubszOGkLvrdlnjbnF0kk0
         GXpAAK613pxMxmKmZmjgLiz97EbrXS/YQTP5zDbFLKkDyZq8wizn30b2+qZADPQnsyN5
         1LN8+sqvKQvLZvzE4mBMjB3NnjC0Uf6LqDlpbb5iLmiuGaJCbi3+Gqk6G+Z3Zkb30Sek
         YV9yxQmtyZWmlNz6WaXQ6+dGu0ik/IUL6eiq4n/Rg4B0nIHbGjNyRu7lSgnHbtSwfmzF
         fTt8b1lJtCFmENB0CP5Ti8RYvFCVRrt2UbtkfcaH1/h7uGRDiwuSLdV3ddy2oZs+IyCv
         jlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-transfer-encoding
         :content-language;
        bh=+fKxgDGSPmUqLXo9HKk8/efhTORtUU9n7nsvOWorgpY=;
        b=lv2HeAspXyOhO816abFbGIoCBeUULgR+I0NX6adToGBJ61HtTKYsPq4PunWdn7R8sQ
         DTxG7khn14PyVF8vHVjp+Uy2f0QBURwF/qUlFCjtxFw1c0lJLqKa9r/USDTaNkO960go
         YzwWkvtRvZzOlqLSgEqzKFEPAbvrKj9KauoIjXECaxzebXfCeyij188QJyLZ/+37YMyl
         T3c+ai9Ria8PrlmP5wPsOtsH3csJI+7JL6rHQET8SJmCmkjSIMghaNFxvM/S0qdbZ+5V
         uqMWNmF7gmTS0LZTXsNrn3+VLe+ZYOb7AdTaCOCjgxCEqK+xewe0CNvdk2nBLRhBVLk5
         Acyg==
X-Gm-Message-State: APjAAAX0ouYnrZYBrssKakC4HRPqBQL4ixU9iTzs2AHG+iQSvEJ/Ku8Z
        VOM69HgBQGMxrhIxiktWVeR5yzXrbQ7RUWAeJpilBOV+53/14cTwvuEFRId4MuIzXDurpXZSCma
        637JBNT4DkBW8Jzm4Z0w1PJsLapBT
X-Received: by 2002:a02:6a2c:: with SMTP id l44mr10396328jac.63.1553380798736;
        Sat, 23 Mar 2019 15:39:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIMvtZfvgFDotox19ZFy5ckfNiNbuj+Dph6+6gU/hG5tb0FuGWzj7HPm3yqwktfVg0aNodXw==
X-Received: by 2002:a02:6a2c:: with SMTP id l44mr10396318jac.63.1553380798553;
        Sat, 23 Mar 2019 15:39:58 -0700 (PDT)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id a77sm3389666itc.5.2019.03.23.15.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 15:39:58 -0700 (PDT)
Subject: Re: [PATCH] scsi: qla4xxx: fix a potential NULL pointer dereference
Cc:     Kangjie Lu <kjlu@umn.edu>, QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190314063100.12805-1-kjlu@umn.edu>
In-Reply-To: <20190314063100.12805-1-kjlu@umn.edu>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <5c390db5-c2a2-cfad-48c1-c619244db9c1@umn.edu>
Date:   Sat, 23 Mar 2019 17:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/14/19 1:30 AM, Kangjie Lu wrote:
> In case iscsi_lookup_endpoint fails, the fix returns -EINVAL to
> avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index a77bfb224248..80289c885c07 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -3203,6 +3203,8 @@ static int qla4xxx_conn_bind(struct iscsi_cls_session *cls_session,
>  	if (iscsi_conn_bind(cls_session, cls_conn, is_leading))
>  		return -EINVAL;
>  	ep = iscsi_lookup_endpoint(transport_fd);
> +	if (!ep)
> +		return -EINVAL;
>  	conn = cls_conn->dd_data;
>  	qla_conn = conn->dd_data;
>  	qla_conn->qla_ep = ep->dd_data;
Gentle reminder, could someone please review this ?
