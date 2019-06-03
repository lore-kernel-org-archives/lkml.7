Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E9FC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F4A24A87
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ga6bafZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfFCIE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:04:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43456 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfFCIE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:04:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so1161666qtj.10;
        Mon, 03 Jun 2019 01:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RfaSV+pbk7w6/znlXv1qGSq++xp8hdtnx0rwYlptGts=;
        b=ga6bafZCmHxDV+BcmEwAaQsBBlEZkPFYGOsxhVLqSVdLrMiD8VQTGepUAJnHL2G3wY
         Aji+SLUEIuw0MSIMC3cBG6nJMELOFarVv7dHMqaO1WN8vDLzJlhClRQjA9PX9dYnQY77
         ZTEMJ4wNAzhm4f9EYkjt8OoYi9gVeLbnydEao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RfaSV+pbk7w6/znlXv1qGSq++xp8hdtnx0rwYlptGts=;
        b=S7qnVrkgAYDY+qPNGEh56Lrall5xKE73DA0EtUbRhz/idJSQYO46KPZxiguyC9H3FN
         VyA487ZlQ1PmcXDYfwdFqGt2GYTdtd3XA/jKxLsxB3/wqj6ePLlPhGoAeIYtGAg2VPNv
         RYjbaW8FSpSA9IUcozvb1003saD5lTAgYJBHE4WxcRv6IwAfaTvkUa35tFlISSHV17sO
         0v2BVE30NL1EaWgTdZkIi9IfOcQG5FyvLDo30PtM1w0pz1l2D2buSmiZ4jGqWDEowleW
         MOXDOxG61KIQCaivzC0HiLtWt5N1luYz6MgX4YbL48yNg//VSr2NXQvcVPSCIKZgKyDe
         /ZNA==
X-Gm-Message-State: APjAAAV3zQW1MKFzkt9JWCiWpciskUbNS9dBGg9qkGVUpNXafKsgxqDm
        HEktJZpdb2UJT2Lv+XQ/DRQhEidIQ94UtNZHXj0=
X-Google-Smtp-Source: APXvYqzsF073EvPFX4Takz8KWZ3H1JBY7zZTMY9VElYM72O2DrEKUU55vAn2In2dlmNN7QDVZrx88Z1tiSxYiMYUjoU=
X-Received: by 2002:ac8:2493:: with SMTP id s19mr1721030qts.220.1559549097905;
 Mon, 03 Jun 2019 01:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190531090950.13466-1-a.filippov@yadro.com> <246c9b25-1c05-4c2f-9185-c438c97ebdec@www.fastmail.com>
In-Reply-To: <246c9b25-1c05-4c2f-9185-c438c97ebdec@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 3 Jun 2019 08:04:46 +0000
Message-ID: <CACPK8Xf9emq+rYjT=O8kQfc-oMcKZwAwXwZ1bciDr+R3CyWz+g@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: dts: aspeed: Add YADRO VESNIN BMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "Alexander A. Filippov" <a.filippov@yadro.com>,
        linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 01:28, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Fri, 31 May 2019, at 18:40, Alexander Filippov wrote:
> > VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> > by YADRO.
> >
> > Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks. Applied to the aspeed dt-for-5.3 branch.

Cheers,

Joel
