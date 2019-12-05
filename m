Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008C2C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96E92464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZX6PGbbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfLETTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:19:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39578 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:19:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id d124so4324847qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 11:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=X8Tp/XdEXs+TR5v+c9/suhk5h4IbR9LUYJcwVVfa/Uw=;
        b=ZX6PGbbxLe5/+H4/x+2ZwhNRSL/jP669CQcGGWDNfkkAp8vql6U0uYnfE+QF3sTNPv
         ExWqhN1gwNF37jPk7G6+k1S5kUO3VRteOuRzWzoejOtvD4hlOjgSANzsdOEnwtpoPWP2
         loOo30hlBIleoDQCDU4y3hF0EO+ggo42JD7IEY1LQ3sXyG2NGfunBUTncU2dCY3lVDSI
         gtynwEONEhLRiHaSOHJOTEorCytRJRJ5RoRTkfc0MAqPEOyDtimybJOX+nJszIUXokJX
         hkMRmmbU/uLOAZCR+LXJJjZ1B43W3JGvA69m//0OFwTn4AdK/9bKfGlfduMjV9HgiJVC
         yr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=X8Tp/XdEXs+TR5v+c9/suhk5h4IbR9LUYJcwVVfa/Uw=;
        b=ENafYUs/q2yKtM3QXHasSbRGA6XjnsD7Nuzq54/Nz3pzSK/XS/GkNkt/27sjpz6xHa
         /9YnoXCfXSvPfpDfPdVkNwYyrvxdRtHIii27jZfrHRbBx3e5696UCYdcT/qZO1yGNaSK
         x91sNgmw5cMYf4K/Qf2X9iO69yOxoXLcvAoNEwOOMwfLazhCZ++Mqt+p9CAh+I7OSYbV
         IDhvPSfO5u6md2A2fVz0YBOSAECX4zG1xQIqcyV86Ed4fNl1WnZZXSkr7OibPL5aBlQg
         9ayLv7DkDeNRLYuf0OJFsqT1r/k7l78O0dsLLoLObvN3/DARN8vvEVBNpWUNQVEtPErZ
         TSkw==
X-Gm-Message-State: APjAAAXIWYfeEKkgaEJ+ZRC9+0KrkgyinMBcTH57x/+exOwmVz8IKc75
        9oXOusP5PYxUwErO1uEemmydxQ==
X-Google-Smtp-Source: APXvYqxARhrKeQEoDRAu0FLed91qByNWJosnqUpmhhkBLUwPDj/7VnH8zVcJgktfsRT/sMody/3aBA==
X-Received: by 2002:a37:a348:: with SMTP id m69mr10474834qke.474.1575573550513;
        Thu, 05 Dec 2019 11:19:10 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a63sm5180161qkd.37.2019.12.05.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:19:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 14:19:08 -0500
Message-Id: <0E1D1C04-5892-438F-9191-F23CBE1A6DC5@lca.pw>
References: <1575572053-128363-1-git-send-email-yang.shi@linux.alibaba.com>
Cc:     fabecassis@nvidia.com, jhubbard@nvidia.com, mhocko@suse.com,
        cl@linux.com, vbabka@suse.cz, mgorman@techsingularity.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <1575572053-128363-1-git-send-email-yang.shi@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 1:54 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> This is because the status is not set if the page is already on the
> target node, but move_pages() should return valid status as long as it
> succeeds.  The valid status may be errno or node id.
>=20
> We can't simply initialize status array to zero since the pages may be
> not on node 0.  Fix it by updating status with node id which the page is
> already on.

This does not look correct either.

=E2=80=9CENOENT
No pages were found that require moving. All pages are either already on the=
 target node, not present, had an invalid address or could not be moved beca=
use they were mapped by multiple processes.=E2=80=9D

move_pages() should return -ENOENT instead.=
