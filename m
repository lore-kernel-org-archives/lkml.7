Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF7FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49C1206D6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 23:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iHgcUugC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKOXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:42:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45640 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKOXmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 18:42:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so5372334pgg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 15:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=iToz+vl4UuzXnSoAQspKE/x5E1vlqbw9FMJgzVbrjnU=;
        b=iHgcUugCHyxz+Iw82+c0FQudbT+3AwXkxLNtu05j9DFuZILtosVa0pZIeWLjgzoFuD
         cc1GFg8q3ApqpdBguYzZg6eVfLNM+atlybo29YbDCtEV2DNxRgLJ6w4VGShzuOwM5hYM
         7nWHaAupLVyptVHk+3dTgYA5jwGewS9OTTjeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=iToz+vl4UuzXnSoAQspKE/x5E1vlqbw9FMJgzVbrjnU=;
        b=mVpLa8JxeAcETMrBU7w8uASG2/ett3hQyubO0OPUT1Wq3a1HTQSivUgSZ3h6aQS+c1
         1H2YN2F1o5PoVX6XlZZmsXTlPjzyniDiOM4n/wOv6tDZDWW9mF4SY2pMJsQNFdZ86oC6
         W0MyO/eYiReAePk+K4c3bUV1PT/myEfZ+dvNUstHy/WDG0b783HRVU+kIfTKHRvaMwHQ
         JFeYHc/z1YhW/dcO4oyi9fQexdRTTmVpRt/aPr0cLO5aspDagmlC9OKr01StVYDM2/k1
         HUKDb/Li3rBAScrs8DOlLWPCUYSduZNja/F7Sw+9hpVk8vHjkkeIvORU+P3kVcIynNnC
         BqNg==
X-Gm-Message-State: APjAAAVvE4VLPOEK/y4Q3YiCzs8Jj7iVcbP+PZUUUhWLl4jDdybgP/r0
        F5/3d1frLZaTyjDRUtQmZCviNQ==
X-Google-Smtp-Source: APXvYqzPVvn22bxdM71aWAaZx9pasmXtHh4KdT7avVg7z9GGIKmnqNx/kRti4q2XTGASSasRs84xOw==
X-Received: by 2002:a62:e306:: with SMTP id g6mr12085031pfh.32.1573861343328;
        Fri, 15 Nov 2019 15:42:23 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p3sm13034585pfb.163.2019.11.15.15.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 15:42:22 -0800 (PST)
Message-ID: <5dcf37de.1c69fb81.8aa8.6308@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-8-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-8-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 07/18] firmware: qcom_scm-64: Add SCM results to descriptor
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 15:42:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:43)
> Remove knowledge of arm_smccc_res struct from client wrappers so that
> client wrappers only work QCOM SCM data structures. SCM calls may have
> up to 3 arguments, so qcom_scm_call_smccc is responsible now for filling
> those 3 arguments accordingly.

Why? Now we can't mark the descriptor 'const'. That looks like a step
backwards from before where we had an input structure 'desc' and an
output structure 'res'. If anything, we should make the output structure
'res' optional in cases where nobody cares to look at the result.

