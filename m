Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB91ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C824E208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 05:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zmt7MuwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbfJJFEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 01:04:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45219 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbfJJFEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 01:04:06 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so3071379pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 22:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=RDcgYyHGE7Ugaco0qkuIi9HynTd/fxe2Ca020N/JEPg=;
        b=Zmt7MuwX3mgqOtO1SLFiulXF3/JFoK87LeyjYNh8GzlLx5Peho4Bfp083Cv/wJtq/p
         qnNtMYUTITHeIv/R9giQdM6XXx/g4bBwXMGW8Y7lGhTERwMu18oYccSNphKgRGHRwzvM
         CsD5zrNHrYDnYRquheyibQcOKC0RePR1BdPoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=RDcgYyHGE7Ugaco0qkuIi9HynTd/fxe2Ca020N/JEPg=;
        b=kDnBpR0vwmLejQSdU19ebLa+GGviN2reQEqEuijJsyV83rJ2sMAS8cGdXWZccE0l4t
         TayjjPYLHIwM+Bi+14Rrxg9s89MN0P/XubcE1hqMYvc5Yv2eheO2ZYp/Ht1v7DjSiMDD
         fxrMvZlkmH4XPNUA4vUa1qLk9LwbF34MgMTuypj/kmNY++yZjoyk3Ttw0CHreDakdxgf
         QWYcVIvubUOboNMrfeVCGOHjsv5Lhmv8F+mvGR+8IvN7fqqknxeBlZQwBJgTIhMgJVrk
         7O+9mxPTUbCVQ67h3ATEztK4MZPAWzipRAOT9CaqA7ntXAUSzRg6iRXl0UbPL2l3naSG
         32lA==
X-Gm-Message-State: APjAAAWAWeOHQ/M5EUVO5ipKtOfZhSkTu+j44F4RnOLMBi1ntSywrE+u
        lytc+C567cWXVH2R1cT8WzvUEg==
X-Google-Smtp-Source: APXvYqw9/raUa8lawyg+DLKK8BYDVbYecdV9aYm7AXYeJETU44FJ3FlHZKqeiYmyuHb821nDWHBGsw==
X-Received: by 2002:a63:4624:: with SMTP id t36mr6066126pga.376.1570683844943;
        Wed, 09 Oct 2019 22:04:04 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p68sm4911397pfp.9.2019.10.09.22.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 22:04:04 -0700 (PDT)
Message-ID: <5d9ebbc4.1c69fb81.b45e2.25ce@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191009013345.17192-1-clew@codeaurora.org>
References: <20191009013345.17192-1-clew@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Chris Lew <clew@codeaurora.org>, bjorn.andersson@linaro.org,
        ohad@wizery.com
Cc:     aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>
Subject: Re: [PATCH] rpmsg: glink: Remove channel decouple from rpdev release
User-Agent: alot/0.8.1
Date:   Wed, 09 Oct 2019 22:04:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Lew (2019-10-08 18:33:45)
> If a channel is being rapidly restarted and the kobj release worker is
> busy, there is a chance the the rpdev_release function will run after
> the channel struct itself has been released.
>=20
> There should not be a need to decouple the channel from rpdev in the
> rpdev release since that should only happen from the channel close
> commands.
>=20
> Signed-off-by: Chris Lew <clew@codeaurora.org>

Fixes tag? The whole thing sounds broken and probably is still racy in
the face of SMP given that channel->rpdev is tested for "published" or
not. Can you describe the race that you're closing more?

