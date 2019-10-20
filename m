Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074EF21A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 18:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvmnNqfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfJTSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 14:20:36 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:41135 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfJTSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 14:20:35 -0400
Received: by mail-pl1-f177.google.com with SMTP id t10so5405071plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=2MtOrLGldIQir4DqPUZct2Uqjg6gZZx4ZsJhImJZB/Y=;
        b=CvmnNqfUInvhCEAUH5m7TYVs8zeQG954/MU4KQLjxoxKlHwc4RYLdCNn/3GuR1zwo+
         Y9K5Cn8wnI5/K2YljAw4ouj9kvwAWa2FAkaagO+6t35xljSNocBz2iceDF25a0PwOHlb
         Jp1LUZTSqJX07ddu2n449lNElnhmPgdJBV1xU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=2MtOrLGldIQir4DqPUZct2Uqjg6gZZx4ZsJhImJZB/Y=;
        b=oUMU+QV8thKjrmgv/C/NbwMyEazL/3PrvPMteogQh+jEC9I9/PqklJrojgVBSLkQTi
         vDbHd3EvORiwhGaeGfPNMEHCIsKosb3k23iV0Fiz6QMaeAaKPioYe2rzxL1JcD9cTAUw
         TCs86XXl+4t+DBpjDwOQy2mic7UKUzG2ug2iuKFoh0kMGQCQN3A5CbjjZvpaGsbJo2Pz
         HF1fZCnfdEqiSeM/QIwwOJnCzaoXdqnA87SPmSjUPZY+0kzw82r6eIdLckweNEa/e8c1
         wB7MPRL+4C9O9Tc9HRALj/lgZsj3MONLb6HjAxwcVwNjXKT/XaH6dnIzYnwx3pCYh+6a
         Od9w==
X-Gm-Message-State: APjAAAU9ivZ5NQYvcL+IEbYmNNVZ4MHrEENHiui4jWNcTI6T6zR7q+mk
        DI76+wqHYJo68eVeD6m07Cacxw==
X-Google-Smtp-Source: APXvYqyDPBZyE4SebG+Ea7Ud6L1w8H8RdR89Dwzy6WlI0msmIT9RKOQk+hL8Js9Nwxi4tSZC4vU3CQ==
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr11921775pls.97.1571595634953;
        Sun, 20 Oct 2019 11:20:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z18sm13510136pgv.90.2019.10.20.11.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 11:20:34 -0700 (PDT)
Message-ID: <5daca572.1c69fb81.68ee2.1f85@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b5d9e61c4a68ef3290958a891c9361523e0073c0.1571484439.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1571484439.git.saiprakash.ranjan@codeaurora.org> <b5d9e61c4a68ef3290958a891c9361523e0073c0.1571484439.git.saiprakash.ranjan@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2 2/3] dt-bindings: msm: Convert LLCC bindings to YAML
User-Agent: alot/0.8.1
Date:   Sun, 20 Oct 2019 11:20:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-10-19 04:37:12)
> Convert LLCC bindings to DT schema format using json-schema.
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

