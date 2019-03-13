Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAF3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42162147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="T/meEIt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCMJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:10:06 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42000 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfCMJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:10:06 -0400
Received: by mail-ed1-f49.google.com with SMTP id j89so801928edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O0AtOZ8m6kHfCPYPtLjI1mxE2JzYouT0BoSnlRpuytQ=;
        b=T/meEIt3d4sGs+Fmlm0ieraR/9EVOOxJrrK3JK2rFIxDXLWG0pmXBmqruKyIUaTpFQ
         s3Xdg7tYe91mF2olskbQ5HwD6GW9SVYP+BXEno4pmw4My8kYYsd3FF2kumwbhlTcab2s
         F7S8GsgQ87odBD3pUesGjsVYf1HTE3ItoL/xXZtudxAURjmzTT591aWEmFt9IqySqLB2
         fp7m4snFJ0sHNrLpsaTN6YQLbrdgg3LZmK7b4/pSBwdDGWsTO2OTzpqhkKznx5kE4SlL
         w1fhSvyz6X6DuZa+Pl24ovHzKD/AoBUwOsnJCbPSAyl6MfYZ1d/8y6liyRm3rtyy2G6I
         VOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O0AtOZ8m6kHfCPYPtLjI1mxE2JzYouT0BoSnlRpuytQ=;
        b=J4sM0AMM/j9RCfewl/8zW/ISB4lQSXWEwWVq9OUhw6AKHy2RyGL3uKoVPogwoX8VOe
         ofgR5Dr1ZSncL3GXJlbfiuKu61sn5rvBRcG9oYLP4IAM2oOtk9hqy49Q1bZVfiZcDlps
         nbNgFMI3+Pi4NV+yqOT/QxLQbXhIHLrTf7NgunRlIC04CKU30AL7G9QjkOZ6/0VelrzO
         yIwRWsYbQeRu1aQSlf107baomP9bcGsWmQDmNaYNSHNym5CCRuJck+KSrIcHe4nrVFeM
         X0/r/b7Yb5denzyI1/tBHZEOaTJn6TIWubE9Jd2DBLT3fqgMxjpiUSTdHnLvEbSTNEmL
         6ZTg==
X-Gm-Message-State: APjAAAV0Qy155d9/3n2JAsTTydDGyjAMHzvTM8dtgQSvxizrnfz4QkQM
        cvWsGL5O0hvZ8OOETbQVXraH3w==
X-Google-Smtp-Source: APXvYqyZ9kbS7cgjjMzkPY9O2O6gzDQn06X+sPn0EZr1B3UYxsgDJN9Ya3XuGBNLOFvIfgzorFw7dA==
X-Received: by 2002:aa7:ce0d:: with SMTP id d13mr6712960edv.36.1552468204422;
        Wed, 13 Mar 2019 02:10:04 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6c0:76e:dd26:cbb7:1dbc:50af])
        by smtp.gmail.com with ESMTPSA id s6sm406144eda.90.2019.03.13.02.10.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 02:10:03 -0700 (PDT)
Date:   Wed, 13 Mar 2019 10:10:03 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jonathon Kowalski <bl0pbl33p@gmail.com>
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linuxtronix.de
Subject: Re: [GIT PULL RESEND] pidfd changes for v5.1-rc1
Message-ID: <20190313091001.6a3wzh6evpe4hxdn@brauner.io>
References: <d5a0a45e-77c3-afc7-fed2-8453d8e95bb4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5a0a45e-77c3-afc7-fed2-8453d8e95bb4@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 05:00:57AM +0000, Jonathon Kowalski wrote:
> Hi,
> 
> Thanks for the work on this system call! I am interested in making use of it
> in my process supervisor. It works pretty well and avoids the long-standing
> issue of PID reuse.

Thanks! The systemd folks have been quite excited about this too.

> 
> One thing that instantly came to mind is to be able to delegate killing to
> some third process depending on the confguration. However, I don't see that
> permissions are attached to the open file description, but seemed to be
> checked when calling pidfd_send_signal as they are with kill(2). Is there

It came up during the discussion. We all preferred to have something
simple and not introduce a new permission model.

There's nothing necessarily blocking us from doing this in the future
though. It's not off the table but out of scope for now.

Thanks!
Christian
