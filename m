Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECEFC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F2D2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 05:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Cx17dLra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLZFxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 00:53:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34845 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfLZFxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 00:53:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so19185984qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Dec 2019 21:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=cLzbJhpD5Hwr6N5MywLf3Xs4c3eeLRB2SD3vQXIQzSw=;
        b=Cx17dLrafYJa5xPSv3lVV3wzk31qC+KuZ6fLVcFnXa4R/jDr945lUBLfgMMNqesPO2
         bbPvceUrbeuHpRJbs9gPFRRoCA3Oa7L32NITAvVcWQxV3lOjAmjxzcCijmWuHrVv/bDW
         PN5o0PsuX/Z0BmPbo7U3DJ8oJwNvMZ5E2vCiRJTRLIakHip1+ffnlDToeZArfb2D8UZY
         HKUa3kDwmYWMMpP+SaXltEIN/aMU8P7De+gA/OYTrJ6JdnYzGhIRTyk+Xe74Qy7usL7o
         XcgSwW77eQcilqJDF4qeTna4Rea8G6Q/hH3MQTg6q0KnSj3njHUUzKf+GVDYo9vuGQ/M
         HCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=cLzbJhpD5Hwr6N5MywLf3Xs4c3eeLRB2SD3vQXIQzSw=;
        b=ocDhrkEib2IZbMXnYTgm3mxljpnoeJ5b/Un4ZkEWnHSCYu1npB2T5g7ECUAxqXqrgf
         LBVscIj3iv5sasBK8sZX+G2M/P10grX+BsTC/IMmF+DPdD5k6W2tfTxslHWNCx2PblTk
         UAG3jQpBitVZq3MMGBxmLxoxhex6ihP/PRwVtb84rLOG4LORGBpkg6gevzDTQfCRSWjU
         wLt6uloSkfIYcLq0wQk48+3r+OXWCm7NVyHxX3khS0mPg9SziviV/HnAsSIjrKnbiI0D
         doGrW/2T26TrnREYo0AZj4srgD/IoweTg1sHTU4Dd5/nKle954eHM6msmyRvCebh5NUZ
         IKZA==
X-Gm-Message-State: APjAAAUt8GCpKxQwaQgr32x6PiarGgawnW7vKNGFMUCzWHx4bymBqEsW
        w7iFdeOdrC+GawhEcBid0pNcNw==
X-Google-Smtp-Source: APXvYqzdbAALcUwCJ//wHxNu4rEzRWBsEQ9+zVEIJE8/RNPfGM5mfTkwmvfYkpkDZDHTnScUlnklKQ==
X-Received: by 2002:ae9:c018:: with SMTP id u24mr37176052qkk.339.1577339609314;
        Wed, 25 Dec 2019 21:53:29 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t3sm9253977qtc.8.2019.12.25.21.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Dec 2019 21:53:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Thu, 26 Dec 2019 00:53:27 -0500
Message-Id: <95CD23C9-D10D-4E6A-BF53-A4C1A4DB281A@lca.pw>
References: <20191226040114.8123-1-miles.chen@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <20191226040114.8123-1-miles.chen@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 25, 2019, at 11:01 PM, Miles Chen <miles.chen@mediatek.com> wrote:
>=20
> That is what the patch does -- targeting on the memory leakage which cause=
s an OOM kernel panic, so the greatest consumer information helps (the amoun=
t of leakage is big enough to cause an OOM kernel panic)
>=20
> I've posted the number of real problems since 2019/5 I solved by this appr=
oach.

The point is in order to make your debugging patch upstream, it has to be ge=
neral useful. Right now, it feels rather situational for me for the reasons g=
iven in the previous emails.=
