Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4297DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E7220872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSDjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:39:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34869 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCSDjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:39:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id d6so14771615eds.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/n3Bc71ybdvKjIv8WI7Myo09209NBqTF0hrZHDQwAWA=;
        b=J0c0VPH3pa7/x/84PFlgeE6PeAYxm4yICLXg39BMJdUFdubBKsuTfwgLBfG6NDLKxK
         ZAZ3DWlA0L3VwWw2/tw55ZM9KCY0ewr9uHHR54uxmC4s1iex82kxECjDlHYMte1uwZd1
         dxdKJfNKmN82AgcGdahH0euJEbHuy+iBO4uXRS8+EIbUSkNstZNZI4Qesz0FtnWuYq4m
         tUiC2TLWjhTQKCgBTF1K6ANk+cTdHczPB0fjgWMjGNlSEYRPqiPi1lEwtPVEixVadpKP
         PjwfieNdMe5Tcw5iaCcEVEMIpUssjNWjVrlxxVb/ueihOR9PYfWcLNyE+BBIlQM8SgYZ
         SO2Q==
X-Gm-Message-State: APjAAAWGzkFTZnPBVpmjRouZvDk5byyA3h9yUD2iP9GpEF9gr8LM6LGj
        HyYk/br3zNo0JUnUNZlGvjGOrNhWusU=
X-Google-Smtp-Source: APXvYqzmnE4cbZt+P7gVmlJiKBKc/dV7o8Om7SNih309gnh9c9dEtGQ+if3sYRjwFk0yiuAjb9N/+Q==
X-Received: by 2002:a17:906:b749:: with SMTP id fx9mr12996376ejb.239.1552966746593;
        Mon, 18 Mar 2019 20:39:06 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id w9sm3780109edq.71.2019.03.18.20.39.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 20:39:06 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id 33so19367616wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:39:06 -0700 (PDT)
X-Received: by 2002:adf:ec87:: with SMTP id z7mr14622103wrn.44.1552966745994;
 Mon, 18 Mar 2019 20:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190319033608.6363-1-axel.lin@ingics.com>
In-Reply-To: <20190319033608.6363-1-axel.lin@ingics.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 19 Mar 2019 11:38:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v6581B1acmxHcM1VPg7jRQ5jZ_yC7Lu6tz42B2rM2LnuEw@mail.gmail.com>
Message-ID: <CAGb2v6581B1acmxHcM1VPg7jRQ5jZ_yC7Lu6tz42B2rM2LnuEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: axp20x: Remove unneeded NULL test against rdev
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:36 AM Axel Lin <axel.lin@ingics.com> wrote:
>
> rdev won't be NULL in .enable callback.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
