Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90206C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5322087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMVUfEE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCQQH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:07:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39166 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCQQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:07:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id b4so11092881oif.6;
        Sun, 17 Mar 2019 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVpnvbaFJ2G1TnnFgwXVlajGfkq6jkzEOBnMmrgWz3I=;
        b=NMVUfEE6liUcGBqCe94xlvG6ftb6PoUlsmzAxby6KS0Ef5aOei/ADRSvKYyDm1q7Ev
         BsShAL/ZVcgxXA+mEHMiZS23Z4z5xSnrhHG0uK1VOYB6UV9ikV9JfQfmWnGnMXss5QNj
         +Stx5wLpe6gE7XV8jbFeh5BUocnjmZj3sF6D/yUlO+/z0Lbryfgv+ss2GVFmwIkIrtGz
         +Zi2NXuAl1zhTUcUuconz5uz6TzA08IIoYnHtzc+YzBgT0Or/6g3DcMuzQUQjW1/2Yr2
         B5mCu2ClGkJ/TAAFNm/USyC75B/d8cU046SzetD5ED9laUTtP91pEHrA2HWNN1u7MsHA
         ks7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVpnvbaFJ2G1TnnFgwXVlajGfkq6jkzEOBnMmrgWz3I=;
        b=IEvdJ7GN9Iwap2lhIqgFN3Qpp8Q5OpEyvqnE7+47uB+dWeUDWR2A/AbDoQhEMSMViT
         DSpKnTgYCPowBOCzb2dl6HyCp4v/Tn6ldPhlGklpMXYbg3W7AsEiaQt/XY/6k9mgThwI
         D0ioOzidI62q6JxpbP/ifjyFQDSmxm1djQa8cvacg+F9Bs/TNFF+rcg2i1avlE0J2ZEQ
         F7cgb/OPZStfwHdowKDaJo1jJp+yZ1KwJyd9HBX3dV7Z5ZbsmRn01akIitc9O/MOeUGy
         XB5uWpOuAvFch+39jus2tR9i2FHlSppv1MxveqUgvJmtdVfsmMf66aBhiHBapaJCXgiF
         iN0Q==
X-Gm-Message-State: APjAAAXM5JiyWv42X8pZPtZA7YFKFKX7FkR+2N5IazpujumCYXpW7vmx
        BP3J1CkWgs7HOm9pUqGhlNn8Os4aTX/ps9RTIMI=
X-Google-Smtp-Source: APXvYqzS90z1jPzZ7XyI8AJKYo33hAKc46zFDGwfq/6mow9lpSq7gG6kDDBoag84+WCH2rAPa2JKmVZOfjIMrvD5Qkg=
X-Received: by 2002:aca:5747:: with SMTP id l68mr134939oib.103.1552838878378;
 Sun, 17 Mar 2019 09:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190310185826.25916-1-TheSven73@gmail.com> <20190310185826.25916-3-TheSven73@gmail.com>
 <20190316155128.16ef1da1@archlinux>
In-Reply-To: <20190316155128.16ef1da1@archlinux>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 17 Mar 2019 12:07:47 -0400
Message-ID: <CAGngYiW8=0aA=oAvB+e=DNVAijyf+2G2zVXj_DX2uNLvzLbYFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: xilinx: prevent touching unclocked h/w on remove
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:51 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Applied to the fixes-togreg branch of iio.git.
>

Thank you kindly for taking this patch set, Jonathan.
