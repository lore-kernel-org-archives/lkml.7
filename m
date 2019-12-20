Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978FC2D0D1
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6C320716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 00:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXHYa4eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLTA3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 19:29:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTA3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 19:29:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so3328160plz.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 16:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eX0+hKMYcJo8oBSEwdDTOyo7vFKsKuywhqNqQ3gnd9c=;
        b=IXHYa4eu6/nT1cGBEnEO7gnNoLSOy6TN1udA1k99BPkuUvT8WFfQeaSMAEbmqUk6a7
         aQ1jaME3xR3qP/wFQFMFijqSey8bkl70nre6AH4Bei84xPZYE+Orx4KM/cQARiIifmnI
         7h+J+ZtUFn9dw4T0HwB3XBsQTtCmZt9qtd7mmAGrFmnZXUICmBHnugxU7JMI4TA9hC7m
         gPgJy9lLZMLZ/U1uYaOUIpP5LT/mLSOniOAAAbxk4hSeQxEb9xwbvAx5w0AgguXBcYWk
         Jm+jkLGiFeyscj9bjsXZx/skIY4/q3ZfEF8ek+MIEaV68EORn4YmPOQrp0XUoOwEFTRD
         EMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eX0+hKMYcJo8oBSEwdDTOyo7vFKsKuywhqNqQ3gnd9c=;
        b=frlHtv71pzEFB1TSBxmfM+5MBNA5jmdgOJdo+YpiZiNMIGWJArJ2JzKLHSJPHZa0J3
         P8FGT75WAYwNSh2D+Ngye3Y2pUSuejLappbV77iQ72Fpr1pIn65cpBU7vhZSzaldoyy5
         IDOmLzkOttojOeW8qbRpYHyhWpYSnb/O/dwqLZmJmmMkRza6mwQLn/PAV8ZtAieRLvMO
         iLLWV76U/C/XhBhefXTOCwKLkmxjC/SLGxIk15P3vVT2wf9EtaHS5oqdS1+QYJtpzj3l
         AUO24fS9eVYZAgfb7/jne/a0XoZM7xRy0BkYfvrTf9OxWIsnzVJIcNJJat6MwVlZCMfV
         ZzNQ==
X-Gm-Message-State: APjAAAXV6dqrxeSNm0gbBrmr9m4Hi+wEGuK7HfODojNbV2MjuzzUY9cV
        ci9be/mfAgvVZj/5BEuwLcDy2w==
X-Google-Smtp-Source: APXvYqzj4L30fXYvdhcn+1Z20UqVHtvyYJaC+EXHuHEQjLIsGtvvTqubS6mgEOKOe+0n+3Optp3Jvw==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2mr12223170plb.148.1576801772778;
        Thu, 19 Dec 2019 16:29:32 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id gc1sm7676050pjb.20.2019.12.19.16.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 16:29:32 -0800 (PST)
Date:   Thu, 19 Dec 2019 16:29:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     sthella@codeaurora.org
Cc:     srinivas.kandagatla@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] nvmem: add QTI SDAM driver
Message-ID: <20191220002929.GJ448416@yoga>
References: <1576574432-9649-1-git-send-email-sthella@codeaurora.org>
 <20191218061400.GV3143381@builder>
 <17c718c483db710b32b2dbbcf4637783@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c718c483db710b32b2dbbcf4637783@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19 Dec 02:29 PST 2019, sthella@codeaurora.org wrote:

> On 2019-12-18 11:44, Bjorn Andersson wrote:
> > On Tue 17 Dec 01:20 PST 2019, Shyam Kumar Thella wrote:
[..]
> > > +subsys_initcall(sdam_init);
> > 
> > module_platform_driver(sdam_driver), unless you have some strong
> > arguments for why this needs to be subsys_initcall
> There are some critical sybsystems which depend on nvmem data. So I would
> prefer using subsys_initcall().

How critical? Needed to kernel module loading?

Can you please document this need somehow? (either a comment here or
something in the commit message). Be specific.

THanks,
Bjorn
