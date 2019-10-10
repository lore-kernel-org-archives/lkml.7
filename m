Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC65ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0072220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="g27litSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfJJXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:43:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36534 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfJJXn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:43:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id o12so11335237qtf.3;
        Thu, 10 Oct 2019 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+99LfkE0Ayp8m1IDOU4Gz0njgEWkjVrScr5OXbe0ExY=;
        b=g27litSgnBG1fH5c8FdwvHHIU8jfoU7WkY4210zjf7prULOHqvPkg0y/kFCN8MqBrk
         eur+7x4q+axYsgRyrUBbB0PxrTYmKzpr6/MYZgdhNheCn4BlgugL5Xhr3XOqMfgGTvf+
         eqBcOiU1wVTRLrXdkllD4uDaYSWfaFJN1F7WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+99LfkE0Ayp8m1IDOU4Gz0njgEWkjVrScr5OXbe0ExY=;
        b=tEOQqAL5hPOY+c9ez0BQQPesLdEa2xpZEqGRoydv3N4R/Q76Zn9RaCLxH/I33ZoHQN
         gGCfIEi2xsZSrx2nv/bJOHClB6lXaRffXRfgwWFFPZguPG/6B3XWmgKWFyeDzSvc4bQn
         PVJWibFn56MNCwmZE8Vq1ThCVTt7c3bYyCZK/oDUIMGziPw+nMCyVnkO7c20BG8hete6
         RMV3F/Bk8zDei6V752OJcJQ7h3rXxH5A4ZC5vx5YsdZ4sK+JN8zVEcNXTaUMrBbS/Y3z
         /NsJbbW5j2ZYciIysBXo7RnirMS3/WRW91GbFMsTj3vRMZCGRwIT5W15iamd4MiJ0iTJ
         0MOQ==
X-Gm-Message-State: APjAAAVE3LbUdJ9mJbq4qYV9TErhxiLSB7Su3iNltMB6xvLz/g3ZuruZ
        BVXNVSv1xd6OjXj80oPNycE9BY5g4sI5tyWOknw=
X-Google-Smtp-Source: APXvYqyKAUsDXXorfPQ38wIFUSbSjZKAetsJg1J3PqJn6MQDhqsbpGCV86yHgGv+eMYgGt6cxc2ZBkuC/GpIyIcn7pc=
X-Received: by 2002:a0c:f702:: with SMTP id w2mr12680741qvn.111.1570751007441;
 Thu, 10 Oct 2019 16:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191010020725.3990-1-andrew@aj.id.au> <20191010020725.3990-3-andrew@aj.id.au>
In-Reply-To: <20191010020725.3990-3-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Oct 2019 23:43:15 +0000
Message-ID: <CACPK8XcfNWkv+iiR8xFfDV6puvRpJUAsSMeX0rPe15+N_X75Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: ast2600: Add RMII RCLK gates for all four MACs
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 at 02:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> RCLK is a fixed 50MHz clock derived from HPLL/HCLK that is described by a
> single gate for each MAC.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>
