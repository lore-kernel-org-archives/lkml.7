Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671FF241E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6iFvgkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfE2VNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:13:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2VNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:13:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id p1so1584513plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=osu/x7FYody2Hoq4uLkPS7Kf2axeOtjhm45H0GWnEgQ=;
        b=Q6iFvgkjVosWfknWr+UHUu0tmky9zm33+DXECZJslVHVhgXMsWHIDiQZUWXntUatCA
         gtYtKge8bQKNw1zPDJ0JxtkDBeLOpk3n788p8jLzboez7cOBdOk3xMXVZZPGpxyS3x9K
         +Uae5F7tOGpwhfcoxXyxW9GrTiMJP+LtO4R7t7p84TuVCE5nj5cKaDb3THXzC3kIsMSO
         io4gJPe2eByMBwXK8RaTcVVnnCWsrJWs+ZmBy1Y71cXlPSbo70tjOnP6CFlK+yP2SeY8
         Uzz2631SlXTf5bRFwZcUyeYsXMkgfBtrNwaHVgCJ3IUlahWRyBWs6lNAckn6GmoeAOfu
         R2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=osu/x7FYody2Hoq4uLkPS7Kf2axeOtjhm45H0GWnEgQ=;
        b=A49oo0jNVgYdhojyrByJTkQ+cLkWG6a68uUl9F/Cx3yeYauMb1ElexK5rs8uDr6q/V
         eCx1uUjVHWfzdqa6VJuyNFqa84QWQp+VfkVg28o7dxsiWUXDaOIB++5AjLGmbm4bhY1t
         DfNEhaPwTOvYScb/9iu7JbzmeZTQ/j2K4A1qCbdGGoZ1Sc0O5ruoUruqwLUOnv/evxCL
         TQ2ZvC4O4/jsKSBdzrqESUU3f+agnI2I2mo5IvVVBXLtzTFx43e768PdMhQOQs5JCXJD
         f6gSoYF61d0ITOSwOYxFmhQbTjykTFLdBrf3FeiD553VzSumtbuacnwOvA7n5PgA7OnU
         qbcQ==
X-Gm-Message-State: APjAAAWf73b9jaawWIT4NzIP1zDK0WAIz8zNZucm8C8efMiobBHO56gM
        BWI9+qw8BDUnsZgw5whISA/jow==
X-Google-Smtp-Source: APXvYqzftdCMQALgk0F9juagotZqZQeBmfKRPjM6r0YhL7Q3xcrGdfu8ua/UIAWP7PZs3j5qSvlnbg==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr123754339plq.186.1559164400332;
        Wed, 29 May 2019 14:13:20 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 80sm584101pfv.38.2019.05.29.14.13.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:13:19 -0700 (PDT)
Date:   Wed, 29 May 2019 14:13:18 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ondrej Zary <linux@rainbow-software.org>
cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
In-Reply-To: <20190529175851.GA10760@hari-Inspiron-1545>
Message-ID: <alpine.DEB.2.21.1905291412360.242480@chino.kir.corp.google.com>
References: <20190529175851.GA10760@hari-Inspiron-1545>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Hariprasad Kelam wrote:

> dont acquire lock before calling wd719x_chip_init.
> 
> Issue identified by coccicheck
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> -----
> changes in v1: Replace GFP_KERNEL with GFP_ATOMIC.
> changes in v2: Call wd719x_chip_init  without lock as suggested
> 		in review

Why was host_lock taken here initially?  I assume it's to protect some 
race in init that leads to an undefined state.
