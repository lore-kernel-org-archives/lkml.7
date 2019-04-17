Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89495C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BF12064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="UqM/5KVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfDQRwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:52:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36630 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733170AbfDQRwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:52:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so28390284qtn.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2SUIuQnYAPUOgPmqi9wrI6b16FE1+k4sZw7VLX7K9ew=;
        b=UqM/5KVEddTHkZenhHKXIQewMlb6bgM0k8PlWy1W36EtJfDKSLLL3kvMwxTydFVbnj
         i0WCH5mcCI24aJzRVwGHc3CKBXHtbvYLE6UKdRm9WkdnAFDlLfQ+gNkXL3povgftiCQv
         70ZVhN6E46ARpCjXLCNx3RmI8L5d6f2g9hY7E4jsvX/L+Oy1XKmLdVmz792X/4NrvDA2
         ehfMzuu0CkOXcK78mn4zKadHXIaRjKOCRKo98MFzcpFS3MWubNDIK7SdLeHpzYB8LZ/U
         OyZZG0a1jhAV7SihHzs67RjIOrw2a6Xaxav7W2gkpoGC+YjUnoRt5VHcEQfHDTpzGNnj
         UsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2SUIuQnYAPUOgPmqi9wrI6b16FE1+k4sZw7VLX7K9ew=;
        b=ub/M0Au2rCGDcj36SUbYQOBWw+hHh8W7oIbuFOf06fjj1DLsCYM9y+oa/ze5C4jGjZ
         6PKWD7XYwQouifNxfFS9VK3Nmsdam6i6kQivptdWxC3XzZWmzsGzYjOzBw+mnWmSrXQg
         ZlfqjXGTHTVqIbCZAep4V28L1qocI5pwglMPHnYYyGbUuduXCF8L2Z51iy+OVdPkXFWp
         N3AkuivDGTg8JRIZMwmZVAh0Zefibmz70QU6AtNfXPbKHE6AhQDsvFcwBzX0Znxngbcw
         yHvzZhi9hqAzy+Zmv3KGBHGO8vfeTRQcOmPWwRs5apEr8DfV43b0N8gm2I60TUkDa02x
         vekg==
X-Gm-Message-State: APjAAAVPTrEi1oJMuS69tEvMhoq/iElqs2KFLCPGlRv1PLCcp4KjeYL2
        7usaq5XRfpg2TciWX0D13rMoLQ==
X-Google-Smtp-Source: APXvYqwR1PR0NeGd989IxaTi81nRdAImjAQS9S6kGjUXcCo0AN8MUcJ1cKUt0AmkqFPiN6iLGqftJw==
X-Received: by 2002:a0c:8b4a:: with SMTP id d10mr71500307qvc.29.1555523523243;
        Wed, 17 Apr 2019 10:52:03 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e128sm23314622qkd.79.2019.04.17.10.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 10:52:03 -0700 (PDT)
Date:   Wed, 17 Apr 2019 10:51:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [oss-drivers] [PATCH] nfp: abm: fix spelling mistake
 "offseting" -> "offsetting"
Message-ID: <20190417105159.3dea5217@cakuba.netronome.com>
In-Reply-To: <20190417131500.4793-1-colin.king@canonical.com>
References: <20190417131500.4793-1-colin.king@canonical.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 14:15:00 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are a couple of spelling mistakes in NL_SET_ERR_MSG_MOD error
> messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks, Colin!
