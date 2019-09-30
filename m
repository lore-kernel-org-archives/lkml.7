Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FEC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB582086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDtbmFA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfI3Wre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:47:34 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35442 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3Wre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:47:34 -0400
Received: by mail-wr1-f52.google.com with SMTP id v8so13151000wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vACRy1d50tv2X7tYoBuy2WMfnYzmRtun586RkaFNiGM=;
        b=tDtbmFA+vGE/kC8Lg1lvDkgL8bos67whQ0/OuZbnWVXp5rlf4k4kGKjS/kWpy7furp
         7YSYPgW1J/CLfQK/OSgslO+litCWUx/N+iy2zSduiubIntEnjbSkPb71J6Qv6gkKsEXt
         J+URKlys+oP5JYOtzydpV7vxiwXcl0cYLbUx5sv4HjfVVNpa3VnmovSiEQy+wLvE4JkX
         VGVkbwEY1cAo6B5MH92whCOWqZo0IXpAC3Mf+eLZjynInbPis1TaZjRNZe5BqLPOVnF/
         IRrZrjmUTBG3+wNIAXpwtp+ADN5HB29+1y/oDXT07/6kOrBzHIMBf4QPHzvRnC0Q8Oow
         taVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vACRy1d50tv2X7tYoBuy2WMfnYzmRtun586RkaFNiGM=;
        b=HRd0DXERHBb41oaS9f14pxqOi8XICHZs8umMzuHxVCwWftsTvsxMcygLQnnCqfi1az
         SQ/m2yXwADnyiQWcWDW5ndn+uA0g114Eef7/zOWi64NAh317xHFhsXyyZ/9Esq0buvXi
         gcfhPkczQjIkx1lNOH3GBn4VaEYp0QwkvhfTJcQhJ3r4BZVIjKR5L1Y+NiXvcGKjcXmb
         jnohN8ytP0i5+OW7Kxdau/gFj75W/rHUOq1kgHj5hRjblT0Hok9gdzK6nEF+moERgsqV
         1Xs+nAcmsHZ97V0GOpQ7xu4hLyQrzFatO23j+Guybxzvig03vFSbdsTuoj37JGGBBzBU
         6OYA==
X-Gm-Message-State: APjAAAVOs5rlWMrY0b5wJfVbk8nU5HYCXdsnoYtqAWZv9UpbXZ/SFGjd
        3MK/1rpZdDLBFhdZ03pb+c8oj/YtRlZG7C4sAr7P1Q==
X-Google-Smtp-Source: APXvYqzXp18FqD3gNqmWnCe4DCapImeolM/VKTXIf0yx9PedpkM/NKo3v3qJC4v0Z3I0EeP4w4KxsBtjXiaE8g0D6NY=
X-Received: by 2002:adf:8b13:: with SMTP id n19mr16093705wra.203.1569883652914;
 Mon, 30 Sep 2019 15:47:32 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Mon, 30 Sep 2019 15:47:21 -0700
Message-ID: <CAGRSmLsV96jK+7UB6T6k8j9u74oPSHTA+1TPU8F9G2NnOqCDJg@mail.gmail.com>
Subject: What populates /proc/partitions ?
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to find out why fd0 is being added to /proc/partitions and stop
that for my build.  I've searched "/proc/partitions" and "partitions",
not finding anything that matters.

If udev is doing it, what function is it call so I can search on that?

TIA!!
