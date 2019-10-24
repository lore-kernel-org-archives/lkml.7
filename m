Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BBBCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F17621906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2MgRgbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504097AbfJXSlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:41:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35428 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437045AbfJXSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:41:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id c8so9940513pgb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1hs/Dz0d9QwkcFsIzZCeelje06H+eTHhL2VOrizezu0=;
        b=l2MgRgbRGJLXh9uN49td3JrbEI+DsqoZ2ptjNCSdhZSV4eUzDraFmEXZviC3NZZ6yW
         62A6tF3Jj6yeO2CHuZZ8PA0dgKImUjwye4hHaufhfVXBRvPBOOg7W/31DQY4cTgFzs3z
         qcV/P7SP4ikukHBvxiy5DnHBPS/EXUUWupPZ24sonuSA0dFUweWhKuBkvd/ypRRoUvKE
         EAUha7i8f2dL5V8bgYf1dFy5apgFYp126hhPwfX00eVrWFEG1sd304tKr+gKRtKfFSgS
         Cvu6A0rt1AvjeuMgvpOSTfCgJyVYGSm8O1wtv+WLEMNJKWqxx0Q/4YCLgNzzJTrBrmi7
         3xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1hs/Dz0d9QwkcFsIzZCeelje06H+eTHhL2VOrizezu0=;
        b=Qv00CJvgUvgSMfzxEqOm+jHrrGZE20EyYqI7CgS/w8xX26UWgnnzjhekJGoUuvMdKA
         XM77MWhEiWmBxtZ3tuMrL7Cu+tINR2mXnHzFw8IyBx70Ec3a2S0rBgGf6Z3c4kBO2igf
         hKF/paJ+KyWuzj3yJrjo0RiLuH+bSDpBxQR3oQC4L746AUuFYfzM/Sm1ZOLWIq69bGDl
         UcfOm9xEopotcAFQtfDPbYUi00zTMh3upsf4UL5t67a2qEv5vPK3vgNW9muCY4O0U8/C
         Q5O7BXzzgYZUH1LRppnBuO/H5TkLjETQ7tbZtkqS4mv68UshiXj6hH/+NaFcwg/JSYoE
         G/Qg==
X-Gm-Message-State: APjAAAV81KdbHvbPKjzaDYQR55vSrqHGKU2a34xq04rupP9gpK1SMy1p
        If+krzRD4UDY696OgGcH78Ai9A==
X-Google-Smtp-Source: APXvYqxOZYWgkqvmIeaInnSp2GR5ShNGsnPDEleElQXRjjnW6mys3/mcroaOx4bRpvWW/Cys54jp2g==
X-Received: by 2002:a63:4e09:: with SMTP id c9mr17293482pgb.98.1571942502955;
        Thu, 24 Oct 2019 11:41:42 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z18sm30207669pgv.90.2019.10.24.11.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 11:41:42 -0700 (PDT)
Date:   Thu, 24 Oct 2019 11:41:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Liu Xiang <liuxiang_1999@126.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com
Subject: Re: [PATCH v2] mm: gup: fix comment of __get_user_pages()
In-Reply-To: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
Message-ID: <alpine.DEB.2.21.1910241141280.130350@chino.kir.corp.google.com>
References: <1571929472-3091-1-git-send-email-liuxiang_1999@126.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Liu Xiang wrote:

> Fix comment of __get_user_pages() and make it more clear.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Liu Xiang <liuxiang_1999@126.com>

Acked-by: David Rientjes <rientjes@google.com>
