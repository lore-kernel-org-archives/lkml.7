Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8B6C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B7C21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576700694;
	bh=9SR6g0H//Syq2bmudVcOmhmN9pjZXNP4X9iyCOZ8ORQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qkYvbLTW8dVo1XSJrqGBgn4MSXfIrf89SLf8k3ryi8T3QS6t4w43NFJ77CNJta8Ox
	 mzE4eEsUNdgzNjVFdvNXEXdvBXJxW3AJWzoSw+eAOa97/haR1/poSRb/Hbu0JeHNjG
	 31wVHN4+3uQ6wUX+oRbQQbt3TWpxbclX4veUrZV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLRUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:24:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38647 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfLRUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:24:53 -0500
Received: by mail-ot1-f68.google.com with SMTP id h20so4007967otn.5;
        Wed, 18 Dec 2019 12:24:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSGYLj+Mktf9A48zPx6thsm+SFOfaeOO9zJCboiaHwQ=;
        b=mGyViT9mRSK8sYAugJG5ZPXX1gCvyOItJi3utyMxs8TfzyuIhiR+JzYdbyKCD5IRFc
         n3g+aWYLVzFYANW/NmOJs1WZ7o0jtiFPmc9KzyJB30bttHXf26rXEGuBQq+JYcXggd27
         nVGIPEkDzgvBF+OJRT9ljZ9cLw8G6rBe4yMhJkBqiInTWoq1SaqeHnf+l/Xvm4OHKABz
         1OP9PfjMlj5+Nk3jfGbBvgvXtuTsEezIJ9YcftsS6UmPX5baaD8Rt612hiu+vGHOgB5A
         FSplnra2/lBHt+ZbVfQk4UEfEPkOry2RputSI7Nbz+baHCEtCESdv7a75eqfEWmUzDP2
         hFzg==
X-Gm-Message-State: APjAAAWN120J6O03/zD09H+4435Wc77L3zuCh+UgouzhkhcAt20bICyE
        q2oI+W0DUCvzzJ5khJk7NA==
X-Google-Smtp-Source: APXvYqyAvyu+vqojCGMlWHsu7M6BiqVhjOowblFzkcGXvLR/TOSZby2Xl2CyBjp+q3mHUj4X2VbL6A==
X-Received: by 2002:a9d:27c4:: with SMTP id c62mr4702014otb.292.1576700692845;
        Wed, 18 Dec 2019 12:24:52 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e39sm1181609ote.73.2019.12.18.12.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 12:24:52 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: Add vendor prefix for ITE Tech. Inc.
Message-ID: <20191218202451.GA27315@bogus>
References: <1575957299-12977-1-git-send-email-allen.chen@ite.com.tw>
 <1575957299-12977-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575957299-12977-2-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 13:53:39 +0800, allen wrote:
> ITE Tech. Inc. (abbreviated as ITE ) is a professional fabless IC
> design house. ITE's core technology includes PC and NB Controller chips,
> Super I/O, High Speed Serial Interface, Video Codec, Touch Sensing,
> Surveillance, OFDM, Sensor Fusion, and so on.
> 
> more information on: http://www.ite.com.tw/
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
