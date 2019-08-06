Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1597AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE024205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SGfjoPA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfHFTNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:13:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35482 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfHFTNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:13:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so63876402qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VnZDZzBAZi4D2nAqWC3qKDXkK4ME9tg6Ir4ylUba4jg=;
        b=SGfjoPA4i1Mm/bTUKSTpZMu1+1qm1orBY6Je1wobz3GeFacipSg3vaAISShedMFloX
         LklV3gXrz4aVn2LkyVj4UGkiuug9d6vhoRh51P1R8K08xXmni+YlDqLz8dI3NLFPUtKm
         oXY6zQlFVCaE3xrmablLByoFZQyld45ysxfuYu+Xc5ngbYZpKCyfE+FXoPrChbqAQHHM
         DtLsZmCMf0xURVExyIwdvQDIWIY39E/4jCu6x3sLTdiAC3HbVr/wFL4DQJkY+DtHK78U
         xpyCC6A7pGy23rjcJ8F5xwjRU6ri2zszNhOdqCpClLxZzFBTnmnjXiZE5BLiiVrPSHxA
         AKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VnZDZzBAZi4D2nAqWC3qKDXkK4ME9tg6Ir4ylUba4jg=;
        b=mUoHcRaNtRy8UDcyv3sRiqQsK2n5qmZqdGIIgLtouEev0RJJ0Ss/ws6Ls4ixhXoHQU
         vdkSsxGIWbvpL+0q12eWSBwi73oKZHyXdcrGLgFsRR2nY3xDT7gCgXZbXta11RIp1wUc
         3KGkGHE6RZ3uyiqkXrj6Q1Lh5SKrm3j7PBxQ+fc97e7GQtHMBIDmCN7ca9u+Td1ilQEl
         CP4p8qh0YnUVw9aNSfj84VGY1PBmXXgxAm6cNjvf97UjYPVX2XB2z+U43gqWu9DC3FC1
         TYO27NnyPnOwuQzoaCZSBNh2E2oQuIFV+SfiHOkWha/jodhpUX9le3/2iKYVgjrnN5uc
         fzHQ==
X-Gm-Message-State: APjAAAVVE9b/2YxLK8dIsCBSUA4P6+z2SmDWY6UZ21KT1nI04oqOEzvG
        D5OUUsW78BIDSjSaK4FopAYvuh9TIh0=
X-Google-Smtp-Source: APXvYqwTM9Nkb/KONg55InkFyQG+V6Xua7EUBriiyRj1o00r4ii18WpOUrQTfkoxnkYCgxcEOVoOUQ==
X-Received: by 2002:a37:311:: with SMTP id 17mr4499484qkd.466.1565118790235;
        Tue, 06 Aug 2019 12:13:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id z19sm40441271qtu.43.2019.08.06.12.13.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 12:13:10 -0700 (PDT)
Date:   Tue, 6 Aug 2019 12:12:42 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: Re: [PATCH net] hv_netvsc: Fix a warning of suspicious RCU usage
Message-ID: <20190806121242.141c2324@cakuba.netronome.com>
In-Reply-To: <PU1P153MB0169AECABF6094A3E7BEE381BFD50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169AECABF6094A3E7BEE381BFD50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 05:17:44 +0000, Dexuan Cui wrote:
> This fixes a warning of "suspicious rcu_dereference_check() usage"
> when nload runs.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Minor change in behaviour would perhaps be worth acknowledging in the
commit message (since you check ndev for NULL later now), and a Fixes
tag would be good.

But the looks pretty straightforward and correct!
