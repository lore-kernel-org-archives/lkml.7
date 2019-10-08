Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3CC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C1521871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+BlNhct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfJHXvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:51:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJHXvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:51:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id k7so138155pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HymENB8AG8ufizSe/L4b4bXByTy1SdlqegKFgCo0vbY=;
        b=t+BlNhct5Z9xKtuP7jrgnvdFPiJnuE7rJZvIaBxfsU+Ma3OuVmYqxxywPBpDSp/4O7
         n8ZBdmZU1fP5/qV2t9eikExcNLCxNplW6F7OO5sGm95uBsYAOzzPLWAL+qujkahv+J7Q
         z1mP2wwUPOxYzrf0fX19WzFVX5ETIqteKMCtmnfHmM/P0/h+RrHITLskgxzDHs2J1srX
         qv2TKT7a5XlawzqsY/hkDTb0g/0CJW/fXdxAC4l7/nNBzjp/ggYwdw407BN3uI8UFBTF
         X/IzEvbtFSimvZxWKq1IFUCtAWwrQWjN9OsyJmTz3Qpz2m4JN+7Rn2ztiacltEWZijPs
         HY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HymENB8AG8ufizSe/L4b4bXByTy1SdlqegKFgCo0vbY=;
        b=N/2dN5FFx4zTTG9Yd8IzeESx2UI5XeTYOnlGmzX3xR5FJNoJATB/31/IvS2mqD+Kjs
         BhPEjy4ja0RUVM7EHBeIJHnKSe7IM7McY5WwWAmW7Vua0sl1/zHwnuFJNW8vaqXjncTn
         Iw3DCh9QeUDccyg5594KE4oAaCWfez/tic7NywhuQaPNqUbuSjgYjC9cApTOHp9cfnn7
         MvWcXGfBnaF620oK0P74ZMbmJc58/3kQ4xZo17pXKEjG6tBfLXsiKLMeM9GxQAw7K3N+
         JroItY6R2OD9YG599pZKw32vVlH5JOyjWKRQ1+/HLuaCTkqxMlgamZJPcrSg0fV/9Lds
         cOjQ==
X-Gm-Message-State: APjAAAUSoDmNkoi9RRupRSwc7o73WDK9qwUCAwA7svMbODWtGPsSUOyJ
        TCHxAbaGbEbgzFCxdY9YFGb6Lg==
X-Google-Smtp-Source: APXvYqw+pEeNGzD0nY+968srFsTK3zQ/UJgiBALiDL8faTpcDCC1upPAqXvaAFAk2A9U/3ZspPPGWg==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr175890pls.245.1570578701839;
        Tue, 08 Oct 2019 16:51:41 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s3sm259517pjq.32.2019.10.08.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:51:41 -0700 (PDT)
Date:   Tue, 8 Oct 2019 16:51:37 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 3/3] phy: qcom-qmp: Add SM8150 QMP UFS PHY support
Message-ID: <20191008235137.GM63675@minitux>
References: <20190906051017.26846-1-vkoul@kernel.org>
 <20190906051017.26846-4-vkoul@kernel.org>
 <20191008074619.GA20801@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008074619.GA20801@jackp-linux.qualcomm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Oct 00:46 PDT 2019, Jack Pham wrote:
> On Fri, Sep 06, 2019 at 10:40:17AM +0530, Vinod Koul wrote:
[..]
> I was thinking of taking a stab at USB if I get time, not sure if that's
> already on your or somebody's (Bjorn?) radar.
> 

We only have remote access to the hardware, making it rather tedious to
do USB. So it's all yours! :)

Regards,
Bjorn
