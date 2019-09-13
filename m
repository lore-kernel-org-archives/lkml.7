Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4D8206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhMy/APO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfIMQsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:48:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40177 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbfIMQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:48:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so18420160pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gW2N1i3dQ1/II0tw58Dh1ejmikzhZEzu/mpUz8rB8wk=;
        b=NhMy/APOmMD+MCKdmXfxHm15pnSkr8an9PegqY0Y2Oaciv+OcSVZmqxex01mJc+5jf
         cdMMZw1sGC+Ywi9p0oLMw48fEOXjM6aQXpiIk5VnLV7EQeLKPbVtnMf0EyxbjUl+rwbX
         DyNm9MhF2SIUuSkrGoH6GkyCng7qh59zPzlsuSv16seUQQU2XHwC40sTnBDFF1z6NM5f
         GJZbN71I6HtwC/WnUiTC66jcwyls4kcpAw3ukVubDfVNqixpHQE2jhP7Nx9npuObsL+4
         FVpSRlyda2rbpCVgArCxOGK9YNb3IGrbqpngzTx63It0EijmPCdGy4JlT/Zmn+VctU8L
         RLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gW2N1i3dQ1/II0tw58Dh1ejmikzhZEzu/mpUz8rB8wk=;
        b=SX6HoARIOVZTVEz5Z8UZyb4BNtDGk+wDt/Y3GIs4N93qshe0rFAYGHmRNnEywU9Aoo
         x56zU4O/d2PhsxQlB6J9+WagA6bYTjPIQ4B90FWMz5xEn3Mkf3rwGbDb0OHSBaGTIa+q
         blRmY3HTPKTRy+rZT+Wnbpz6ImJG+hKDiWrn5AYU9jwxxjHOb9Cf95IwHyGZhLX3AsFA
         65EVIDLW1MRCb6e8h+18tUJyIsK+gWr8ZBPaNtX2OWa00BoR6Ns083r41X7s01y6J54U
         nqLo+5JXdnrMPGX+152sctrOjNzC/6kzyae6OIk/Zm/3+wwUnZ39/85iVV/XOyeeSqND
         nv5Q==
X-Gm-Message-State: APjAAAUY7WB8hsWxZdb3uK7JkI4hd7JWViFgRMy99H192JbAT47gtCdv
        dkegcZN0qAriPU8HXxghXRFSlQ==
X-Google-Smtp-Source: APXvYqwBu4eLOKb28t6qtNtdNBCKtNWHQYJ5sXVXd/zYhLtXCm0scT1SEcsP0hEMNdo7XbVmtYvSqw==
X-Received: by 2002:a17:90a:cc04:: with SMTP id b4mr6039257pju.127.1568393308933;
        Fri, 13 Sep 2019 09:48:28 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id v5sm30831622pfv.76.2019.09.13.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 09:48:28 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:48:23 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] dt-bindings: i2c: Aspeed: Add AST2600 compatible
Message-ID: <20190913164823.GB52781@google.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
 <1568392510-866-3-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568392510-866-3-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:35:10AM -0500, Eddie James wrote:
> Document the AST2600 I2C bus compatible string.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
