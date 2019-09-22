Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7A620820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 16:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCTb0/EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfIVQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 12:49:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44067 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfIVQt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 12:49:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id g3so4925566pgs.11;
        Sun, 22 Sep 2019 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wm6PJBsN37XhpKJFJa4+Hrg+E3W65pYxtn8YOPxmArE=;
        b=VCTb0/EA6Tzp8+07Ff4T8bGU+w/8ZMPzXU3k5iIFjRk2XuUMKXKj7uN2nuz9Vj3vC0
         sevvMwDdyxzGEMZVqPju/jP5FlSRHmVSy6Gmv0HzYxzqEjY9PYH1QkPlfNWacSYNuk0H
         EUZ1Xav+2wOpeLVnS94GOgNmBiyhYk7NyvehejOi6CMsLhzeP8FBhc35mtevv6l88eul
         qos7oDM+1zeBMvUEHER7jkkxF5lGWdll9jFQnO8+6uaXEHmbyOmd7UisUuvBdgyp8rbA
         UuQoZRVzc7K1pdsNwpwwfc9rtJOPcOZpKj7vC2ZSmUI1TxZfBSi67+K8boKST6QFeuw2
         e1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wm6PJBsN37XhpKJFJa4+Hrg+E3W65pYxtn8YOPxmArE=;
        b=cu84DtIBSKtwRO40YikinS3vSRW0247M3oRQNcnClRTVKG1sz9KIXwplhKgeJglcYI
         FDf6ba55NbnVIEA75pPxsMFwVecSqk6AJqcQuBCKwXelC5/g37oHNG8o97UKX95QFqHn
         bf7tA2seAQkBMAhHFFOJY76ag8sc7ymodnh9et5FGHXVD3ku9GqsreLNfvJuTK4e8zNb
         KdpzaGxabYiv92KBeew1QhFi3MnzsX//e0cBkBYNaCKWcABlAYv3NrHOZXPLIqExEUiH
         IcFxtnnn/ryL0VNvgYFYViYRSq4lDxAR/z1nVICN3I4DN6QpUJotpxwYg68VTVRlBf6v
         0z7g==
X-Gm-Message-State: APjAAAWdFXYjBPK0Q9XaiJ+aHXhtatqOrm+kbi3uVMGqIUjG3VQBYIsi
        03vOra2YL6xMfwr8n7pI7A8=
X-Google-Smtp-Source: APXvYqzRZaZyV3ysOmoGeMiD5itNz07YGm8hcT7ruDiNx2VozXKa2TlDorvKVWxElXooE2uDuTL8oQ==
X-Received: by 2002:a62:db84:: with SMTP id f126mr29943440pfg.25.1569170966903;
        Sun, 22 Sep 2019 09:49:26 -0700 (PDT)
Received: from SD ([2409:4041:2e8b:6e6f:acd5:5ade:157f:5f8f])
        by smtp.gmail.com with ESMTPSA id o64sm8978093pjb.24.2019.09.22.09.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 09:49:26 -0700 (PDT)
Date:   Sun, 22 Sep 2019 22:19:15 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     ludovic.desroches@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: host: atmel-mci: assign false/true to bool variable
Message-ID: <20190922164915.GA5589@SD>
References: <20190918172823.GA28786@SD>
 <20190918180112.GR21254@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918180112.GR21254@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:01:12PM +0200, Alexandre Belloni wrote:
> More useful than information than info on semantic patching, it would be
> good to have info on why you feel this is necessary.

Sure, will update the changelog and resend.
