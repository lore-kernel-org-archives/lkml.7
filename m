Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93035C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630AF2178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OxGhg6Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbfKGR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:59:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41338 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731171AbfKGR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:59:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id h4so2508109pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=O6gBNRGhVZ1gdZRloCa4pu6sdIjr6Vbikqu0zr43xGE=;
        b=OxGhg6ZoRHVSnJPS/KQ8rA72slPD0/uCvstdZnD41uuJR/XZ+uroAy0C2HsRi8TJEH
         Ehivz8UEUDJWp/mtRdbhh2Ru2z40X6CTZgFSymicjTvrKVz3nyARqURphSni6IEb4ejJ
         Gx1FErmbqtJ3pBj1kUb7zhFeX6MKw9dKBkMRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=O6gBNRGhVZ1gdZRloCa4pu6sdIjr6Vbikqu0zr43xGE=;
        b=Ad5OlVbIks7cqJMFT6oJUQaQd00z+8kz8ilEfnuYIXlrGAid0P/dAV1buNk68aUUy1
         EC5EbZ9chpxH6gBhn4ntV1H3Fr+QVzSm4my/UyrCsW0VWR4DvDnPWamrRP6EHf9eY0E+
         qQxqMBgQSRpheGMa7XNShtqRcnEVf/Uk3BfOHrwYsIQjwboQYpuYWltv44cRhe7j9VOx
         P27hbbD9j6Qitl/hoXI6cJreI9KaXpB55eGAyi2tOYZMG2cQpSlURNMU36zOsZIv7ipj
         UcPONymlfDmHJisbQUjrDpfeECLWXXPljMb9fR59YZBcnmgqDDmgiFuQZN7Tf3nSvgb5
         1lbw==
X-Gm-Message-State: APjAAAWfbeiljh7TkVpPEJCvKJdBZII8qe05HZgzOrTnE8w6qRdmxmoA
        3w/lZXIRCcL4UpVJkZ947ifjPoPQxP15pg==
X-Google-Smtp-Source: APXvYqyVCRadOx088g6lxPYOjNqiHOYdn+JqmwRs1jOGVb7nudBtoJQRBm1zQAzNz1+MhSrGJSPaug==
X-Received: by 2002:a63:2f47:: with SMTP id v68mr6162731pgv.239.1573149587179;
        Thu, 07 Nov 2019 09:59:47 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i187sm3674211pfc.177.2019.11.07.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:59:46 -0800 (PST)
Message-ID: <5dc45b92.1c69fb81.99916.8f34@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-12-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-12-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 11/14] arm64: dts: qcom: pm6150: Add PM6150/PM6150L PMIC peripherals
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:59:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:14)
> From: Kiran Gunda <kgunda@codeaurora.org>
>=20
> Add PM6150/PM6150L peripherals such as PON, GPIOs, ADC and other
> PMIC infra modules.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

