Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9317C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E52206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbCvU/0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389745AbfKGRrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:47:08 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41049 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbfKGRrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:47:07 -0500
Received: by mail-pl1-f193.google.com with SMTP id d29so1978649plj.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=A7C9nVWoqw2fCjix+RUHcJ/eKACVMV7OHWjEbohU/GE=;
        b=nbCvU/0vsQlCsJtreSa5tAxqXZb9eqFw3OHc//Wxc3I1fbj7PbXJjwjtLZuVLExqb6
         FvVIonVu/SCwdSgbJQC/P4ptX3HLQBQFcVVduEBmETL6O4RQY1x1VP35ckLizm3osN91
         x0gKl14M13trxmf4ZPz6MKLAMXJqONkHp3dw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=A7C9nVWoqw2fCjix+RUHcJ/eKACVMV7OHWjEbohU/GE=;
        b=MwQpI6WoBHNz/Pam3E3EqG1wwhZQql/CFRN4CjhEX0Kebi/T/9w/rhU7pV8fp8jNp9
         V4ImbyWWgLiFthP0HjFjzx/zI45W76x403hmvBNfK3YG8IvznkE0xNwJMjaCiMplUsvI
         1/vfUZxe6/Ll5G6o0JpXbprSf5lBta68SoYh6Id0m7VMl0QhfyBxy4aUG0iAtvpG1/Ue
         vyKIDfcOpT9C+Gx+4Zf3C+jRClypu5CrJ5gksiXQDGCGucGtP3zHqlXEGGYv3dtJb/AH
         SvpSJQomfTnO8UkNWtTq5UGHQUnSJfvJBL+psrlBX7uZeL/CZ/PTLnhmOZcFjlo/UfGa
         IdOA==
X-Gm-Message-State: APjAAAV5cUN+400kp5WzzqVV0uFqGzbQ0hZElgdJYAnpgdpUufKBn3nv
        YVzDkdubAkwIE8buiXAHpX1RuQ==
X-Google-Smtp-Source: APXvYqzjUMjRSghQq7WVhSh6oycWsvdJOoNe8Z0d2BQhXaaagbJ6/VCFELKa3s/V96a2q64CTcfk4g==
X-Received: by 2002:a17:90a:850c:: with SMTP id l12mr6981004pjn.16.1573148827187;
        Thu, 07 Nov 2019 09:47:07 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s23sm3257366pgh.21.2019.11.07.09.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:47:06 -0800 (PST)
Message-ID: <5dc4589a.1c69fb81.a0cd0.85b7@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-4-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-4-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 03/14] dt-bindings: arm-smmu: update binding for qcom sc7180 SoC
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:47:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:06)
> Add the soc specific compatible for sc7180 smmu-500
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

