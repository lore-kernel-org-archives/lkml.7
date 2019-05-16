Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5509C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B32070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="VZjhIAPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEPVvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:51:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38342 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEPVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:51:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id 14so4473412ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rQ486v7/+lFC+0C10/1HSU/dAUcUYwocGLqU5d/PNiE=;
        b=VZjhIAPa7wz0aagS0zRQq87ux8qNQnOd/eEqJ3whEmgJH9V3r2MCHmqkfSn6wkShgi
         blx8XQcNi/K2mQUkcBq3S/OjrcDOnWEAvhCjK2UFAEooDhnk9dSWCaSufQC/i+qU0usv
         YF3Fka6CWTe3GwACK6y8fuK89WpSwGsnHeGgp1MYMLMlwVN+A1/b4DxAR18H3NNDyacY
         WXJGtcBr4nhNEugSl/IzuI33lXhFS8pp3MYsPiV3drBVn5pN4kfsiJpomUc1jy/gFCCV
         KmtT9hAY7If0VQKCX3sjq+eCOpCZLJ9HdAGAgQUIBmJr3DuTNcS1o+IUlhrIaDm4Smwz
         kVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rQ486v7/+lFC+0C10/1HSU/dAUcUYwocGLqU5d/PNiE=;
        b=dXfJiUNp+VvE6Cm/jOmOa5KYNJT+8cZEUWLW8CsSy9ftzNgtbuvSJUi6fzPTq7/zP6
         S2Q02aaFS219E/Zh1JTziQM3iFH4p9KQFUg7v9N9OgpLxe1gGHiPkOZv9bU50USbT/g5
         K6xeKLRekhAXkSYQOfBL3Fl6MW9XOh+//1OWV8+K4/mdPLsjTcdpf1XHXpymQCqomAd1
         9sc0wj6I+c1PkcUkMtHX3PnhC1yV6Y9t93Ejej46MaHCfI52trRkL8BUnNpudDhg8crU
         hxSSJmBLxXMvPyecqKRW44+m9Hk72DRONpesv6ZbyM935PtKeiHRqH6lpf0QqnTMjsy4
         unng==
X-Gm-Message-State: APjAAAX5GRxscAG4JkZicX7JpU6eHiJ9+0MvhJGzN2A36zNtYLcgkNkJ
        sHeGvlU9+t1PpRbYY6JX0vlrEw==
X-Google-Smtp-Source: APXvYqyoR03Ehfj3ojjApBgIzWWuU5NWZW4AT5OOLTz6COtQltQch4b5sqKTVODUFWGIgXoKEeSxzQ==
X-Received: by 2002:a2e:97cf:: with SMTP id m15mr9579164ljj.135.1558043468356;
        Thu, 16 May 2019 14:51:08 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id l76sm1171256lfe.77.2019.05.16.14.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 14:51:06 -0700 (PDT)
Date:   Thu, 16 May 2019 14:43:41 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     arnd@arndb.de, robh+dt@kernel.org, mark.rutland@arm.com,
        arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sprd: Add clock properties for serial devices
Message-ID: <20190516214341.2qxtmg4turuuozkn@localhost>
References: <1246f7a9ce912458ea3b889b0c0e392897a664c8.1554879978.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246f7a9ce912458ea3b889b0c0e392897a664c8.1554879978.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 03:22:50PM +0800, Baolin Wang wrote:
> We've introduced power management logics for the Spreadtrum serial
> controller by commit 062ec2774c8a ("serial: sprd: Add power management
> for the Spreadtrum serial controller"), thus add related clock properties
> to support this feature.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Applied to arm/late.


-Olof
