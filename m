Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA53DC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B368C2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="le27mUD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfLBNdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:33:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfLBNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:33:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so12238528wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 05:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z+QGY7jr44pYxe54+7M8En72VvMMFxWIK2gqrMhHkc0=;
        b=le27mUD5UzEV0sC6F+c2OWBzFaCE/ZZFIDGVHEaMHQdzCZ4pKSL6hu1C/MTBt3Baz7
         XZ5hEl18r+IM/w35GemiYipJGhyW+W6zAYo/fV2aQN4d+/ugKQ3hOVK4mc4MrlMCt69Z
         6AImhqwukeBqGJHM7m3vIshhmgyiNfvs8LBgpYdPRrsoKsFsFFxYka93um+o7DBBkez6
         sjfx9V0wKoYfNP1qza7FpXhtvveHssOCpsbi6q+QeIFc7w+/bBF+K1O/oowkekvNic0U
         ozb5hhWTYjrBNsj19K+USAL/YorGBXuM+haGGDsyMoDAKYsGX/QJ0aTUmNdNY9r986cW
         bnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z+QGY7jr44pYxe54+7M8En72VvMMFxWIK2gqrMhHkc0=;
        b=f7QvY/p3dqa9pfFMjQtVUBQDwTlpb5y2BEoJ8eJ85K92fuQbdBtNPoTJaoTjVtmaBl
         3QNaB0+FdXClqZlIxvmkba0z/yGKjUrIobe4DCo3Wu00Ha81fVZneOjkD3tH0LXUNmrb
         tF5GXlrtBfB4Ir3f+PHI6i5ZimyBJL1SeLFmkVhQHgFmm///TOExyLjQU30VgwMQ85+U
         EdpRUEuQ8kpN299SUsIM/71sqA7jqEFrZSdQa2AJGE/GxNlRVSm7jyWUwL94TQC9mJ4u
         SIs8j2wKeUPhNDFyzL6Uuol1bHhrDuzST6iUfKhoJuEGwEdvG8aPJtD84TZ40FwTODAs
         iyWw==
X-Gm-Message-State: APjAAAUfnULwaVDzv2Zr9ORNIOOXnsWPiU4SqFZXjIY0VCX0qk71mKDC
        QT1tNgJZDvbY6CHtf+tRG8JTcQ==
X-Google-Smtp-Source: APXvYqzXLdveSYJmzHMioR623raAZQnudeDTjtbXpxlDpAqRENKmsL2huGVsIN+qfrtE1GNKlFMp4w==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr27621576wrv.364.1575293577633;
        Mon, 02 Dec 2019 05:32:57 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id s10sm18753106wrw.12.2019.12.02.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 05:32:56 -0800 (PST)
Date:   Mon, 2 Dec 2019 14:32:54 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] agp: minor fixes, does the maintainer still there
 ?
Message-ID: <20191202133254.GA21550@Red>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 08:14:40AM +0000, Corentin Labbe wrote:
> Hello
> 
> This patch serie fixes some minor problem found in the agp subsystem
> There are no change since v1 (posted two years ago)
> This is simply a repost for trying to get an answer (gentle ping 6 month
> ago got no answer also).
> 
> Regards
> 

Hello

Does the AGP maintainer still maintain it ?

Regards
