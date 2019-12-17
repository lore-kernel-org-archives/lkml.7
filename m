Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99684C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDF32082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 06:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S65UElUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfLQGNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 01:13:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfLQGNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 01:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576563210;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=SiU3iojc8KztiOx21hGe4lTyBXAFozx9uHjLevKXtxs=;
        b=S65UElUd38xbejY709c/isPmnzPvpoolLKhdbukBOGFMzMoVPFGs4t+ZY+ZRd8hLPRatKD
        yx26Az3Ly4V4TQY+zzgMRbeDIwp6S8SACw/jNmhc99JsUG03f+scJpKuIoOEY0HoynRkMY
        paKnRN4HLWyblzoKJMmJAwOYp9Cuedc=
Received: from mail-yw1-f70.google.com (mail-yw1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-WntPusbYNA-up1L7EFtWcw-1; Tue, 17 Dec 2019 01:13:29 -0500
X-MC-Unique: WntPusbYNA-up1L7EFtWcw-1
Received: by mail-yw1-f70.google.com with SMTP id u199so4305865ywc.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 22:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SiU3iojc8KztiOx21hGe4lTyBXAFozx9uHjLevKXtxs=;
        b=rk6KonHJ8WkD5v6k0LYLuyTTf8nChb/hf55l3UjskmK+n1lfxez+Dd5EYedpePIPP1
         XBeezUXyLbJEm1YYQXKz6e5fDpGQRL2UwZ8rUO/Qg9nMbNi4Mk/fVI4sVe779XmA2TFw
         8AAxUNLDlsqwXHlBCoeZHmEsG9u97l2PUaJaNKIwBSUadfDxXr7nAlUB9fqwBqSJ4iOX
         aNOasAUwepShfug0qyXlz1T3EqWMT8ryho0aHMIM3//hL+3IrCzvyPAEoMzS+W0WHVA8
         As7XHmQaxfHkqwLiyhEAtUOaLRzB1NGJjyDq9k9G8PYCC7AbRztWVChfXmgSkz2rAWOr
         O2lQ==
X-Gm-Message-State: APjAAAUTkpP5OL/+FWi/VWVN6VFoYEiEBW1R3GxqCzBs4DEUuZVNm9ce
        5hv5Ien/w3D48WtL8m4aps4L8kGqj+QO+jiWWKtf+cDqLEK1u4mQdp7S+IxZrhw2/WvN+Lr88qs
        woJgZ3vA8bDOolMeCoUhuxoP3
X-Received: by 2002:a25:3803:: with SMTP id f3mr23248221yba.144.1576563208268;
        Mon, 16 Dec 2019 22:13:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoB5IjXGTbrM0Ii2yTe96Xko4hQNa6W9HaJcW2UvIjEDQcue5di77FK6VsGF+OdaPWhJQlPw==
X-Received: by 2002:a25:3803:: with SMTP id f3mr23248212yba.144.1576563208012;
        Mon, 16 Dec 2019 22:13:28 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x84sm9173071ywg.47.2019.12.16.22.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 22:13:27 -0800 (PST)
Date:   Mon, 16 Dec 2019 23:13:25 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: panic in dmar_remove_one_dev_info
Message-ID: <20191217061325.fbzcxgh4sng5lkn7@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20191216205757.x4hewnduopbo4mpv@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191216205757.x4hewnduopbo4mpv@cantor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 16 19, Jerry Snitselaar wrote:
>HP is seeing a panic on gen9 dl360 and dl560 while testing these other
>changes we've been eorking on. I just took an initial look, but have
>to run to a dentist appointment so couldn't dig too deep. It looks
>like the device sets dev->archdata.iommu to DEFER_DEVICE_DOMAIN_INFO
>in intel_iommu_add_device, and then it needs a private domain so
>dmar_remove_one_dev_info gets called. That code path ends up trying to
>use DEFER_DEVICE_DOMAIN_INFO as a pointer.  I don't need if there just
>needs to be a check in there to bail out if it sees
>DEFER_DEVICE_DOMAIN_INFO, or if something more is needed. I'll look
>at it some more when I get back home.
>
>Regards,
>Jerry

Hi Baolu,

Does this look sane?

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5163,7 +5163,8 @@ static void dmar_remove_one_dev_info(struct device *dev)
  
         spin_lock_irqsave(&device_domain_lock, flags);
         info = dev->archdata.iommu;
-       if (info)
+       if (info && info != DEFER_DEVICE_DOMAIN_INFO
+           && info != DUMMY_DEVICE_DOMAIN_INFO)
                 __dmar_remove_one_dev_info(info);
         spin_unlock_irqrestore(&device_domain_lock, flags);
  }




Regards,
Jerry

