Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47B0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E9220675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PosPp5gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfD2RHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:07:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43086 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfD2RHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:07:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id k2so10046562lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s/4xwtUG/cKwNNv3hBRVLGCWHejEs70XonImzRvFPlM=;
        b=PosPp5gys1RLkjRFXyznCdadARcWawPbjUCapw+0DkAT04c2KewGwgcUnjlQPjN4EL
         Pay6WfEsAorzRzfqjbxpQwvhj+S6BsCkJF1Aj/M7GgT6fkrRBhxeSA8oQjZ8MnXNL55g
         RcXAyp/5LNr1zxaGspstUvCDRo6tzUVhBjojVUxEfZvVacIgWEPLpZNp/d7jQFI1fVyB
         jBmHyMU4J//xSQYjFgUUPZEDvadZ7Oymss3hEzQe0vrYoc0kpB0U+sL01MPGVQkfIHFK
         srUoGYSDVaayKysYH3dUnnNa9FdgeyiUulCNS3sfKykmFN0ym3aA3t+xY8MOVllZWGAX
         MHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s/4xwtUG/cKwNNv3hBRVLGCWHejEs70XonImzRvFPlM=;
        b=jWE1F6QtCQ9nry89eFgQsy+FU+3LuLb2tlS/V+dLw6w/Bpx0Y9PNrMVlfD4ATd1Vcp
         t1ZUWf4cpT8Sn96ImkvyV5Lt81qaOCAaLXjosPn9dWZBBJjkJ1ong2xEtbXVMQUzlx9S
         W7ZEgoulI0pdljSP2tRudm1j2coXuUxrp0mqfdPn5bpGjx7AQs1wMcInIRT1RlKHjm1C
         TOIKt1JZwLhaPif37Hzzq9fjHoZO2Sm8ts4Hpzv4H+ky6fgNcfwGquDvDOmMbVoI/3QC
         VIOaiY79z0f9o0CFFOnpkds1FP01z4ABpq1fUyl1Dmsit6TsnxpKF16zJjGnKEy7ScBo
         04kw==
X-Gm-Message-State: APjAAAWksalN18ji+jvJ3tvxSXsvUzJoqJy5AXgxis5lyYvUOapzpXk5
        SwWhteNReE0d09RlXU2rYsj0mJApdbfyEuMq
X-Google-Smtp-Source: APXvYqzoR8001nycqA47aAwHYB8TFNG6jxgEY1mY9b15Zx7v+/BxfcA4dwe4+0Gp70CAao/rEQLNXQ==
X-Received: by 2002:a2e:9b14:: with SMTP id u20mr14356452lji.67.1556557667904;
        Mon, 29 Apr 2019 10:07:47 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z17sm6926179lja.26.2019.04.29.10.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 10:07:46 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:32:29 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Patrick Venture <venture@google.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>
Subject: Re: [PATCH] soc: add aspeed folder and misc drivers
Message-ID: <20190429163229.ibeny5r4islxiyrp@localhost>
References: <20190422173838.182736-1-venture@google.com>
 <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 10:08:11AM +0200, Arnd Bergmann wrote:
> On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> >
> > Create a SoC folder for the ASPEED parts and place the misc drivers
> > currently present into this folder.  These drivers are not generic part
> > drivers, but rather only apply to the ASPEED SoCs.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> 
> Looks ok, but please resend to arm@kernel.org or soc@kernel.org
> so we can track the submission and make sure it gets applied if
> you want this to go through the arm-soc tree.
> 
> If Greg wants to pick it up, that's fine too.
> 
> Either way,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to the SoC tree now.


-Olof
