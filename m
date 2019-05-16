Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B32C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9252089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 04:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h98J4Si4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfEPELz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 00:11:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43743 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfEPELy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 00:11:54 -0400
Received: by mail-yw1-f66.google.com with SMTP id t5so824039ywf.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NdkZ/duDqLu2X8L8Sp9Y1qQjsBGdKP1kR2TopQEGdI=;
        b=h98J4Si4/wykEUWphi4d4zl7MVsiGlxZQ6HVAqIclAJVVNx36TI/Gb1g1PcpNkvsN4
         MxNtkNqR10IHlg2XylQTO3XARn21apQcIPqn51p2b1ajul9hzUVMqFJL2JYPJL6DH8Wa
         DK+93LMNzo9B95rN6fkqxXdEqIiUqN/14UnJaGx8NbzXO87vuLClz7tRB6+n423UqMos
         Lq1eg7agukcKpTHnoE8QlTNbaOd91nwdP0j0dL2O5UVznM0YLWWxsvv1ytI2RqP2k+3i
         seTD0xiJqcQBMdSCj3wWGBGXcMXpROw62l1g1duECrW53ow5iiQjYxoDCWzURfcqKAmj
         u3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NdkZ/duDqLu2X8L8Sp9Y1qQjsBGdKP1kR2TopQEGdI=;
        b=Z0CXn5DYyWzeBsb916a1OZ9ko3zam+oZjtLBGeoN3gVlRaQtx5HOV+tjwv6rbXMsHp
         NelO6apgoSvOTOlju63TS48b8tmbMdA0YRc9UugWHih1dM9nBR9Ett7Tu8+cH3SaD/vW
         ouUj7iy57mxyktZl6lF6ss8I+5e1vMNsAO6ghLCMdAatYp5TyQzbgqf9Ew/x748JdjmV
         znt5QYB/yrzUicnpvuz+sFzwQn2+Cl25qqhk+leuS9j5U+L0j72hY/GBeiehPsK54yVM
         ZH1RoU5wwSLSvp7UeXIVUtvxUSwFzzrGfHQ60BmcxPjDKqfm9sdtU8gdA3Y9A/RCCsE7
         k00w==
X-Gm-Message-State: APjAAAWotMpk4MvH/Z+JnZG/p40cSH3XCaiGTMN41Kve/pt23nP7yeUE
        EvjA4eamlwobOZo1UtNXrKhsrA==
X-Google-Smtp-Source: APXvYqztbht9RfzIpZ2Bsj4NurJ8AOAUJ52oxUqsz7FB9PMDuUFaijoDiZw87NThfUjW+P5pLLGLNg==
X-Received: by 2002:a81:241:: with SMTP id 62mr23262278ywc.109.1557979913641;
        Wed, 15 May 2019 21:11:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li483-211.members.linode.com. [50.116.44.211])
        by smtp.gmail.com with ESMTPSA id p83sm1647743ywp.36.2019.05.15.21.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 21:11:52 -0700 (PDT)
Date:   Thu, 16 May 2019 12:11:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wanglai Shi <shiwanglai@hisilicon.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
        mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzhuangluan@hisilicon.com, John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v4] arm64: dts: hi3660: Add CoreSight support
Message-ID: <20190516041140.GC12557@leoy-ThinkPad-X240s>
References: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555768835-68555-1-git-send-email-shiwanglai@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 10:00:35PM +0800, Wanglai Shi wrote:
> This patch adds DT bindings for the CoreSight trace components
> on hi3660, which is used by 96boards Hikey960.
> 
> Signed-off-by: Wanglai Shi <shiwanglai@hisilicon.com>

Hi Wei,

Mathieu and me both have reviewed this patch, could you pick up this
patch?  Thanks a lot!

Leo.
