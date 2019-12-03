Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC21C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6B20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 18:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BAw/Dmna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfLCSHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 13:07:14 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37359 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfLCSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 13:07:14 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so1831738pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/sxFBO+A4bmmlzeA7kuVL6WCWUyudTPsIA+QFiheH5M=;
        b=BAw/Dmnay1FLKQCIDZm7gksS5lhoF8Z8pN9rRw+7OMz3u6YDyu7z3zqsQPxKaUT5kQ
         HNyBORMDB003vrTmJ/ICK2nWe0X3SsrYlGRHuqmfAG0QDvTlw+lWuZhyWFExBGGiFbaj
         Em4mMOyfhrZj3nv3/oSol59HVfCLyDhAki2qhRoseCWCqaJwU/3P1bUAsq7UW0E1C6Y0
         ++PVI76pMnSdBJaQqS+19sszKnOCTSpuNPRcPvFpRlzscwFKE5BHiyFY4lygTOG3wL6k
         b16qMzks5zFEYvv8yQnkGojVS95Vm6a8zPGfTIh2kcVcMr/mfW0MkXJqxoBizSRIx+Tb
         ypmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/sxFBO+A4bmmlzeA7kuVL6WCWUyudTPsIA+QFiheH5M=;
        b=opTS5R1XCJ03o4hrYcxk7MHXMWMGvRRSfnHRcUEQTfjVBvnVS6tYR4EKIjq3WsdrWX
         cPc4rr9G/d2ee/eimunhEYxxqTxC5ad49UNJfz6tGjAAWFGmjy2TJgolI/mjZMsohVcS
         a6x9Fwku8Srgi71d4DUwA4RwQPW8uPDdIWxwEHfFIArjmoFOEP3eiwue4fz8DJ9bdZ00
         mg6k/unf++buP1+OzKJDEh0zsGxZGcFCA60tne+8wA1Sb7X9g5o70HBZ2jpNzTv1QhY3
         sLeyzJf+UoWa7kkzHaqfocAC+8AZicbQqjrYxx2FREut+06HYyI3u9PHH2MHto/Zxz+o
         OQ1w==
X-Gm-Message-State: APjAAAWVkhPSS53GRSz1CVRnG4hAYfPwrpZGiCwd/Ncy7X9kH20hTemV
        JLcW/bNyirVrgpKEPlYFwUywiA==
X-Google-Smtp-Source: APXvYqwg4cfBTLYScskl8BNpesAVZqxCCfCNlGvkZA2ZM13raINhG+LP2JI69AiqSD3T/ezOHPL4ig==
X-Received: by 2002:a17:902:8f96:: with SMTP id z22mr5932828plo.11.1575396433357;
        Tue, 03 Dec 2019 10:07:13 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h6sm4103397pgq.61.2019.12.03.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 10:07:13 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:07:01 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jcfaracco@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, davem@davemloft.net, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, dnmendes76@gmail.com
Subject: Re: [PATCH RFC v7 net-next] netdev: pass the stuck queue to the
 timeout handler
Message-ID: <20191203100701.0d6a367e@cakuba.netronome.com>
In-Reply-To: <20191203071101.427592-1-mst@redhat.com>
References: <20191203071101.427592-1-mst@redhat.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Dec 2019 02:12:48 -0500, Michael S. Tsirkin wrote:
> This allows incrementing the correct timeout statistic without any mess.
> Down the road, devices can learn to reset just the specific queue.
> 
> The patch was generated with the following script:

Still:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
