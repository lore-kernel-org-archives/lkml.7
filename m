Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB48DC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8404F217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFhfY+Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfGPSnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:43:11 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:44828 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfGPSnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:43:08 -0400
Received: by mail-qk1-f178.google.com with SMTP id d79so15390972qke.11;
        Tue, 16 Jul 2019 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v/ru8PCEpq1AM6FsIwq0TZL2+3wSw+IOUeVLbviNldg=;
        b=pFhfY+Z2ezl0RTxORAgJttb02+aWblI0YEmYz9CiOMxGO2CMnWt86p4XDnGiyJaz+7
         9Zd9frULjDwX/L1oqkCuqUoOpA+xJNKipH/U867fu2aXG2JbMFSoH8CbuaSUhW6WqoJp
         FA3l6I6hslDbdcD1AS6IzdwIwqnCBZ/pVHqLbQQD57C4Yhgs8OmX3BccAEtQwuYVr1s0
         hzNR6GEiuoFpthgwOfD7vr31pdlVrJemo2f+cFlrQdioe2x1SkEFjNakuJM4tzOl+vrC
         CQWhrFrOeE14c+GqFOLhMFQpfxUSCvSFCh19V5+GROWpgVsgE9sB+iz1kZZ/Gyq6JHtD
         Wj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v/ru8PCEpq1AM6FsIwq0TZL2+3wSw+IOUeVLbviNldg=;
        b=TBbEWl1YMFPKB5MPvJ3KvciQ52B2kp+qM4dO5C+w1yr9CEKHCtGwHZ/kAMWW8oKdBW
         edbC3xGkcpN1EMvJUoPNWor43PeKw/QXu6O5g7AiKiF2pk6Bg12nz65yL3Ch6tpbNtxx
         FdAtjAyG5IGRMnpO4dOyU4CuRoGo/ekJ/tZ91qcNcv5n2iTM2Vf41bWch7Ec+AQXMZMs
         tTTSs7E6JI1QVtruGujMnEsPkexlb4MgIibussI/NMBouHdahZvaE46kKdyVxjM5OqEk
         5VzUxm/oEWZghsgg2lBcHxejz1ms3Uw0OP2dupb6SkXIi93OVW6kjfzuwvRiMh4h+7QF
         orBg==
X-Gm-Message-State: APjAAAX0lsSCVbTxky41dj8DyXgNy8/ozYSvXJL6X6CZO6wVDNFjb/XO
        FC5IjNGiw6PwCQEtZw7OfJwEA2/p
X-Google-Smtp-Source: APXvYqxDtiu1cKr8CTvdOeKG5ejpiA6DO0r3aRsxVxHzSirVyVUZI3Bn+LDonDFYpcHvrU5n5bl4Ig==
X-Received: by 2002:a37:4a49:: with SMTP id x70mr22585277qka.375.1563302587002;
        Tue, 16 Jul 2019 11:43:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id h26sm13475265qta.58.2019.07.16.11.43.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:43:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6C0440340; Tue, 16 Jul 2019 15:43:02 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:43:02 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] perf script: Fix --max-blocks man page description
Message-ID: <20190716184302.GB3624@kernel.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711181922.18765-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2019 at 11:19:20AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --max-blocks description was using the old name brstackasm.
> Use brstackinsn instead.

Thanks, applied.

- Arnaldo
