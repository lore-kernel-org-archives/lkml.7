Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355DC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9F12238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzYCDtws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfGYRSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:18:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGYRSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:18:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so23350165pgp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=pKF4uTEG2V2736jXBsUmCSSZEQt/JQWcWxojg2SNHvQ=;
        b=YzYCDtwsX9ubBUiVtnqndDSs3hmpOz1P0CeQ2TgcZ8Gn4gowsx2EV6xe/gDciXbo2V
         cXdMt+RL/GjOKn65B/pUAoWDBBVtRu8cL07AYgSTHhJrpiSVUcvsdrZEvC/sw2oNtyHQ
         J06ebgNs46VM6Kb3iZgbNX/a4WxRa0QpnyGOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=pKF4uTEG2V2736jXBsUmCSSZEQt/JQWcWxojg2SNHvQ=;
        b=RX3CNGWjZVSkVa45suWmXkUC3Gyk+u635aBJmM7NHJmcDL1kUJl5w9b77g9q3kCjxX
         yQHb0oWsHoa1XPGKbIVqQPEGFxd8PLyo+yWvEYGo9uLwvWhe+esHgxwr+uk+lKyUfjz0
         ToFFYvE0rWDfeNyXiG7yK7R76JKY4PpZC1F8CyTRaZV38ZbkGY12gQKV0M4tBVqPsm0s
         t4JmmF70B5YZygNSAe0LB+leRuO4pKL0C0E/L0XcTh0TPYhTA5XgF7foeVgkcL6fAF4e
         Nswyr5+fdV/DPQslZhx4yNdwOJIv2tex98imV/dTPtWBAVnBY3yXGMCQ947K+laB8YCd
         yN2w==
X-Gm-Message-State: APjAAAWz4m4HZrM2uFcwdOzEsOclQ2Hs9JyLtpJs1ykWM1zhIFPaD2bo
        GCRfRDRUl5+4VSFFcX29pRIqGw==
X-Google-Smtp-Source: APXvYqwyvvB59B3ughI+E3wp1WnBBj0Dam/Cxzjm5SQLtruxS4EDniq2hIg9r9i6o5dS5o9HEqeP6A==
X-Received: by 2002:a63:7245:: with SMTP id c5mr73569315pgn.11.1564075129171;
        Thu, 25 Jul 2019 10:18:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l31sm88237663pgm.63.2019.07.25.10.18.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:18:48 -0700 (PDT)
Message-ID: <5d39e478.1c69fb81.53508.87c6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1564073635-27998-1-git-send-email-jcrouse@codeaurora.org>
References: <1564073635-27998-1-git-send-email-jcrouse@codeaurora.org>
Subject: Re: [PATCH] drm/msm: Use generic bulk clock function
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 25 Jul 2019 10:18:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jordan Crouse (2019-07-25 09:53:55)
> Remove the homebrewed bulk clock get function and replace it with
> devm_clk_bulk_get_all().
>=20
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

