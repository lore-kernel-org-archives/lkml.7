Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11452C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F48206F0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575309629;
	bh=VPYvkExsUsped+EhUhYNqttSjJVvfVTGU4BbPk4HKOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HK00dMW5wO4+tL9L5haGxH0Ff5MwlIBCo+bNirfgKOwClCOz4DYsdApSSkx1CnmGd
	 zvhmfT9pXLFqqPq650Rl5YIV4eaoxGJIEvYj6Qx5dlAxomjK1ZqIvgz1tyLWP947Ut
	 4yV3IMrzbKZXB9feQfypu6Cp9OzRQVSsnK82mmIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfLBSA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:00:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33823 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLBSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:00:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so669016qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFlACXBJnb8jry0uEhbM4QtsoFH3IHAG2OdflxxHZn4=;
        b=H8im5zMX0YkVeHvoe2sjBf7xMMVChOCdRzbfdeD6VqDApM3L6rqqCMW1z4orKqT9Bh
         GaMn/cj0wt42I6z3QNbdgDoOsp2wMLxIFsptPVp9RXtQZv1hSxr2e5JlgUKADpJvY1aW
         XP+QjPkg0gAIStPXj8j9oq6NIEFonPVviKhjeUHRSPqe7aGJ88UsLad3IEOLwerifSzC
         iXZG3kn7BTbTSYY3tE+uilTAYU4tiav/HEfsQqWSV+dqYf5vSQwaFwTYaFs3T0BPWBuJ
         MxZqnZYJlXu7IyFIkNcKDsp95rxmRRE6s9AnDyCHxmp8u0nLkfTFWA052EAD30zqfODd
         eGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFlACXBJnb8jry0uEhbM4QtsoFH3IHAG2OdflxxHZn4=;
        b=GVE8/iMg/d2Y1BSnqYndXZIPXl0Kx8fLTvXdV9lkCPH9FrQJH219LQ8EHc7p3YNA1Q
         spYzZUNU8SP0CDmCebVUx36qWeOSEwkzBU/KCLJGahVQuyU9GgAzOv2BvdnpseWaSCjE
         4pFrHGdoBwWzxoxOPwyhYEN/nLQ7aevff4HmgaNpHx/FOGLEK2Vg6343VSK8tApaxfHe
         NJh12xWoBzkrXm+prAYc4nhipeMZfC41PMhbCKmClvz3W7tJU26H7uDiiytLKoAdJFc2
         VgPB0gPGt/SbECCDTTlZ4AS7udoZwnsuIRxNUHvoATuFjLnVKFGyG/XxbpCZ/6CxxV+C
         Dbyg==
X-Gm-Message-State: APjAAAUYcId7w2UuPXDY9kZqa/tJyQgoGNuiT0FJZrHOIRi5zJxrfyuU
        6PEKrkx1LQsoifydQMU/WE8=
X-Google-Smtp-Source: APXvYqzRcDCJ82cFvHbD9y1gQG8gX3GG4kBrcr8c13UWsO/ctiH3jMJSNDGrHl98tEQd38ZQ5RMS/w==
X-Received: by 2002:aed:29e1:: with SMTP id o88mr660564qtd.182.1575309627136;
        Mon, 02 Dec 2019 10:00:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:c909])
        by smtp.gmail.com with ESMTPSA id o2sm151759qkf.68.2019.12.02.10.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 10:00:26 -0800 (PST)
Date:   Mon, 2 Dec 2019 10:00:23 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     pmladek@suse.com, joe@perches.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] workqueue: Use pr_warn instead of pr_warning
Message-ID: <20191202180023.GB16681@devbig004.ftw2.facebook.com>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
 <20191128004752.35268-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128004752.35268-2-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:47:49AM +0800, Kefeng Wang wrote:
> Use pr_warn() instead of the remaining pr_warning() calls.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route however you see fit.

Thanks.

-- 
tejun
