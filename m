Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EEC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56BB20732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UtGcVOPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKOTib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 14:38:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39570 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKOTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 14:38:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so7165007pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=N3RglndAty+Q/Su9LZ87Avtb9ayjrGHyeAiCuksi9yI=;
        b=UtGcVOPwv+Sz7IoEtQf5f6u5Bwgm0baqY2Pm/LkCq5Y+myds1WEgPKSc/h4IFVnGfM
         4cJdrIwH0moWO54hBHgBqhBcFoRIB5Gi6eNmpMXxG108ONJdy3ibW5lS+7A3vvNUpUPU
         hnztaqL+IFnT/g0h1yPCraXD14WhOHqnkPB8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=N3RglndAty+Q/Su9LZ87Avtb9ayjrGHyeAiCuksi9yI=;
        b=qYQNUo/hpI85AcSH7DJBXFt7TEie1V3CBsuPjrxBFF94y1nA4vJDx5XCyOKGKos/6M
         lFnsGgErjHOvbx8zRZ2WZDJPI0hVLbgMnxA9tr5u3wtgFA3Xc2yXm/DP0ACXUFMLxyLv
         pmjVzdgAmm/KliB/yYypeukz3G/PlAKTNPRnEv0weKBiAgzBnur6mGC4lCWUwP36QF9A
         HuYQI07hxBFQequVqcyLsyX2wg9scBPq8ZOYgcRs6MWilELsyJbcfXX06f7j8pKDfb4D
         82Up1+0EwSjiqKBDiBLHxuS5d4N9/WsIeLqJE6ZHUdzO2GZnsKZ3+0fmOICB9AASHUWt
         IdsA==
X-Gm-Message-State: APjAAAW9p4hh3s2jqkr3sEQh5emtxjDIVX2zRl/RKApGASGOx8riM//S
        noR22q1J6U3ktiUCBxerEtPtfha2Sx8=
X-Google-Smtp-Source: APXvYqyIIQmbO8Jh5LsYVJAkG9qSWUVFtjTBJtmPW9PBcFmGXEA3YzAVQ7//IHl8Rf9YfaPCT7oA/A==
X-Received: by 2002:a63:395:: with SMTP id 143mr12694732pgd.93.1573846709916;
        Fri, 15 Nov 2019 11:38:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 82sm11338835pfa.115.2019.11.15.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 11:38:29 -0800 (PST)
Message-ID: <5dcefeb5.1c69fb81.757a7.0d4f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <83394ae827ce7c123228b749bcae2a2c470e88a4.1573814758.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1573814758.git.saiprakash.ranjan@codeaurora.org> <83394ae827ce7c123228b749bcae2a2c470e88a4.1573814758.git.saiprakash.ranjan@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: msm: Rename cache-controller to system-cache-controller
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 11:38:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-11-15 02:59:11)
> DT schema checks for the node name 'cache-controller' and enforces
> that there has to be a cache-level associated with it. But LLCC is
> a system cache and does not have a cache-level property and hence
> the dt binding check fails. So let us rename the LLCC cache-controller
> to system-cache-controller which is the proper description and also
> makes the schema happy.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

