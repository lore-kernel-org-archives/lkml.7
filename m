Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FAAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D8D217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaFcRTb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfEJWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:10:48 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35650 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfEJWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:10:48 -0400
Received: by mail-ed1-f43.google.com with SMTP id p26so7082812edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/7iP1H8jYHok11EpsySbjHdSiWJmN/DYdow4cCNPHk=;
        b=iaFcRTb8NE/xMUnQTsGtMWCw+XwDqzZG+lcCVCefA4TBalJzpJulM3dp/IMHguz4br
         brmf9YEFE7R+kqkRX4BMpv7gsO99FnBsQpifxWEx3mGsPkxXz6dGhnwUPJjvYhbUaJAC
         0A4Ez8M/FTZZtKe7tZRIsNsSLg1n758mhS8WhlWGKlv8rYTK0HcDoo+sz/j/rpmsSB1b
         7he9O7YEPLqhuDgT7kI2H1SrSxSjBucf6iESC9L2jIfVWKNFn2LzhUW/EWFhiwexUrgD
         xTG3q4IpshinBR3qfusjfvhNH9UYD+vY/nwGOZWPs1AeaiObRKb2rrjMPVDMAFLztLlV
         zMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/7iP1H8jYHok11EpsySbjHdSiWJmN/DYdow4cCNPHk=;
        b=Lw98NKX8Y9ZSR2X0ZKSq4Ri+MlvgEXcM4/v3ysRWVcoeO8v+oeNa098MwP5jrbhKm3
         x3S3sqQ+Rq8+YYT2I5ZoZHZuLsB55rqxeFG7XD767TLe3PInq57K7rTw7x7wUUdxBvJp
         UJba5VhvFu4EOqYemb9uUI/4EeEUlfzC1Xb3XGJVT/iJYAqj0K6TyfhczEq7phhudqc1
         W7fZQXMHPPWDRu7wbC7bQynjCoeIipFWRT3KDaI17nNkpzM0Qx0PU211Ekc857BpKKON
         cxixuIU1PjuCdT8vj8fnGV4xur6I1cmR+WkDRMHoXt5F4VbzOW/k8t57t8S/o1iVlyal
         fUtA==
X-Gm-Message-State: APjAAAUOJ2daO20sKHHdsBtIR4VkKOyi6aByTwMIg8q3hqfSjcct/1RL
        5S/snEqLx9X7arSqku2A2j64VNlV
X-Google-Smtp-Source: APXvYqz4cYPXx+WlMWe/0b1npGHEEdd0defXqIa42bIFi/GG2md9wfXhzCZBgCV51VpVfDc8k+FPYA==
X-Received: by 2002:aa7:dada:: with SMTP id x26mr14074256eds.77.1557526246802;
        Fri, 10 May 2019 15:10:46 -0700 (PDT)
Received: from rimwks ([2001:470:1f15:3d8:7285:c2ff:fe37:5722])
        by smtp.gmail.com with ESMTPSA id b42sm1767557edd.83.2019.05.10.15.10.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 15:10:45 -0700 (PDT)
From:   Rozhuk Ivan <rozhuk.im@gmail.com>
X-Google-Original-From: Rozhuk Ivan <Rozhuk.IM@gmail.com>
Date:   Sat, 11 May 2019 01:10:43 +0300
To:     Robert Wing <wingairak@gmail.com>
Cc:     ossobserver@redchan.it, linux-kernel@vger.kernel.org,
        misc@openbsd.org, Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: Re: Danish FreeBSD Developer hates jews collectively
Message-ID: <20190511011043.35a09117@rimwks>
In-Reply-To: <CA+3BqY0Jwx+Qjj41L-zfx5WkM4VvqtKLb7mkODW-Z68j+E1VWw@mail.gmail.com>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it>
        <20190510073249.73a17721@rimwks>
        <20190510182231.k24xb%steffen@sdaoden.eu>
        <CA+3BqY0Jwx+Qjj41L-zfx5WkM4VvqtKLb7mkODW-Z68j+E1VWw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 08:56:48 -0800
Robert Wing <wingairak@gmail.com> wrote:

> At the cost of sending more spam to the FreeBSD-Current mailing
> list...
> 
> I'm posting the following excerpt taken from the FreeBSD website as a
> reminder to those subscribed to this list and who continue to spam it:
> 
> "This is the mailing list for users of freebsd-current. It includes
> warnings about new features coming out in -current that will affect
> the users, and instructions on steps that must be taken to remain
> -current. Anyone running "current" must subscribe to this list."


Im not sure that freebsd.org is tech resource after it apply CoC.
