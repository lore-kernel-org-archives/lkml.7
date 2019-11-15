Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA15C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10B20730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="isV1GwSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKOSsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:48:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33940 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKOSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:48:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id h13so5273065plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=X4twp3pctC7VCYEezfWUSk2DKafsbFD6g/B7PxJ7beE=;
        b=isV1GwSykbdCIUh1Sq2o8vQA3iKaQVXo2ALyRNUWZ8d6X0VzM46cePA97/qONQhJ00
         RFJ8tV421WaulCuo3jygFdZGKUKdOYYkry8Skc2I706xbc0HLFhIDEepgOxGqQdmgQS0
         3vfOyfjJdFFH/sFlt9zScWDVH7vA6ecKloMps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=X4twp3pctC7VCYEezfWUSk2DKafsbFD6g/B7PxJ7beE=;
        b=eXn29llbfutiHE2ZSbutLzlBv+2a9PjztMG5VPwbCg+DcetvFTTeGpPBsk3dx9X8pE
         9O50v1HMxvNUn8Zzj4QIjDHRtGZnWqlSRZf+KmB6kVq8anz9EUydOAXXtS39XB/ih2Ul
         9CKIp/y8FOwBESX1gf9lIG528T+G6kU2NKYyG+ThAGmJpL5ird4kxrB/plN15QJvqQ4T
         LxK+Ok27bRZULNyykMZO8qwezZVrrfpfb2BIhp9P4C9TkAOJjmxOK5LMsecId0jSAbK+
         AjADQzndKGte+NtiO/gBtfdjihZvOGMYJohOzoBATKoliLojkDPUW/A9WjG7olOLlJXK
         Cupg==
X-Gm-Message-State: APjAAAUHqxl3wLFCTABxoYjJPewE37KCOE2fAIWQ5x97q6zOKeDfJyfC
        zIsWuiRGiCSAHIF6BfGw1TFNQA==
X-Google-Smtp-Source: APXvYqzCEHYKTJk35+KbDAqTeknJ92k5jjiweJcm0Q36J9YfJLytr/wLW+RFHHfKHabR4PfHBGRO9g==
X-Received: by 2002:a17:902:8ec6:: with SMTP id x6mr16554556plo.151.1573843701878;
        Fri, 15 Nov 2019 10:48:21 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a26sm11247215pff.155.2019.11.15.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:48:21 -0800 (PST)
Message-ID: <5dcef2f5.1c69fb81.ccbc2.1a7e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573756521-27373-2-git-send-email-ilina@codeaurora.org>
References: <1573756521-27373-1-git-send-email-ilina@codeaurora.org> <1573756521-27373-2-git-send-email-ilina@codeaurora.org>
Cc:     evgreen@chromium.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        linux-gpio@vger.kernel.org, agross@kernel.org,
        dianders@chromium.org, Lina Iyer <ilina@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, maz@kernel.org
Subject: Re: [PATCH 01/12] irqdomain: add bus token DOMAIN_BUS_WAKEUP
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 10:48:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-11-14 10:35:10)
> A single controller can handle normal interrupts and wake-up interrupts
> independently, with a different numbering space. It is thus crucial to
> allow the driver for such a controller discriminate between the two.
>=20
> A simple way to do so is to tag the wake-up irqdomain with a "bus token"
> that indicates the wake-up domain. This slightly abuses the notion of
> bus, but also radically simplifies the design of such a driver. Between
> two evils, we choose the least damaging.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

