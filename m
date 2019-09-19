Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07014C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C389C21848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="hitoYH0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfISGLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:11:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfISGLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:11:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so1704749wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+kJRnH/bobkHHD8pbQwbBalV5RlXRs7lsi398MM0g98=;
        b=hitoYH0qrf7DoRJ7kw5xIyrIwuyKYlJi3HR62Ok2KWtUmi4lbhSrw7TfTdFUjH9G3n
         25ECHYJKD/ybkvDAO7PIIxXI/aPTs+14edqpbMNlnppeXQKFLf3kEUYM+PsNmyZXgZm6
         MxqTrCuKBJqKKawXRNQFX0dq9j7Iac0bZOV4BF8Y3oI+mZkg0S2IGolU2RWe9HcLFNJ2
         /XKjdQxBBSm25hEVP5r2YwBourumDWz9wae4xxYw4Q/7shT+pr6IAWbx0wd413JIIYOQ
         qKk61FiVPfj26eJw9ZLpmp4avSiZ/C/nwRBeApiETDFOXvm5gIJZRzaaavltkbYXgG/g
         vpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+kJRnH/bobkHHD8pbQwbBalV5RlXRs7lsi398MM0g98=;
        b=dG92FTogBJ8JcsDq4aTkJX4juiQxVVrl4+zZvtlz0odXTyZlCUfRRiiQ+Hj/yDa4o/
         OmzPZvJYE+S9owD/xLEd9gyxUTT/88rHii5TX3KpV0yVezbli4wDSzWxVi0Cwd73mSxY
         juYDhpGYCNj7eL8seE5nWdRRGEOGfUzVrz8MrEI31LkZNCTUr1ypawzVcQmb2WrI7PSO
         DpyE8KMJ6mtJK+j4Ig3SKTHWZliooSibumdH8N80Fn7Hiee/c1nze+59ZM62HNTPHK7L
         8qohg4K1h9/5xainbJ9cln6V9l5uxTHYYr0GDkBmTFxByQxhoYRZ3tPB0dva6fTO0PU2
         FjMQ==
X-Gm-Message-State: APjAAAU5iJpzHrlFfwW8JH1FW3tn1cD5f1IG24J62jkTGFbfm43XeK30
        s04JAjzCVt2HBr7S7Dhd0+tn3A==
X-Google-Smtp-Source: APXvYqyteUZGKccctX+0pmHumUNlCkzksd2Swwvkb2aXq671ZL0GC7B1FQDuLPvJ69igKEpQRzAiQw==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr5750322wrq.301.1568873494305;
        Wed, 18 Sep 2019 23:11:34 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id j26sm13832561wrd.2.2019.09.18.23.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:11:33 -0700 (PDT)
Date:   Thu, 19 Sep 2019 08:11:33 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ray Jui <ray.jui@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: Re: [PATCH] devlink: add devlink notification for recovery
Message-ID: <20190919061133.GB2187@nanopsycho>
References: <1568832741-20850-1-git-send-email-sheetal.tigadoli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568832741-20850-1-git-send-email-sheetal.tigadoli@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Sep 18, 2019 at 08:52:21PM CEST, sheetal.tigadoli@broadcom.com wrote:
>From: Vikas Gupta <vikas.gupta@broadcom.com>
>
>Add a devlink notification for reporter recovery
>
>Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
>Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
>---
> net/core/devlink.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
>
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index e48680e..42909fb 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -4730,6 +4730,28 @@ struct devlink_health_reporter *
> }
> EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
> 
>+static void __devlink_recover_notify(struct devlink *devlink,
>+				     enum devlink_command cmd)
>+{
>+	struct sk_buff *msg;
>+	int err;
>+
>+	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>+
>+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>+	if (!msg)
>+		return;
>+
>+	err = devlink_nl_fill(msg, devlink, cmd, 0, 0, 0);
>+	if (err) {
>+		nlmsg_free(msg);
>+		return;
>+	}
>+
>+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
>+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
>+}
>+
> static int
> devlink_health_reporter_recover(struct devlink_health_reporter *reporter,
> 				void *priv_ctx)
>@@ -4747,6 +4769,9 @@ struct devlink_health_reporter *
> 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_HEALTHY;
> 	reporter->last_recovery_ts = jiffies;
> 
>+	__devlink_recover_notify(reporter->devlink,
>+				 DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
>+
> 	return 0;
> }

To follow the rest of the code The notification should be done upon
any reported change, using devlink_nl_health_reporter_fill() to prepare
the message.

Also, this is net-next patch net-next is closed now.
>
