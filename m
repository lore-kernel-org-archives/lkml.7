Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCFAC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A7E2189F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="DiNlS0lM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfHFWKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:10:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41440 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHFWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:10:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so7364656qtj.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=k5MlzirpZYamcdWz7AWbdCMy4iWhcebC9AZ/B4iX4vQ=;
        b=DiNlS0lMBqKQ8N8XEC9ggrn/qkh+UA2hvtCs3VnCp/1FDuRFh8AWh0IrPMQTSI1seh
         ILTlQ69cQuC8/r1/C++1zZs61I17M+qy5aejqcX8ujbltSmqJ1JxPV4twEW8bb/XA75B
         R2wDG0iLFvBwzqcChOWMGDsxHqs5u1o207qqjuEv/znX7OKV48xSF6SE1i9X2jzYisqS
         zSyAFrx2evZTUZNrvCIVwVGYMifT8jRUHFC7oRXrAH6Hf/lj4EaJLSciLzD6e6GSoyc6
         KQpvphQctVTQIdodoQQq/kfH+9K0S98Umqp8zkpdkLtRZmbCCklHtYljPnaonLTZ5sEK
         Okug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=k5MlzirpZYamcdWz7AWbdCMy4iWhcebC9AZ/B4iX4vQ=;
        b=VtGz91RkmCJMFDQXbosgyELz5v+LZdjwFiSm9dRn5GYrxGio2ym+UoozEGjY5Axab5
         STL4KAl2AjnRvccwaiXlEAAyWV6Y6V+K+xXWlR3F23M0v+1NT8rV74QG/CpcxrNsgBxV
         1nSHCCePv3k+9h0hHLy4hTQ6ZpU+RM/EKodomLwYwiPBVZYkrmJdMZLzfSykCyiHFWRr
         xf+6s30+dZXqxEIVCkaya57YucKnfxak1RZ1oeyfnR5GLxNd3jnVadn3rS2KGnfJs8SJ
         t1h9mPesenQloqr84MZ+/k9Ii0pMJJpm9eInE1DDHv7GRp3PY7fGlH7O/Mz2JUSr0xoo
         HIEg==
X-Gm-Message-State: APjAAAW4iQMJmkFwCxFCGPGpzJGMXNa1Edu/0eXNrlGCLgravY+szdCD
        IuHm1fHzQgZDWmUkYyZJRpSVXg==
X-Google-Smtp-Source: APXvYqxJVIiFVF2MvxFJ5nvgTIbxn2d6z4r2/R64xlzNBTDE0v1VaGLNq/YntAbOLyQiOadkdwKc7w==
X-Received: by 2002:aed:3987:: with SMTP id m7mr5096695qte.56.1565129433194;
        Tue, 06 Aug 2019 15:10:33 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t26sm47547788qtc.95.2019.08.06.15.10.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:10:33 -0700 (PDT)
Date:   Tue, 6 Aug 2019 15:10:07 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] r8152: change rx_frag_head_sz and
 rx_max_agg_num dynamically
Message-ID: <20190806151007.75a8dd2c@cakuba.netronome.com>
In-Reply-To: <1394712342-15778-294-albertk@realtek.com>
References: <1394712342-15778-289-albertk@realtek.com>
        <1394712342-15778-294-albertk@realtek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 19:18:04 +0800, Hayes Wang wrote:
> Let rx_frag_head_sz and rx_max_agg_num could be modified dynamically
> through the sysfs.
> 
> Signed-off-by: Hayes Wang <hayeswang@realtek.com>

Please don't expose those via sysfs. Ethtool's copybreak and descriptor
count should be applicable here, I think.
