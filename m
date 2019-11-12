Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE81CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D4721783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573535880;
	bh=+sjdYVv8CDJT89mCUOL1IQ+FuBUStP5YIxV+BRhizMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RA0QbSgvUcBL4U/WsZIyDq61xj/SGV4+cnZa0y73i9zQ7a9t0voT4z3Q2lnmPSvdr
	 GYzAbz+cOMczz5AHBCZtLkOuK0Dd+DM8q/eVLLJPshMA1MJdAZEVt8SJD4uvANDV+T
	 1ikuQgP2W4Ad3amr68JtbtXvgyd9KVAy6LtzDHzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfKLFR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfKLFR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:17:59 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629E021783
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573535878;
        bh=+sjdYVv8CDJT89mCUOL1IQ+FuBUStP5YIxV+BRhizMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwabfAw/3h3DTKe7ptAw21A+aiLqSS9Yxtb7Av60cvCyaX4JpmVRVRr8OsqAf4lNV
         QEz7Mq+KHshF2+zP6/N541Gce1O1w8RSqjiJso4xEz746D4OsJ0PWU9AL+EsC4yve/
         7mPCYSMKbwQdGzxYkXiLnR/LlvpOcRHS0co25vjo=
Received: by mail-qv1-f45.google.com with SMTP id c9so5884916qvz.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:17:58 -0800 (PST)
X-Gm-Message-State: APjAAAVseOsIPduV6i6hCBBs0xyEEIT4ucxkABRnbEzRk2j9+IKvdMA0
        mG/I2Ye2ibj8EwUqqZ7zEuLqsWCzJQy6SNu9ba4=
X-Google-Smtp-Source: APXvYqyRMq8MPHBbv10LcomZfNYFYesotjA4C4S3ZUC/cErDRyyFxBF01/9DX6UFwCBG6keYQ/6e7NX4CI4hPzjyXJo=
X-Received: by 2002:ad4:462d:: with SMTP id x13mr7948364qvv.105.1573535877525;
 Mon, 11 Nov 2019 21:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk> <20191108130123.6839-5-linux@rasmusvillemoes.dk>
In-Reply-To: <20191108130123.6839-5-linux@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Date:   Mon, 11 Nov 2019 23:17:19 -0600
X-Gmail-Original-Message-ID: <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
Message-ID: <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
Subject: Re: [PATCH v4 04/47] soc: fsl: qe: introduce qe_io{read,write}* wrappers
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 7:03 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The QUICC engine drivers use the powerpc-specific out_be32() etc. In
> order to allow those drivers to build for other architectures, those
> must be replaced by iowrite32be(). However, on powerpc, out_be32() is
> a simple inline function while iowrite32be() is out-of-line. So in
> order not to introduce a performance regression on powerpc when making
> the drivers work on other architectures, introduce qe_io* helpers.

Isn't it also true that iowrite32be() assumes a little-endian platform
and always does a byte swap?
