Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6F4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A31B218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOIazxTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLRhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:37:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42235 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLRhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:37:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so5467620plb.9;
        Fri, 12 Apr 2019 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WQwj+VNsbN89uc9KNQnyoysq5Qv09ZoKMyKulbxkgXc=;
        b=UOIazxTtFyu8YgBtqMepG51ldHCrXhWFOom93VUBY+NSQuazQmUpDxcjARtIM1BqIl
         oR5P1/Lq0Ty+MrJlRgo/l/ULdU6nIB46fThbrCU1WBdDQzW/9NQZJBbGP/qTmf+m80Gc
         h86/OMPlAtc0yu9mmwRn77EjqWSDqNZ5jOuSl/MDrk5B+s/e9yCnf/78KsgeEhAmfMhO
         dK6x8XsqQ8IMTpe5nNiHph9rmCbHMJltllSd7eniN1vpbcREDpRS68SiQ6HUnNfUwxD1
         pLkChLUlLt51T/8gEwbjOQe9JvX3k0me8+o7MiPe10w1f08yJcg4tuGJKMBMeWiITOLn
         o8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WQwj+VNsbN89uc9KNQnyoysq5Qv09ZoKMyKulbxkgXc=;
        b=YMOFynLNxkWSHt6V7VeDtJ372TLITPKfREKAXL7CIo3PBlmRrIOMEByQxqTwhJi9Zd
         JiROk/zBRVdrLjgdsdO0BLXlMhlXDT/Y5dvOFEJm2Fc8LruJlyaeeOydm/pDLGeMsBQ/
         cfgWB9b5Y/j0cNLNGH8TXj1YeqUlZDYP7EWZFLzJCVxcguw+7wPP5zLL1Y51ScoFZ38Z
         F2E049nkxvbhvZncq8U06f9anixc62K2R2HB0FW318t3Drth5Zev1L0b+xK4STGpKVwn
         jIZy0LbAhP3/gjK64C2zVdDX2qFI9Y5xjenaWszuf/qiblkG7IWhHOWhX5NP//6b0FPe
         r+xQ==
X-Gm-Message-State: APjAAAUs7nHu/tXNB+zYO5psn96qdJWLcAc831/smUFwJKnsvodn9gQa
        M66vAtFeXAFS/iPIlJY7AIE=
X-Google-Smtp-Source: APXvYqyJOFrq3CjcLTA7ek/kRbKHAxA+ZlxarcU7HPAz2Cc34cGP3Nc12rv3w2lpqhNBxnUmv6nwFg==
X-Received: by 2002:a17:902:298b:: with SMTP id h11mr36684419plb.258.1555090670209;
        Fri, 12 Apr 2019 10:37:50 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g64sm98942049pfg.13.2019.04.12.10.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 10:37:49 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:37:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Patrick Venture <venture@google.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: hwmon: ir35221: fix company name
Message-ID: <20190412173748.GA22482@roeck-us.net>
References: <20190412162742.65962-1-venture@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412162742.65962-1-venture@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:27:42AM -0700, Patrick Venture wrote:
> Fix the company name from "Infinion" to "Infineon."
> 
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to hwmon-next.

Thanks,
Guenter
