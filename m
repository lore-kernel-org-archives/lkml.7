Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B78C04AAA
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3A0206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 01:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JxhfTMnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEEB2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 21:28:25 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36774 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfEEB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 21:28:24 -0400
Received: by mail-yw1-f67.google.com with SMTP id q185so7572939ywe.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2otJGsHwkb3bMNHmlrt86miIvaLDTlDpTJs8h69fY9k=;
        b=JxhfTMnbWRoOHCOUk/H+0boBBwK1HWTT0HZFsJweoqU4b4GBnnp+GQ5OVf4JNfg1Yt
         v2h9iSU74OGnfmIDHmo1nM80H7+pQvBvj/xuXBkEIHGYVXybXSH9e9rAQqbuY6CK76vF
         686yvgWB+Sc6PuXSlHT5Dcr00FPjG/OV2WtX6DKpu1jNyvAsgKMP60rLr0xTS9q71w0Z
         DJoeWiOlLDlCc87tNnaK8h+ErZr4gfVXMKfwHQ4EB47DoDBI+E/HAXihxEzeaqB9NNCM
         /Yv67vyrQ6dItsMU3l4IvoNs7WKll32XcSgecrV18xOKyvrbcB74zw4KcIK9hK2z2VAB
         hw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2otJGsHwkb3bMNHmlrt86miIvaLDTlDpTJs8h69fY9k=;
        b=IqKgoeoE8NgjNU4ufWEc8x8Rc8lN5t2Rcw4jaJfFqJMlEH98nlc4l5gs7MSWmNGp/O
         aCcMo5wa2sLTzURik3XbNyAI56yikvtqlMEwlADBtEdK9d3ze7Of2GOwuWp+qNiqw+mu
         sgAW6L9W8F5EGcIiCWh8n9ibh+ko8Wt8hKLO9TDSlMBkcHhjNq4DJpseIfkSlZKg7ET9
         ea2SEuBkG9APGNNeMoeKIm9io67moXNUZgLciEZ/SKefGKe3DpO1VlJgqrdQ8qZv6njz
         /aXIdmfCK7IWYaB0dg8/+neFRqitrkSV1+Oc5bMWvXZbSll89z0wqa0k1bkAQHBUBcBd
         M0Wg==
X-Gm-Message-State: APjAAAXqC6Uo3cyaaOutHEUBefMG0EnXvqZlWZKNDt4b3Z1KDd/3/nff
        HX1LLtlWVIOAMxLiZo0cvtt/u2mycYc=
X-Google-Smtp-Source: APXvYqz7Z9HZlRm0+fIdfo/3YxyspUpGDcHqYzE/lSefk4LuGcWQDBJSRzQ6K2CZ5K1h8oOvfmrEow==
X-Received: by 2002:a25:6104:: with SMTP id v4mr3581702ybb.450.1557019703548;
        Sat, 04 May 2019 18:28:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id a11sm4034363ywh.49.2019.05.04.18.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 18:28:22 -0700 (PDT)
Date:   Sun, 5 May 2019 09:28:15 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shiwanglai@hisilicon.com
Subject: Re: [PATCH v5 4/4] coresight: funnel: Support static funnel
Message-ID: <20190505012815.GA6229@leoy-ThinkPad-X240s>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <20190412102738.12679-5-leo.yan@linaro.org>
 <16ae9127-b282-e6b8-3a6c-5165c8618bb4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ae9127-b282-e6b8-3a6c-5165c8618bb4@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, May 03, 2019 at 04:11:50PM +0100, Suzuki K Poulose wrote:

[...]

> Given that we now warn about OBSOLETE bindings, please could you fix
> the existing DTS in the kernel source tree to use the new binding ?
> Similarly for the replicator.

Yeah, will do.  Thanks for reminding.

Thanks,
Leo Yan
