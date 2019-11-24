Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C86C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 02:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0947720714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 02:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="F9Q1zyQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKXCZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 21:25:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43553 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKXCZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 21:25:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id q16so690856plr.10
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=O1nyYlECjp0BHoEkdlX1u+EmoR7HXi9s61iX1ye0QNg=;
        b=F9Q1zyQnHoqvRkvUyxc75tvx/7Hc0KdxQCXE7E7G2mtU0C++RNydvVcevUBNiwtB76
         3yAaNcEU0c+0KYjgoCVe4oazerk5qMtWsTEvzaD0YuvcGyr/B53EWVw3o1CPF7e0zfH7
         XO+dIhDZIAVuv/OlTG2r52gznYaXCPTPD+JtXVOX38kLK4Ko/azPep9mX09We+f7yr/5
         21G3Sg+WT62U7R0Ul4WeM+yAoazH0qz7id3M3LZUeHfV2mdknVbNfjIJ3CcSqkJqYZwF
         7LPO4r1txTKglogpFj0dJ7h/9YpxxO6qhvwb179kCLhtQAJg6H+et3QTmTdUz1xlJMLT
         vRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=O1nyYlECjp0BHoEkdlX1u+EmoR7HXi9s61iX1ye0QNg=;
        b=LC67zOl4P2b8/mhZNzxpTzglm9bfX1Gu9vBTtHRQn+ME467vTqRibqZ6a2bDDWEuJe
         xBHKshpWk+gtBOn/bOi9e/I4I9fvl07Px0YL5nygajiyNGfUdUUY12kiMWaEugO54eKH
         8Wr4EXTD+SwBZnBbqTV2XksWiPKwRN4vx3f4YVBEIGbCqKQZj0SH5WDAiu9k1UytmYFI
         ac7UOl4FiS7gd5SOJUNlqAhrMbd4hu9iFsZvJaSEKMAkkuBKm0EA/WhrLoaGNlQwgu8T
         IggEAhvyDwOJRY/eXFP0SYbqik8UFW2M82IEz2xZQ4Dc1tOA6vNVQY0UoBAvnwn1fZ4N
         VYjw==
X-Gm-Message-State: APjAAAVr31SF7C7lZShAg0uJpI/tL5ZMae2KmAdTnBgyNZylUtwIkJQ/
        1wWI5sy2r2kDl+/b5Lg3lUslnQ==
X-Google-Smtp-Source: APXvYqyhfKeVUj1c3iwZ2gGQjiP9Sw1k2q7K+12TsTIZl9kCXTKEBzuMKqmTjt9OBkr/cWJdOUyQ5g==
X-Received: by 2002:a17:902:a403:: with SMTP id p3mr20634633plq.275.1574562350095;
        Sat, 23 Nov 2019 18:25:50 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id r16sm3262712pgl.77.2019.11.23.18.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 18:25:49 -0800 (PST)
Date:   Sat, 23 Nov 2019 18:25:45 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, emamd001@umn.edu
Subject: Re: [PATCH] sctp: Fix memory leak in sctp_sf_do_5_2_4_dupcook
Message-ID: <20191123182545.2c73268a@cakuba.netronome.com>
In-Reply-To: <20191122221759.32271-1-navid.emamdoost@gmail.com>
References: <20191122221759.32271-1-navid.emamdoost@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 16:17:56 -0600, Navid Emamdoost wrote:
> In the implementation of sctp_sf_do_5_2_4_dupcook() the allocated
> new_asoc is leaked if security_sctp_assoc_request() fails. Release it
> via sctp_association_free().
> 
> Fixes: 2277c7cd75e3 ("sctp: Add LSM hooks")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Applied, queued for stable, thanks!
