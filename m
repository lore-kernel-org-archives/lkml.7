Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD7DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916BC206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tEpsjhnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbfJVRTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:19:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42004 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfJVRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:19:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id u4so3907150ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=cy34QT92NHhuXVd0S9iPTc4eeCufEq/lJNlVwgrDWg0=;
        b=tEpsjhnXNsRzMFdAsi5Me5vtmMaSPKxbjyPby898vjwDTkOf6U4LzY66u49GwG4QxU
         PelGGK5wr/HkW0Vel+2/ab6Ro+WYh6lMvqELw1S19dch0gJnycxJkFTFS7qJ/0CbRwDp
         sS0FMnzQOyBKK+qQMbNnbfna88/YZZt46vKYn3UZ5CPC4RZdQ+MgHwWZ2JxseE2eFT1j
         cxE31qCc1oC8snuXaIae7fZMBEiVgQZhqc9zYn8CWTLNW1AV4MhL6/90fvnphP33G9EI
         jCZ8RU5+GWaky9PujnMjVTE9Uf3mk/Ci5xhAlEXOcUF/xARugV0TAjRGujTBAnYhurKv
         MZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cy34QT92NHhuXVd0S9iPTc4eeCufEq/lJNlVwgrDWg0=;
        b=DhmOiQFPnxb0IDNUiVcjlZXi8BI2XMrGhzg3fvIgMssZuJF1Tir9VCwJKklC9pyLcn
         7iNuYxfKB27AI0J1F23KsLk0RgiypAX4OMXHV9FmzYp/8O42SqqSjvt8uBeIfAC26aGJ
         QKy6TUc6QB0hSYcDrk1kTnFop0Sl1gRY9B41Du/ZLYGVd5rqjEZy5CI2YGM3/ToUi1tr
         /0Cdgt6RGvek4dU0jT9kCEKW+QJHF7Krm/V1vX4cSn7kKyMWQ4UjKkfMIO9slUh056LI
         isSzCOwJj63TsxfwR+CTjFWIM2dQ2B5xbkJfVq9UISzuQN9hVCF74QnG7pWoco5HtG5l
         w3rw==
X-Gm-Message-State: APjAAAWe68n4U6adOLmLuPaEMWT9cGbfHT38+VNqTnm/e09/rZjBGPUv
        UNHJH4vp1InR3lfNVtKjuWPPFg==
X-Google-Smtp-Source: APXvYqx2nMG9uV82zzuDAWW/sGyUPqp5AI2OI+UE3fPbmcfyRxRy2DzOxBhWNqFGs90SK1p+WXM+Qw==
X-Received: by 2002:a2e:97ca:: with SMTP id m10mr192469ljj.190.1571764782935;
        Tue, 22 Oct 2019 10:19:42 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id d24sm5173468lfl.65.2019.10.22.10.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 10:19:42 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:19:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] net: fix sk_page_frag() recursion from memory reclaim
Message-ID: <20191022101936.23759c14@cakuba.netronome.com>
In-Reply-To: <41874d3e-584c-437c-0110-83e001abf1b9@gmail.com>
References: <20191019170141.GQ18794@devbig004.ftw2.facebook.com>
        <dc6ff540-e7fc-695e-ed71-2bc0a92a0a9b@gmail.com>
        <20191019211856.GR18794@devbig004.ftw2.facebook.com>
        <41874d3e-584c-437c-0110-83e001abf1b9@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2019 14:25:57 -0700, Eric Dumazet wrote:
> On 10/19/19 2:18 PM, Tejun Heo wrote:
> 
> > Whatever works is fine by me.  gfpflags_allow_blocking() is clearer
> > than testing __GFP_DIRECT_RECLAIM directly tho.  Maybe a better way is
> > introducing a new gfpflags_ helper?  
> 
> Sounds good to me !

IIUC there will be a v2 with a new helper, dropping this from patchwork.
