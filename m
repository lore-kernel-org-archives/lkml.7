Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE2CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 15:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="PKwhnyLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfJaPVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 11:21:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40222 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfJaPVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:21:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id r4so4583886pfl.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o6eqeIwaCQCAg87SksrNHLVnftpB/cAn9NS9wCxkNqY=;
        b=PKwhnyLwJvgqOX1sDYGBB897Yl2Mk5RbgPR5PsEX+yZgT3cjgw1EqgPoPdy3/aj2KM
         J6fw9M16PptWlutsg00fkxQTykqm1xQwEDsBAKIOvsREYpwl63BiyjtqO+Fu+QqksVeU
         cNYPNkwr52lg1DL39dHbta9bnSpLTNSjej2SwBskbL52TJqXKGLURcSyOh+T5FwwZsvM
         hFXCh9SF+XbbmES3xO2DrQaCwU2TrK5H/M6ChYhyxIUPYHwAWfyiu6qI1j9OwDJm3So3
         QPKvt4Sxgojexo5ZCo/ogib5u7A4M2ngtvSnAp8Nfvm+ZFT28ebleeVvdCFifBV0rzZR
         fcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o6eqeIwaCQCAg87SksrNHLVnftpB/cAn9NS9wCxkNqY=;
        b=ZUYam57Thvk5/ejmBWt+H+3FpHyjO4i5Ti96bnt3kETRcpO7vcVhwrljmuO35hQsVZ
         KPzkIXlboy2yV9V6bePFtn3i+ekHkItatZ0j0KSd2/enXWYDGukFS9/HTGeln9stTd4q
         S+IlHUnUDrmFQP+ukRQ4fmwrfGCOthApWdHi4WyBCDGS5Xr118z3Vdr+PJr3o3g0R7WG
         LN2/ViXMA6ZBObagaMYjdLzd3nRAsCDA1FnlRxRnyGK2/PPc0F+Xxy9OKH8FyGw6Gr5F
         x8fH9ZEhC+V4s+r5Wb2MGx1g9WODbGo4MshR9aAMj/S0fMBYRWyV4vsHJFlKARkqmZI4
         wtrg==
X-Gm-Message-State: APjAAAUrK3QbJvsIx59NjewibEu9+495S1WAW8afdyB7YfaAHuloLwS7
        20QerFuVyZV4/1CfVwQPB6MmDYQisylDpg==
X-Google-Smtp-Source: APXvYqwn7iSji6RwvzjExwPk2ri0M2/mwE8JDon/sMBYHOw0KBV2KB32u8HMz+kIPjKXMWaot0amyw==
X-Received: by 2002:a65:41c5:: with SMTP id b5mr7203931pgq.78.1572535260326;
        Thu, 31 Oct 2019 08:21:00 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id x125sm4114563pfb.93.2019.10.31.08.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 08:20:59 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] scsi: Adjust DBD setting in mode sense for caching
 mode page per LLD
To:     Can Guo <cang@codeaurora.org>, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1572318655-28772-1-git-send-email-cang@codeaurora.org>
 <1572318655-28772-2-git-send-email-cang@codeaurora.org>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <fd78538f-8e5f-2e5f-0107-a8bc284d037d@android.com>
Date:   Thu, 31 Oct 2019 08:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572318655-28772-2-git-send-email-cang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 8:10 PM, Can Guo wrote:
> Host sends MODE_SENSE_10 with caching mode page, to check if the device
> supports the cache feature.
> UFS JEDEC standards require DBD field to be set to 1.
>
> This patch allows LLD to define the setting of DBD if required.
>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>   drivers/scsi/sd.c        | 6 +++++-
>   include/scsi/scsi_host.h | 6 ++++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index aab4ed8..6d8194f 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2629,6 +2629,7 @@ static int sd_try_rc16_first(struct scsi_device *sdp)
>   {
>   	int len = 0, res;
>   	struct scsi_device *sdp = sdkp->device;
> +	struct Scsi_Host *host = sdp->host;
variable locality
>   	int dbd;
>   	int modepage;
> @@ -2660,7 +2661,10 @@ static int sd_try_rc16_first(struct scsi_device *sdp)
>   		dbd = 8;
>   	} else {
>   		modepage = 8;
> -		dbd = 0;
> +		if (host->set_dbd_for_caching)
> +			dbd = 8;
> +		else
> +			dbd = 0;
>   	}
>   

This simplifies to:

-   } else if (sdp->type == TYPE_RBC) {

+    } else if (sdp->type == TYPE_RBC || sdp->host->set_dbd_for_caching) {

>   	/* cautiously ask */
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 2c3f0c5..3900987 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -650,6 +650,12 @@ struct Scsi_Host {
>   	unsigned no_scsi2_lun_in_cdb:1;
>   
>   	/*
> +	 * Set "DBD" field in mode_sense caching mode page in case it is
> +	 * mandatory by LLD standard.
> +	 */
> +	unsigned set_dbd_for_caching:1;
> +
> +	/*
>   	 * Optional work queue to be utilized by the transport
>   	 */
>   	char work_q_name[20];


