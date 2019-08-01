Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D5EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ED320B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHALrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:47:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40672 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfHALrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:47:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so35457713lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjmvCfksO5i4OgPdHptucLhtzAqpKuPPbM9IMLKAEX8=;
        b=rJERcwpwndAo48rtmfYX2Qo4M0Fp5hj9pvDQNj0ajqNjSYlxbw4MyoH9qsOhsEPKbJ
         um/DjAuX1Nb/o3/nKOOfqwuHFdjSna3PWDqCbK8SLG6SY/9DhQ1deRPOD+HWmFUT331q
         n1/YbL3xvRedCXs7PU3YeFJuivBoGQGJIJhuNJDIla6DsuMqikBmERB4jAUrFS31j5xS
         or7f8KuO7EpotoHQHX2QMSbmq9F8EkDIC9xBhlKAI2XlMCWhJhSbKVesM16yI8QQFPa7
         EurQHgnuEvzJMpg8dTRr61/kf2d3AopudhyV3BWeEAOmuITRoCEJTanhxwgg+wDgy9RO
         5kuA==
X-Gm-Message-State: APjAAAUNgduQ3woVM085AGTqvgiY/KoVaRDdDFQVpVJ66veVZM48PrMJ
        J4ARevyhMZsmknXViYSzyhUhywqSI6ygwyaPIQ8jfQ==
X-Google-Smtp-Source: APXvYqzUmKsMptn1owkPtGVZ2cOYw1oDcBkPsCahi9gmMdekV5W29oI32q6fTgnFRW7p/WoxZoXccmXgZ/bRHJED5Fc=
X-Received: by 2002:a2e:9643:: with SMTP id z3mr68846819ljh.43.1564660034911;
 Thu, 01 Aug 2019 04:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190731183116.4791-1-mcroce@redhat.com> <20190801071801.GF3579@kwain>
In-Reply-To: <20190801071801.GF3579@kwain>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 1 Aug 2019 13:46:39 +0200
Message-ID: <CAGnkfhyx7MHaG=YNhS7VrzsBqhVCPw5VeHPM7SFpiLeq3cb5Gw@mail.gmail.com>
Subject: Re: [PATCH net] mvpp2: fix panic on module removal
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 9:18 AM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> Hi Matteo,
>
> On Wed, Jul 31, 2019 at 08:31:16PM +0200, Matteo Croce wrote:
> >
> > diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > index c51f1d5b550b..5002d51fc9d6 100644
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -5760,7 +5760,6 @@ static int mvpp2_remove(struct platform_device *pdev)
> >       mvpp2_dbgfs_cleanup(priv);
> >
> >       flush_workqueue(priv->stats_queue);
> > -     destroy_workqueue(priv->stats_queue);
> >
> >       fwnode_for_each_available_child_node(fwnode, port_fwnode) {
> >               if (priv->port_list[i]) {
> > @@ -5770,6 +5769,8 @@ static int mvpp2_remove(struct platform_device *pdev)
> >               i++;
> >       }
>
> Shouldn't you also move flush_workqueue() here?
>

I think that that flush it's unneeded at all, as all port remove calls
cancel_delayed_work_sync().

I tried removing it and it doesn't crash on rmmod.

--
Matteo Croce
per aspera ad upstream
