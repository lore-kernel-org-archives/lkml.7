Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A3FC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE620881
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvsuXKTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfD1BcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:32:12 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41513 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfD1BcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:32:11 -0400
Received: by mail-oi1-f193.google.com with SMTP id v23so5657675oif.8;
        Sat, 27 Apr 2019 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bvv5L+mOeGMPKWyP0URyk3hyk8Cfz2d5oC2SlKBtkWk=;
        b=qvsuXKThjFpVjppKXSgxgDFfNECbmfleaAfHtp95tHVmAjCPb0aw+sAvkQNmQmFIfU
         al5Hr8iOaVUJ5Z5zy0IjWW46b6Z1kuRe5wSLMt+p4vSPqIjDaxsOAo54OHGG8W3cZhrE
         4GAaU5ePTg/sC1atkkK1uj7rN+tiy8JpKVWkiuAHSkYaAX/7IqUhdkNgizHFAyTntXvA
         MkL5wqymRXr/OtJsmsBf39ep4lwPsKpsVSqHKYsPPfa7cDdusFpQyCyIpa12RuVXNSvC
         pAMjbD3ZxHlCEtQuomeEPXDT04b9WwzXYBkVJHy+0MU7iiolZf24HXI57Zmu3SOiwb9K
         tFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bvv5L+mOeGMPKWyP0URyk3hyk8Cfz2d5oC2SlKBtkWk=;
        b=VnWDQXZ4dK6lU9wJzsUt4Op8kOPcnyuvV5o3iO4eDJmgRSp5O98DW1Vy0gEkGtuo3S
         hBnUsvP4fChqEib68oNd43tqux+NWkSPs2rLylYrHXYdylTiMkV7DhBQdp8LhqiHRYTC
         JSCUhngpIk9pP4kTjopDIN3e7BGaOroGPf3lmi/ogfoPwHHm7FlgU8v+rCPj02m96xrg
         18/nl1er7SBCoUWMHvgFkDryEM2GVWyYXI81afWxNA+mJdVNT/Ss/n90rY+7KIOBOe8e
         l/7JGp6wusYwd5QGlDonlNarsVZj3/4lSZWc7jcV/rN4zjAW39BTUi9ryMP9oQFHxXhH
         Ef+A==
X-Gm-Message-State: APjAAAVopv9gkBCb8Is8FOgXwW7u+XRtafRJziGvwUqAKk6MkQwXno+j
        xH+VpSEiMKvzWajSr58v1Mb6d7T5lFo=
X-Google-Smtp-Source: APXvYqzcUerKyzolrxIdvmaUiBA+k/ZWGA30ueEmDFzf3ACqHlCdLYHYf1N3fWSVxByifr0eCzIteQ==
X-Received: by 2002:aca:43d5:: with SMTP id q204mr12259864oia.13.1556415130859;
        Sat, 27 Apr 2019 18:32:10 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.30])
        by smtp.gmail.com with ESMTPSA id y129sm13132446oig.27.2019.04.27.18.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Apr 2019 18:32:10 -0700 (PDT)
Subject: Re: [PATCH] fs: ocfs: fix spelling mistake "heartbeart" ->
 "heartbeat"
To:     ChenGang <cg.chen@huawei.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@oss.oracle.com,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>
References: <1556367755-118120-1-git-send-email-cg.chen@huawei.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <cee2552d-3a57-418b-1c17-91bb714370f1@gmail.com>
Date:   Sun, 28 Apr 2019 09:32:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556367755-118120-1-git-send-email-cg.chen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ChenGang,
Could you please fold these four patches into one?

Thanks,
Joseph

On 19/4/27 20:22, ChenGang wrote:
> There is a spelling mistake in o2hb_do_disk_heartbeat debug message.Fix it.
> 
> Signed-off-by: ChenGang <cg.chen@huawei.com>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index f3c20b2..e4e7df1 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -1198,7 +1198,7 @@ static int o2hb_do_disk_heartbeat(struct o2hb_region *reg)
>  	if (atomic_read(&reg->hr_steady_iterations) != 0) {
>  		if (atomic_dec_and_test(&reg->hr_unsteady_iterations)) {
>  			printk(KERN_NOTICE "o2hb: Unable to stabilize "
> -			       "heartbeart on region %s (%s)\n",
> +			       "heartbeat on region %s (%s)\n",
>  			       config_item_name(&reg->hr_item),
>  			       reg->hr_dev_name);
>  			atomic_set(&reg->hr_steady_iterations, 0);
> 
