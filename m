Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96095C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6276720661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfQXCzeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCFVSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:18:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40910 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:18:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id u9so9406675pgo.7;
        Wed, 06 Mar 2019 13:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vkbFsO7UtONNBfXfGJYdtz5hJ8wK93PPF7z+no1SJu0=;
        b=tfQXCzeUChjqpp+aWsWwI0JwPHvv/xhV/TVpYVW++NDiCgeFjYNiyTiPsE+lHgJ7k7
         X9H+QhLLbQC7UVdxo6CNoOhLJPnsf6Gb8lwhuuv9eqrR99l4bu2V1AZNkPIpz+7Ze3xN
         68eAWs1YxDpYHxObiW/R8EVYAJSOTlAXWiAb3oRKiVbAngTRFS9pjFQ+K2e24givNt2s
         oV4USXidvuuSY8pvVSJeVfAXGuYDS0lgeEbicO2inn7xI+qxvNZ6AtTwx6GNQxOCU544
         by1NorgbEmvSa6yJ/Kz/plZqiAhO55GgN1Bt8fHkmCP95Ke1ZPkT/8645EEEgHWR6J8m
         ac2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vkbFsO7UtONNBfXfGJYdtz5hJ8wK93PPF7z+no1SJu0=;
        b=GRvEKJ/FY+65xeLxw2PVxrasKjdiPTaGYOp2hkDuxBOW679gj7BqyTsCJgr0xAxlGK
         LJDdOliByyikVLye7NPt91zOeVnJVy5iumenZjxpAYEEwIuv18KUc4pC19NryI8EXDr9
         CvH+JlHbFknNajRKWl2ZwPiTMN8/KPXAheHUoXBMj79unppGuhYfMiHdiWugf6VZH62a
         w6fP2ix/oINyTQdu3MXZz2O0nVqOprBNHzXGet2TH8rDaryYimGMPWkzfe9a3jBJk+g7
         eVa+HnG8NDJcT9jH77GLq8IETXV3IXK1uG83uWvZO4rPIL7xqzQhdpcZwO2SmJm7GzKW
         MiJQ==
X-Gm-Message-State: APjAAAXaCeIvp3PfmFS+yhbXxcUkN8PrZQGH9LyuWq3BvScnBdM3uMvk
        QcAJvUblWP9amuR8/YbFs0M1qBfACME=
X-Google-Smtp-Source: APXvYqyXy45NI2GL1cT16HUSc/WntboSqpX5QaF7wqzBVGcnuAsYoZwNpzqf+uRFU89kOP9tspX6SQ==
X-Received: by 2002:a63:b447:: with SMTP id n7mr8134613pgu.401.1551907103530;
        Wed, 06 Mar 2019 13:18:23 -0800 (PST)
Received: from myunghoj-Precision-5530 ([118.220.181.225])
        by smtp.gmail.com with ESMTPSA id u8sm3270221pgp.48.2019.03.06.13.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:18:22 -0800 (PST)
Date:   Thu, 7 Mar 2019 06:15:38 +0900
From:   Myungho Jung <mhjungk@gmail.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: Reset secpath in xfrm failure
Message-ID: <20190306211536.GA27609@myunghoj-Precision-5530>
References: <20190306073304.GA22426@myunghoj-Precision-5530>
 <20190306113543.GD3758@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306113543.GD3758@gauss3.secunet.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:35:43PM +0100, Steffen Klassert wrote:
> On Wed, Mar 06, 2019 at 04:33:08PM +0900, Myungho Jung wrote:
> > In esp4_gro_receive() and esp6_gro_receive(), secpath can be allocated
> > without adding xfrm state to xvec. Then, sp->xvec[sp->len - 1] would
> > fail and result in dereferencing invalid pointer in esp4_gso_segment()
> > and esp6_gso_segment(). Reset secpath if xfrm function returns error.
> > 
> > Reported-by: syzbot+b69368fd933c6c592f4c@syzkaller.appspotmail.com
> > Signed-off-by: Myungho Jung <mhjungk@gmail.com>
> 
> The patch itself looks ok, but please add a 'Fixes' tag to
> the commit message.
> 
> Thanks!

Hi Steffen,

Thanks for reviewing the change. I'll add fixes tag and resubmit it.

Thanks,
Myungho
