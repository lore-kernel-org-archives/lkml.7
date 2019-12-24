Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F8C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCE9206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 19:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJVdKacB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLXTJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:09:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59056 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbfLXTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 14:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577214545;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=sN9oy8InhvYTWTcIBE/ApxS/MBEGLGguoOVJTgKsavo=;
        b=jJVdKacBe0wQCss1x8T4wt7+tk0KPTIRzDkofj9xJNyi7ecBawk7LX288YcTzQbkpx1lU6
        NRKZm0/+3rBvPElV0motQ7Qa2X5Li8QgvyQ/MImxDNbUPW5XhLRWvoZP76Qg5LQGkMjCyy
        s3YTmzHn0EaFEQg5V/YWbyYorq3m3EM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-TkeCNZUeMaWNTn-I9_Tqnw-1; Tue, 24 Dec 2019 14:09:00 -0500
X-MC-Unique: TkeCNZUeMaWNTn-I9_Tqnw-1
Received: by mail-yb1-f197.google.com with SMTP id a14so15919397ybh.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 11:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sN9oy8InhvYTWTcIBE/ApxS/MBEGLGguoOVJTgKsavo=;
        b=E7ZSoe49i2/lbMwWaF/6ILxVGU7jwevgf+fM5e30g1WzIDPP2Y0oUiw7GK3wE29Ii3
         TowEtANhC0mwwORpeh4Tk3kXMvgOPPnlk+2mCATIvPJct7EOha6HIcskCpRVqrrAh/4A
         f2P54nb2l/P5JVVxTLe5OU9qRxilhatgPAuE/n0AoRGkpaCYG4LgUQRQegzsy0wSr1Xt
         X2Drvfdfzhhig5bE7bpcXCGcLpjjMIezwzsMuHBVwICcSOrqCVZ6HmJn2oR9T4T7d4B3
         21k36liCh5B4yu/1xC3uTMlLvFzSIMEIwvvcP04uOnGchic8xS8CRyFkd+ecJhD4QDK5
         vGCA==
X-Gm-Message-State: APjAAAU4/BXEpmOAQ3365VqIArLO6BHB4SVrXDypVhcDZfpdZ7M8/DMm
        gZ09kw+LR0JY1SZGaC3oxlKLtCqLsd/vvk2FOsN3SwuCTF54c8iemmz1Vy8/orLhU5+FVmiQdOF
        mLytkW0AADNrURQ6UL1BndenP
X-Received: by 2002:a25:68d2:: with SMTP id d201mr27072874ybc.177.1577214540288;
        Tue, 24 Dec 2019 11:09:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz0S3EZ46tOP4qqPj6eQg1Mo8wV9UwKPT4m38jrGBN38s6oteTQkqrcrF05/SG735A3VfXw9w==
X-Received: by 2002:a25:68d2:: with SMTP id d201mr27072853ybc.177.1577214540042;
        Tue, 24 Dec 2019 11:09:00 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id e131sm9679917ywb.81.2019.12.24.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 11:08:59 -0800 (PST)
Date:   Tue, 24 Dec 2019 12:08:57 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Roland Dreier <roland@purestorage.com>,
        Jim Yan <jimyan@baidu.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add a quirk flag for scope mismatched
 devices
Message-ID: <20191224190857.kb32qjogzumoh4xv@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Roland Dreier <roland@purestorage.com>, Jim Yan <jimyan@baidu.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20191224062240.4796-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191224062240.4796-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 24 19, Lu Baolu wrote:
>We expect devices with endpoint scope to have normal PCI headers,
>and devices with bridge scope to have bridge PCI headers.  However
>Some PCI devices may be listed in the DMAR table with bridge scope,
>even though they have a normal PCI header. Add a quirk flag for
>those special devices.
>
>Cc: Roland Dreier <roland@purestorage.com>
>Cc: Jim Yan <jimyan@baidu.com>
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

