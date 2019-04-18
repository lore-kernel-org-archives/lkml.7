Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577C5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D82B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRMIg96L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbfDRNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:37:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43198 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDRNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:37:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so1213292pgu.10;
        Thu, 18 Apr 2019 06:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fgw0F0skyyODBRq+lT/ECQm7fShKCgC6rK6gTKcQHJU=;
        b=vRMIg96LwuS+F8UX7HPYlzniWMs8c0FYxHZ2GoLzhrmSR80Qm3hxr5oXS0vk30cUa1
         RmnMBphg3ix+MlY3NNb/CpOKJkd0hjIvP/1eOKpqulgERpz0oO9NdcXHNaTKv4BztydI
         JBVz5b9Q3XAWZ3AS7shRcMMJNEDc4XxDDKia+Q7nRq2649G4FGKyFsXVl2VBI+fVJKDh
         R9GE+9n7/0IC7s9uVNmz6Bcw1pG8QsfndgTxEZtuoVLnKm70hnwZesnYJ2lb88Ldnipg
         3eX6MAs2kplYLAihJGhimFVwpr6Um6qqV7badUkEADj3PEmlfCXp8i7W0GrhHESwyVo3
         sVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fgw0F0skyyODBRq+lT/ECQm7fShKCgC6rK6gTKcQHJU=;
        b=KnIhQPibPSYiTn7dqqbL5uxZGxOrNN8x3em23iMEk+j4n+hfnWTDi0eCvAWVJ3J9ry
         T3FwKHcWTLwxc4XiDKSmL3l1jFv6z+yxq1geW7XwyWz7BW0OtgYxI7ruH4c+pmykPoyR
         UpvqWa1hwUp5IgvhIOoNH8IpVfmFtIZxjLmzYYQDUi6zsRbemNe/8WdvNojuOwEfKrb3
         pMaCw/q2dwQ0P3ltcqc77f6EFK/hWzmgQ/c5KguKvO4UcJE2SJaAT6pSTTrS3HBDkXF8
         4XwjupuGCclYlaVObJ6nGbUlm/sx/gnO6b+F7NExVBPt/cpZ4oHmxXtdhhGLbHN8Xg/P
         hesw==
X-Gm-Message-State: APjAAAXjr8cq0XOOHEZl04TShO+4j+ziY4g8+yQCeY5AL8TvJncLIy98
        q/szSe/GygFpVVy10O6mKoM=
X-Google-Smtp-Source: APXvYqw5viC7wqrGpFGixVPXsMoI7HAPvIiK7Zk7Ez++2/MUiQmRhnfRC24pWrzzZejUdiFbuEPthQ==
X-Received: by 2002:a62:12d0:: with SMTP id 77mr95124163pfs.15.1555594670659;
        Thu, 18 Apr 2019 06:37:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y191sm2341425pgd.78.2019.04.18.06.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:37:49 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:37:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (ina3221) Do not read-back to cache
 reg_config
Message-ID: <20190418133749.GA13515@roeck-us.net>
References: <20190417231210.5762-1-nicoleotsuka@gmail.com>
 <20190417231210.5762-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417231210.5762-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:12:09PM -0700, Nicolin Chen wrote:
> Reading back the CONFIG register increases an extra I2C
> transaction. This's not necessary and could be replaced
> with a local variable caching the register settings.
> 
> So this patch replaces two readback regmap_read() calls
> with a tmp variable.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter
