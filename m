Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FB1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70EB20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577484804;
	bh=iZnqzqDa4efObkwi/oGhOaDMX+KempluIoxxYoO/E5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vlcwwrrY1eUZBwVHs99NvDZ2Z26poPEvJvvEteybjm4Oo7fGM94r+Cw8IwLpXlRki
	 ogtO79usbS0tCE1KG7qOSGxHsA7XtIhQRcS9ZF6DJD/hgSDGVoRoO8ShXPY936QlUl
	 NLm8CvA7Ydn9n5XNSJK/WY3yCS3A/ZSxCVYpHBrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0WNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:13:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36656 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL0WNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:13:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so21560920lfe.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 14:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzNDgewdty9+XCRaXDaU2bPI7xNE/bDJBnpHNO7m5MI=;
        b=eXwiGLZOx9BivEyNJf7zzgLYHeRiMJI1uecqF8smMsuOgs+Cx53GMofDb4oWPS3MGQ
         BIGX05y8iL3+DicrPwXvF3BPXyBut0xRzAix260rRPvJOGlkag7p9e2Li+ta+DW4rH92
         vmo8HQ9NZJTCKxHKlc/BhYmbqDJhF15/q1dNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzNDgewdty9+XCRaXDaU2bPI7xNE/bDJBnpHNO7m5MI=;
        b=RzZ48NxduQEcS3NNLwWAwc+ORXZsWTj27Dq5GNsBdgzIJnbtJMFGlS8TsvE7GW49YZ
         465lFPHuW2ar92iSXd55cIhaVySiW57e//5SFuP15X8tphfCDTQ6mqVDwB8ID6WmkfLP
         tdILp+Glitg3U3xq5Kh4ICX8+1y65Lnq3sKpSMLSN+E8gs8Y1lzypoL+R21zrTPM+wv+
         951hfMoXM+IvcJ0pLUwtSAx6HXbY8r7H6eorCRFxa+rWwzAIe2FrzUwhEu7/m2UPx+x2
         c7IpdNh8p9oQhyN5El8dM+d0VPIQp7Y+NdT3ROCYP9PuSOxmHrU6DBThiFD0vY5yqC13
         AAEQ==
X-Gm-Message-State: APjAAAUKoeMhiyNqCq9ZZmMi64yEKhMYv2Pm/2SaH1lleepIEZ0maGhK
        5+q3xa4c8pCScOp5HOQCyk3rnRcgN/M=
X-Google-Smtp-Source: APXvYqy8+kV/M3orb5GoFT0p6jk0LD9Ecb/zupTVNKdksl+7Jj5gnZwAui20QhALHJrpSn33orrmLw==
X-Received: by 2002:a19:ca59:: with SMTP id h25mr29763831lfj.27.1577484801093;
        Fri, 27 Dec 2019 14:13:21 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 138sm15446810lfa.76.2019.12.27.14.13.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 14:13:20 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id y4so13760020ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 14:13:19 -0800 (PST)
X-Received: by 2002:a2e:8946:: with SMTP id b6mr27871105ljk.1.1577484799595;
 Fri, 27 Dec 2019 14:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20191221.180914.601367701836089009.davem@davemloft.net>
In-Reply-To: <20191221.180914.601367701836089009.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Dec 2019 14:13:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpoNwcb2fXH3e=pFjY1Tjb9rHLVjq_q-OzK3FMgvx2wA@mail.gmail.com>
Message-ID: <CAHk-=whpoNwcb2fXH3e=pFjY1Tjb9rHLVjq_q-OzK3FMgvx2wA@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 21, 2019 at 6:09 PM David Miller <davem@davemloft.net> wrote:
>
> Antoine Tenart (2):
>       of: mdio: export of_mdiobus_child_is_phy

I didn't notice until now (bad me - I've actually been taking a few
days off due to xmas), but this causes a new warning in some
configurations.

In particular, it causes a warning about

   'of_mdiobus_child_is_phy' defined but noy used

because when CONFIG_OF_MDIO is disabled, the <linux/of_mdio.h> header now has

  static bool of_mdiobus_child_is_phy(struct device_node *child)
  {
         return false;
  }

which is all kinds of stupid.

I'm assuming that dummy function should just be marked "inline", the
way the other helper dummy functions are defined when OF_MDIO is not
enabled.

                 Linus
