Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701C5C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4528421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 20:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfGSUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 16:15:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41793 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfGSUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 16:15:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so34018728ota.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 13:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kkpL/Yq6hsmshdWJXQRmWbef4HDFrUIMo3dW6QtsBOU=;
        b=qtEBrz5rJqg6a0y6Zle/o/zf0XEWuNrhoSgZE9AHDSRDkIkF5Y+JRDmQwMWjyJcv6w
         0O41IlSKQd3aUL2gr4M4/dAjf2vuz4GZbbUxiRLznvMwn25RPnxuOhZmp5Ykl/nnXz6M
         dZEIezuQdAttX+w//oLiMSgHdvDKFDaF/KhqfFHmPDFdDcy7l2/gcof8T6zCKf+pJl9G
         Jh+0p/Y8hXLnOc0spIr68tIS6wOPLPHYIOTkAKVaouKiRf6WF4WXZIQjU3NaHWV/3MnC
         XZjtjIq/6iow/W9QlcaVQkcqWULxDdxvLL2tOYf/eIlE5GgZiJPc+mpHEwMOsku5Cgxn
         MYog==
X-Gm-Message-State: APjAAAVlPZhxye/csvpFLuIzWvhPYkdldeT9BwWeHDooBhM8Ifjy8dqP
        vhHBkdPjrr0bYtsKB7TlIxU=
X-Google-Smtp-Source: APXvYqz7EYdCm82iMo376gSzheRtPm1ARvAvJv85wvLvZKPbuwQ1NT8A7vSMqRZGif0NVaoqIQe5Ng==
X-Received: by 2002:a05:6830:c9:: with SMTP id x9mr33170188oto.332.1563567353487;
        Fri, 19 Jul 2019 13:15:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id f125sm10938514oia.44.2019.07.19.13.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 13:15:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>
Message-ID: <e516395c-7741-af1a-42a9-2bd528b3976c@grimberg.me>
Date:   Fri, 19 Jul 2019 13:15:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ba6d1a56-8f86-4060-a167-6d67435e1a88@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> [1]:
> Or actually:
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 76cd3dd8736a..a0e2072fe73e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3576,6 +3576,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>          struct nvme_ns *ns, *next;
>          LIST_HEAD(ns_list);
> 
> +       mutex_lock(&ctrl->scan_lock);
> +       list_for_each_entry(ns, &ctrl->namespaces, list)
> +               if (nvme_mpath_clear_current_path(ns))
> +                       kblockd_schedule_work(&ns->head->requeue_work);
> +       mutex_lock(&ctrl->scan_lock);

This should be mutex_unlock of course...
