Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E64C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6672C20692
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 16:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfILQ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 12:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22249 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfILQ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 12:27:00 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C57F811A07
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 16:26:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id x1so12220904wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 09:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qziAxNyAubhHTYBSD4yRsXHN9OiFD1ZQQkCUflFkono=;
        b=pIrsjjlj9xaHHWV8kpB+s7tvoJ9AqmehKjEe56m6mspkNydn8oZ9IY0IpAwpt+pNLN
         bWaCfBEqPe1r4VO9S+rPKM3UQFpiMyRiZ99VYN2X0+8591BFZAxjQ1sNWYZH298FfYPO
         gqtLe2UOwo7ORX4v7N022tUSbdw4XvrkS+50taUKy4jEFvDiAgpykhGeqP30zzCrae5e
         wRdcc1ZWcBvu0KqIErv6DPlLVtyXshCvy2Vb7vwp2lsBAJmA9PCg4DO0amsu+oYsPhMA
         mL8fX20V2KiEHxER/X20lK/sKTV3UFE5jQw+sXcfiEwgN+tws3zaZY98hoWOO0V0MWIS
         hVOQ==
X-Gm-Message-State: APjAAAVJADIwBKRaaIKix8YHJmYAcS+M3XG5GvEFUNdQ5hLdxZ5AgKJ7
        0GieZQ4BfUfsg7biZnExHQ1bTlB3IsJBZ8pD/YlecDC6wJgzoSKfjZ9/Aw/lOgJwbueIKCn8WSt
        s6RBaXEMLipOoTIIm4z/cu69v
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr30494549wrs.179.1568305618362;
        Thu, 12 Sep 2019 09:26:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqztK9Z/gMX7ORCbNgZ1dSvJGdv9fZucXr5OOgjDSMAriajITOz+b+G+khvqtWA6VKF/ll3rqg==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr30494531wrs.179.1568305618131;
        Thu, 12 Sep 2019 09:26:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n1sm30678076wrg.67.2019.09.12.09.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 09:26:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH 2/3] hv_utils: Support host-initiated hibernation request
In-Reply-To: <1568245130-70712-3-git-send-email-decui@microsoft.com>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com> <1568245130-70712-3-git-send-email-decui@microsoft.com>
Date:   Thu, 12 Sep 2019 18:26:56 +0200
Message-ID: <87a7b9cwfj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> +static void perform_hibernation(struct work_struct *dummy)
> +{
> +	/*
> +	 * The user is expected to create the program, which can be a simple
> +	 * script containing two lines:
> +	 * #!/bin/bash
> +	 * echo disk > /sys/power/state

'systemctl hibernate' is what people do nowadays :-)

> +	 */
> +	static char hibernate_cmd[PATH_MAX] = "/sbin/hyperv-hibernate";
> +

Let's not do that (I remember when we were triggering network restart
from netvsc and it was a lot of pain).

Receiving hybernation request from the host is similar to pushing power
button on your desktop: an ACPI event is going to be generated and your
userspace will somehow react to it. I see two options:
1) We try to hook up some existing userspace (udev?)
2) We write a new hyperv-daemon handling the request (with a config file
instead of hardcoding please).

-- 
Vitaly
