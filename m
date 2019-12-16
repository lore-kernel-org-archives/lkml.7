Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DFC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057E021582
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR7WwK07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLPU6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:58:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37034 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbfLPU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576529882;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type; bh=grtorLDue+Atr16b7VawQ97nR0ZCI76hZCAvkSUnQVk=;
        b=KR7WwK07Y4AeS1up2re9tv74tYMFMWfZVtiUFNY0qMXbd3WnKiv98hrEuyK0GGM7uDPbhA
        3rMDaWA85Q/qdxXrtrxAjlRJ9AfavnXQvgTIu+Pdc2aLqJV8g+wPGN9MTeazTh0nbPgxKb
        1C8kZMtKWhJQSPYJjJ88rv59Uyc1Ouc=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-ud7rSE1dNKObFw9bmjLnjw-1; Mon, 16 Dec 2019 15:58:00 -0500
X-MC-Unique: ud7rSE1dNKObFw9bmjLnjw-1
Received: by mail-yw1-f71.google.com with SMTP id r75so162017ywg.19
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 12:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition;
        bh=grtorLDue+Atr16b7VawQ97nR0ZCI76hZCAvkSUnQVk=;
        b=eopiC3Dlrd9roF1wkyP0qytjvVCEe0p1H+acKLBAySTxMu/0p78EO2rEmyvdelllxB
         eSKaVJlkEOoXiMSeZpRBOwLugD8aK+Yz1eHKwi/CMlCWsq8sMAI4yYf+H1FnB16vlziZ
         9B7mKz2Q3w7iOo8aj5ym0Xn35r6i0nwWXfkAqovxXEZHCek/cp7j0dpvlntJSFKocxfP
         maakFXfS1MdKef5+BZDSWpKeMDFfX90QnDdvoGjwvkeWtnlfcgRmu0WlMTj8h601Kd8I
         FxPjo7lqeYrW7ATIxClVzW9ISpLsTgxEbZ3gw+FW3ohP4ZAviFfmI52hK13EHabhaiE0
         OUvA==
X-Gm-Message-State: APjAAAXJW21BKXwKvtahCzh7OGbMFnqmhkj5jTZJpJkP0DZ7jcdMSMFD
        BBDfNjo79HnjUPwEUGZU30tKsqN/0VxBlDK89aBS+6XwTZwPYLSmDmD48lg6eo22nRttzXEl+8R
        5jaF7jRAhs4tQS6XznhYF6jdm
X-Received: by 2002:a0d:cb53:: with SMTP id n80mr13704396ywd.405.1576529880007;
        Mon, 16 Dec 2019 12:58:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+OKdhPZQjA6xun6338qOULi2wP5YUfJvWUvCQuUfX5vn1GAiZni7I+dtFM/7KCqX1whgSqg==
X-Received: by 2002:a0d:cb53:: with SMTP id n80mr13704382ywd.405.1576529879712;
        Mon, 16 Dec 2019 12:57:59 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id s68sm2425938ywg.69.2019.12.16.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 12:57:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:57:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: panic in dmar_remove_one_dev_info
Message-ID: <20191216205757.x4hewnduopbo4mpv@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
        Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP is seeing a panic on gen9 dl360 and dl560 while testing these other
changes we've been eorking on. I just took an initial look, but have
to run to a dentist appointment so couldn't dig too deep. It looks
like the device sets dev->archdata.iommu to DEFER_DEVICE_DOMAIN_INFO
in intel_iommu_add_device, and then it needs a private domain so
dmar_remove_one_dev_info gets called. That code path ends up trying to
use DEFER_DEVICE_DOMAIN_INFO as a pointer.  I don't need if there just
needs to be a check in there to bail out if it sees
DEFER_DEVICE_DOMAIN_INFO, or if something more is needed. I'll look
at it some more when I get back home.

Regards,
Jerry

