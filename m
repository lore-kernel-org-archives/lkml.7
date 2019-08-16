Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD8C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDA32077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kt8Af6t2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfHPT47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:56:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44789 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfHPT46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:56:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so3615282pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XDxicx1OP6wHEEPTkhNVlA3uTUHqZWelhtfoFqZM2P0=;
        b=Kt8Af6t2TxX8A/GfqjYGndn7iKVncQRUE/WtDfk34SccDPKUlp8oE0OfzeXlicZgd1
         MZkAnjryNIIBET4U9oMiljfG5WZQihr426LGa+oGRSZ1UWP3k32khcfHIwNd5Ci+/ZM1
         gjlslkRx7BZZth5fjw/7UlDQ/wI2WtQ9eJV1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XDxicx1OP6wHEEPTkhNVlA3uTUHqZWelhtfoFqZM2P0=;
        b=ELADBwlAxPX0qwGPa+rcXU6nCIQRgX8sw4SaG3kv08EKEtg8hQMNy1HaG8PQZjfzwk
         P6kaNR3k26yrfpYH1HMGrlPFzAC9Jf2OXNUesYxbMoZkSU+UehTp17niiZISp6eRGC3N
         KK9LWB11nhzTyd5PQM2U338yUac1IKZ3tWAdl8bzvQlzZ5WhS9l63Z2L6LMbnp+6dPgJ
         86Ndi0U7SZTxf1mXuMoY/4Lqos9ABFhp6YYck/rWqmQ2JTu1F2xIiE+s5lk6TWYDsw3A
         h35bb/NeKPOKSfB3tN7ZZd44HJSoIwJnrTjyueXCaR/HllfpOb7c0boHzZHnZA1PxNab
         CWQQ==
X-Gm-Message-State: APjAAAXM22t7gMLcIirNVJrssbO5fcD0A5ht/7Sv+giCy5kXezGTs0+m
        eK2y/E3KzRSxvPUjuGbNOYsLeerC1nNQ0a6KddIlPdaQTEM2ISBFBNBaJ3T4RzQQVXK4cRG40bP
        7KxMXg4+Eu7tAmyfXX4yCQCwch0eED21uAIsLqUSO7HAYucPXVPTkoFFSImd9qt9UrmsSCi3omV
        FgD9c=
X-Google-Smtp-Source: APXvYqwc8GYCB3OP3WP4dI74ppom+NhRyeIPQBp2bN1x7NdcjYCvPOlHYRPGpuPIMWxIqu5f1ZsFjw==
X-Received: by 2002:a17:90a:234e:: with SMTP id f72mr8875479pje.121.1565985418002;
        Fri, 16 Aug 2019 12:56:58 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u26sm7784201pgl.79.2019.08.16.12.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 12:56:57 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: remove redundant code
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190808013525.13681-1-huangfq.daxian@gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <32a8659f-cc3e-ae7d-7a38-3ffae3e22a3e@broadcom.com>
Date:   Fri, 16 Aug 2019 12:56:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808013525.13681-1-huangfq.daxian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/2019 6:35 PM, Fuqian Huang wrote:
> Remove the redundant initialization code.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>

Looks good!

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

