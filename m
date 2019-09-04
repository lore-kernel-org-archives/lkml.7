Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A5021883
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q+1hk21R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfIDUWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:22:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730365AbfIDUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:22:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so6163277pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=xVOtfa4FemHiS/Yp7atJtq7Zy87lPl7zBOB4z9A7MuY=;
        b=Q+1hk21RFb1tZ0ePhKaz0FBP+F7xrChbtOjP47j0INYk22MckIk8FAVmUdnlduNLiY
         vJUGbBajYhb8/8theSGrC63KxTjXhJjvmsEpUPvgpupBO36l5uZMwaw87S+8NHl54zZQ
         Wq0wbDhaLvHhiTG6g1xXdzZAwbvn8n9Iph63c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xVOtfa4FemHiS/Yp7atJtq7Zy87lPl7zBOB4z9A7MuY=;
        b=cJhdnHhBIk1WlkZqazFb3QlI6BzVg6Q5iCOB5WxYWtzdTOnge+TaprNRPCqgd1Thqs
         1ltBisB9Io8hOqhOXQhy87KORP89DU5Qi914JduliDelqzenf4bqzmmu707IVRSDxgYX
         nGnATv76/OfFOmGLU5cmbBTqp6ls605/RWR/u8JZZpsgoaZxTSqou9j74EYalzQiCeVV
         JvapiW/1PczVkCBRrSsslhxsdvHrJf+6Ajli/UOT8k5vHEE1ET/iPJne8Ff3Cizvxwl4
         WQ4pV49J6nVhCo7LUzYO6tvCvM7wl+dOe378aMAX0cbA3VFt+zyk3iInq0f7FLXQKPI2
         B90Q==
X-Gm-Message-State: APjAAAXkZQWX2qPqhE/tH/lRe/YCZ6CeEpz210xkZzZlMxwVK4p9yAW3
        BxDSch2wR0JNbIykWu/DBhpF1DLnJEE=
X-Google-Smtp-Source: APXvYqwBzTEtSdnbNv4cKtzyBFFJzW885bb0y8aCjJz1dx+RCqXH5zFiSZ/xW+rVes78ygzURGS+fA==
X-Received: by 2002:a63:3ec7:: with SMTP id l190mr4031pga.334.1567628549777;
        Wed, 04 Sep 2019 13:22:29 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d20sm30053798pfq.88.2019.09.04.13.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 13:22:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] scsi: lpfc: Convert existing %pf users to %ps
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, Joe Perches <joe@perches.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20190904160423.3865-1-sakari.ailus@linux.intel.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <2899e50b-2984-c546-2d3e-450908eada88@broadcom.com>
Date:   Wed, 4 Sep 2019 13:22:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904160423.3865-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/2019 9:04 AM, Sakari Ailus wrote:
> Convert the remaining %pf users to %ps to prepare for the removal of the
> old %pf conversion specifier support.
>
> Fixes: 323506644972 ("scsi: lpfc: Migrate to %px and %pf in kernel print calls")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>   drivers/scsi/lpfc/lpfc_hbadisc.c | 4 ++--
>   drivers/scsi/lpfc/lpfc_sli.c     | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
>

Reviewed by: James Smart <james.smart@broadcom.com>

-- james


